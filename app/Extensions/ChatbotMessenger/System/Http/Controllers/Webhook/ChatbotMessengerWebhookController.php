<?php

namespace App\Extensions\ChatbotMessenger\System\Http\Controllers\Webhook;

use App\Extensions\Chatbot\System\Models\ChatbotChannel;
use App\Extensions\Chatbot\System\Models\ChatbotChannelWebhook;
use App\Extensions\ChatbotMessenger\System\Services\MessengerConversationService;
use App\Http\Controllers\Controller;
use App\Models\ConnectedAccount;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ChatbotMessengerWebhookController extends Controller
{
    public function __construct(
        public MessengerConversationService $service
    ) {}

    /**
     * Global webhook handler that routes via ConnectedAccount
     * GET: Meta webhook verification
     * POST: Handle actual Facebook Messenger events
     */
    public function handleGlobal(Request $request)
    {
        // Handle Meta webhook verification (GET)
        if ($request->isMethod('get')) {
            return $this->verifyWebhookSubscription($request);
        }

        // Only process 'page' object webhooks
        if ($request->input('object') !== 'page') {
            Log::info('Messenger webhook: ignoring non-page object', [
                'object' => $request->input('object'),
            ]);
            return response('OK', 200);
        }

        $pageId   = data_get($request->input('entry.0'), 'id');
        $messaging = $request->input('entry.0.messaging.0');

        Log::info('Messenger webhook POST received', [
            'page_id'        => $pageId,
            'has_messaging'  => !empty($messaging),
            'messaging_keys' => $messaging ? array_keys($messaging) : [],
        ]);

        if (!$pageId) {
            Log::warning('Messenger webhook missing page ID in entry.0.id');
            return response('Bad Request', 400);
        }

        // Look up the ConnectedAccount for this page
        $account = ConnectedAccount::query()
            ->where('platform', 'messenger')
            ->where('account_identifier', $pageId)
            ->where('connection_status', 'connected')
            ->first();

        if (!$account) {
            Log::warning('Messenger webhook: no ConnectedAccount found for page', [
                'page_id' => $pageId,
            ]);
            return response('OK', 200);
        }

        // Find active chatbots linked to this account via the pivot table
        $chatbots = $account->extChatbots()
            ->where('active', true)
            ->get();

        Log::info('Messenger webhook: chatbots found for account', [
            'account_id'   => $account->id,
            'page_id'      => $pageId,
            'chatbot_count' => $chatbots->count(),
            'chatbot_ids'  => $chatbots->pluck('id')->toArray(),
        ]);

        if ($chatbots->isEmpty()) {
            Log::warning('Messenger webhook: account has no active linked chatbots — assign one on the Channel step', [
                'account_id' => $account->id,
                'page_id'    => $pageId,
            ]);
            return response('OK', 200);
        }

        if ($chatbots->count() > 1) {
            Log::info('Messenger webhook: multiple chatbots, using most recently updated', [
                'selected_id' => $chatbots->sortByDesc('updated_at')->first()->id,
            ]);
        }

        $chatbot = $chatbots->sortByDesc('updated_at')->first();

        // Find or create the ChatbotChannel, ensuring access_token is always up to date
        $channel = ChatbotChannel::query()
            ->where('chatbot_id', $chatbot->id)
            ->where('channel', 'messenger')
            ->first();

        // The Page access token lives on the ConnectedAccount (encrypted).
        // We must store/refresh it in channel credentials so MessengerService can send replies.
        $credentials = [
            'page_id'              => $pageId,
            'connected_account_id' => $account->id,
            'access_token'         => $account->access_token, // decrypted by model cast
        ];

        if (!$channel) {
            $channel = ChatbotChannel::create([
                'user_id'      => $chatbot->user_id,
                'chatbot_id'   => $chatbot->id,
                'channel'      => 'messenger',
                'credentials'  => $credentials,
                'connected_at' => now(),
            ]);
            Log::info('Messenger webhook: created ChatbotChannel', ['channel_id' => $channel->id]);
        } else {
            // Refresh the access token in case it was rotated
            $channel->update(['credentials' => $credentials]);
        }

        return $this->processWebhook($chatbot->id, $channel->id, $request);
    }

    /**
     * Verify Meta webhook subscription
     * Meta sends GET with hub.mode, hub.verify_token, hub.challenge
     */
    protected function verifyWebhookSubscription(Request $request)
    {
        $mode = $request->query('hub_mode');
        $token = $request->query('hub_verify_token');
        $challenge = $request->query('hub_challenge');

        $expectedToken = env('MESSENGER_WEBHOOK_VERIFY_TOKEN');

        if (!$expectedToken) {
            Log::error('Messenger webhook verification failed: MESSENGER_WEBHOOK_VERIFY_TOKEN not configured in .env');
            return response('Webhook verification token not configured', 500);
        }

        if ($mode === 'subscribe' && $token === $expectedToken) {
            Log::info('Messenger webhook verification successful');
            return response($challenge, 200);
        }

        Log::warning('Messenger webhook verification failed', [
            'mode' => $mode,
            'token_received' => $token,
            'token_expected' => $expectedToken,
        ]);

        return response('Forbidden', 403);
    }

    /**
     * Legacy channel-based webhook handler (backward compatibility)
     */
    public function handle(
        int $chatbotId,
        int $channelId,
        Request $request
    ) {
        return $this->processWebhook($chatbotId, $channelId, $request);
    }

    private function processWebhook(int $chatbotId, int $channelId, Request $request)
    {
        $channel = ChatbotChannel::query()->findOrFail($channelId);

        // Persist the raw webhook payload for debugging
        ChatbotChannelWebhook::query()->create([
            'chatbot_id'         => $chatbotId,
            'chatbot_channel_id' => $channelId,
            'payload'            => $request->all(),
            'created_at'         => now(),
        ]);

        $messaging = $request->input('entry.0.messaging.0');

        if (!$messaging) {
            // Delivery receipts, read events, etc. — not a user message, skip silently
            Log::info('Messenger webhook: no messaging entry, skipping (delivery/read event)', [
                'chatbot_id' => $chatbotId,
                'entry_keys' => array_keys($request->input('entry.0', [])),
            ]);
            return response('OK', 200);
        }

        // Skip echo events (messages sent by the page itself)
        if (data_get($messaging, 'message.is_echo')) {
            Log::info('Messenger webhook: skipping echo message', ['chatbot_id' => $chatbotId]);
            return response('OK', 200);
        }

        $messageText = data_get($messaging, 'message.text');
        $senderId    = data_get($messaging, 'sender.id');

        Log::info('Messenger webhook: processing message', [
            'chatbot_id'  => $chatbotId,
            'channel_id'  => $channelId,
            'sender_id'   => $senderId,
            'has_text'    => !empty($messageText),
            'message_preview' => $messageText ? mb_substr($messageText, 0, 80) : null,
        ]);

        $this->service
            ->setIpAddress()
            ->setChatbotId($chatbotId)
            ->setChannelId($channelId)
            ->setPayload($messaging);

        $conversation = $this->service->storeConversation();

        /** @var \App\Extensions\Chatbot\System\Models\Chatbot $chatbot */
        $chatbot = $this->service->getChatbot();

        $this->service->insertMessage(
            conversation: $conversation,
            message:      $messageText ?? '',
            role:         'user',
            model:        $chatbot->getAttribute('ai_model')
        );

        $this->service->handle();

        Log::info('Messenger webhook: message handled successfully', [
            'chatbot_id'      => $chatbotId,
            'conversation_id' => $conversation->id,
        ]);

        return response('OK', 200);
    }

    private function verifyWebhook($verifyToken): void
    {
        if (isset($_GET['hub_verify_token']) && $_GET['hub_verify_token'] === $verifyToken) {
            if (isset($_GET['hub_challenge'])) {
                echo $_GET['hub_challenge'];
                exit;
            }
        }
    }
}
