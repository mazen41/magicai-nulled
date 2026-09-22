<?php

namespace App\Extensions\SocialMedia\System\Services\Publisher\Contracts;

interface PlatformAccountInterface
{
    public function getCredentials(): array;

    public function getPlatform(): string;

    public function isConnected(): bool;
}
