<?php

namespace App\Extensions\ChatbotWhatsapp\System\Services;

use App\Extensions\Chatbot\System\Enums\InteractionType;
use App\Extensions\Chatbot\System\Models\Chatbot;
use App\Extensions\Chatbot\System\Models\ChatbotChannel;
use App\Extensions\Chatbot\System\Models\ChatbotConversation;
use App\Extensions\Chatbot\System\Models\ChatbotHistory;
use App\Extensions\Chatbot\System\Services\GeneratorService;
use App\Extensions\ChatbotAgent\System\Services\ChatbotForPanelEventAbly;
use App\Helpers\Classes\Helper;
use App\Helpers\Classes\MarketplaceHelper;
use Exception;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;

/**
 * Mirrors MessengerConversationService but for WhatsApp Cloud API.
 * All AI and conversation logic is delegated to the shared GeneratorService.
 */
class WhatsAppCloudConversationService
{
    protected ?ChatbotConversation $conversation = null;
    protected ?ChatbotHistory      $history      = null;
    protected ?Chatbot             $chatbot      = null;

    protected string $humanAgentCommand = 'humanagent';

    protected int    $chatbotId;
    protected int    $channelId;
    protected ?string $ipAddress = null;
    protected ?array  $payload   = null;

    // -----------------------------------------------------------------------
    // Public entry points
    // -----------------------------------------------------------------------

    public function handle(): void
    {
        $chatbotChannel = ChatbotChannel::find($this->channelId);

        if (! $chatbotChannel) {
            Log::error('WhatsAppCloudConversationService::handle — ChatbotChannel not found', [
                'channel_id' => $this->channelId,
            ]);
            return;
        }

        $whatsapp = app(WhatsAppCloudService::class)->setChatbotChannel($chatbotChannel);

        // Extract the customer's phone number (WhatsApp "from" field)
        $recipient   = data_get($this->payload, 'from');
        $messageType = data_get($this->payload, 'type', 'text');
        $messageBody = data_get($this->payload, 'text.body');

        Log::info('WhatsAppCloudConversationService::handle', [
            'chatbot_id'       => $this->chatbotId,
            'channel_id'       => $this->channelId,
            'recipient'        => $recipient,
            'message_type'     => $messageType,
            'has_message_body' => ! empty($messageBody),
        ]);

        $conversation = $this->conversation;
        $chatbot      = $conversation->chatbot;

        if ($conversation->connect_agent_at) {
            if ($conversation->last_activity_at->diffInMinutes() > 10) {
                $this->closeInactiveConversation($conversation, $whatsapp, $recipient);
            }
            return;
        }

        $conversation->update(['last_activity_at' => now()]);

        try {
            if ($messageType === 'text' && is_string($messageBody)) {
                $this->processTextMessage($messageBody, $conversation, $chatbot, $whatsapp, $recipient);
            } else {
                $this->sendUnsupportedMessageType($conversation, $chatbot, $whatsapp, $recipient);
            }
        } catch (\Throwable $e) {
            Log::error('WhatsAppCloudConversationService::handle — exception', [
                'chatbot_id' => $this->chatbotId,
                'error'      => $e->getMessage(),
                'trace'      => $e->getTraceAsString(),
            ]);
        }
    }

    // -----------------------------------------------------------------------
    // Private helpers (mirror MessengerConversationService)
    // -----------------------------------------------------------------------

    protected function closeInactiveConversation(ChatbotConversation $conversation, WhatsAppCloudService $whatsapp, string $recipient): void
    {
        $conversation->update(['connect_agent_at' => null]);
        $message = trans('The conversation has been closed due to inactivity.');
        $this->insertMessage($conversation, $message, 'assistant', $conversation->chatbot->ai_model);
        $whatsapp->sendText($message, $recipient);
    }

    protected function processTextMessage(string $messageBody, ChatbotConversation $conversation, Chatbot $chatbot, WhatsAppCloudService $whatsapp, string $recipient): void
    {
        if ($this->isHumanAgentCommand($chatbot, $messageBody)) {
            $this->connectToHumanAgent($chatbot, $conversation, $whatsapp, $recipient);
            return;
        }

        $result    = $this->generateResponseStructured($messageBody);
        $response  = $result['text'] ?? trans("Sorry, I can't answer right now.");
        $imageUrls = $result['image_urls'] ?? [];

        if (! $conversation->connect_agent_at && $chatbot->interaction_type === InteractionType::SMART_SWITCH && MarketplaceHelper::isRegistered('chatbot-agent')) {
            $response .= "\n\n\nTo speak with a live support agent, please enter the #{$this->humanAgentCommand} command.";
        }

        $whatsapp->sendText($response, $recipient);
        $this->insertMessage($conversation, $response, 'assistant', $chatbot->ai_model);

        // Send product images as separate WhatsApp image messages
        foreach ($imageUrls as $imageUrl) {
            $whatsapp->sendImage($imageUrl, $recipient);
            usleep(300000); // 300ms delay between messages
        }

        if (! empty($imageUrls)) {
            Log::info('WhatsAppCloudConversationService: sent product images', [
                'recipient'   => $recipient,
                'image_count' => count($imageUrls),
            ]);
        }
    }

    /**
     * Generate a response and return structured result with text + image URLs.
     * Strips the ecommerce HTML sentinel so only clean text is sent to WhatsApp.
     *
     * @return array{text: string|null, image_urls: string[]}
     */
    protected function generateResponseStructured(string $prompt): array
    {
        $raw = app(GeneratorService::class)
            ->setChatbot($this->conversation->chatbot)
            ->setConversation($this->conversation)
            ->setPrompt($prompt)
            ->generate();

        if ($raw === null) {
            return ['text' => null, 'image_urls' => []];
        }

        $imageUrls = [];

        if (str_contains($raw, '<!--ECOMMERCE_UI-->')) {
            [$aiPart, $htmlPart] = explode('<!--ECOMMERCE_UI-->', $raw, 2);

            $text = strip_tags($aiPart);
            $text = html_entity_decode($text, ENT_QUOTES | ENT_HTML5, 'UTF-8');
            $text = trim(preg_replace('/\s+/', ' ', $text));

            if (preg_match_all('/src=["\']([^"\'>]+)["\']/', $htmlPart, $matches)) {
                foreach ($matches[1] as $url) {
                    $url = trim($url);
                    if (str_starts_with($url, 'http') && ! empty($url)) {
                        $imageUrls[] = $url;
                    }
                }
                $imageUrls = array_slice(array_unique($imageUrls), 0, 5);
            }
        } else {
            $text = strip_tags($raw);
            $text = html_entity_decode($text, ENT_QUOTES | ENT_HTML5, 'UTF-8');
            $text = trim(preg_replace('/\s+/', ' ', $text));
        }

        return [
            'text'       => $text ?: null,
            'image_urls' => $imageUrls,
        ];
    }

    protected function sendUnsupportedMessageType(ChatbotConversation $conversation, Chatbot $chatbot, WhatsAppCloudService $whatsapp, string $recipient): void
    {
        $message = trans('The chatbot does not support the type of message you are sending.');
        $this->insertMessage($conversation, $message, 'assistant', $chatbot->ai_model);
        $whatsapp->sendText($message, $recipient);
    }

    protected function connectToHumanAgent(Chatbot $chatbot, ChatbotConversation $conversation, WhatsAppCloudService $whatsapp, string $recipient): void
    {
        $conversation->update(['connect_agent_at' => now()]);

        if ($connectMessage = $chatbot->connect_message) {
            $chatbotHistory = $this->insertMessage($conversation, $connectMessage, 'assistant', $chatbot->ai_model, true);
            $whatsapp->sendText($connectMessage, $recipient);
            $this->dispatchAgentEvent($chatbot, $conversation, $chatbotHistory);
        }
    }

    protected function dispatchAgentEvent(Chatbot $chatbot, ChatbotConversation $conversation, ?ChatbotHistory $chatbotHistory): void
    {
        if (MarketplaceHelper::isRegistered('chatbot-agent')) {
            try {
                ChatbotForPanelEventAbly::dispatch($chatbot, $conversation->load('lastMessage'), $chatbotHistory);
            } catch (Exception $e) {
                Log::error($e->getMessage());
            }
        }
    }

    protected function isHumanAgentCommand(Chatbot $chatbot, string $message): bool
    {
        return str_contains($message, $this->humanAgentCommand) && $chatbot->interaction_type === InteractionType::SMART_SWITCH;
    }

    /** @deprecated Use generateResponseStructured() */
    protected function generateResponse(string $prompt): ?string
    {
        return $this->generateResponseStructured($prompt)['text'];
    }

    public function insertMessage(ChatbotConversation $conversation, string $message, string $role, string $model, bool $forcePanelEvent = false): ChatbotHistory
    {
        $chatbot = $conversation->getAttribute('chatbot');

        $chatbotHistory = ChatbotHistory::query()->create([
            'chatbot_id'      => $conversation->getAttribute('chatbot_id'),
            'conversation_id' => $conversation->getAttribute('id'),
            'message_id'      => data_get($this->payload, 'id'),
            'role'            => $role,
            'model'           => Helper::setting('openai_default_model'),
            'message'         => $message,
            'message_type'    => 'text',
            'content_type'    => 'text',
            'created_at'      => now(),
            'read_at'         => $conversation->getAttribute('connect_agent_at') ? null : now(),
        ]);

        $this->history = $chatbotHistory;

        $sendEvent = $conversation->getAttribute('connect_agent_at')
            && $chatbot->getAttribute('interaction_type') !== InteractionType::AUTOMATIC_RESPONSE
            && $role === 'user';

        if ($sendEvent || $forcePanelEvent) {
            $conversation->touch();
            if (MarketplaceHelper::isRegistered('chatbot-agent')) {
                try {
                    ChatbotForPanelEventAbly::dispatch(
                        $chatbot,
                        $conversation->load('lastMessage'),
                        $chatbotHistory
                    );
                } catch (Exception $e) {
                    Log::error($e->getMessage());
                }
            }
        }

        return $chatbotHistory;
    }

    public function storeConversation(): Builder|Model|ChatbotConversation
    {
        $this->chatbot = Chatbot::find($this->chatbotId);

        $this->conversation = ChatbotConversation::firstOrCreate([
            'chatbot_id'          => $this->chatbotId,
            'chatbot_channel'     => 'whatsapp_cloud',
            'chatbot_channel_id'  => $this->channelId,
            'customer_channel_id' => $this->getCustomerChannelId(),
        ], [
            'session_id'        => md5(uniqid(mt_rand(), true)),
            'conversation_name' => data_get($this->payload, 'from'),
            'ip_address'        => $this->ipAddress,
            'connect_agent_at'  => $this->chatbot->getAttribute('interaction_type') === InteractionType::HUMAN_SUPPORT ? now() : null,
            'last_activity_at'  => now(),
            'customer_payload'  => [
                'From' => $this->getCustomerChannelId(),
            ],
        ]);

        $this->conversation->setRelation('chatbot', $this->chatbot);

        return $this->conversation;
    }

    public function getCustomerChannelId(): ?string
    {
        return data_get($this->payload, 'from');
    }

    // -----------------------------------------------------------------------
    // Fluent setters (mirror MessengerConversationService)
    // -----------------------------------------------------------------------

    public function setChatbotId(int $chatbotId): static
    {
        $this->chatbotId = $chatbotId;
        return $this;
    }

    public function getChatbotId(): int
    {
        return $this->chatbotId;
    }

    public function setChannelId(int $channelId): static
    {
        $this->channelId = $channelId;
        return $this;
    }

    public function getChannelId(): int
    {
        return $this->channelId;
    }

    public function setIpAddress(?int $ipAddress = null): static
    {
        $this->ipAddress = $ipAddress
            ? (string) $ipAddress
            : (request()?->header('cf-connecting-ip') ?? request()?->ip());
        return $this;
    }

    public function setPayload(?array $payload): static
    {
        $this->payload = $payload;
        return $this;
    }

    public function getPayload(): ?array
    {
        return $this->payload;
    }

    public function getChatbot(): Model|Builder|Chatbot|null
    {
        return $this->chatbot;
    }
}
