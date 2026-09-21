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

        // Support both JSON body and form-data submissions
        $accountIds = $request->input('connected_account_ids', []);

        // Ensure we always have a plain array of integers
        if (!is_array($accountIds)) {
            $accountIds = [];
        }
        $accountIds = array_values(array_filter(array_map('intval', $accountIds)));

        // Verify all accounts belong to the user and are connected
        if (!empty($accountIds)) {
            $accounts = ConnectedAccount::query()
                ->where('user_id', $user->id)
                ->where('connection_status', 'connected')
                ->whereIn('id', $accountIds)
                ->get();

            if ($accounts->count() !== count($accountIds)) {
                return response()->json([
                    'status'  => 'error',
                    'message' => trans('One or more connected accounts not found or access denied.'),
                ], 403);
            }
        }

        // Sync the many-to-many relationship
        $chatbot->connectedAccounts()->sync($accountIds);

        // Reload the relation so the response reflects the actual DB state
        $chatbot->load('connectedAccounts');
        $savedIds = $chatbot->connectedAccounts->pluck('id')->map(fn ($id) => (int) $id)->toArray();

        return response()->json([
            'status'  => 'success',
            'message' => trans('Account selection saved.'),
            'data'    => [
                'connected_account_ids' => $savedIds,
            ],
        ]);
    }
}
