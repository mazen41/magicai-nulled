<?php

namespace App\Extensions\AISocialMedia\System\Http\Controllers\Api;

use App\Extensions\AISocialMedia\System\Enums\Platform;
use App\Extensions\AISocialMedia\System\Helpers\Instagram;
use App\Extensions\AISocialMedia\System\Models\AutomationPlatform;
use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class InstagramController extends Controller
{
    public function redirect()
    {
        // Scopes come from config('ai-social-media.instagram.scopes'):
        // instagram_business_basic, instagram_business_content_publish,
        // instagram_business_manage_comments, instagram_business_manage_messages
        return Instagram::authRedirect();
    }

    public function callback(Request $request)
    {
        $code = $request->get('code');

        if (! $code) {
            return redirect()->route('dashboard.user.automation.platform.list')
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
            $expiresIn = $longTokenResponse->json('expires_in', 5184000);

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
            ])->throw()->json();

        } catch (Exception $exception) {
            Log::error('AISocialMedia Instagram OAuth callback failed', [
                'message' => $exception->getMessage(),
            ]);

            return redirect()->route('dashboard.user.automation.platform.list')
                ->with([
                    'type'    => 'error',
                    'message' => trans('Something went wrong, please try again.'),
                ]);
        }

        if (! isset($igAccount['id'])) {
            return redirect()->route('dashboard.user.automation.platform.list')
                ->with([
                    'type'    => 'error',
                    'message' => trans('Could not retrieve Instagram account. Please try again.'),
                ]);
        }

        AutomationPlatform::query()->updateOrCreate([
            'user_id'  => Auth::id(),
            'platform' => Platform::instagram->value,
        ], [
            'credentials' => [
                'id'          => $igAccount['id'],
                'name'        => $igAccount['name'] ?? $igAccount['username'] ?? '',
                'username'    => $igAccount['username'] ?? '',
                'picture'     => $igAccount['profile_picture_url'] ?? '',
                'access_token' => $longLivedToken,
            ],
            'expires_at' => now()->addSeconds($expiresIn),
        ]);

        return to_route('dashboard.user.automation.platform.list')->with([
            'type'    => 'success',
            'message' => trans('Instagram account connected successfully.'),
        ]);
    }
}
