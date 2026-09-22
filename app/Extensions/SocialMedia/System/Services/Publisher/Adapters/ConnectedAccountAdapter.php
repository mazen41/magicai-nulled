<?php

namespace App\Extensions\SocialMedia\System\Services\Publisher\Adapters;

use App\Extensions\SocialMedia\System\Services\Publisher\Contracts\PlatformAccountInterface;
use App\Models\ConnectedAccount;

class ConnectedAccountAdapter implements PlatformAccountInterface
{
    public function __construct(
        private ConnectedAccount $account
    ) {}

    public function getCredentials(): array
    {
        return [
            'access_token' => $this->account->access_token,
            'refresh_token' => $this->account->refresh_token,
            'platform_id' => $this->account->account_identifier,
        ];
    }

    public function getPlatform(): string
    {
        return $this->account->platform;
    }

    public function isConnected(): bool
    {
        return $this->account->isConnected() && !$this->account->isTokenExpired();
    }
}
