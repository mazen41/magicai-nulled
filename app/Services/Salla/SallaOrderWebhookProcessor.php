<?php

namespace App\Services\Salla;

use App\Models\SallaConnection;
use App\Models\SallaOrder;
use App\Models\SallaWebhookEvent;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use RuntimeException;

class SallaOrderWebhookProcessor
{
    private SallaConnection $connection;
    private SallaOrderService $orderService;

    // Supported order events
    private const SUPPORTED_EVENTS = [
        'order.created',
        'order.updated',
        'order.cancelled',
        'order.refunded',
        'order.deleted',
    ];

    public function __construct(SallaConnection $connection, SallaOrderService $orderService)
    {
        $this->connection = $connection;
        $this->orderService = $orderService;
    }

    /**
     * Process Salla order webhook event
     */
    public function process(SallaWebhookEvent $event): void
    {
        // Validate event type
        if (! in_array($event->event_type, self::SUPPORTED_EVENTS)) {
            Log::info('Salla webhook event is not a supported order event', [
                'webhook_event_id' => $event->id,
                'event_type' => $event->event_type,
            ]);

            return;
        }

        // Parse webhook payload
        $payload = json_decode($event->payload, true);

        if (! $payload || ! isset($payload['data']['id'])) {
            Log::warning('Salla order webhook payload missing order ID', [
                'webhook_event_id' => $event->id,
                'event_type' => $event->event_type,
            ]);

            return;
        }

        $sallaOrderId = $payload['data']['id'];

        // Special handling for order.deleted
        if ($event->event_type === 'order.deleted') {
            $this->handleOrderDeleted($event, $sallaOrderId);
            return;
        }

        // For other events, retrieve current order from Salla API
        try {
            $orderData = $this->orderService->getOrder($sallaOrderId);
        } catch (\Exception $e) {
            Log::error('Failed to retrieve Salla order from API', [
                'webhook_event_id' => $event->id,
                'salla_order_id' => $sallaOrderId,
                'error' => $e->getMessage(),
            ]);

            // Re-throw to allow Laravel's retry mechanism
            throw $e;
        }

        // Store order snapshot in a short database transaction
        DB::transaction(function () use ($event, $sallaOrderId, $orderData) {
            $this->storeOrderSnapshot($event, $sallaOrderId, $orderData);
        });

        Log::info('Salla order webhook event processed successfully', [
            'webhook_event_id' => $event->id,
            'event_type' => $event->event_type,
            'salla_order_id' => $sallaOrderId,
            'reference_id' => $orderData['data']['reference_id'] ?? null,
        ]);
    }

    /**
     * Handle order.deleted event
     */
    private function handleOrderDeleted(SallaWebhookEvent $event, int $sallaOrderId): void
    {
        // Update existing local record as deleted if it exists
        $order = SallaOrder::where('salla_connection_id', $this->connection->id)
            ->where('salla_order_id', $sallaOrderId)
            ->first();

        if ($order) {
            DB::transaction(function () use ($order) {
                $order->update([
                    'status' => 'deleted',
                    'status_name' => 'Deleted',
                    'deleted_at' => now(),
                    'last_synced_at' => now(),
                ]);
            });

            Log::info('Salla order marked as deleted', [
                'webhook_event_id' => $event->id,
                'salla_order_id' => $sallaOrderId,
            ]);
        } else {
            // No local record exists - log but don't create a new record for deleted order
            Log::info('Salla order deleted but no local record exists', [
                'webhook_event_id' => $event->id,
                'salla_order_id' => $sallaOrderId,
            ]);
        }
    }

    /**
     * Store order snapshot (business idempotency)
     */
    private function storeOrderSnapshot(SallaWebhookEvent $event, int $sallaOrderId, array $orderData): void
    {
        $order = SallaOrder::where('salla_connection_id', $this->connection->id)
            ->where('salla_order_id', $sallaOrderId)
            ->first();

        $statusSlug = $orderData['data']['status']['slug'] ?? null;
        $statusName = $orderData['data']['status']['name'] ?? null;
        $amounts = $orderData['data']['amounts'] ?? [];

        if ($order) {
            // Update existing snapshot
            $order->update([
                'reference_id' => $orderData['data']['reference_id'] ?? $order->reference_id,
                'status' => $statusSlug ?? $order->status,
                'status_name' => $statusName ?? $order->status_name,
                'currency' => $orderData['data']['currency'] ?? $order->currency,
                'total' => $amounts['total']['amount'] ?? $order->total,
                'sub_total' => $amounts['sub_total']['amount'] ?? $order->sub_total,
                'shipping_cost' => $amounts['shipping_cost']['amount'] ?? $order->shipping_cost,
                'tax_amount' => $amounts['tax']['amount']['amount'] ?? $order->tax_amount,
                'payment_method' => $orderData['data']['payment_method'] ?? $order->payment_method,
                'order_date' => $orderData['data']['date']['date'] ?? $order->order_date,
                'order_data' => $orderData['data'] ?? $order->order_data,
                'last_synced_at' => now(),
            ]);
        } else {
            // Create new snapshot
            SallaOrder::create([
                'salla_connection_id' => $this->connection->id,
                'salla_order_id' => $sallaOrderId,
                'reference_id' => $orderData['data']['reference_id'] ?? null,
                'status' => $statusSlug,
                'status_name' => $statusName,
                'currency' => $orderData['data']['currency'] ?? 'SAR',
                'total' => $amounts['total']['amount'] ?? null,
                'sub_total' => $amounts['sub_total']['amount'] ?? null,
                'shipping_cost' => $amounts['shipping_cost']['amount'] ?? null,
                'tax_amount' => $amounts['tax']['amount']['amount'] ?? null,
                'payment_method' => $orderData['data']['payment_method'] ?? null,
                'order_date' => $orderData['data']['date']['date'] ?? null,
                'order_data' => $orderData['data'] ?? null,
                'last_synced_at' => now(),
            ]);
        }
    }
}
