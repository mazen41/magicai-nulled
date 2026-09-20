<?php

namespace App\Extensions\ChatbotMessenger\System\Http\Controllers\Webhook;

use App\Extensions\Chatbot\System\Models\ChatbotChannel;
use App\Extensions\Chatbot\System\Models\ChatbotChannelWebhook;
use App\Extensions\ChatbotMessenger\System\Services\MessengerConversationService;
use App\Http\Controllers\Controller;
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
     * Fallback to legacy channel-based routing for backward compatibility
     */
    public function handleGlobal(Request $request)
    {
        // Handle Meta webhook verification (GET)
        if ($request->isMethod('get')) {
            return $this->verifyWebhookSubscription($request);
        }

        // Handle webhook events (POST)
        $pageId = data_get($request->input('entry.0'), 'id');

        if (!$pageId) {
            Log::warning('Messenger webhook missing page ID');
            return response('Bad Request', 400);
        }

        // First: try ConnectedAccount routing
        $account = \App\Models\ConnectedAccount::query()
            ->where('platform', 'messenger')
            ->where('account_identifier', $pageId)
            ->where('connection_status', 'connected')
            ->first();

        if ($account) {
            // Find active chatbots for this account using the new relationship
            $chatbots = $account->extChatbots()
                ->where('active', true)
                ->get();

            if (!$chatbots->isEmpty()) {
                // Multi-chatbot routing: use most recently updated
                if ($chatbots->count() > 1) {
                    Log::info('Multiple chatbots for Messenger page', [
                        'page_id' => $pageId,
                        'chatbot_count' => $chatbots->count(),
                        'selected_chatbot_id' => $chatbots->sortByDesc('updated_at')->first()->id,
                    ]);
                }

                $chatbot = $chatbots->sortByDesc('updated_at')->first();

                // Create or find channel
                $channel = ChatbotChannel::query()
                    ->where('chatbot_id', $chatbot->id)
                    ->where('channel', 'messenger')
                    ->first();

                if (!$channel) {
                    $channel = ChatbotChannel::create([
                        'user_id'      => $chatbot->user_id,
                        'chatbot_id'   => $chatbot->id,
                        'channel'      => 'messenger',
                        'credentials'  => [
                            'page_id' => $pageId,
                            'connected_account_id' => $account->id,
                        ],
                        'connected_at' => now(),
                    ]);
                }

                return $this->processWebhook($chatbot->id, $channel->id, $request);
            }
        }

        // Fallback: verify with global app secret for existing channels
        $this->verifyWebhook(setting('INSTAGRAM_APP_SECRET') ?? '');

        return response('OK', 200);
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

        ChatbotChannelWebhook::query()->create([
            'chatbot_id'         => $chatbotId,
            'chatbot_channel_id' => $channelId,
            'payload'            => $request->all(),
            'created_at'         => now(),
        ]);

        $this->verifyWebhook(data_get($channel['credentials'], 'verify_token', ''));

        if (! $request->input('entry.0.messaging.0')) {
            return response('OK', 200);
        }

        $this->service
            ->setIpAddress()
            ->setChatbotId($chatbotId)
            ->setChannelId($channelId)
            ->setPayload($request->input('entry.0.messaging.0'));

        $conversation = $this->service->storeConversation();

        /**
         * @var ChatbotChannel $chatbot
         */
        $chatbot = $this->service->getChatbot();

        $this->service->insertMessage(
            conversation: $conversation,
            message: $request->input('entry.0.messaging.0.message.text') ?? '',
            role: 'user',
            model: $chatbot->getAttribute('ai_model')
        );

        $this->service->handle();

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
