<?php

namespace App\Http\Controllers\Integration;

use App\Http\Controllers\Controller;
use App\Services\OAuth\ConnectedAccountService;
use App\Services\OAuth\OAuthStateService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class InstagramOAuthController extends Controller
{
    public function __construct(
        private OAuthStateService $stateService,
        private ConnectedAccountService $accountService
    ) {}

    public function redirect()
    {
        $user = Auth::user();

        if (!setting('INSTAGRAM_APP_ID') || !setting('INSTAGRAM_APP_SECRET')) {
            return back()->with(['type' => 'error', 'message' => trans('Instagram App ID and Secret are not configured.')]);
        }

        $state = $this->stateService->generate('instagram', $user->id);

        $params = [
            'response_type' => 'code',
            'client_id'     => setting('INSTAGRAM_APP_ID'),
            'redirect_uri'  => $this->redirectUri(),
            'scope'         => 'instagram_basic,instagram_manage_messages,pages_read_engagement,pages_show_list',
            'state'         => $state,
        ];

        $url = 'https://www.facebook.com/dialog/oauth?' . http_build_query($params);

        return redirect()->away($url);
    }

    public function callback(Request $request)
    {
        $user = Auth::user();

        if ($request->has('error')) {
            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Instagram authorization was denied.')]);
        }

        $code  = $request->input('code');
        $state = $request->input('state');

        if (!$code || !$state) {
            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Invalid callback parameters.')]);
        }

        if (!$this->stateService->validate('instagram', $user->id, $state)) {
            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Invalid or expired OAuth state. Please try again.')]);
        }

        try {
            // Exchange code for short-lived token
            $tokenRes = Http::asForm()->post('https://graph.facebook.com/v18.0/oauth/access_token', [
                'client_id'     => setting('INSTAGRAM_APP_ID'),
                'client_secret' => setting('INSTAGRAM_APP_SECRET'),
                'code'          => $code,
                'redirect_uri'  => $this->redirectUri(),
            ])->throw()->json();

            $shortToken = $tokenRes['access_token'];

            // Get pages the user manages
            $pagesRes = Http::withToken($shortToken)
                ->get('https://graph.facebook.com/v18.0/me/accounts', [
                    'fields' => 'connected_instagram_account,name,access_token',
                ])->throw()->json();

            $page = $pagesRes['data'][0] ?? null;

            if (!$page || !isset($page['connected_instagram_account']['id'])) {
                throw new Exception('No Instagram Business account found connected to this Facebook page.');
            }

            // Get Instagram account info
            $igId  = $page['connected_instagram_account']['id'];
            $igRes = Http::withToken($page['access_token'] ?? $shortToken)
                ->get("https://graph.facebook.com/v18.0/{$igId}", [
                    'fields' => 'id,name,username,profile_picture_url',
                ])->throw()->json();

            // Save to connected_accounts
            $this->accountService->createOrUpdate(
                user:              $user,
                platform:          'instagram',
                accountIdentifier: $igId,
                accessToken:       $page['access_token'] ?? $shortToken,
                accountData: [
                    'name'     => $igRes['username'] ?? $igRes['name'] ?? 'Instagram Account',
                    'username' => $igRes['username'] ?? null,
                    'avatar'   => $igRes['profile_picture_url'] ?? null,
                    'metadata' => [
                        'page_id'   => $page['id'],
                        'page_name' => $page['name'],
                        'ig_name'   => $igRes['name'],
                    ],
                ]
            );

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'success', 'message' => trans('Instagram account connected successfully.')]);

        } catch (Exception $e) {
            Log::error('Instagram OAuth callback failed', ['user_id' => $user->id, 'error' => $e->getMessage()]);

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Failed to connect Instagram. Please try again.')]);
        }
    }

    private function redirectUri(): string
    {
        return route('dashboard.user.integrations.instagram.callback');
    }
}
