<?php

namespace App\Services\Salla;

use App\Models\SallaConnection;

class SallaOrderService
{
    private SallaConnection $connection;
    private SallaApiClient $apiClient;

    public function __construct(SallaConnection $connection, SallaApiClient $apiClient)
    {
        $this->connection = $connection;
        $this->apiClient = $apiClient;
    }

    /**
     * List orders from Salla
     *
     * Supported query parameters:
     * - page: Pagination page number (retrieve sequentially)
     * - per_page: Orders per page (max 30 recommended)
     * - status: Filter by order status
     * - from_date: Filter orders from this date (YYYY-MM-DD)
     * - to_date: Filter orders to this date (YYYY-MM-DD)
     *
     * Pagination guidelines from Salla:
     * - Retrieve pages sequentially (page=1, then page=2, etc.)
     * - Do not skip pages
     * - Use per_page=30 to reduce requests
     * - Complete pagination within 15 minutes (cached window)
     * - Filter by date whenever possible
     *
     * @param  array  $query  Query parameters
     * @return array Paginated order list from Salla API
     */
    public function getOrders(array $query = []): array
    {
        return $this->apiClient->get('orders', $query);
    }

    /**
     * Get a single order by ID
     *
     * @param  int|string  $id  Order ID
     * @param  array  $query  Optional query parameters (e.g., format=light)
     * @return array Order details from Salla API
     */
    public function getOrder(int|string $id, array $query = []): array
    {
        return $this->apiClient->get("orders/{$id}", $query);
    }
}
