<?php

namespace App\Extensions\ChatbotWhatsapp\System\Services;

use App\Extensions\Chatbot\System\Models\ChatbotChannel;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

/**
 * Sends messages via the Meta WhatsApp Cloud API.
 *
 * Credentials are read from the ChatbotChannel credentials array,
 * which is populated by the webhook controller from the ConnectedAccount.
 */
class WhatsAppCloudService
{
    public ChatbotChannel $chatbotChannel;

    public function sendText(string $message, string $recipientPhone): void
    {
        $credentials  = $this->chatbotChannel->credentials ?? [];
        $accessToken  = data_get($credentials, 'access_token', '');
        $phoneNumberId = data_get($credentials, 'phone_number_id', '');

        if (! $accessToken || ! $phoneNumberId) {
            Log::error('WhatsApp Cloud: missing credentials for send', [
                'channel_id'     => $this->chatbotChannel->id,
                'has_token'      => !empty($accessToken),
                'has_phone_id'   => !empty($phoneNumberId),
            ]);
            return;
        }

        $graphVersion = config('services.meta.graph_version', 'v18.0');

        try {
            $response = Http::withToken($accessToken)
                ->timeout(15)
                ->post("https://graph.facebook.com/{$graphVersion}/{$phoneNumberId}/messages", [
                    'messaging_product' => 'whatsapp',
                    'to'                => $recipientPhone,
                    'type'              => 'text',
                    'text'              => ['body' => $message],
                ]);

            if (! $response->successful()) {
                Log::error('WhatsApp Cloud: send failed', [
                    'status'       => $response->status(),
                    'body'         => $response->body(),
                    'phone_number_id' => $phoneNumberId,
                    'recipient'    => $recipientPhone,
                ]);
            }
        } catch (\Throwable $e) {
            Log::error('WhatsApp Cloud: exception during send', [
                'error'     => $e->getMessage(),
                'recipient' => $recipientPhone,
            ]);
        }
    }

    public function getChatbotChannel(): ChatbotChannel
    {
        return $this->chatbotChannel;
    }

    public function setChatbotChannel(ChatbotChannel $chatbotChannel): static
    {
        $this->chatbotChannel = $chatbotChannel;

        return $this;
    }
}
