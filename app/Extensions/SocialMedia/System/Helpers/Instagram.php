<?php

namespace App\Extensions\SocialMedia\System\Helpers;

use App\Extensions\SocialMedia\System\Helpers\Contracts\BaseMetaHelper;
use Exception;
use Illuminate\Http\Client\PendingRequest;
use Illuminate\Http\Client\Response;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class Instagram extends BaseMetaHelper
{
    protected array $config = [];

    public function __construct(?array $config = null, protected ?string $accessToken = null)
    {
        $instagramConfig = config('social-media.instagram');

        $instagramConfig = array_merge($instagramConfig, [
            'app_id'     => setting('INSTAGRAM_APP_ID'),
            'app_secret' => setting('INSTAGRAM_APP_SECRET'),
        ]);

        $this->config = $config ?? $instagramConfig;
        $this->config['redirect_uri'] = secure_url(config('social-media.instagram.redirect_uri'));
    }

    private function apiClient(): PendingRequest
    {
        return Http::withToken($this->accessToken)
            ->baseUrl($this->config['api_url'])
            ->retry(1, 3000);
    }

    public static function authRedirect(array $scopes = []): RedirectResponse
    {
        $instagram = new self;

        if ($scopes) {
            $instagram->config['scopes'] = $scopes;
        }

        // Uses base_url = https://api.instagram.com → /oauth/authorize
        $authUri = $instagram->apiUrl('oauth/authorize', [
            'response_type' => 'code',
            'client_id'     => $instagram->config['app_id'],
            'redirect_uri'  => $instagram->config['redirect_uri'],
            'scope'         => collect($instagram->config['scopes'])->join(','),
        ], true);

        return redirect($authUri);
    }

    /**
     * Exchange authorization code for a short-lived Instagram user access token.
     * POSTs to https://api.instagram.com/oauth/access_token
     * Returns: { access_token, token_type, expires_in }
     */
    public function getAccessToken(string $code): Response
    {
        return Http::asForm()->post($this->config['token_url'], [
            'client_id'     => $this->config['app_id'],
            'client_secret' => $this->config['app_secret'],
            'grant_type'    => 'authorization_code',
            'redirect_uri'  => $this->config['redirect_uri'],
            'code'          => $code,
        ]);
    }

    /**
     * Exchange a short-lived token for a long-lived Instagram access token.
     * POSTs to https://graph.instagram.com/access_token
     * Returns: { access_token, token_type, expires_in }
     * Long-lived tokens are valid for 60 days and are refreshable.
     */
    public function getLongLivedToken(string $shortLivedToken): Response
    {
        return Http::asForm()->post($this->config['longtoken_url'], [
            'grant_type'        => 'ig_exchange_token',
            'client_secret'     => $this->config['app_secret'],
            'access_token'      => $shortLivedToken,
        ]);
    }

    /**
     * Refresh an existing long-lived token before it expires.
     * POSTs to https://graph.instagram.com/refresh_access_token
     */
    public function refreshAccessToken(): Response
    {
        $refreshUrl = $this->config['api_url'] . '/refresh_access_token';

        return Http::asForm()->post($refreshUrl, [
            'grant_type'   => 'ig_refresh_token',
            'access_token' => $this->accessToken,
        ]);
    }

    /**
     * Get the authenticated Instagram user's own account info directly.
     * GETs https://graph.instagram.com/v21.0/me
     * No Facebook Pages or connected_instagram_account lookup needed.
     */
    public function getMe(?array $fields = null): Response
    {
        $defaultFields = ['id', 'name', 'username', 'profile_picture_url', 'followers_count', 'account_type'];

        return Http::withToken($this->accessToken)
            ->get($this->apiUrl('me', [
                'fields' => collect($fields ?? $defaultFields)->join(','),
            ]));
    }

    /**
     * Get info for a specific Instagram account by ID.
     * Used by follower sync and post-connection profile refresh.
     */
    public function getInstagramInfo(string $igId, ?array $fields = null): Response
    {
        return Http::withToken($this->accessToken)->get($this->apiUrl($igId), [
            'fields' => collect($fields)->join(','),
        ]);
    }

    public function publishSingleMediaPost(string $igId, array $postData): Response
    {
        $apiUrl = $this->apiUrl("$igId/media");

        $uploadMediaRes = Http::withToken($this->accessToken)
            ->retry(3, 3000)
            ->post($apiUrl, $postData)->throw();

        $mediaId = $uploadMediaRes->json('id');

        $uploadStatus = $this->checkUploadStatus($mediaId);

        throw_if(! $uploadStatus['is_ready'], new Exception($uploadStatus['status']));

        return $this->publishContainer($igId, $uploadMediaRes->json('id'));
    }

    public function publishStory(string $igId, string $imageUrl): Response
    {
        $apiUrl = $this->apiUrl("$igId/media");

        $uploadMediaRes = Http::withToken($this->accessToken)
            ->retry(3, 3000)
            ->post($apiUrl, [
                'image_url'  => $imageUrl,
                'media_type' => 'STORIES',
            ])->throw();

        $mediaId = $uploadMediaRes->json('id');

        $uploadStatus = $this->checkUploadStatus($mediaId);

        throw_if(! $uploadStatus['is_ready'], new Exception($uploadStatus['status']));

        return $this->publishContainer($igId, $mediaId);
    }

    public function publishCarouselPost(string $igId, array $files, string $mediaType = 'image', string $caption = ''): Response
    {
        $containerIds = [];
        foreach ($files as $fileUrl) {
            $containerData = [
                'is_carousel_item' => true,
            ];

            if ($mediaType == 'image') {
                $containerData['media_type'] = 'IMAGE';
                $containerData['image_url'] = $fileUrl;
            } elseif ($mediaType == 'video') {
                $containerData['media_type'] = 'VIDEO';
                $containerData['video_url'] = $fileUrl;
            }

            $apiUrl = $this->apiUrl($igId . '/media');
            $containerRes = Http::withToken($this->accessToken)
                ->asForm()
                ->acceptJson()
                ->post($apiUrl, $containerData)
                ->throw();

            $containerIds[] = $containerRes->json('id');
        }

        $carouselApiUrl = $this->apiUrl($igId . '/media');

        $publishCarouselContainerRes = Http::withToken($this->accessToken)
            ->retry(3, 3000)
            ->post($carouselApiUrl, [
                'media_type' => 'CAROUSEL',
                'children'   => $containerIds,
                'caption'    => $caption,
            ]);

        return $this->publishContainer($igId, $publishCarouselContainerRes->json('id'));
    }

    protected function publishContainer(string $igId, string $creation_id)
    {
        $apiUrl = $this->apiUrl($igId . '/media_publish');

        return Http::retry(3, 3000)
            ->withToken($this->accessToken)
            ->post($apiUrl, [
                'creation_id' => (int) $creation_id,
            ]);
    }

    private function checkUploadStatus(string $mediaId, int $delayInSeconds = 3, int $maxAttempts = 10): array
    {
        $status = false;
        $attempted = 0;
        $isFinished = false;

        while (! $isFinished && $attempted < $maxAttempts) {
            Log::info("Checking upload for: $mediaId");
            $videoStatus = $this->apiClient()->get($this->apiUrl($mediaId, ['fields' => 'status_code,status']))->throw();
            Log::info("Got upload status is: $status. on $attempted/$maxAttempts attempts");

            $status = $videoStatus->json('status_code');
            $isFinished = in_array(strtolower($status), ['finished', 'ok', 'completed', 'ready']);

            if ($isFinished) {
                Log::info("Upload finished with status: $status");

                break;
            }

            $isError = in_array(strtolower($status), ['error', 'failed']);
            if ($isError) {
                Log::info("Upload error with status: $status");

                break;
            }

            $attempted++;
            sleep($delayInSeconds);
        }

        return [
            'is_ready'    => $isFinished,
            'status_code' => $status,
            'status'      => $videoStatus->json('status'),
        ];
    }

    public function getMedia(string $igId, int $limit = 50, ?array $fields = null): Response
    {
        $defaultFields = ['id', 'caption', 'media_type', 'media_url', 'thumbnail_url', 'timestamp', 'like_count', 'comments_count'];

        return Http::withToken($this->accessToken)
            ->get($this->apiUrl("$igId/media", [
                'fields' => collect($fields ?? $defaultFields)->join(','),
                'limit'  => $limit,
            ]));
    }

    public function getPostAnalytics(string $postId, array $fields = []): Response
    {
        return Http::withToken($this->accessToken)
            ->get($this->apiUrl($postId, [
                'fields' => collect($fields)->join(','),
            ]));
    }
}
