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

class MessengerOAuthController extends Controller
{
    public function __construct(
        private OAuthStateService $stateService,
        private ConnectedAccountService $accountService
    ) {}

    public function redirect()
    {
        $user = Auth::user();

        if (!setting('INSTAGRAM_APP_ID') || !setting('INSTAGRAM_APP_SECRET')) {
            return back()->with(['type' => 'error', 'message' => trans('Facebook App ID and Secret are not configured.')]);
        }

        $state = $this->stateService->generate('messenger', $user->id);

        $params = [
            'response_type' => 'code',
            'client_id'     => setting('INSTAGRAM_APP_ID'),
            'redirect_uri'  => $this->redirectUri(),
            'scope'         => 'pages_messaging,pages_read_engagement,pages_show_list',
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
                ->with(['type' => 'error', 'message' => trans('Facebook authorization was denied.')]);
        }

        $code  = $request->input('code');
        $state = $request->input('state');

        if (!$code || !$state) {
            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Invalid callback parameters.')]);
        }

        if (!$this->stateService->validate('messenger', $user->id, $state)) {
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
                    'fields' => 'id,name,access_token',
                ])->throw()->json();

            $pages = $pagesRes['data'] ?? [];

            if (empty($pages)) {
                throw new Exception('No Facebook Pages found. You must have at least one Facebook Page to use Messenger.');
            }

            // For simplicity, use the first page. In production, this should show a page selector
            $page = $pages[0];

            // Save to connected_accounts
            $this->accountService->createOrUpdate(
                user:              $user,
                platform:          'messenger',
                accountIdentifier: $page['id'],
                accessToken:       $page['access_token'],
                accountData: [
                    'name'     => $page['name'],
                    'username' => null,
                    'avatar'   => null,
                    'metadata' => [
                        'page_id'   => $page['id'],
                        'page_name' => $page['name'],
                    ],
                ]
            );

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'success', 'message' => trans('Facebook Page connected successfully.')]);

        } catch (Exception $e) {
            Log::error('Messenger OAuth callback failed', ['user_id' => $user->id, 'error' => $e->getMessage()]);

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Failed to connect Facebook Page. Please try again.')]);
        }
    }

    private function redirectUri(): string
    {
        return route('dashboard.user.integrations.messenger.callback');
    }
}
