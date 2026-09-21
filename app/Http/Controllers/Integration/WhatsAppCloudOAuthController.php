<?php

namespace App\Http\Controllers\Integration;

use App\Http\Controllers\Controller;
use App\Services\OAuth\ConnectedAccountService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

/**
 * WhatsApp Business Cloud API (Meta) connection controller.
 *
 * The user provides:
 *   - WhatsApp Business Account ID
 *   - Phone Number ID
 *   - Phone number (display)
 *   - Permanent Access Token (from Meta Business Manager / System User token)
 *
 * We store these as a ConnectedAccount with platform = 'whatsapp_cloud'.
 * The access token is stored encrypted; it is never returned to the frontend.
 */
class WhatsAppCloudOAuthController extends Controller
{
    public function __construct(
        private ConnectedAccountService $accountService
    ) {}

    /**
     * Show the WhatsApp Cloud API connect form.
     */
    public function connect()
    {
        return view('panel.user.integrations.whatsapp-cloud.connect');
    }

    /**
     * Store the WhatsApp Cloud API credentials as a ConnectedAccount.
     */
    public function store(Request $request)
    {
        $user = Auth::user();

        $request->validate([
            'phone_number_id'           => 'required|string|max:50',
            'whatsapp_business_account_id' => 'required|string|max:50',
            'access_token'              => 'required|string',
            'phone_number'              => 'required|string|max:30',
            'display_name'              => 'nullable|string|max=200',
        ]);

        $phoneNumberId = trim($request->input('phone_number_id'));
        $wabaId        = trim($request->input('whatsapp_business_account_id'));
        $accessToken   = trim($request->input('access_token'));
        $phoneNumber   = trim($request->input('phone_number'));
        $displayName   = trim($request->input('display_name', $phoneNumber));

        // Optionally verify the token by calling Meta's Graph API
        $verifiedName = $displayName;
        try {
            $graphVersion = config('services.meta.graph_version', 'v18.0');
            $response = Http::withToken($accessToken)
                ->timeout(8)
                ->get("https://graph.facebook.com/{$graphVersion}/{$phoneNumberId}", [
                    'fields' => 'display_phone_number,verified_name',
                ]);

            if ($response->successful()) {
                $data = $response->json();
                $verifiedName = $data['verified_name'] ?? $displayName;
                $phoneNumber  = $data['display_phone_number'] ?? $phoneNumber;
            }
        } catch (Exception $e) {
            Log::warning('WhatsApp Cloud: could not verify token against Graph API', [
                'user_id' => $user->id,
                'error'   => $e->getMessage(),
            ]);
            // Non-fatal — we still save the credentials the user provided
        }

        try {
            $this->accountService->createOrUpdate(
                user:              $user,
                platform:          'whatsapp_cloud',
                accountIdentifier: $phoneNumberId,     // The Phone Number ID is the routing key
                accessToken:       $accessToken,
                accountData: [
                    'name'     => $verifiedName ?: $phoneNumber,
                    'username' => $phoneNumber,
                    'avatar'   => null,
                    'metadata' => [
                        'phone_number_id'              => $phoneNumberId,
                        'whatsapp_business_account_id' => $wabaId,
                        'phone_number'                 => $phoneNumber,
                        'display_name'                 => $verifiedName ?: $phoneNumber,
                    ],
                ]
            );

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'success', 'message' => trans('WhatsApp Business account connected successfully.')]);

        } catch (Exception $e) {
            Log::error('WhatsApp Cloud connection failed', [
                'user_id' => $user->id,
                'error'   => $e->getMessage(),
            ]);

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Failed to connect WhatsApp Business account. Please check your credentials.')]);
        }
    }
}
