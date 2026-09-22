<?php

namespace App\Extensions\SocialMedia\System\Services\Publisher;

use App\Extensions\SocialMedia\System\Models\SocialMediaPost;
use App\Extensions\SocialMedia\System\Services\Publisher\Adapters\ConnectedAccountAdapter;
use App\Extensions\SocialMedia\System\Services\Publisher\Adapters\SocialMediaPlatformAdapter;
use App\Extensions\SocialMedia\System\Services\Publisher\Contracts\BasePublisherService;
use App\Models\ConnectedAccount;

class PublisherDriver
{
    public SocialMediaPost $post;

    public function setPost(SocialMediaPost $post): self
    {
        $this->post = $post;

        return $this;
    }

    public function getPost(): SocialMediaPost
    {
        return $this->post;
    }

    public function getDriver(): ?BasePublisherService
    {
        \Log::info('[PUBLISHER DRIVER] Entered', [
            'post_id' => $this->post->id,
            'user_id' => $this->post->user_id,
            'connected_account_id' => $this->post->connected_account_id,
            'social_media_platform_id' => $this->post->social_media_platform_id,
            'status' => $this->post->status,
        ]);

        $platformAccount = null;

        if ($this->post->connected_account_id) {
            \Log::info('[PUBLISHER DRIVER] Using ConnectedAccount', [
                'connected_account_id' => $this->post->connected_account_id,
            ]);

            $connectedAccount = ConnectedAccount::query()
                ->where('id', $this->post->connected_account_id)
                ->where('user_id', $this->post->user_id)
                ->where('connection_status', 'connected')
                ->first();

            if (!$connectedAccount) {
                \Log::error('[PUBLISHER DRIVER] ConnectedAccount NOT FOUND', [
                    'connected_account_id' => $this->post->connected_account_id,
                    'user_id' => $this->post->user_id,
                ]);
                return null;
            }

            \Log::info('[PUBLISHER DRIVER] ConnectedAccount found', [
                'id' => $connectedAccount->id,
                'platform' => $connectedAccount->platform,
                'account_identifier' => $connectedAccount->account_identifier,
                'account_name' => $connectedAccount->account_name,
                'account_username' => $connectedAccount->account_username,
                'connection_status' => $connectedAccount->connection_status,
                'is_token_expired' => $connectedAccount->isTokenExpired(),
            ]);

            $platformAccount = new ConnectedAccountAdapter($connectedAccount);

            \Log::info('[PUBLISHER DRIVER] ConnectedAccountAdapter created', [
                'platform' => $platformAccount->getPlatform(),
            ]);
        } elseif ($this->post->platform) {
            \Log::info('[PUBLISHER DRIVER] Using legacy SocialMediaPlatform', [
                'platform_id' => $this->post->social_media_platform_id,
            ]);

            $platformAccount = new SocialMediaPlatformAdapter($this->post->platform);
        } else {
            \Log::error('[PUBLISHER DRIVER] No account source available', [
                'connected_account_id' => $this->post->connected_account_id,
                'social_media_platform_id' => $this->post->social_media_platform_id,
            ]);
        }

        if (!$platformAccount) {
            \Log::error('[PUBLISHER DRIVER] Platform account is null');
            return null;
        }

        $platformType = $platformAccount->getPlatform();

        \Log::info('[PUBLISHER DRIVER] Resolved platform type', [
            'platform_type' => $platformType,
        ]);

        $driver = match ($platformType ?: 'default') {
            'instagram'      => app(InstagramService::class),
            'facebook'       => app(FacebookService::class),
            'linkedin'       => app(LinkedinService::class),
            'x'              => app(XService::class),
            'tiktok'         => app(TiktokService::class),
            'youtube'        => app(YoutubeService::class),
            'youtube-shorts' => app(YoutubeService::class),
            default          => null,
        };

        if (!$driver) {
            \Log::error('[PUBLISHER DRIVER] No driver found for platform', [
                'platform_type' => $platformType,
            ]);
            return null;
        }

        \Log::info('[PUBLISHER DRIVER] Driver resolved', [
            'driver_class' => get_class($driver),
        ]);

        if ($driver instanceof BasePublisherService) {
            $driver
                ->setPost($this->post)
                ->setPlatform($platformAccount);

            \Log::info('[PUBLISHER DRIVER] Driver configured with post and platform');
        }

        return $driver;
    }
}
