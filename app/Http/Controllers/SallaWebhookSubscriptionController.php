<?php

namespace App\Http\Controllers;

use App\Models\SallaConnection;
use App\Services\Salla\SallaApiClient;
use App\Services\Salla\SallaOAuthService;
use App\Services\Salla\SallaWebhookService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class SallaWebhookSubscriptionController extends Controller
{
    /**
     * List webhook subscriptions for a connection
     */
    public function index(Request $request, int $connectionId)
    {
        $user = $request->user();

        // Verify user owns the connection
        $connection = SallaConnection::where('id', $connectionId)
            ->where('user_id', $user->id)
            ->firstOrFail();

        $subscriptions = $connection->webhookSubscriptions()->get();

        return response()->json([
            'subscriptions' => $subscriptions,
        ]);
    }

    /**
     * Subscribe to a webhook event
     */
    public function subscribe(Request $request, int $connectionId)
    {
        $user = $request->user();

        // Verify user owns the connection
        $connection = SallaConnection::where('id', $connectionId)
            ->where('user_id', $user->id)
            ->firstOrFail();

        $validated = $request->validate([
            'event' => 'required|string|in:order.created,order.updated,order.cancelled,order.refunded,order.deleted,product.created,product.updated,product.deleted',
            'name' => 'nullable|string|max:255',
        ]);

        $apiClient = new SallaApiClient($connection, app(SallaOAuthService::class));
        $webhookService = new SallaWebhookService($connection, $apiClient);

        try {
            $result = $webhookService->subscribe($validated['event'], $validated['name'] ?? null);

            return response()->json($result, 201);
        } catch (\Exception $e) {
            Log::error('Failed to subscribe to Salla webhook', [
                'connection_id' => $connectionId,
                'event' => $validated['event'],
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'error' => 'Failed to subscribe to webhook',
            ], 500);
        }
    }

    /**
     * Update a webhook subscription
     */
    public function update(Request $request, int $connectionId, int $subscriptionId)
    {
        $user = $request->user();

        // Verify user owns the connection
        $connection = SallaConnection::where('id', $connectionId)
            ->where('user_id', $user->id)
            ->firstOrFail();

        // Verify subscription belongs to connection
        $subscription = $connection->webhookSubscriptions()
            ->where('id', $subscriptionId)
            ->firstOrFail();

        $validated = $request->validate([
            'name' => 'nullable|string|max:255',
            'version' => 'nullable|integer|in:1,2',
            'type' => 'nullable|string',
            'rule' => 'nullable|string',
            'headers' => 'nullable|array',
        ]);

        if (! $subscription->salla_webhook_id) {
            return response()->json([
                'error' => 'Cannot update subscription without Salla webhook ID',
            ], 400);
        }

        $apiClient = new SallaApiClient($connection, app(SallaOAuthService::class));
        $webhookService = new SallaWebhookService($connection, $apiClient);

        try {
            $result = $webhookService->updateWebhook($subscription->salla_webhook_id, $validated);

            return response()->json($result);
        } catch (\Exception $e) {
            Log::error('Failed to update Salla webhook subscription', [
                'connection_id' => $connectionId,
                'subscription_id' => $subscriptionId,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'error' => 'Failed to update webhook subscription',
            ], 500);
        }
    }

    /**
     * Delete/unsubscribe a webhook
     */
    public function destroy(Request $request, int $connectionId, int $subscriptionId)
    {
        $user = $request->user();

        // Verify user owns the connection
        $connection = SallaConnection::where('id', $connectionId)
            ->where('user_id', $user->id)
            ->firstOrFail();

        // Verify subscription belongs to connection
        $subscription = $connection->webhookSubscriptions()
            ->where('id', $subscriptionId)
            ->firstOrFail();

        if (! $subscription->salla_webhook_id) {
            return response()->json([
                'error' => 'Cannot delete subscription without Salla webhook ID',
            ], 400);
        }

        $apiClient = new SallaApiClient($connection, app(SallaOAuthService::class));
        $webhookService = new SallaWebhookService($connection, $apiClient);

        try {
            $result = $webhookService->unsubscribe($subscription->salla_webhook_id);

            return response()->json($result);
        } catch (\Exception $e) {
            Log::error('Failed to delete Salla webhook subscription', [
                'connection_id' => $connectionId,
                'subscription_id' => $subscriptionId,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'error' => 'Failed to delete webhook subscription',
            ], 500);
        }
    }

    /**
     * Synchronize subscriptions with Salla API
     */
    public function sync(Request $request, int $connectionId)
    {
        $user = $request->user();

        // Verify user owns the connection
        $connection = SallaConnection::where('id', $connectionId)
            ->where('user_id', $user->id)
            ->firstOrFail();

        $apiClient = new SallaApiClient($connection, app(SallaOAuthService::class));
        $webhookService = new SallaWebhookService($connection, $apiClient);

        try {
            $result = $webhookService->syncSubscriptions();

            return response()->json($result);
        } catch (\Exception $e) {
            Log::error('Failed to sync Salla webhook subscriptions', [
                'connection_id' => $connectionId,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'error' => 'Failed to sync webhook subscriptions',
            ], 500);
        }
    }
}
