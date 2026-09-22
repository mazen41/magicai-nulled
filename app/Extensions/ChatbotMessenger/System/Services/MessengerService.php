<?php

namespace App\Extensions\ChatbotMessenger\System\Services;

use App\Extensions\Chatbot\System\Models\ChatbotChannel;

class MessengerService
{
    public ChatbotChannel $chatbotChannel;

    public function sendText($message, $receiver)
    {
        $access_token = data_get($this->chatbotChannel['credentials'], 'access_token', '');

        $simpleMessengerBot = new \App\Extensions\ChatbotMessenger\System\Helpers\SimpleMessengerBot($access_token);

        $simpleMessengerBot->sendMessage($receiver, $message);
    }

    /**
     * Send a single image attachment via Messenger Graph API.
     * Returns true on success, false on failure (non-fatal — caller logs and continues).
     */
    public function sendImage(string $imageUrl, string $receiver): bool
    {
        $access_token = data_get($this->chatbotChannel['credentials'], 'access_token', '');

        if (empty($access_token)) {
            return false;
        }

        $data = [
            'recipient' => ['id' => $receiver],
            'message'   => [
                'attachment' => [
                    'type'    => 'image',
                    'payload' => [
                        'url'         => $imageUrl,
                        'is_reusable' => true,
                    ],
                ],
            ],
        ];

        $curl = curl_init();
        curl_setopt_array($curl, [
            CURLOPT_URL            => 'https://graph.facebook.com/v18.0/me/messages',
            CURLOPT_POST           => true,
            CURLOPT_POSTFIELDS     => json_encode($data),
            CURLOPT_HTTPHEADER     => [
                'Content-Type: application/json',
                'Authorization: Bearer ' . $access_token,
            ],
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT        => 10,
        ]);

        $response  = curl_exec($curl);
        $httpCode  = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        $curlError = curl_error($curl);
        curl_close($curl);

        if ($curlError || $httpCode !== 200) {
            \Illuminate\Support\Facades\Log::warning('MessengerService: image send failed', [
                'recipient'  => $receiver,
                'image_url'  => $imageUrl,
                'http_code'  => $httpCode,
                'curl_error' => $curlError,
                'response'   => $response,
            ]);
            return false;
        }

        return true;
    }

    public function getChatbotChannel(): ChatbotChannel
    {
        return $this->chatbotChannel;
    }

    public function setChatbotChannel(ChatbotChannel $chatbotChannel): self
    {
        $this->chatbotChannel = $chatbotChannel;

        return $this;
    }
}
