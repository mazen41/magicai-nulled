<?php

namespace App\Extensions\SocialMedia\System\Http\Controllers\Oauth;

use App\Extensions\SocialMedia\System\Enums\PlatformEnum;
use App\Extensions\SocialMedia\System\Helpers\Tiktok;
use App\Extensions\SocialMedia\System\Http\Controllers\Oauth\Traits\HasBackRoute;
use App\Extensions\SocialMedia\System\Models\SocialMediaPlatform;
use App\Helpers\Classes\Helper;
use App\Http\Controllers\Controller;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Query\Builder;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;

class TiktokController extends Controller
{
    use HasBackRoute;

    public function __construct(public Tiktok $api) {}

    private function cacheKey(): string
    {
        return 'platforms.' . Auth::id() . '.tiktok';
    }

    public function redirect(Request $request)
    {
        if (Helper::appIsDemo()) {
            return back()->with([
                'type'    => 'error',
                'message' => trans('This feature is disabled in demo mode.'),
            ]);
        }

        $this->setBackCacheRoute();

        if ($request->has('platform_id') && $request->get('platform_id')) {
            Cache::remember($this->cacheKey(), 60, function () use ($request) {
                return $request->get('platform_id');
            });
        }

        return $this->api::authRedirect();
    }

    public function callback(Request $request)
    {
        try {
            $code = $request->get('code');

            if (! $code) {
                return back()->with([
                    'type'    => 'error',
                    'message' => trans('Something went wrong, please try again.'),
                ]);
            }

            $response = $this->api->getAccessToken($code)
                ->throw();

            // Check for actual API errors, not just presence of error field
            if ($response->json('error.code') && $response->json('error.code') !== 'ok') {
                return back()->with([
                    'type'    => 'error',
                    'message' => trans('Failed to connect TikTok account: ' . $response->json('error.message', 'Unknown error')),
                ]);
            }

            $tokenData = $response->object();
            
            // Log the response structure for debugging
            \Log::info('TikTok token response structure', [
                'response' => json_encode($tokenData),
                'properties' => array_keys(get_object_vars($tokenData))
            ]);

            // Handle different TikTok API response structures
            $openId = $tokenData->open_id ?? $tokenData->data->open_id ?? $tokenData->user_id ?? null;
            $accessToken = $tokenData->access_token ?? $tokenData->data->access_token ?? null;
            $expiresIn = $tokenData->expires_in ?? $tokenData->data->expires_in ?? 3600;
            $refreshToken = $tokenData->refresh_token ?? $tokenData->data->refresh_token ?? null;
            $refreshExpiresIn = $tokenData->refresh_expires_in ?? $tokenData->data->refresh_expires_in ?? null;

            if (!$openId || !$accessToken) {
                \Log::error('TikTok OAuth missing required fields', [
                    'open_id' => $openId,
                    'access_token' => $accessToken ? 'present' : 'missing'
                ]);
                return back()->with([
                    'type'    => 'error',
                    'message' => trans('TikTok API response missing required fields'),
                ]);
            }

            $platformId = Cache::get($this->cacheKey());

            if ($platformId && is_numeric($platformId)) {

                $item = SocialMediaPlatform::query()
                    ->where('user_id', Auth::id())
                    ->where('platform', PlatformEnum::tiktok->value)
                    ->where('id', $platformId)
                    ->first();

                if ($item) {
                    $item->update([
                        'credentials' => [
                            'platform_id'            => $openId,
                            'access_token'           => $accessToken,
                            'access_token_expire_at' => now()->addSeconds($expiresIn),

                            'refresh_token'           => $refreshToken ?? '',
                            'refresh_token_expire_at' => $refreshExpiresIn ? now()->addSeconds($refreshExpiresIn) : null,
                        ],
                        'connected_at' => now(),
                        'expires_at'   => now()->addSeconds($expiresIn),
                    ]);

                    $this->api->setToken($accessToken);

                    try {
                        $this->setProfileInfo($item);
                    } catch (\Exception $e) {
                        \Log::error('TikTok profile info fetch failed: ' . $e->getMessage());
                        // Continue even if profile info fails
                    }
                }

                Cache::forget($this->cacheKey());
            } else {
                $item = SocialMediaPlatform::query()->create([
                    'user_id'     => Auth::id(),
                    'platform'    => PlatformEnum::tiktok->value,
                    'credentials' => [
                        'platform_id'            => $openId,
                        'access_token'           => $accessToken,
                        'access_token_expire_at' => now()->addSeconds($expiresIn),

                        'refresh_token'           => $refreshToken ?? '',
                        'refresh_token_expire_at' => $refreshExpiresIn ? now()->addSeconds($refreshExpiresIn) : null,
                    ],
                    'connected_at' => now(),
                    'expires_at'   => now()->addSeconds($expiresIn),
                ]);

                $this->api->setToken($accessToken);

                try {
                    $this->setProfileInfo($item);
                } catch (\Exception $e) {
                    \Log::error('TikTok profile info fetch failed: ' . $e->getMessage());
                    // Continue even if profile info fails
                }
            }

            return $this->redirectToPlatforms('success', 'Tiktok account connected successfully.');
        } catch (\Exception $e) {
            \Log::error('TikTok OAuth callback error: ' . $e->getMessage());
            return back()->with([
                'type'    => 'error',
                'message' => trans('Failed to connect TikTok account: ' . $e->getMessage()),
            ]);
        }
    }

    protected function setProfileInfo(SocialMediaPlatform|Model|Builder $item): void
    {
        $userInfo = [];
        try {
            $userInfoResponse = $this->api->getAccountInfo([
                'open_id',
                'display_name',
                'avatar_url',
                'avatar_url_100',
                'username',
                'follower_count',
                'followers_count',
            ]);
            $userInfo = $userInfoResponse->json('data.user', []) ?? [];
        } catch (\Exception $e) {
            \Log::warning('TikTok getAccountInfo exception: ' . $e->getMessage());
        }

        $creatorInfoData = $this->api->getCreatorInfo();
        $creatorInfo = [];
        if (isset($creatorInfoData['error']['code']) && $creatorInfoData['error']['code'] === 'ok') {
            $creatorInfo = $creatorInfoData['data'] ?? [];
        }

        $displayName = data_get($userInfo, 'display_name')
            ?: data_get($creatorInfo, 'creator_nickname')
            ?: data_get($userInfo, 'username')
            ?: data_get($creatorInfo, 'creator_username')
            ?: 'TikTok Account';

        $username = data_get($userInfo, 'username')
            ?: data_get($creatorInfo, 'creator_username')
            ?: '';

        $avatar = data_get($userInfo, 'avatar_url')
            ?: data_get($userInfo, 'avatar_url_100')
            ?: data_get($creatorInfo, 'creator_avatar_url')
            ?: '';

        $followersCount = (int) (
            data_get($userInfo, 'follower_count')
            ?? data_get($userInfo, 'followers_count')
            ?? data_get($creatorInfo, 'follower_count')
            ?? data_get($creatorInfo, 'followers_count')
            ?? 0
        );

        $item->update([
            'credentials' => array_merge($item->credentials ?? [], [
                'name'     => $displayName,
                'username' => $username,
                'picture'  => $avatar,
                'meta'     => array_merge($creatorInfo, $userInfo),
            ]),
            'followers_count' => $followersCount,
        ]);

        $openId = data_get($item->credentials, 'platform_id') ?: (string) $item->id;
        $accessToken = data_get($item->credentials, 'access_token', '');
        $refreshToken = data_get($item->credentials, 'refresh_token', null);
        $expiresAt = $item->expires_at;

        if ($item->user_id && $accessToken) {
            $user = \App\Models\User::find($item->user_id);
            if ($user) {
                app(\App\Services\OAuth\ConnectedAccountService::class)->createOrUpdate(
                    $user,
                    'tiktok',
                    (string) $openId,
                    (string) $accessToken,
                    [
                        'name'     => $displayName,
                        'username' => $username,
                        'avatar'   => $avatar,
                        'metadata' => array_merge($creatorInfo, $userInfo),
                    ],
                    $refreshToken,
                    $expiresAt
                );
            }
        }
    }

    public function redirectToPlatforms(string $type = 'success', string $message = 'Tiktok account connected successfully.'): RedirectResponse
    {
        return to_route($this->getBackCacheRoute())->with([
            'type'    => $type,
            'message' => trans($message),
        ]);
    }

    public function verify()
    {
        return setting('TIKTOK_OAUTH_VERIFY', 'tiktok-developers-site-verification=U4IyiClYTw8yPBShtWnQkY01ncYucsC3');
    }
}
