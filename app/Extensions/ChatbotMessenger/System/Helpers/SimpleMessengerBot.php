<?php

namespace App\Extensions\ChatbotMessenger\System\Helpers;

class SimpleMessengerBot
{
    private string $pageAccessToken;

    public function __construct($pageAccessToken)
    {
        $this->pageAccessToken = $pageAccessToken;
    }

    public function sendMessage($userId, $message)
    {
        $url = 'https://graph.facebook.com/v18.0/me/messages';

        if (empty($this->pageAccessToken)) {
            \Illuminate\Support\Facades\Log::error('SimpleMessengerBot: page access token is empty — cannot send reply', [
                'recipient' => $userId,
            ]);
            return false;
        }

        $data = [
            'recipient' => ['id' => $userId],
            'message'   => ['text' => $message],
        ];

        $curl = curl_init();
        curl_setopt_array($curl, [
            CURLOPT_URL        => $url,
            CURLOPT_POST       => true,
            CURLOPT_POSTFIELDS => json_encode($data),
            CURLOPT_HTTPHEADER => [
                'Content-Type: application/json',
                'Authorization: Bearer ' . $this->pageAccessToken,
            ],
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT        => 10,
        ]);

        $response = curl_exec($curl);
        $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        $curlError = curl_error($curl);
        curl_close($curl);

        if ($curlError) {
            \Illuminate\Support\Facades\Log::error('SimpleMessengerBot: cURL error sending reply', [
                'recipient'  => $userId,
                'curl_error' => $curlError,
            ]);
            return false;
        }

        if ($httpCode !== 200) {
            \Illuminate\Support\Facades\Log::error('SimpleMessengerBot: Graph API rejected reply', [
                'recipient'   => $userId,
                'http_status' => $httpCode,
                'response'    => $response,
                'token_hint'  => substr($this->pageAccessToken, 0, 8) . '...',
            ]);
            return false;
        }

        \Illuminate\Support\Facades\Log::info('SimpleMessengerBot: reply sent successfully', [
            'recipient' => $userId,
        ]);

        return true;
    }

    public function verifyWebhook($verifyToken)
    {
        if (isset($_GET['hub_verify_token']) && $_GET['hub_verify_token'] === $verifyToken) {
            echo $_GET['hub_challenge'];
            exit;
        }
    }

    public function getIncomingMessage()
    {
        $input = file_get_contents('php://input');
        $data = json_decode($input, true);

        if (isset($data['entry'][0]['messaging'][0]['message'])) {
            $messaging = $data['entry'][0]['messaging'][0];

            return [
                'user_id' => $messaging['sender']['id'],
                'message' => $messaging['message']['text'] ?? '',
            ];
        }

        return null;
    }
}
