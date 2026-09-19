<?php

namespace App\Services\Salla;

use App\Models\SallaConnection;
use App\Models\SallaOrder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class SallaOrderQueryService
{
    private SallaConnection $connection;
    private SallaOrderService $orderService;

    public function __construct(SallaConnection $connection, SallaOrderService $orderService)
    {
        $this->connection = $connection;
        $this->orderService = $orderService;
    }

    /**
     * Find local order by Salla order ID
     *
     * @param  SallaConnection  $connection
     * @param  int|string  $sallaOrderId
     * @return SallaOrder|null
     */
    public function findBySallaOrderId(SallaConnection $connection, int|string $sallaOrderId): ?SallaOrder
    {
        return SallaOrder::where('salla_connection_id', $connection->id)
            ->where('salla_order_id', $sallaOrderId)
            ->first();
    }

    /**
     * Find local order by reference ID
     *
     * @param  SallaConnection  $connection
     * @param  string  $referenceId
     * @return SallaOrder|null
     */
    public function findByReferenceId(SallaConnection $connection, string $referenceId): ?SallaOrder
    {
        return SallaOrder::where('salla_connection_id', $connection->id)
            ->where('reference_id', $referenceId)
            ->first();
    }

    /**
     * Get latest local snapshot
     *
     * @param  SallaConnection  $connection
     * @param  int|string  $sallaOrderId
     * @return SallaOrder|null
     */
    public function getLatestSnapshot(SallaConnection $connection, int|string $sallaOrderId): ?SallaOrder
    {
        return $this->findBySallaOrderId($connection, $sallaOrderId);
    }

    /**
     * Refresh order from Salla API
     *
     * External API call occurs outside DB transaction.
     * Only the local snapshot write uses a short transaction.
     *
     * @param  SallaConnection  $connection
     * @param  int|string  $sallaOrderId
     * @return SallaOrder
     * @throws \Exception If API call fails
     */
    public function refreshOrder(SallaConnection $connection, int|string $sallaOrderId): SallaOrder
    {
        // External API call - outside transaction
        try {
            $orderData = $this->orderService->getOrder($sallaOrderId);
        } catch (\Exception $e) {
            Log::error('Failed to refresh Salla order from API', [
                'salla_connection_id' => $connection->id,
                'salla_order_id' => $sallaOrderId,
                'error' => $e->getMessage(),
            ]);

            // Re-throw to allow caller to handle retry
            throw $e;
        }

        // Store order snapshot in a short database transaction
        $order = DB::transaction(function () use ($connection, $sallaOrderId, $orderData) {
            return $this->storeOrderSnapshot($connection, $sallaOrderId, $orderData);
        });

        Log::info('Salla order refreshed successfully', [
            'salla_connection_id' => $connection->id,
            'salla_order_id' => $sallaOrderId,
            'reference_id' => $orderData['data']['reference_id'] ?? null,
        ]);

        return $order;
    }

    /**
     * Store order snapshot (reused from SallaOrderWebhookProcessor)
     *
     * @param  SallaConnection  $connection
     * @param  int|string  $sallaOrderId
     * @param  array  $orderData
     * @return SallaOrder
     */
    private function storeOrderSnapshot(SallaConnection $connection, int|string $sallaOrderId, array $orderData): SallaOrder
    {
        $order = SallaOrder::where('salla_connection_id', $connection->id)
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

            return $order;
        } else {
            // Create new snapshot
            return SallaOrder::create([
                'salla_connection_id' => $connection->id,
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
