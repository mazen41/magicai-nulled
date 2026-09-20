<?php

namespace App\Http\Controllers\Integration;

use App\Http\Controllers\Controller;
use App\Services\OAuth\ConnectedAccountService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class WhatsAppOAuthController extends Controller
{
    public function __construct(
        private ConnectedAccountService $accountService
    ) {}

    public function connect(Request $request)
    {
        $user = Auth::user();

        $request->validate([
            'account_sid' => 'required|string',
            'auth_token' => 'required|string',
            'phone_number' => 'required|string',
            'environment' => 'required|in:sandbox,production',
        ]);

        try {
            // Store Twilio credentials in connected_accounts
            $this->accountService->createOrUpdate(
                user:              $user,
                platform:          'whatsapp',
                accountIdentifier: $request->input('account_sid'),
                accessToken:       $request->input('auth_token'),
                accountData: [
                    'name'     => $request->input('phone_number'),
                    'username' => $request->input('account_sid'),
                    'avatar'   => null,
                    'metadata' => [
                        'phone_number' => $request->input('phone_number'),
                        'environment' => $request->input('environment'),
                        'sandbox_phone' => $request->input('sandbox_phone'),
                    ],
                ]
            );

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'success', 'message' => trans('WhatsApp (Twilio) account connected successfully.')]);

        } catch (Exception $e) {
            Log::error('WhatsApp connection failed', ['user_id' => $user->id, 'error' => $e->getMessage()]);

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Failed to connect WhatsApp account.')]);
        }
    }
}
