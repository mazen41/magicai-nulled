<?php

namespace App\Extensions\SocialMedia\System\Services\Publisher;

use App\Extensions\SocialMedia\System\Helpers\Tiktok;
use App\Extensions\SocialMedia\System\Services\Publisher\Contracts\BasePublisherService;
use Illuminate\Http\Client\Response;

class TiktokService extends BasePublisherService
{
    public function handle(): Response
    {
        $media = $this->post->video;

        $message = $this->post->content;

        $tiktok = new Tiktok;

        $tiktok->setToken($this->accessToken);

        $options = config('social-media.tiktok.options', []);

        $postData = [
            'post_info' => [
                'title'                    => str($message)->limit(150)->toString(),
                'privacy_level'            => $options['privacy_level'] ?? 'PUBLIC',
                'disable_duet'             => $options['disable_duet'] ?? false,
                'disable_comment'          => $options['disable_comment'] ?? false,
                'disable_stitch'           => $options['disable_stitch'] ?? false,
                'video_cover_timestamp_ms' => $options['video_cover_timestamp_ms'] ?? 0,
            ],
            'source_info' => [
                'source'    => 'PULL_FROM_URL',
                'video_url' => url($media),
            ],
        ];

        return $tiktok->postVideo($postData);
    }
}
