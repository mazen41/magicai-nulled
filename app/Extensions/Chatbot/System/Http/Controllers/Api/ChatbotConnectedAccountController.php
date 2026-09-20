<?php

namespace App\Extensions\Chatbot\System\Http\Controllers\Api;

use App\Extensions\Chatbot\System\Models\Chatbot as ExtChatbot;
use App\Http\Controllers\Controller;
use App\Models\ConnectedAccount;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ChatbotConnectedAccountController extends Controller
{
    public function update(Request $request, int $chatbotId): JsonResponse
    {
        $user = Auth::user();

        $chatbot = ExtChatbot::query()
            ->where('user_id', $user->id)
            ->findOrFail($chatbotId);

        $accountId = $request->input('connected_account_id');
        $platform = $request->input('platform');

        if ($accountId) {
            // Verify ownership
            $account = ConnectedAccount::query()
                ->where('user_id', $user->id)
                ->where('connection_status', 'connected')
                ->find($accountId);

            if (!$account) {
                return response()->json([
                    'status'  => 'error',
                    'message' => trans('Connected account not found or access denied.'),
                ], 403);
            }

            // Validate platform compatibility if provided
            if ($platform && $account->platform !== $platform) {
                return response()->json([
                    'status'  => 'error',
                    'message' => trans('Connected account platform does not match required platform.'),
                ], 400);
            }
        }

        $chatbot->update([
            'connected_account_id' => $accountId ?: null,
        ]);

        return response()->json([
            'status'  => 'success',
            'message' => trans('Account selection saved.'),
            'data'    => ['connected_account_id' => $chatbot->connected_account_id],
        ]);
    }
}
