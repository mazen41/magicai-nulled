<?php

namespace App\Extensions\SocialMedia\System\Http\Controllers\Oauth;

use App\Extensions\SocialMedia\System\Enums\PlatformEnum;
use App\Extensions\SocialMedia\System\Helpers\Instagram;
use App\Extensions\SocialMedia\System\Http\Controllers\Oauth\Traits\HasBackRoute;
use App\Extensions\SocialMedia\System\Http\Controllers\Oauth\Traits\HasSaveImage;
use App\Extensions\SocialMedia\System\Models\SocialMediaPlatform;
use App\Extensions\SocialMediaAutomation\System\Services\WebhookProcessor;
use App\Helpers\Classes\Helper;
use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Throwable;

class InstagramController extends Controller
{
    use HasBackRoute;
    use HasSaveImage;

    private function cacheKey(): string
    {
        return 'platforms.' . Auth::id() . '.instagram';
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

        if (setting('INSTAGRAM_APP_ID') && setting('INSTAGRAM_APP_SECRET')) {
            if ($request->has('platform_id') && $request->get('platform_id')) {
                Cache::remember($this->cacheKey(), 60, function () use ($request) {
                    return $request->get('platform_id');
                });
            }

            // Scopes come from config('social-media.instagram.scopes'):
            // instagram_business_basic, instagram_business_content_publish,
            // instagram_business_manage_comments, instagram_business_manage_messages
            return Instagram::authRedirect();
        }

        return back()->with([
            'type'    => 'error',
            'message' => 'Instagram app id and secret not set. Please contact the administrator.',
        ]);
    }

    public function callback(Request $request)
    {
        $code = $request->get('code');

        if (! $code) {
            return redirect()->route($this->getBackCacheRoute())
                ->with([
                    'type'    => 'error',
                    'message' => trans('Something went wrong, please try again.'),
                ]);
        }

        $instagram = new Instagram;

        try {
            // Step 1: Exchange code for short-lived token
            // POST https://api.instagram.com/oauth/access_token
            $shortTokenResponse = $instagram->getAccessToken($code)->throw();
            $shortLivedToken = $shortTokenResponse->json('access_token');

            if (! $shortLivedToken) {
                throw new Exception('No access_token in short-lived token response.');
            }

            // Step 2: Exchange short-lived token for long-lived token (60-day)
            // GET https://graph.instagram.com/access_token
            $longTokenResponse = $instagram->getLongLivedToken($shortLivedToken)->throw();
            $longLivedToken = $longTokenResponse->json('access_token');
            $expiresIn = $longTokenResponse->json('expires_in', 5184000); // default 60 days in seconds

            if (! $longLivedToken) {
                throw new Exception('No access_token in long-lived token response.');
            }

            $instagram->setToken($longLivedToken);

            // Step 3: Get Instagram account directly via /me
            // GET https://graph.instagram.com/v21.0/me
            // No Facebook Pages, no connected_instagram_account lookup needed.
            $igAccount = $instagram->getMe([
                'id',
                'name',
                'username',
                'profile_picture_url',
                'followers_count',
            ])->throw()->json();

        } catch (Exception $exception) {
            Log::error('Instagram OAuth callback failed', [
                'message' => $exception->getMessage(),
            ]);

            return redirect()->route($this->getBackCacheRoute())
                ->with([
                    'type'    => 'error',
                    'message' => 'Something went wrong, please try again.',
                ]);
        }

        if (! isset($igAccount['id'])) {
            return redirect()->route($this->getBackCacheRoute())
                ->with([
                    'type'    => 'error',
                    'message' => trans('Could not retrieve Instagram account. Please try again.'),
                ]);
        }

        $followersCount = (int) ($igAccount['followers_count'] ?? 0);
        $expiresAt = now()->addSeconds($expiresIn);

        $credentials = [
            'type'         => 'user',
            'id'           => $igAccount['id'],
            'platform_id'  => $igAccount['id'],
            'name'         => $igAccount['name'] ?? $igAccount['username'] ?? '',
            'username'     => $igAccount['username'] ?? '',
            'picture'      => $igAccount['profile_picture_url'] ?? '',
            'access_token' => $longLivedToken,
        ];

        $platformId = Cache::get($this->cacheKey());

        if ($platformId && is_numeric($platformId)) {
            $platform = SocialMediaPlatform::query()
                ->where('id', $platformId)
                ->where('user_id', Auth::id())
                ->where('platform', PlatformEnum::instagram->value)
                ->first();

            if ($platform) {
                $platform->update([
                    'credentials'     => $credentials,
                    'connected_at'    => now(),
                    'expires_at'      => $expiresAt,
                    'followers_count' => $followersCount,
                ]);
            }

            Cache::forget($this->cacheKey());
        } else {
            SocialMediaPlatform::query()->create([
                'user_id'         => Auth::id(),
                'platform'        => PlatformEnum::instagram->value,
                'credentials'     => $credentials,
                'connected_at'    => now(),
                'expires_at'      => $expiresAt,
                'followers_count' => $followersCount,
            ]);
        }

        return to_route($this->getBackCacheRoute())->with([
            'type'    => 'success',
            'message' => trans('Instagram account connected successfully.'),
        ]);
    }

    public function webhook(Request $request)
    {
        // GET: Verification handshake
        if ($request->isMethod('GET')) {
            $verify_token = setting('INSTAGRAM_WEBHOOK_SECRET', 'default-password');

            if ($request->get('hub_mode') === 'subscribe' && $request->get('hub_verify_token') === $verify_token) {
                return response($request->get('hub_challenge'), 200)
                    ->header('Content-Type', 'text/plain');
            }

            return response('Token invalid', 403);
        }

        // POST: Process incoming webhook events
        if ($request->isMethod('POST')) {
            try {
                if (class_exists(WebhookProcessor::class)) {
                    $processor = app(WebhookProcessor::class);

                    $appSecret = setting('INSTAGRAM_APP_SECRET');

                    if ($appSecret && ! $processor->verifySignature($request, $appSecret)) {
                        return response('Invalid signature', 403);
                    }

                    $processor->processInstagramPayload($request->json()->all());
                }
            } catch (Throwable $e) {
                Log::error('Instagram webhook processing failed', [
                    'error' => $e->getMessage(),
                ]);
            }

            return response('EVENT_RECEIVED', 200);
        }

        return response('Method not allowed', 405);
    }
}
