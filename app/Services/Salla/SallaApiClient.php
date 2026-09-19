<?php

namespace App\Services\Salla;

use App\Models\SallaConnection;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use RuntimeException;

class SallaApiClient
{
    private SallaConnection $connection;
    private SallaOAuthService $oauthService;

    public function __construct(SallaConnection $connection, SallaOAuthService $oauthService)
    {
        $this->connection = $connection;
        $this->oauthService = $oauthService;
    }

    /**
     * Make an authenticated GET request
     */
    public function get(string $endpoint, array $query = []): array
    {
        $url = $this->buildUrl($endpoint);

        $response = Http::timeout($this->getTimeout())
            ->retry($this->getRetryAttempts(), 100)
            ->withHeaders($this->getHeaders())
            ->get($url, $query);

        return $this->handleResponse($response, $endpoint);
    }

    /**
     * Make an authenticated POST request
     */
    public function post(string $endpoint, array $data = []): array
    {
        $url = $this->buildUrl($endpoint);

        $response = Http::timeout($this->getTimeout())
            ->retry($this->getRetryAttempts(), 100)
            ->withHeaders($this->getHeaders())
            ->post($url, $data);

        return $this->handleResponse($response, $endpoint);
    }

    /**
     * Make an authenticated PUT request
     */
    public function put(string $endpoint, array $data = []): array
    {
        $url = $this->buildUrl($endpoint);

        $response = Http::timeout($this->getTimeout())
            ->retry($this->getRetryAttempts(), 100)
            ->withHeaders($this->getHeaders())
            ->put($url, $data);

        return $this->handleResponse($response, $endpoint);
    }

    /**
     * Make an authenticated DELETE request
     */
    public function delete(string $endpoint, array $query = []): array
    {
        $url = $this->buildUrl($endpoint);

        $response = Http::timeout($this->getTimeout())
            ->retry($this->getRetryAttempts(), 100)
            ->withHeaders($this->getHeaders())
            ->delete($url, $query);

        return $this->handleResponse($response, $endpoint);
    }

    /**
     * Build full URL from endpoint
     */
    private function buildUrl(string $endpoint): string
    {
        $baseUrl = rtrim(config('salla.api.base_url'), '/');
        $endpoint = ltrim($endpoint, '/');

        return $baseUrl . '/' . $endpoint;
    }

    /**
     * Get authentication headers
     */
    private function getHeaders(): array
    {
        $accessToken = $this->oauthService->getValidAccessToken($this->connection);

        return [
            'Authorization' => 'Bearer ' . $accessToken,
            'Accept' => 'application/json',
            'Content-Type' => 'application/json',
        ];
    }

    /**
     * Get timeout from config
     */
    private function getTimeout(): int
    {
        return config('salla.api.timeout', 30);
    }

    /**
     * Get retry attempts from config
     */
    private function getRetryAttempts(): int
    {
        return config('salla.api.retry_attempts', 3);
    }

    /**
     * Handle HTTP response
     */
    private function handleResponse($response, string $endpoint): array
    {
        if ($response->successful()) {
            return $response->json() ?? [];
        }

        $status = $response->status();
        $body = $response->body();

        Log::error('Salla API request failed', [
            'endpoint' => $endpoint,
            'status' => $status,
            'connection_id' => $this->connection->id,
        ]);

        throw new RuntimeException(
            "Salla API request failed: HTTP {$status} for endpoint {$endpoint}"
        );
    }
}
