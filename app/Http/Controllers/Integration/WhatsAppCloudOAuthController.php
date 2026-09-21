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

/**
 * WhatsApp Business Cloud API — Meta Embedded Signup (OAuth) flow.
 *
 * Flow:
 *   connect()  → redirect user to Meta OAuth dialog
 *   callback() → exchange code for token → fetch phone details → save ConnectedAccount
 *
 * Config keys (config/services.php → meta.whatsapp):
 *   app_id, app_secret, redirect_uri, scope
 *
 * Tokens are stored encrypted by ConnectedAccountService / ConnectedAccount model.
 * Tokens are NEVER logged or returned to the frontend.
 */
class WhatsAppCloudOAuthController extends Controller
{
    public function __construct(
        private OAuthStateService $stateService,
        private ConnectedAccountService $accountService
    ) {}

    /**
     * Redirect the user to the Meta OAuth dialog (Embedded Signup).
     */
    public function connect()
    {
        $user = Auth::user();

        $appId = config('services.meta.whatsapp.app_id');

        if (empty($appId)) {
            return back()->with([
                'type'    => 'error',
                'message' => trans('WhatsApp App ID is not configured. Please contact the administrator.'),
            ]);
        }

        $state = $this->stateService->generate('whatsapp_cloud', $user->id);

        $params = [
            'response_type' => 'code',
            'client_id'     => $appId,
            'redirect_uri'  => $this->redirectUri(),
            'scope'         => config('services.meta.whatsapp.scope', 'whatsapp_business_management,whatsapp_business_messaging'),
            'state'         => $state,
        ];

        $url = 'https://www.facebook.com/dialog/oauth?' . http_build_query($params);

        return redirect()->away($url);
    }

    /**
     * Handle the Meta OAuth callback.
     * Exchange code -> token -> fetch phone number details -> save ConnectedAccount.
     */
    public function callback(Request $request)
    {
        $user = Auth::user();

        // User denied access
        if ($request->has('error')) {
            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('WhatsApp authorization was denied.')]);
        }

        $code  = $request->input('code');
        $state = $request->input('state');

        if (! $code || ! $state) {
            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Invalid callback parameters.')]);
        }

        // CSRF state validation
        if (! $this->stateService->validate('whatsapp_cloud', $user->id, $state)) {
            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Invalid or expired OAuth state. Please try again.')]);
        }

        try {
            $graphVersion = config('services.meta.graph_version', 'v18.0');
            $appId        = config('services.meta.whatsapp.app_id');
            $appSecret    = config('services.meta.whatsapp.app_secret');

            // 1. Exchange authorization code for a user access token
            $tokenRes = Http::asForm()
                ->post("https://graph.facebook.com/{$graphVersion}/oauth/access_token", [
                    'client_id'     => $appId,
                    'client_secret' => $appSecret,
                    'code'          => $code,
                    'redirect_uri'  => $this->redirectUri(),
                ])->throw()->json();

            $userToken = $tokenRes['access_token'];

            // 2. Fetch WhatsApp Business Accounts + phone numbers (nested call)
            $wabaRes = Http::withToken($userToken)
                ->get("https://graph.facebook.com/{$graphVersion}/me/businesses", [
                    'fields' => 'id,name,whatsapp_business_accounts{id,name,phone_numbers{id,display_phone_number,verified_name}}',
                ])->throw()->json();

            $businesses    = $wabaRes['data'] ?? [];
            $phoneNumberId = null;
            $wabaId        = null;
            $phoneNumber   = null;
            $verifiedName  = null;

            foreach ($businesses as $business) {
                $wabas = $business['whatsapp_business_accounts']['data'] ?? [];
                foreach ($wabas as $waba) {
                    $phones = $waba['phone_numbers']['data'] ?? [];
                    if (! empty($phones)) {
                        $phone         = $phones[0];
                        $phoneNumberId = $phone['id'];
                        $wabaId        = $waba['id'];
                        $phoneNumber   = $phone['display_phone_number'] ?? null;
                        $verifiedName  = $phone['verified_name'] ?? null;
                        break 2;
                    }
                }
            }

            // Fallback: query WABAs directly when the nested businesses call yields nothing
            if (! $phoneNumberId) {
                $wabaFallback = Http::withToken($userToken)
                    ->get("https://graph.facebook.com/{$graphVersion}/me/whatsapp_business_accounts", [
                        'fields' => 'id,name',
                    ])->json();

                $firstWaba = ($wabaFallback['data'] ?? [])[0] ?? null;

                if ($firstWaba) {
                    $wabaId    = $firstWaba['id'];
                    $phonesRes = Http::withToken($userToken)
                        ->get("https://graph.facebook.com/{$graphVersion}/{$wabaId}/phone_numbers", [
                            'fields' => 'id,display_phone_number,verified_name',
                        ])->json();

                    $firstPhone = ($phonesRes['data'] ?? [])[0] ?? null;
                    if ($firstPhone) {
                        $phoneNumberId = $firstPhone['id'];
                        $phoneNumber   = $firstPhone['display_phone_number'] ?? null;
                        $verifiedName  = $firstPhone['verified_name'] ?? null;
                    }
                }
            }

            if (! $phoneNumberId || ! $wabaId) {
                throw new Exception(
                    'No WhatsApp Business phone number found. ' .
                    'Ensure your Meta account has a verified WhatsApp Business phone number.'
                );
            }

            $displayLabel = $verifiedName ?: $phoneNumber ?: 'WhatsApp Business';

            // 3. Save as a ConnectedAccount — token is encrypted at rest
            $this->accountService->createOrUpdate(
                user:              $user,
                platform:          'whatsapp_cloud',
                accountIdentifier: $phoneNumberId,
                accessToken:       $userToken,
                accountData: [
                    'name'     => $displayLabel,
                    'username' => $phoneNumber,
                    'avatar'   => null,
                    'metadata' => [
                        'phone_number_id'              => $phoneNumberId,
                        'whatsapp_business_account_id' => $wabaId,
                        'phone_number'                 => $phoneNumber,
                        'display_name'                 => $displayLabel,
                    ],
                ]
            );

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'success', 'message' => trans('WhatsApp Business account connected successfully.')]);

        } catch (Exception $e) {
            Log::error('WhatsApp Cloud OAuth callback failed', [
                'user_id' => $user->id,
                'error'   => $e->getMessage(),
            ]);

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Failed to connect WhatsApp Business account. Please try again.')]);
        }
    }

    private function redirectUri(): string
    {
        return route('dashboard.user.integrations.whatsapp-cloud.callback');
    }
}
