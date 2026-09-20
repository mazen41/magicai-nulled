<?php

namespace App\Extensions\ChatbotInstagram\System\Http\Controllers\Webhook;

use App\Extensions\Chatbot\System\Models\ChatbotChannel;
use App\Extensions\Chatbot\System\Models\ChatbotChannelWebhook;
use App\Extensions\ChatbotInstagram\System\Services\InstagramConversationService;
use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class ChatbotInstagramWebhookController extends Controller
{
    public function __construct(
        public InstagramConversationService $service
    ) {}

    /**
     * Global webhook endpoint for Instagram.
     * GET: subscription verification. POST: resolve channel from payload and process.
     */
    public function handleGlobal(Request $request): JsonResponse|Response
    {
        if ($request->isMethod('get')) {
            return $this->verifySubscription($request);
        }

        if (! $this->verifySignature($request)) {
            return response()->json(['error' => 'Invalid signature'], 403);
        }

        $instagramId = $request->input('entry.0.id');

        if (! $instagramId) {
            return response()->json(['error' => 'Missing entry ID'], 400);
        }

        $channel = $this->resolveChannelByInstagramId((string) $instagramId);

        if (! $channel) {
            return response()->json(['error' => 'Channel not found'], 404);
        }

        return $this->processWebhook(
            $channel->getAttribute('chatbot_id'),
            $channel->getKey(),
            $request
        );
    }

    /**
     * Legacy per-chatbot/channel webhook endpoint (backward compatibility).
     */
    public function handle(int $chatbotId, int $channelId, Request $request): JsonResponse|Response
    {
        if ($response = $this->verifyWebhookLegacy($request, $channelId)) {
            return $response;
        }

        return $this->processWebhook($chatbotId, $channelId, $request);
    }

    /**
     * Shared webhook processing logic.
     */
    protected function processWebhook(int $chatbotId, int $channelId, Request $request): JsonResponse
    {
        $payload = $request->input('entry.0.messaging.0');

        if (! $payload) {
            return response()->json(['status' => false]);
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
            ->setPayload($payload);

        $conversation = $this->service->storeConversation();

        $chatbot = $this->service->getChatbot();

        $this->service->insertMessage(
            conversation: $conversation,
            message: $payload['message']['text'] ?? '',
            role: 'user',
            model: $chatbot->getAttribute('ai_model')
        );

        $this->service->handle();

        return response()->json(['status' => 'processed']);
    }

    /**
     * Verify GET subscription using global verify token from settings.
     */
    protected function verifySubscription(Request $request): Response
    {
        $verifyToken = setting('INSTAGRAM_VERIFY_TOKEN');

        if ($request->get('hub_mode') === 'subscribe' && $request->get('hub_verify_token') === $verifyToken) {
            return response($request->get('hub_challenge'), 200);
        }

        return response('Token invalid', 403);
    }

    /**
     * Verify X-Hub-Signature-256 HMAC on POST requests.
     * Rejects webhook if app secret is not configured (security requirement).
     */
    protected function verifySignature(Request $request): bool
    {
        $appSecret = setting('INSTAGRAM_APP_SECRET');

        if (! $appSecret) {
            Log::error('Instagram webhook rejected: INSTAGRAM_APP_SECRET not configured');
            return false;
        }

        $signature = $request->header('X-Hub-Signature-256');

        if (! $signature) {
            Log::warning('Instagram webhook rejected: X-Hub-Signature-256 header missing');
            return false;
        }

        $expectedHash = 'sha256=' . hash_hmac('sha256', $request->getContent(), $appSecret);

        $isValid = hash_equals($expectedHash, $signature);
        
        if (!$isValid) {
            Log::warning('Instagram webhook rejected: signature verification failed');
        }
        
        return $isValid;
    }

    /**
     * Find the ChatbotChannel matching the Instagram Business Account ID from the payload.
     * First checks existing channel-based lookup (backward compatibility),
     * then falls back to connected_accounts → ext_chatbots lookup.
     * 
     * IMPORTANT: Does NOT auto-create channels with plaintext credentials.
     * ConnectedAccount is the credential source.
     */
    protected function resolveChannelByInstagramId(string $instagramId): ?ChatbotChannel
    {
        // First: existing channel-based lookup (backward compatibility)
        $channel = ChatbotChannel::query()
            ->where('channel', 'instagram')
            ->whereJsonContains('credentials->instagram_id', $instagramId)
            ->first();

        if ($channel) return $channel;

        // Second: new connected_accounts → ext_chatbots lookup
        $account = \App\Models\ConnectedAccount::query()
            ->where('platform', 'instagram')
            ->where('account_identifier', $instagramId)
            ->where('connection_status', 'connected')
            ->first();

        if (!$account) return null;

        // Use the new many-to-many relationship
        $chatbots = $account->chatbots()
            ->where('active', true)
            ->get();

        if ($chatbots->isEmpty()) return null;

        // Multi-chatbot routing strategy:
        // If multiple chatbots are attached to the same account, use the most recently updated active chatbot
        // This provides deterministic routing while supporting multiple chatbots per account
        if ($chatbots->count() > 1) {
            Log::info('Multiple chatbots for Instagram account', [
                'instagram_id' => $instagramId,
                'chatbot_count' => $chatbots->count(),
                'selected_chatbot_id' => $chatbots->sortByDesc('updated_at')->first()->id,
            ]);
        }
        
        $chatbot = $chatbots->sortByDesc('updated_at')->first();

        if (!$chatbot) return null;

        // Create minimal compatibility channel WITHOUT plaintext credentials
        // The actual credentials come from ConnectedAccount
        $channel = ChatbotChannel::query()
            ->where('chatbot_id', $chatbot->id)
            ->where('channel', 'instagram')
            ->first();

        if (!$channel) {
            $channel = ChatbotChannel::create([
                'user_id'      => $chatbot->user_id,
                'chatbot_id'   => $chatbot->id,
                'channel'      => 'instagram',
                'credentials'  => [
                    'instagram_id' => $instagramId,
                    'connected_account_id' => $account->id, // Reference to credential source
                ],
                'connected_at' => now(),
            ]);
        }

        return $channel;
    }

    /**
     * Legacy GET verification using per-channel verify token.
     */
    private function verifyWebhookLegacy(Request $request, int $channelId): ?Response
    {
        $channel = ChatbotChannel::query()->find($channelId);

        if (! $channel) {
            if ($request->isMethod('get')) {
                return response('Channel not found', 404);
            }

            return response('Channel not found', 404);
        }

        $verifyToken = data_get($channel->credentials, 'verify_token');

        if ($request->isMethod('get')) {
            if ($request->get('hub_mode') === 'subscribe' && $request->get('hub_verify_token') === $verifyToken) {
                return response($request->get('hub_challenge'), 200);
            }

            return response('Token invalid', 403);
        }

        return null;
    }
}
