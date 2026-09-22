<?php

namespace App\Extensions\SocialMedia\System\Services\Publisher;

use App\Extensions\SocialMedia\System\Enums\PostTypeEnum;
use App\Extensions\SocialMedia\System\Helpers\Facebook;
use App\Extensions\SocialMedia\System\Services\Publisher\Contracts\BasePublisherService;

class FacebookService extends BasePublisherService
{
    public function handle()
    {
        \Log::info('[FACEBOOK PUBLISH] Entered', [
            'post_id' => $this->post->id,
            'platform_id' => $this->platformId,
            'post_type' => $this->post->post_type,
            'content_length' => strlen($this->post->content ?? ''),
            'has_image' => !empty($this->post->image),
            'image_count' => count($this->post->images ?? []),
        ]);

        $images = $this->post->images ?? [];
        $media = $this->post->image;

        $message = $this->post->content;

        $facebook = new Facebook;

        $facebook->setToken($this->accessToken);

        if ($this->post->post_type === PostTypeEnum::Story) {
            \Log::info('[FACEBOOK PUBLISH] Publishing photo story', [
                'platform_id' => $this->platformId,
                'media_url' => url($media),
            ]);

            $response = $facebook->publishPhotoStory($this->platformId, url($media));

            \Log::info('[FACEBOOK PUBLISH] Photo story response', [
                'response_type' => gettype($response),
            ]);

            return $response;
        }

        if (count($images) > 0) {
            \Log::info('[FACEBOOK PUBLISH] Publishing photos on page', [
                'platform_id' => $this->platformId,
                'image_count' => count($images),
            ]);

            $response = $facebook->publishPhotoOnPage($this->platformId, $message, $images);

            \Log::info('[FACEBOOK PUBLISH] Photos response', [
                'response_type' => gettype($response),
            ]);

            return $response;
        }

        \Log::info('[FACEBOOK PUBLISH] Publishing text or single photo', [
            'platform_id' => $this->platformId,
            'has_media' => (bool) $media,
        ]);

        $response = match ((bool) $media) {
            true => $facebook->publishPhotoOnPage($this->platformId, $message, [
                $media,
            ]),
            default => $facebook->publishTextOnPage($this->platformId, $message),
        };

        \Log::info('[FACEBOOK PUBLISH] Final response', [
            'response_type' => gettype($response),
        ]);

        return $response;
    }
}
