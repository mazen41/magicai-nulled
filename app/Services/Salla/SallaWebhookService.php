<?php

namespace App\Services\Salla;

use App\Models\SallaConnection;
use App\Models\SallaWebhookSubscription;
use Illuminate\Support\Facades\Log;
use RuntimeException;

class SallaWebhookService
{
    private SallaConnection $connection;
    private SallaApiClient $apiClient;

    public function __construct(SallaConnection $connection, SallaApiClient $apiClient)
    {
        $this->connection = $connection;
        $this->apiClient = $apiClient;
    }

    /**
     * Subscribe to a Salla webhook event
     */
    public function subscribe(string $event, string $name = null): array
    {
        $webhookUrl = config('salla.webhook_url');

        if (! $webhookUrl) {
            throw new RuntimeException('SALLA_WEBHOOK_URL is not configured');
        }

        // Check if subscription already exists for this URL
        $existingSubscription = $this->findExistingSubscription($webhookUrl);

        if ($existingSubscription) {
            Log::info('Salla webhook subscription already exists', [
                'connection_id' => $this->connection->id,
                'event' => $event,
                'subscription_id' => $existingSubscription->id,
            ]);

            return [
                'status' => 'exists',
                'subscription' => $existingSubscription,
            ];
        }

        // Create subscription via Salla API
        $payload = [
            'name' => $name ?? "MagicAI {$event}",
            'event' => $event,
            'url' => $webhookUrl,
            'version' => 2,
        ];

        $response = $this->apiClient->post('webhooks/subscribe', $payload);

        // Store subscription locally
        $subscription = SallaWebhookSubscription::create([
            'salla_connection_id' => $this->connection->id,
            'salla_webhook_id' => $response['data']['id'] ?? null,
            'name' => $response['data']['name'] ?? $payload['name'],
            'event' => $response['data']['event'] ?? $event,
            'url' => $response['data']['url'] ?? $webhookUrl,
            'version' => $response['data']['version'] ?? 2,
            'type' => $response['data']['type'] ?? null,
            'rule' => $response['data']['rule'] ?? null,
            'headers' => $response['data']['headers'] ?? null,
            'status' => 'active',
            'synced_at' => now(),
        ]);

        Log::info('Salla webhook subscription created', [
            'connection_id' => $this->connection->id,
            'event' => $event,
            'subscription_id' => $subscription->id,
            'salla_webhook_id' => $subscription->salla_webhook_id,
        ]);

        return [
            'status' => 'created',
            'subscription' => $subscription,
            'api_response' => $response,
        ];
    }

    /**
     * List all webhooks for the connection
     */
    public function listWebhooks(): array
    {
        $response = $this->apiClient->get('webhooks');

        return $response['data'] ?? [];
    }

    /**
     * Find an existing subscription for the URL
     * Salla behavior: "New subscriptions with the same URL will update events / restore old webhooks"
     * So we check by URL, not by event
     */
    private function findExistingSubscription(string $url): ?SallaWebhookSubscription
    {
        return SallaWebhookSubscription::where('salla_connection_id', $this->connection->id)
            ->where('url', $url)
            ->where('status', 'active')
            ->first();
    }

    /**
     * Update an existing webhook subscription
     */
    public function updateWebhook(int $sallaWebhookId, array $data): array
    {
        $response = $this->apiClient->put("webhooks/{$sallaWebhookId}", $data);

        // Update local subscription
        $subscription = SallaWebhookSubscription::where('salla_connection_id', $this->connection->id)
            ->where('salla_webhook_id', $sallaWebhookId)
            ->first();

        if ($subscription) {
            $subscription->update([
                'name' => $data['name'] ?? $subscription->name,
                'version' => $data['version'] ?? $subscription->version,
                'type' => $data['type'] ?? $subscription->type,
                'rule' => $data['rule'] ?? $subscription->rule,
                'headers' => $data['headers'] ?? $subscription->headers,
                'synced_at' => now(),
            ]);
        }

        Log::info('Salla webhook subscription updated', [
            'connection_id' => $this->connection->id,
            'salla_webhook_id' => $sallaWebhookId,
        ]);

        return [
            'status' => 'updated',
            'subscription' => $subscription,
            'api_response' => $response,
        ];
    }

    /**
     * Delete/unsubscribe a webhook
     */
    public function unsubscribe(int $sallaWebhookId): array
    {
        $response = $this->apiClient->delete('webhooks/unsubscribe', ['id' => $sallaWebhookId]);

        // Update local subscription status
        $subscription = SallaWebhookSubscription::where('salla_connection_id', $this->connection->id)
            ->where('salla_webhook_id', $sallaWebhookId)
            ->first();

        if ($subscription) {
            $subscription->update([
                'status' => 'inactive',
                'synced_at' => now(),
            ]);
        }

        Log::info('Salla webhook subscription deleted', [
            'connection_id' => $this->connection->id,
            'salla_webhook_id' => $sallaWebhookId,
        ]);

        return [
            'status' => 'deleted',
            'subscription' => $subscription,
            'api_response' => $response,
        ];
    }

    /**
     * Synchronize local subscriptions with Salla API
     */
    public function syncSubscriptions(): array
    {
        $apiWebhooks = $this->listWebhooks();
        $synced = 0;
        $created = 0;
        $markedInactive = 0;

        // Get all Salla webhook IDs from API response
        $apiWebhookIds = array_column($apiWebhooks, 'id');

        foreach ($apiWebhooks as $apiWebhook) {
            $subscription = SallaWebhookSubscription::where('salla_connection_id', $this->connection->id)
                ->where('salla_webhook_id', $apiWebhook['id'])
                ->first();

            if ($subscription) {
                // Update existing
                $subscription->update([
                    'name' => $apiWebhook['name'] ?? $subscription->name,
                    'event' => $apiWebhook['event'] ?? $subscription->event,
                    'url' => $apiWebhook['url'] ?? $subscription->url,
                    'version' => $apiWebhook['version'] ?? $subscription->version,
                    'type' => $apiWebhook['type'] ?? $subscription->type,
                    'rule' => $apiWebhook['rule'] ?? $subscription->rule,
                    'headers' => $apiWebhook['headers'] ?? $subscription->headers,
                    'status' => 'active',
                    'synced_at' => now(),
                ]);
                $synced++;
            } else {
                // Create new
                SallaWebhookSubscription::create([
                    'salla_connection_id' => $this->connection->id,
                    'salla_webhook_id' => $apiWebhook['id'],
                    'name' => $apiWebhook['name'] ?? 'Unknown',
                    'event' => $apiWebhook['event'] ?? 'unknown',
                    'url' => $apiWebhook['url'] ?? '',
                    'version' => $apiWebhook['version'] ?? 2,
                    'type' => $apiWebhook['type'] ?? null,
                    'rule' => $apiWebhook['rule'] ?? null,
                    'headers' => $apiWebhook['headers'] ?? null,
                    'status' => 'active',
                    'synced_at' => now(),
                ]);
                $created++;
            }
        }

        // Mark local subscriptions as inactive if they no longer exist remotely
        $inactiveSubscriptions = SallaWebhookSubscription::where('salla_connection_id', $this->connection->id)
            ->where('status', 'active')
            ->whereNotNull('salla_webhook_id')
            ->whereNotIn('salla_webhook_id', $apiWebhookIds)
            ->get();

        foreach ($inactiveSubscriptions as $subscription) {
            $subscription->update([
                'status' => 'inactive',
                'synced_at' => now(),
            ]);
            $markedInactive++;
        }

        Log::info('Salla webhook subscriptions synchronized', [
            'connection_id' => $this->connection->id,
            'synced' => $synced,
            'created' => $created,
            'marked_inactive' => $markedInactive,
        ]);

        return [
            'synced' => $synced,
            'created' => $created,
            'marked_inactive' => $markedInactive,
            'total' => count($apiWebhooks),
        ];
    }
}
