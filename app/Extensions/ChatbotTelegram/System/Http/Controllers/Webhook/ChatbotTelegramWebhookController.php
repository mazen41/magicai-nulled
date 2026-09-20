<?php

namespace App\Extensions\ChatbotTelegram\System\Http\Controllers\Webhook;

use App\Extensions\Chatbot\System\Models\Chatbot;
use App\Extensions\Chatbot\System\Models\ChatbotChannel;
use App\Extensions\Chatbot\System\Models\ChatbotChannelWebhook;
use App\Extensions\ChatbotTelegram\System\Services\Telegram\TelegramConversationService;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ChatbotTelegramWebhookController extends Controller
{
    public function __construct(
        public TelegramConversationService $service
    ) {}

    /**
     * Global webhook handler that routes via ConnectedAccount
     * Fallback to legacy channel-based routing for backward compatibility
     */
    public function handleGlobal(Request $request)
    {
        $botId = data_get($request->input('message'), 'from.id');

        if (!$botId) {
            Log::warning('Telegram webhook missing bot ID');
            return response('Bad Request', 400);
        }

        // First: try ConnectedAccount routing
        $account = \App\Models\ConnectedAccount::query()
            ->where('platform', 'telegram')
            ->where('account_identifier', $botId)
            ->where('connection_status', 'connected')
            ->first();

        if ($account) {
            // Find active chatbots for this account
            $chatbots = \App\Extensions\Chatbot\System\Models\Chatbot::query()
                ->where('connected_account_id', $account->id)
                ->where('active', true)
                ->get();

            if (!$chatbots->isEmpty()) {
                // Multi-chatbot routing: use most recently updated
                if ($chatbots->count() > 1) {
                    Log::info('Multiple chatbots for Telegram bot', [
                        'bot_id' => $botId,
                        'chatbot_count' => $chatbots->count(),
                        'selected_chatbot_id' => $chatbots->sortByDesc('updated_at')->first()->id,
                    ]);
                }
                
                $chatbot = $chatbots->sortByDesc('updated_at')->first();

                // Create or find channel
                $channel = ChatbotChannel::query()
                    ->where('chatbot_id', $chatbot->id)
                    ->where('channel', 'telegram')
                    ->first();

                if (!$channel) {
                    $channel = ChatbotChannel::create([
                        'user_id'      => $chatbot->user_id,
                        'chatbot_id'   => $chatbot->id,
                        'channel'      => 'telegram',
                        'credentials'  => [
                            'bot_id' => $botId,
                            'connected_account_id' => $account->id,
                        ],
                        'connected_at' => now(),
                    ]);
                }

                return $this->processWebhook($chatbot->id, $channel->id, $request);
            }
        }

        return response('OK', 200);
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
        if (! $request->get('update_id') && ! $request->get('message')) {
            return response('OK', 200);
        }

        ChatbotChannelWebhook::query()->create([
            'chatbot_id'         => $chatbotId,
            'chatbot_channel_id' => $channelId,
            'payload'            => $request->all(),
            'created_at'         => now(),
        ]);

        $this->service
            ->setIpAddress()
            ->setChatbotId($chatbotId)
            ->setChannelId($channelId)
            ->setPayload($request->all());

        $conversation = $this->service->storeConversation();

        if ($conversation === null) {
            return response('OK', 200);
        }

        /** @var Chatbot $chatbot */
        $chatbot = $this->service->getChatbot();

        $this->service->insertMessage(
            conversation: $conversation,
            message: $request->input('message.text') ?? '',
            role: 'user',
            model: $chatbot->getAttribute('ai_model')
        );

        $this->service->handleTelegram();

        return response('OK', 200);
    }
}
