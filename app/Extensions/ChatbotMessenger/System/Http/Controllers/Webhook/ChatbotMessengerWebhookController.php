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
        Log::info('[FB WEBHOOK DEBUG] REQUEST RECEIVED', [
            'method' => $request->method(),
            'url' => $request->fullUrl(),
            'content_type' => $request->header('Content-Type'),
            'object' => $request->input('object'),
            'entry_count' => count($request->input('entry', [])),
        ]);

        // Handle Meta webhook verification (GET)
        if ($request->isMethod('get')) {
            return $this->verifyWebhookSubscription($request);
        }

        // Only process 'page' object webhooks
        if ($request->input('object') !== 'page') {
            Log::info('[FB WEBHOOK DEBUG] Ignoring non-page object', [
                'object' => $request->input('object'),
            ]);
            return response('OK', 200);
        }

        $pageId   = data_get($request->input('entry.0'), 'id');
        $messaging = $request->input('entry.0.messaging.0');
        $changes = $request->input('entry.0.changes', []);

        Log::info('[FB WEBHOOK DEBUG] Page event received', [
            'page_id' => $pageId,
            'has_messaging' => !empty($messaging),
            'has_changes' => !empty($changes),
            'change_count' => count($changes),
            'messaging_keys' => $messaging ? array_keys($messaging) : [],
        ]);

        // CHECK FOR FEED EVENTS AND ROUTE TO AUTOMATION PROCESSOR
        if (!empty($changes)) {
            foreach ($changes as $change) {
                $field = $change['field'] ?? '';
                $value = $change['value'] ?? [];

                if ($field === 'feed') {
                    Log::info('[FB WEBHOOK DEBUG] FEED EVENT - Routing to SocialMediaAutomation processor', [
                        'page_id' => $pageId,
                        'item' => $value['item'] ?? null,
                        'verb' => $value['verb'] ?? null,
                    ]);

                    // Try to process feed events via SocialMediaAutomation
                    if (class_exists(\App\Extensions\SocialMediaAutomation\System\Services\WebhookProcessor::class)) {
                        try {
                            $processor = app(\App\Extensions\SocialMediaAutomation\System\Services\WebhookProcessor::class);
                            $processor->processFacebookPayload($request->json()->all());
                            Log::info('[FB WEBHOOK DEBUG] Feed event processed by SocialMediaAutomation');
                        } catch (\Throwable $e) {
                            Log::error('[FB WEBHOOK DEBUG] SocialMediaAutomation processing failed', [
                                'error' => $e->getMessage(),
                                'file' => $e->getFile(),
                                'line' => $e->getLine(),
                            ]);
                        }
                    } else {
                        Log::warning('[FB WEBHOOK DEBUG] SocialMediaAutomation extension not found');
                    }

                    // Return after processing feed event
                    return response('OK', 200);
                }
            }
        }

        // Original messaging event handling continues below
        $messaging = $request->input('entry.0.messaging.0');

        if (!$pageId) {
            Log::warning('[FB WEBHOOK DEBUG] Missing page ID in entry.0.id');
            return response('Bad Request', 400);
        }

        if (!$messaging) {
            Log::info('[FB WEBHOOK DEBUG] No messaging entry, skipping (this was a feed event)');
            return response('OK', 200);
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

        // Find ALL chatbots linked to this account via the pivot table (don't filter by active — let the chatbot's own logic handle that)
        $allChatbots = $account->extChatbots()->get();
        $chatbots    = $allChatbots->where('active', true);

        Log::info('Messenger webhook: chatbots found for account', [
            'account_id'        => $account->id,
            'page_id'           => $pageId,
            'total_linked'      => $allChatbots->count(),
            'active_count'      => $chatbots->count(),
            'all_chatbot_ids'   => $allChatbots->pluck('id')->toArray(),
            'active_chatbot_ids' => $chatbots->pluck('id')->toArray(),
        ]);

        // If no active chatbots, fall back to any linked chatbot
        if ($chatbots->isEmpty()) {
            $chatbots = $allChatbots;
            Log::warning('Messenger webhook: no active chatbots found — falling back to all linked chatbots (including inactive)', [
                'account_id'   => $account->id,
                'page_id'      => $pageId,
                'chatbot_count' => $chatbots->count(),
            ]);
        }

        if ($chatbots->isEmpty()) {
            Log::warning('Messenger webhook: account has NO linked chatbots at all — assign one on the Channel step', [
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
        // Note: $account->access_token uses the 'encrypted' cast and returns the plaintext value even though it's in $hidden.
        $rawToken = $account->access_token;

        Log::info('Messenger webhook: building credentials', [
            'chatbot_id'   => $chatbot->id,
            'account_id'   => $account->id,
            'has_token'    => !empty($rawToken),
            'token_prefix' => $rawToken ? substr($rawToken, 0, 8) . '...' : 'EMPTY',
        ]);

        $credentials = [
            'page_id'              => $pageId,
            'connected_account_id' => $account->id,
            'access_token'         => $rawToken,
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
            Log::info('Messenger webhook: refreshed ChatbotChannel credentials', ['channel_id' => $channel->id]);
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
        try {
            ChatbotChannelWebhook::query()->create([
                'chatbot_id'         => $chatbotId,
                'chatbot_channel_id' => $channelId,
                'payload'            => $request->all(),
                'created_at'         => now(),
            ]);
        } catch (\Throwable $e) {
            Log::warning('Messenger webhook: could not persist webhook payload', ['error' => $e->getMessage()]);
        }

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

        // Skip delivery/read receipts
        if (isset($messaging['delivery']) || isset($messaging['read'])) {
            Log::info('Messenger webhook: skipping delivery/read receipt', ['chatbot_id' => $chatbotId]);
            return response('OK', 200);
        }

        $messageText = data_get($messaging, 'message.text');
        $senderId    = data_get($messaging, 'sender.id');

        Log::info('Messenger webhook: processing message', [
            'chatbot_id'      => $chatbotId,
            'channel_id'      => $channelId,
            'sender_id'       => $senderId,
            'has_text'        => !empty($messageText),
            'message_preview' => $messageText ? mb_substr($messageText, 0, 80) : null,
            'channel_creds'   => [
                'has_page_id'     => !empty(data_get($channel->credentials, 'page_id')),
                'has_token'       => !empty(data_get($channel->credentials, 'access_token')),
                'token_prefix'    => data_get($channel->credentials, 'access_token')
                    ? substr(data_get($channel->credentials, 'access_token'), 0, 8) . '...'
                    : 'MISSING',
            ],
        ]);

        try {
            $this->service
                ->setIpAddress()
                ->setChatbotId($chatbotId)
                ->setChannelId($channelId)
                ->setPayload($messaging);

            $conversation = $this->service->storeConversation();

            /** @var \App\Extensions\Chatbot\System\Models\Chatbot $chatbot */
            $chatbot = $this->service->getChatbot();

            Log::info('Messenger webhook: conversation stored, inserting user message', [
                'chatbot_id'      => $chatbotId,
                'conversation_id' => $conversation->id,
                'chatbot_active'  => $chatbot->getAttribute('active'),
                'ai_model'        => $chatbot->getAttribute('ai_model'),
            ]);

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
        } catch (\Throwable $e) {
            Log::error('Messenger webhook: FATAL error during message processing', [
                'chatbot_id' => $chatbotId,
                'channel_id' => $channelId,
                'error'      => $e->getMessage(),
                'file'       => $e->getFile() . ':' . $e->getLine(),
                'trace'      => mb_substr($e->getTraceAsString(), 0, 2000),
            ]);
        }

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
