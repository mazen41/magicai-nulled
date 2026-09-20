<?php

namespace App\Services\Salla;

use App\Models\SallaConnection;
use App\Models\User;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use RuntimeException;

class SallaOAuthService
{
    private const STATE_TTL = 600; // 10 minutes
    private const REFRESH_LOCK_TTL = 30; // 30 seconds
    private const TOKEN_EXPIRY_BUFFER = 300; // 5 minutes before expiry

    /**
     * Generate Salla authorization URL with secure state
     */
    public function getAuthorizationUrl(User $user): string
    {
        $state = $this->generateState();
        $this->storeState($user->id, $state);

        $params = [
            'client_id' => config('salla.client_id'),
            'response_type' => 'code',
            'redirect_uri' => config('salla.redirect_uri'),
            'scope' => implode(' ', config('salla.scopes')),
            'state' => $state,
        ];

        return config('salla.oauth.auth_url') . '?' . http_build_query($params);
    }

    /**
     * Validate OAuth state
     */
    public function validateState(User $user, string $state): bool
    {
        $storedState = $this->getStoredState($user->id);

        if ($storedState === null) {
            return false;
        }

        if ($storedState !== $state) {
            return false;
        }

        $this->consumeState($user->id);

        return true;
    }

    /**
     * Exchange authorization code for tokens
     */
    public function exchangeCodeForTokens(string $code): array
    {
        $response = Http::asForm()->timeout(30)
            ->post(config('salla.oauth.token_url'), [
                'grant_type' => 'authorization_code',
                'client_id' => config('salla.client_id'),
                'client_secret' => config('salla.client_secret'),
                'code' => $code,
                'redirect_uri' => config('salla.redirect_uri'),
            ]);

        if ($response->failed()) {
            Log::error('Salla token exchange failed', [
                'status' => $response->status(),
                'body' => $response->body(),
            ]);

            throw new RuntimeException('Failed to exchange authorization code for tokens');
        }

        $data = $response->json();

        if (! isset($data['access_token'])) {
            Log::error('Salla token exchange missing access_token', [
                'response' => $data,
            ]);

            throw new RuntimeException('Invalid token response from Salla');
        }

        return $data;
    }

    /**
     * Get user info from Salla
     */
    public function getUserInfo(string $accessToken): array
    {
        $response = Http::asForm()->timeout(30)
            ->withToken($accessToken)
            ->get(config('salla.oauth.user_info_url'));

        if ($response->failed()) {
            Log::error('Salla user info request failed', [
                'status' => $response->status(),
                'body' => $response->body(),
            ]);

            throw new RuntimeException('Failed to retrieve user info from Salla');
        }

        return $response->json();
    }

    /**
     * Create or update Salla connection
     */
    public function createConnection(User $user, array $tokens, array $userInfo): SallaConnection
    {
        $tokenExpiresAt = $this->calculateTokenExpiry($tokens);

        $sallaStoreId = $userInfo['id'] ?? null;
        $storeName = $userInfo['name'] ?? null;
        $storeDomain = $userInfo['domain'] ?? null;
        $merchantEmail = $userInfo['email'] ?? null;
        $merchantName = $userInfo['merchant_name'] ?? null;

        // Check for existing connection to same store
        $existingConnection = null;
        if ($sallaStoreId) {
            $existingConnection = SallaConnection::query()
                ->where('user_id', $user->id)
                ->where('salla_store_id', $sallaStoreId)
                ->first();
        }

        if ($existingConnection) {
            // Update existing connection
            $existingConnection->update([
                'access_token' => $tokens['access_token'],
                'refresh_token' => $tokens['refresh_token'] ?? null,
                'token_expires_at' => $tokenExpiresAt,
                'store_name' => $storeName,
                'store_domain' => $storeDomain,
                'merchant_email' => $merchantEmail,
                'merchant_name' => $merchantName,
                'store_data' => $userInfo,
                'connection_status' => 'connected',
                'connected_at' => now(),
                'last_synced_at' => now(),
            ]);

            return $existingConnection;
        }

        // Create new connection
        return SallaConnection::create([
            'user_id' => $user->id,
            'salla_store_id' => $sallaStoreId,
            'store_name' => $storeName,
            'store_domain' => $storeDomain,
            'merchant_email' => $merchantEmail,
            'merchant_name' => $merchantName,
            'access_token' => $tokens['access_token'],
            'refresh_token' => $tokens['refresh_token'] ?? null,
            'token_expires_at' => $tokenExpiresAt,
            'connection_status' => 'connected',
            'store_data' => $userInfo,
            'connected_at' => now(),
            'last_synced_at' => now(),
        ]);
    }

    /**
     * Refresh access token with locking
     */
    public function refreshAccessToken(SallaConnection $connection): array
    {
        $lockKey = "salla_refresh_{$connection->id}";

        $lock = Cache::lock($lockKey, self::REFRESH_LOCK_TTL);

        try {
            $lock->block(10);

            // Reload connection to get latest state
            $connection->refresh();

            if (!$connection->refresh_token) {
                throw new RuntimeException('No refresh token available');
            }

            $response = Http::asForm()->timeout(30)
                ->post(config('salla.oauth.token_url'), [
                    'grant_type' => 'refresh_token',
                    'refresh_token' => $connection->refresh_token,
                    'client_id' => config('salla.client_id'),
                    'client_secret' => config('salla.client_secret'),
                ]);

            if ($response->failed()) {
                Log::error('Salla token refresh failed', [
                    'connection_id' => $connection->id,
                    'status' => $response->status(),
                    'body' => $response->body(),
                ]);

                throw new RuntimeException('Failed to refresh access token');
            }

            $data = $response->json();

            if (! isset($data['access_token'])) {
                Log::error('Salla token refresh missing access_token', [
                    'connection_id' => $connection->id,
                    'response' => $data,
                ]);

                throw new RuntimeException('Invalid refresh response from Salla');
            }

            // Update connection with new tokens atomically
            $connection->update([
                'access_token' => $data['access_token'],
                'refresh_token' => $data['refresh_token'] ?? $connection->refresh_token,
                'token_expires_at' => $this->calculateTokenExpiry($data),
            ]);

            return $data;
        } finally {
            $lock?->release();
        }
    }

    /**
     * Check if token is expired
     */
    public function isTokenExpired(SallaConnection $connection): bool
    {
        if (!$connection->token_expires_at) {
            return true;
        }

        return $connection->token_expires_at->isPast();
    }

    /**
     * Check if token should be refreshed
     */
    public function shouldRefreshToken(SallaConnection $connection): bool
    {
        if (!$connection->token_expires_at) {
            return true;
        }

        return $connection->token_expires_at->subSeconds(self::TOKEN_EXPIRY_BUFFER)->isPast();
    }

    /**
     * Get valid access token, refreshing if necessary
     */
    public function getValidAccessToken(SallaConnection $connection): string
    {
        if ($this->isTokenExpired($connection)) {
            $this->refreshAccessToken($connection);
            $connection->refresh();
        } elseif ($this->shouldRefreshToken($connection)) {
            $this->refreshAccessToken($connection);
            $connection->refresh();
        }

        return $connection->access_token;
    }

    /**
     * Generate cryptographically secure state
     */
    private function generateState(): string
    {
        return bin2hex(random_bytes(32));
    }

    /**
     * Store state in cache
     */
    private function storeState(int $userId, string $state): void
    {
        Cache::put("salla_oauth_state_{$userId}", $state, self::STATE_TTL);
    }

    /**
     * Get stored state
     */
    private function getStoredState(int $userId): ?string
    {
        return Cache::get("salla_oauth_state_{$userId}");
    }

    /**
     * Consume state (single-use)
     */
    private function consumeState(int $userId): void
    {
        Cache::forget("salla_oauth_state_{$userId}");
    }

    /**
     * Calculate token expiry from response
     */
    private function calculateTokenExpiry(array $tokenResponse): ?Carbon
    {
        if (isset($tokenResponse['expires'])) {
            // Salla returns expires as timestamp
            return Carbon::createFromTimestamp($tokenResponse['expires']);
        }

        if (isset($tokenResponse['expires_in'])) {
            // Standard OAuth expires_in (seconds)
            return now()->addSeconds($tokenResponse['expires_in']);
        }

        // Default to 14 days as per Salla documentation
        return now()->addDays(14);
    }
}
