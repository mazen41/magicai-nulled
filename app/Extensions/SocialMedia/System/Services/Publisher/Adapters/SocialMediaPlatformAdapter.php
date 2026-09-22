<?php

namespace App\Extensions\SocialMedia\System\Services\Publisher\Adapters;

use App\Extensions\SocialMedia\System\Models\SocialMediaPlatform;
use App\Extensions\SocialMedia\System\Services\Publisher\Contracts\PlatformAccountInterface;

class SocialMediaPlatformAdapter implements PlatformAccountInterface
{
    public function __construct(
        private SocialMediaPlatform $platform
    ) {}

    public function getCredentials(): array
    {
        return $this->platform->credentials;
    }

    public function getPlatform(): string
    {
        return $this->platform->platform;
    }

    public function isConnected(): bool
    {
        return $this->platform->isConnected();
    }
}
