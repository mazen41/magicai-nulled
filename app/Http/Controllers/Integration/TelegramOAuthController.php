<?php

namespace App\Http\Controllers\Integration;

use App\Http\Controllers\Controller;
use App\Services\OAuth\ConnectedAccountService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class TelegramOAuthController extends Controller
{
    public function __construct(
        private ConnectedAccountService $accountService
    ) {}

    public function connect(Request $request)
    {
        $user = Auth::user();

        $request->validate([
            'bot_token' => 'required|string|min:35|max:55',
        ]);

        $botToken = $request->input('bot_token');

        try {
            // Verify bot token by calling getMe API
            $response = Http::post("https://api.telegram.org/bot{$botToken}/getMe")->throw()->json();

            if (!$response['ok']) {
                throw new Exception('Invalid Telegram bot token');
            }

            $botInfo = $response['result'];
            $botId = $botInfo['id'];
            $botUsername = $botInfo['username'];
            $botName = $botInfo['first_name'];

            // Save to connected_accounts
            $this->accountService->createOrUpdate(
                user:              $user,
                platform:          'telegram',
                accountIdentifier: $botId,
                accessToken:       $botToken,
                accountData: [
                    'name'     => $botName,
                    'username' => $botUsername,
                    'avatar'   => null,
                    'metadata' => [
                        'bot_type' => $botInfo['bot_type'] ?? 'bot',
                        'can_join_groups' => $botInfo['can_join_groups'] ?? false,
                        'supports_inline_queries' => $botInfo['supports_inline_queries'] ?? false,
                    ],
                ]
            );

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'success', 'message' => trans('Telegram bot connected successfully.')]);

        } catch (Exception $e) {
            Log::error('Telegram bot connection failed', ['user_id' => $user->id, 'error' => $e->getMessage()]);

            return redirect()->route('dashboard.user.integrations.index')
                ->with(['type' => 'error', 'message' => trans('Failed to connect Telegram bot. Please verify the token.')]);
        }
    }

    public function setupWebhook(Request $request, ConnectedAccount $account)
    {
        $user = Auth::user();

        if ($account->user_id !== $user->id) {
            abort(403, 'Unauthorized');
        }

        if ($account->platform !== 'telegram') {
            abort(400, 'Not a Telegram account');
        }

        $webhookUrl = $request->input('webhook_url');

        if (!$webhookUrl) {
            return response()->json(['error' => 'webhook_url required'], 400);
        }

        try {
            $botToken = $account->access_token;
            $botId = $account->account_identifier;

            // Set webhook
            $response = Http::post("https://api.telegram.org/bot{$botToken}/setWebhook", [
                'url' => $webhookUrl,
            ])->throw()->json();

            if (!$response['ok']) {
                throw new Exception('Failed to set Telegram webhook: ' . ($response['description'] ?? 'Unknown error'));
            }

            // Update webhook status
            $account->update([
                'webhook_registered' => true,
                'metadata' => array_merge($account->metadata ?? [], [
                    'webhook_url' => $webhookUrl,
                ]),
            ]);

            return response()->json([
                'status' => 'success',
                'message' => trans('Telegram webhook configured successfully.'),
            ]);

        } catch (Exception $e) {
            Log::error('Telegram webhook setup failed', ['account_id' => $account->id, 'error' => $e->getMessage()]);

            return response()->json([
                'status' => 'error',
                'message' => trans('Failed to configure Telegram webhook.'),
            ], 500);
        }
    }
}
