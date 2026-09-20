<?php

namespace App\Services\OAuth;

use Illuminate\Support\Facades\Cache;

class OAuthStateService
{
    private const STATE_TTL = 600; // 10 minutes

    public function generate(string $platform, int $userId): string
    {
        $state = bin2hex(random_bytes(32));
        // Use state itself as cache key to prevent collision
        // Store platform and userId for validation
        Cache::put("oauth_state_{$state}", [
            'platform' => $platform,
            'user_id' => $userId,
        ], self::STATE_TTL);
        return $state;
    }

    public function validate(string $platform, int $userId, string $state): bool
    {
        $stored = Cache::get("oauth_state_{$state}");
        if (!$stored) return false;
        if ($stored['user_id'] !== $userId) return false;
        if ($stored['platform'] !== $platform) return false;
        
        $this->consume($state);
        return true;
    }

    public function consume(string $state): void
    {
        Cache::forget("oauth_state_{$state}");
    }
}
