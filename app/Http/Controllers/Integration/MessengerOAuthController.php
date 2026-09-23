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
            'scope'         => 'pages_messaging,pages_read_engagement,pages_show_list,pages_manage_posts',
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
                        'granted_permissions' => $request->input('granted_scopes', []),
                    ],
                ]
            );

            Log::info('Messenger OAuth: permissions granted', [
                'page_id' => $page['id'],
                'granted_scopes' => $request->input('granted_scopes'),
            ]);

            // Debug: Check token permissions
            $debugResponse = Http::get("https://graph.facebook.com/v18.0/debug_token", [
                'input_token' => $page['access_token'],
                'access_token' => setting('INSTAGRAM_APP_ID') . '|' . setting('INSTAGRAM_APP_SECRET'),
            ]);

            Log::info('Messenger OAuth: token debug', [
                'page_id' => $page['id'],
                'debug_response' => $debugResponse->json(),
            ]);

            // Subscribe the Page to our App's webhooks so Facebook starts
            // delivering feed (comments) and messages events to our webhook URL.
            // Without this call the App-level webhook URL is registered but
            // Facebook never sends real events for this Page.
            $subscribeRes = Http::withToken($page['access_token'])
                ->post("https://graph.facebook.com/v18.0/{$page['id']}/subscribed_apps", [
                    'subscribed_fields' => 'feed,messages,messaging_postbacks,messaging_optins',
                ]);

            if ($subscribeRes->successful()) {
                Log::info('Messenger OAuth: page subscribed to app webhooks', [
                    'page_id'   => $page['id'],
                    'page_name' => $page['name'],
                    'result'    => $subscribeRes->json(),
                ]);
            } else {
                Log::warning('Messenger OAuth: page webhook subscription failed (non-fatal)', [
                    'page_id'   => $page['id'],
                    'page_name' => $page['name'],
                    'status'    => $subscribeRes->status(),
                    'body'      => $subscribeRes->json(),
                ]);
            }

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

    /**
     * One-time fix: subscribe all existing connected Messenger pages to the App's webhooks.
     * Visit: GET /dashboard/user/integrations/messenger/resubscribe
     * This is needed for pages connected before the subscription call was added to callback().
     */
    public function resubscribeAll()
    {
        $user = Auth::user();

        $accounts = \App\Models\ConnectedAccount::query()
            ->where('user_id', $user->id)
            ->where('platform', 'messenger')
            ->where('connection_status', 'connected')
            ->get();

        if ($accounts->isEmpty()) {
            return back()->with(['type' => 'error', 'message' => 'No connected Messenger accounts found.']);
        }

        $results = [];

        foreach ($accounts as $account) {
            $pageId    = $account->account_identifier;
            $pageToken = $account->access_token;

            if (!$pageToken) {
                $results[] = "Page {$pageId}: SKIPPED (no token)";
                continue;
            }

            $res = Http::withToken($pageToken)
                ->post("https://graph.facebook.com/v18.0/{$pageId}/subscribed_apps", [
                    'subscribed_fields' => 'feed,messages,messaging_postbacks,messaging_optins',
                ]);

            if ($res->successful()) {
                Log::info('resubscribeAll: page subscribed', ['page_id' => $pageId, 'result' => $res->json()]);
                $results[] = "Page {$pageId} ({$account->account_name}): SUCCESS " . json_encode($res->json());
            } else {
                Log::error('resubscribeAll: page subscription failed', ['page_id' => $pageId, 'status' => $res->status(), 'body' => $res->json()]);
                $results[] = "Page {$pageId} ({$account->account_name}): FAILED {$res->status()} " . $res->body();
            }
        }

        return response('<pre>' . implode("\n", $results) . '</pre>')
            ->header('Content-Type', 'text/html');
    }
}
