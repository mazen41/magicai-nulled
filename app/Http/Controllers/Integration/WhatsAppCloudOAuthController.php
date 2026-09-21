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
 * WhatsApp Business Cloud API — Meta Embedded Signup flow.
 *
 * Flow:
 *   connect()  → redirect to Meta Embedded Signup URL
 *   callback() → receive session info → verify → obtain token → save ConnectedAccount
 */
class WhatsAppCloudOAuthController extends Controller
{
    public function __construct(
        private OAuthStateService $stateService,
        private ConnectedAccountService $accountService
    ) {}

    // -------------------------------------------------------------------------
    // Step 1: Redirect to Meta Embedded Signup
    // -------------------------------------------------------------------------
    public function connect()
    {
        $user  = Auth::user();
        $appId = config('services.meta.whatsapp.app_id');
        $configId = config('services.meta.whatsapp.config_id');

        if (empty($appId)) {
            return back()->with([
                'type'    => 'error',
                'message' => trans('WhatsApp App ID is not configured. Please contact the administrator.'),
            ]);
        }

        if (empty($configId)) {
            return back()->with([
                'type'    => 'error',
                'message' => trans('WhatsApp Embedded Signup Config ID is not configured. Please contact the administrator.'),
            ]);
        }

        $state = $this->stateService->generate('whatsapp_cloud', $user->id);

        // Meta Embedded Signup URL with required parameters
        $params = [
            'app_id'        => $appId,
            'config_id'     => $configId,
            'callback_url'  => $this->redirectUri(),
            'state'         => $state,
            'extras'        => json_encode([
                'sessionInfoVersion' => '3',
                'version' => 'v4',
            ]),
        ];

        $embeddedSignupUrl = 'https://business.facebook.com/messaging/whatsapp/onboard/?' . http_build_query($params);

        Log::info('WhatsApp Cloud: Redirecting to Embedded Signup', [
            'user_id' => $user->id,
            'app_id' => $appId,
            'config_id' => $configId,
        ]);

        return redirect()->away($embeddedSignupUrl);
    }

    // -------------------------------------------------------------------------
    // Step 2: Meta redirects back with session info
    // -------------------------------------------------------------------------
    public function callback(Request $request)
    {
        $user = Auth::user();

        // Handle errors from Meta
        if ($request->has('error')) {
            Log::warning('WhatsApp Cloud: Embedded Signup error', [
                'user_id' => $user->id,
                'error' => $request->input('error'),
                'error_description' => $request->input('error_description'),
            ]);

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('WhatsApp authorization was denied or failed.')]);
        }

        // Validate state
        $state = $request->input('state');
        if (! $state || ! $this->stateService->validate('whatsapp_cloud', $user->id, $state)) {
            Log::warning('WhatsApp Cloud: Invalid OAuth state', ['user_id' => $user->id]);
            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Invalid or expired OAuth state. Please try again.')]);
        }

        try {
            $graphVersion = config('services.meta.graph_version', 'v18.0');

            // Extract Embedded Signup session information
            $wabaId = $request->input('wa_id');
            $phoneNumberId = $request->input('phone_number_id');
            $phoneNumber = $request->input('phone_number');
            $displayPhoneNumber = $request->input('display_phone_number');

            Log::info('WhatsApp Cloud: Received Embedded Signup callback', [
                'user_id' => $user->id,
                'waba_id' => $wabaId,
                'phone_number_id' => $phoneNumberId,
                'has_phone_number' => !empty($phoneNumber),
            ]);

            // Validate required parameters
            if (empty($wabaId) || empty($phoneNumberId)) {
                Log::error('WhatsApp Cloud: Missing required Embedded Signup parameters', [
                    'user_id' => $user->id,
                    'waba_id' => $wabaId,
                    'phone_number_id' => $phoneNumberId,
                ]);

                return redirect()->route('dashboard.user.integrations.index')
                    ->with(['type' => 'error', 'message' => trans('WhatsApp Embedded Signup did not return required information. Please try again.')]);
            }

            // Obtain system user access token using app credentials
            // This token is used to verify the WABA and get a permanent access token
            $tokenRes = Http::asForm()
                ->post("https://graph.facebook.com/{$graphVersion}/oauth/access_token", [
                    'client_id'     => config('services.meta.whatsapp.app_id'),
                    'client_secret' => config('services.meta.whatsapp.app_secret'),
                    'grant_type'    => 'client_credentials',
                ])->throw()->json();

            $systemUserToken = $tokenRes['access_token'];

            // Get the WhatsApp Business Account details to verify access
            $wabaRes = Http::withToken($systemUserToken)
                ->get("https://graph.facebook.com/{$graphVersion}/{$wabaId}", [
                    'fields' => 'id,name,currency,message_template_namespace',
                ])->throw()->json();

            // Get the phone number details to verify and get more info
            $phoneRes = Http::withToken($systemUserToken)
                ->get("https://graph.facebook.com/{$graphVersion}/{$phoneNumberId}", [
                    'fields' => 'id,display_phone_number,verified_name,quality_rating',
                ])->throw()->json();

            // Subscribe the phone number to the webhook (optional but recommended)
            $webhookUrl = config('app.url') . '/api/v2/chatbot/webhook/whatsapp';
            $webhookVerifyToken = env('WHATSAPP_WEBHOOK_VERIFY_TOKEN');

            try {
                Http::withToken($systemUserToken)
                    ->post("https://graph.facebook.com/{$graphVersion}/{$phoneNumberId}/subscribers", [
                        'webhook_url' => $webhookUrl,
                        'fields' => 'messages',
                        'verify_token' => $webhookVerifyToken,
                    ]);

                Log::info('WhatsApp Cloud: Webhook subscribed successfully', [
                    'phone_number_id' => $phoneNumberId,
                ]);
            } catch (Exception $e) {
                Log::warning('WhatsApp Cloud: Failed to subscribe webhook', [
                    'phone_number_id' => $phoneNumberId,
                    'error' => $e->getMessage(),
                ]);
                // Continue anyway - webhook can be configured later
            }

            // Create or update ConnectedAccount
            $displayLabel = $phoneRes['verified_name'] ?? $displayPhoneNumber ?? $phoneNumber ?? 'WhatsApp Business';

            $this->accountService->createOrUpdate(
                user:              $user,
                platform:          'whatsapp_cloud',
                accountIdentifier: $phoneNumberId,
                accessToken:       $systemUserToken,
                accountData: [
                    'name'     => $displayLabel,
                    'username' => $displayPhoneNumber ?? $phoneNumber,
                    'avatar'   => null,
                    'metadata' => [
                        'phone_number_id'              => $phoneNumberId,
                        'whatsapp_business_account_id' => $wabaId,
                        'phone_number'                 => $displayPhoneNumber ?? $phoneNumber,
                        'display_name'                 => $displayLabel,
                        'waba_name'                    => $wabaRes['name'] ?? 'Unknown',
                        'currency'                     => $wabaRes['currency'] ?? null,
                        'quality_rating'               => $phoneRes['quality_rating'] ?? null,
                    ],
                ]
            );

            Log::info('WhatsApp Cloud: ConnectedAccount created successfully', [
                'user_id' => $user->id,
                'waba_id' => $wabaId,
                'phone_number_id' => $phoneNumberId,
            ]);

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'success', 'message' => trans('WhatsApp Business account connected successfully.')]);

        } catch (Exception $e) {
            Log::error('WhatsApp Cloud Embedded Signup callback failed', [
                'user_id' => $user->id,
                'error'   => $e->getMessage(),
                'trace'   => $e->getTraceAsString(),
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
