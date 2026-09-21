<?php

namespace App\Extensions\ChatbotWhatsapp\System\Http\Controllers\Webhook;

use App\Extensions\Chatbot\System\Models\ChatbotChannel;
use App\Extensions\Chatbot\System\Models\ChatbotChannelWebhook;
use App\Extensions\ChatbotWhatsapp\System\Services\WhatsAppCloudConversationService;
use App\Http\Controllers\Controller;
use App\Models\ConnectedAccount;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Log;

/**
 * Handles Meta WhatsApp Cloud API webhooks.
 *
 * GET  api/v2/chatbot/webhook/whatsapp  — Meta hub verification
 * POST api/v2/chatbot/webhook/whatsapp  — Incoming message events
 *
 * Routing follows the same pattern as ChatbotMessengerWebhookController:
 *   1. Extract the Phone Number ID from the payload.
 *   2. Look up the ConnectedAccount (platform = 'whatsapp_cloud', account_identifier = phone_number_id).
 *   3. Find the most recently updated active chatbot linked via chatbot_connected_accounts.
 *   4. Find or create a ChatbotChannel record that carries the credentials.
 *   5. Delegate to WhatsAppCloudConversationService.
 */
class ChatbotWhatsAppCloudWebhookController extends Controller
{
    public function __construct(
        private WhatsAppCloudConversationService $service
    ) {}

    // -----------------------------------------------------------------------
    // Global entry point (GET = verify, POST = handle)
    // -----------------------------------------------------------------------

    public function handleGlobal(Request $request)
    {
        if ($request->isMethod('get')) {
            return $this->verifyWebhookSubscription($request);
        }

        return $this->handlePost($request);
    }

    // -----------------------------------------------------------------------
    // GET — Meta hub verification
    // -----------------------------------------------------------------------

    protected function verifyWebhookSubscription(Request $request): Response
    {
        $mode      = $request->query('hub_mode');
        $token     = $request->query('hub_verify_token');
        $challenge = $request->query('hub_challenge');

        $expected = env('WHATSAPP_WEBHOOK_VERIFY_TOKEN');

        if (! $expected) {
            Log::error('WhatsApp Cloud webhook: WHATSAPP_WEBHOOK_VERIFY_TOKEN not set in .env');
            return response('Webhook verify token not configured', 500);
        }

        if ($mode === 'subscribe' && hash_equals($expected, (string) $token)) {
            Log::info('WhatsApp Cloud webhook verification successful');
            return response((string) $challenge, 200);
        }

        Log::warning('WhatsApp Cloud webhook verification failed', [
            'mode'           => $mode,
            'token_received' => $token,
        ]);

        return response('Forbidden', 403);
    }

    // -----------------------------------------------------------------------
    // POST — Incoming message
    // -----------------------------------------------------------------------

    protected function handlePost(Request $request)
    {
        // Only handle 'whatsapp_business_account' object
        if ($request->input('object') !== 'whatsapp_business_account') {
            return response('OK', 200);
        }

        // Navigate the nested Meta payload to the first message
        $entry   = $request->input('entry.0');
        $changes = data_get($entry, 'changes.0');
        $value   = data_get($changes, 'value');

        // Phone Number ID is the routing key — maps to ConnectedAccount.account_identifier
        $phoneNumberId = data_get($value, 'metadata.phone_number_id');

        if (! $phoneNumberId) {
            Log::warning('WhatsApp Cloud webhook: missing phone_number_id in payload');
            return response('OK', 200);
        }

        // Only process inbound messages (not status updates)
        $messages = data_get($value, 'messages');
        if (empty($messages)) {
            // Status update (delivered, read, etc.) — acknowledge and ignore
            return response('OK', 200);
        }

        $message = $messages[0];
        $messageType = data_get($message, 'type', 'text');

        // We only process text messages in this implementation
        if ($messageType !== 'text') {
            Log::info('WhatsApp Cloud webhook: ignoring non-text message', [
                'type'           => $messageType,
                'phone_number_id' => $phoneNumberId,
            ]);
            return response('OK', 200);
        }

        Log::info('WhatsApp Cloud webhook POST received', [
            'phone_number_id' => $phoneNumberId,
            'from'            => data_get($message, 'from'),
            'message_id'      => data_get($message, 'id'),
        ]);

        // -------------------------------------------------------------------
        // Resolve ConnectedAccount → Chatbot (same pattern as Messenger)
        // -------------------------------------------------------------------

        $account = ConnectedAccount::query()
            ->where('platform', 'whatsapp_cloud')
            ->where('account_identifier', $phoneNumberId)
            ->where('connection_status', 'connected')
            ->first();

        if (! $account) {
            Log::warning('WhatsApp Cloud webhook: no ConnectedAccount for phone_number_id', [
                'phone_number_id' => $phoneNumberId,
            ]);
            return response('OK', 200);
        }

        $allChatbots = $account->extChatbots()->get();
        $chatbots    = $allChatbots->where('active', true);

        if ($chatbots->isEmpty()) {
            $chatbots = $allChatbots;
            Log::warning('WhatsApp Cloud webhook: no active chatbots, falling back to all linked', [
                'account_id'   => $account->id,
                'chatbot_count' => $chatbots->count(),
            ]);
        }

        if ($chatbots->isEmpty()) {
            Log::warning('WhatsApp Cloud webhook: account has no linked chatbots', [
                'account_id' => $account->id,
            ]);
            return response('OK', 200);
        }

        $chatbot = $chatbots->sortByDesc('updated_at')->first();

        // -------------------------------------------------------------------
        // Find or create the ChatbotChannel, keeping credentials fresh
        // -------------------------------------------------------------------

        $rawToken = $account->access_token;

        $credentials = [
            'phone_number_id'      => $phoneNumberId,
            'connected_account_id' => $account->id,
            'access_token'         => $rawToken,
        ];

        $channel = ChatbotChannel::query()
            ->where('chatbot_id', $chatbot->id)
            ->where('channel', 'whatsapp_cloud')
            ->first();

        if (! $channel) {
            $channel = ChatbotChannel::create([
                'user_id'      => $chatbot->user_id,
                'chatbot_id'   => $chatbot->id,
                'channel'      => 'whatsapp_cloud',
                'credentials'  => $credentials,
                'connected_at' => now(),
            ]);
        } else {
            $channel->update(['credentials' => $credentials]);
        }

        return $this->processWebhook($chatbot->id, $channel->id, $message, $request);
    }

    // -----------------------------------------------------------------------
    // Core processing
    // -----------------------------------------------------------------------

    private function processWebhook(int $chatbotId, int $channelId, array $messagePayload, Request $request): Response
    {
        // Persist raw payload for debugging
        try {
            ChatbotChannelWebhook::query()->create([
                'chatbot_id'         => $chatbotId,
                'chatbot_channel_id' => $channelId,
                'payload'            => $request->all(),
                'created_at'         => now(),
            ]);
        } catch (\Throwable $e) {
            Log::warning('WhatsApp Cloud: could not persist webhook payload', ['error' => $e->getMessage()]);
        }

        $messageText = data_get($messagePayload, 'text.body');
        $from        = data_get($messagePayload, 'from');

        Log::info('WhatsApp Cloud: processing message', [
            'chatbot_id'      => $chatbotId,
            'channel_id'      => $channelId,
            'from'            => $from,
            'message_preview' => $messageText ? mb_substr($messageText, 0, 80) : null,
        ]);

        try {
            $this->service
                ->setIpAddress()
                ->setChatbotId($chatbotId)
                ->setChannelId($channelId)
                ->setPayload($messagePayload);

            $conversation = $this->service->storeConversation();
            $chatbot      = $this->service->getChatbot();

            $this->service->insertMessage(
                conversation: $conversation,
                message:      $messageText ?? '',
                role:         'user',
                model:        $chatbot?->getAttribute('ai_model') ?? ''
            );

            $this->service->handle();

        } catch (\Throwable $e) {
            Log::error('WhatsApp Cloud: FATAL error during message processing', [
                'chatbot_id' => $chatbotId,
                'channel_id' => $channelId,
                'error'      => $e->getMessage(),
                'file'       => $e->getFile() . ':' . $e->getLine(),
            ]);
        }

        return response('OK', 200);
    }
}
