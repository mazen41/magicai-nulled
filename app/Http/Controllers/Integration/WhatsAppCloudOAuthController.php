<?php

namespace App\Http\Controllers\Integration;

use App\Http\Controllers\Controller;
use App\Services\OAuth\ConnectedAccountService;
use App\Services\OAuth\OAuthStateService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

/**
 * WhatsApp Business Cloud API — Meta Embedded Signup (OAuth) flow.
 *
 * Flow:
 *   connect()  → redirect to Meta OAuth dialog
 *   callback() → exchange code → fetch all WABAs + phones → show picker
 *   select()   → user picks a phone → save ConnectedAccount
 */
class WhatsAppCloudOAuthController extends Controller
{
    public function __construct(
        private OAuthStateService $stateService,
        private ConnectedAccountService $accountService
    ) {}

    // -------------------------------------------------------------------------
    // Step 1: Redirect to Meta OAuth
    // -------------------------------------------------------------------------
    public function connect()
    {
        $user  = Auth::user();
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

        return redirect()->away('https://www.facebook.com/dialog/oauth?' . http_build_query($params));
    }

    // -------------------------------------------------------------------------
    // Step 2: Meta redirects back — exchange code, fetch phones, show picker
    // -------------------------------------------------------------------------
    public function callback(Request $request)
    {
        $user = Auth::user();

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

        if (! $this->stateService->validate('whatsapp_cloud', $user->id, $state)) {
            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Invalid or expired OAuth state. Please try again.')]);
        }

        try {
            $graphVersion = config('services.meta.graph_version', 'v18.0');

            // Exchange code for user access token
            $tokenRes = Http::asForm()
                ->post("https://graph.facebook.com/{$graphVersion}/oauth/access_token", [
                    'client_id'     => config('services.meta.whatsapp.app_id'),
                    'client_secret' => config('services.meta.whatsapp.app_secret'),
                    'code'          => $code,
                    'redirect_uri'  => $this->redirectUri(),
                ])->throw()->json();

            $userToken = $tokenRes['access_token'];

            // Collect all WABAs + their phone numbers
            $phones = $this->fetchAllPhones($userToken, $graphVersion);

            if (empty($phones)) {
                return redirect()->route('dashboard.user.integrations.index')
                    ->with(['type' => 'error', 'message' => trans('No WhatsApp Business phone numbers found on your Meta account.')]);
            }

            // If only one phone, connect it directly without showing picker
            if (count($phones) === 1) {
                $this->savePhone($user, $phones[0], $userToken);
                return redirect()->route('dashboard.user.integrations.index')
                    ->with(['type' => 'success', 'message' => trans('WhatsApp Business account connected successfully.')]);
            }

            // Store token + phone list in cache for the select step (5 min TTL)
            $pickToken = bin2hex(random_bytes(16));
            Cache::put("wa_pick_{$user->id}_{$pickToken}", [
                'token'  => $userToken,
                'phones' => $phones,
            ], 300);

            return redirect()->route('dashboard.user.integrations.whatsapp-cloud.select', [
                'pick' => $pickToken,
            ]);

        } catch (Exception $e) {
            Log::error('WhatsApp Cloud OAuth callback failed', [
                'user_id' => $user->id,
                'error'   => $e->getMessage(),
            ]);

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Failed to connect WhatsApp Business account. Please try again.')]);
        }
    }

    // -------------------------------------------------------------------------
    // Step 3: Show phone number picker
    // -------------------------------------------------------------------------
    public function select(Request $request)
    {
        $user      = Auth::user();
        $pickToken = $request->query('pick');
        $cached    = Cache::get("wa_pick_{$user->id}_{$pickToken}");

        if (! $cached) {
            return redirect()->route('dashboard.user.integrations.whatsapp-cloud.connect')
                ->with(['type' => 'error', 'message' => trans('Session expired. Please try connecting again.')]);
        }

        return view('panel.user.integrations.whatsapp-cloud.select', [
            'phones'     => $cached['phones'],
            'pick_token' => $pickToken,
        ]);
    }

    // -------------------------------------------------------------------------
    // Step 4: User submits chosen phone — save ConnectedAccount
    // -------------------------------------------------------------------------
    public function store(Request $request)
    {
        $user      = Auth::user();
        $pickToken = $request->input('pick_token');
        $cached    = Cache::get("wa_pick_{$user->id}_{$pickToken}");

        if (! $cached) {
            return redirect()->route('dashboard.user.integrations.whatsapp-cloud.connect')
                ->with(['type' => 'error', 'message' => trans('Session expired. Please try connecting again.')]);
        }

        $phoneId = $request->input('phone_number_id');
        $phone   = collect($cached['phones'])->firstWhere('phone_number_id', $phoneId);

        if (! $phone) {
            return back()->with(['type' => 'error', 'message' => trans('Invalid selection. Please try again.')]);
        }

        try {
            $this->savePhone($user, $phone, $cached['token']);
            Cache::forget("wa_pick_{$user->id}_{$pickToken}");

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'success', 'message' => trans('WhatsApp Business account connected successfully.')]);

        } catch (Exception $e) {
            Log::error('WhatsApp Cloud store failed', ['user_id' => $user->id, 'error' => $e->getMessage()]);

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Failed to connect WhatsApp Business account. Please try again.')]);
        }
    }

    // -------------------------------------------------------------------------
    // Helpers
    // -------------------------------------------------------------------------

    /**
     * Fetch every WABA + phone number the token can access.
     * Returns a flat array of phone entries.
     */
    private function fetchAllPhones(string $token, string $graphVersion): array
    {
        $phones = [];

        // Primary: me/businesses → nested WABAs → nested phone_numbers
        $bizRes = Http::withToken($token)
            ->get("https://graph.facebook.com/{$graphVersion}/me/businesses", [
                'fields' => 'id,name,whatsapp_business_accounts{id,name,phone_numbers{id,display_phone_number,verified_name}}',
            ])->json();

        foreach ($bizRes['data'] ?? [] as $business) {
            foreach ($business['whatsapp_business_accounts']['data'] ?? [] as $waba) {
                foreach ($waba['phone_numbers']['data'] ?? [] as $p) {
                    $phones[] = [
                        'phone_number_id' => $p['id'],
                        'waba_id'         => $waba['id'],
                        'waba_name'       => $waba['name'] ?? 'Unknown',
                        'phone_number'    => $p['display_phone_number'] ?? '',
                        'verified_name'   => $p['verified_name'] ?? '',
                    ];
                }
            }
        }

        // Fallback: me/whatsapp_business_accounts (direct WABA access)
        if (empty($phones)) {
            $wabaRes = Http::withToken($token)
                ->get("https://graph.facebook.com/{$graphVersion}/me/whatsapp_business_accounts", [
                    'fields' => 'id,name',
                ])->json();

            foreach ($wabaRes['data'] ?? [] as $waba) {
                $phonesRes = Http::withToken($token)
                    ->get("https://graph.facebook.com/{$graphVersion}/{$waba['id']}/phone_numbers", [
                        'fields' => 'id,display_phone_number,verified_name',
                    ])->json();

                foreach ($phonesRes['data'] ?? [] as $p) {
                    $phones[] = [
                        'phone_number_id' => $p['id'],
                        'waba_id'         => $waba['id'],
                        'waba_name'       => $waba['name'] ?? 'Unknown',
                        'phone_number'    => $p['display_phone_number'] ?? '',
                        'verified_name'   => $p['verified_name'] ?? '',
                    ];
                }
            }
        }

        return $phones;
    }

    /**
     * Persist a phone entry as a ConnectedAccount.
     */
    private function savePhone($user, array $phone, string $token): void
    {
        $displayLabel = $phone['verified_name'] ?: $phone['phone_number'] ?: 'WhatsApp Business';

        $this->accountService->createOrUpdate(
            user:              $user,
            platform:          'whatsapp_cloud',
            accountIdentifier: $phone['phone_number_id'],
            accessToken:       $token,
            accountData: [
                'name'     => $displayLabel,
                'username' => $phone['phone_number'],
                'avatar'   => null,
                'metadata' => [
                    'phone_number_id'              => $phone['phone_number_id'],
                    'whatsapp_business_account_id' => $phone['waba_id'],
                    'phone_number'                 => $phone['phone_number'],
                    'display_name'                 => $displayLabel,
                ],
            ]
        );
    }

    private function redirectUri(): string
    {
        return route('dashboard.user.integrations.whatsapp-cloud.callback');
    }
}
