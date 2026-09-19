<?php

namespace App\Http\Controllers;

use App\Models\SallaConnection;
use App\Models\SallaOrder;
use App\Services\Salla\SallaApiClient;
use App\Services\Salla\SallaOAuthService;
use App\Services\Salla\SallaOrderQueryService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class SallaOrderController extends Controller
{
    /**
     * Display Salla orders for a connection
     */
    public function index($connectionId)
    {
        $user = Auth::user();

        $connection = SallaConnection::query()
            ->where('user_id', $user->id)
            ->findOrFail($connectionId);

        $orders = SallaOrder::query()
            ->where('salla_connection_id', $connection->id)
            ->orderBy('order_date', 'desc')
            ->paginate(20);

        return view('default.panel.user.salla.orders.index', [
            'connection' => $connection,
            'orders' => $orders,
        ]);
    }

    /**
     * Display Salla order details
     */
    public function show($connectionId, $orderId)
    {
        $user = Auth::user();

        $connection = SallaConnection::query()
            ->where('user_id', $user->id)
            ->findOrFail($connectionId);

        $order = SallaOrder::query()
            ->where('salla_connection_id', $connection->id)
            ->where('id', $orderId)
            ->findOrFail($orderId);

        return view('default.panel.user.salla.orders.show', [
            'connection' => $connection,
            'order' => $order,
        ]);
    }

    /**
     * Refresh order from Salla API
     */
    public function refresh($connectionId, $orderId)
    {
        $user = Auth::user();

        $connection = SallaConnection::query()
            ->where('user_id', $user->id)
            ->findOrFail($connectionId);

        $order = SallaOrder::query()
            ->where('salla_connection_id', $connection->id)
            ->where('id', $orderId)
            ->findOrFail($orderId);

        try {
            $apiClient = new SallaApiClient($connection, app(SallaOAuthService::class));
            $orderService = new \App\Services\Salla\SallaOrderService($connection, $apiClient);
            $queryService = new SallaOrderQueryService($connection, $orderService);

            $queryService->refreshOrder($connection, $order->salla_order_id);

            Log::info('Salla order refreshed successfully', [
                'user_id' => $user->id,
                'connection_id' => $connection->id,
                'salla_order_id' => $order->salla_order_id,
            ]);

            return back()->with([
                'type' => 'success',
                'message' => trans('Order refreshed successfully.'),
            ]);

        } catch (\Exception $e) {
            Log::error('Salla order refresh failed', [
                'user_id' => $user->id,
                'connection_id' => $connection->id,
                'salla_order_id' => $order->salla_order_id,
                'error' => $e->getMessage(),
            ]);

            return back()->with([
                'type' => 'error',
                'message' => trans('Order refresh failed:').' '.$e->getMessage(),
            ]);
        }
    }
}
