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
        $platformAccount = null;

        if ($this->post->connected_account_id) {
            $connectedAccount = ConnectedAccount::query()
                ->where('id', $this->post->connected_account_id)
                ->where('user_id', $this->post->user_id)
                ->where('connection_status', 'connected')
                ->first();

            if (!$connectedAccount) {
                return null;
            }

            $platformAccount = new ConnectedAccountAdapter($connectedAccount);
        } elseif ($this->post->platform) {
            $platformAccount = new SocialMediaPlatformAdapter($this->post->platform);
        }

        if (!$platformAccount) {
            return null;
        }

        $platformType = $platformAccount->getPlatform();

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

        if ($driver instanceof BasePublisherService) {
            $driver
                ->setPost($this->post)
                ->setPlatform($platformAccount);
        }

        return $driver;
    }
}
