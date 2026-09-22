<?php

namespace App\Extensions\SocialMedia\System\Services;

use App\Extensions\SocialMedia\System\Enums\PlatformEnum;
use App\Extensions\SocialMedia\System\Models\SocialMediaPlatform;
use App\Extensions\SocialMedia\System\Models\SocialMediaPost;
use Exception;
use Illuminate\Http\Request;

class SocialMediaShareService
{
    public Request $request;

    public PlatformEnum $platform;

    public function storeBulk($data)
    {
        \Log::info('[POST NOW] SocialMediaShareService entered', [
            'has_connected_account_id' => isset($data['connected_account_id']),
            'has_selected_user_platforms' => isset($data['selectedUserPlatforms']),
            'status' => $data['status'] ?? 'not_set',
            'post_now' => $data['post_now'] ?? false,
        ]);

        $selectedUserPlatforms = $data['selectedUserPlatforms'] ?? [];
        $connectedAccountId = $data['connected_account_id'] ?? null;

        $posts = [];

        if ($connectedAccountId) {
            \Log::info('[POST NOW] Creating post with ConnectedAccount', [
                'connected_account_id' => $connectedAccountId,
            ]);

            $created = array_merge($data, [
                'connected_account_id' => $connectedAccountId,
                'social_media_platform_id' => null,
            ]);
            $posts[] = SocialMediaPost::query()->create($created)->getKey();
        } else {
            \Log::info('[POST NOW] Creating post with SocialMediaPlatform', [
                'platform_count' => count($selectedUserPlatforms),
            ]);

            foreach ($selectedUserPlatforms as $selectedUserPlatform) {
                $created = array_merge($data, [
                    'social_media_platform_id' => $selectedUserPlatform,
                    'connected_account_id' => null,
                ]);

                $posts[] = SocialMediaPost::query()->create($created)->getKey();
            }
        }

        $postModels = SocialMediaPost::query()->whereIn('id', $posts)->get();

        \Log::info('[POST NOW] SocialMediaPost saved', [
            'post_count' => count($postModels),
            'post_ids' => $postModels->pluck('id')->toArray(),
            'post_statuses' => $postModels->pluck('status')->toArray(),
        ]);

        return $postModels;
    }

    public function store($data)
    {
        return SocialMediaPost::query()->create($data);
    }

    public function update(SocialMediaPost $post, array $data): void
    {
        $connectedAccountId = $data['connected_account_id'] ?? null;
        $socialMediaPlatformId = $data['social_media_platform_id'] ?? null;

        if ($connectedAccountId) {
            $data['connected_account_id'] = $connectedAccountId;
            $data['social_media_platform_id'] = null;
        } elseif ($socialMediaPlatformId) {
            $data['social_media_platform_id'] = $socialMediaPlatformId;
            $data['connected_account_id'] = null;
        }

        $post->update($data);
    }

    public function selectedPlatform(): PlatformEnum
    {
        try {
            if ($this->request->get('platform') && in_array($this->request->get('platform'), PlatformEnum::toArray(), true)) {
                return PlatformEnum::from($this->request->get('platform'));
            }

            return PlatformEnum::facebook;
        } catch (Exception $e) {
            return PlatformEnum::facebook;
        }
    }

    public function setRequest(Request $request): self
    {
        $this->request = $request;

        return $this;
    }

    public function setPlatform(SocialMediaPlatform $platform): self
    {
        $this->platform = $platform;

        return $this;
    }
}
