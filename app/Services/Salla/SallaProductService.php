<?php

namespace App\Services\Salla;

use App\Models\SallaConnection;

class SallaProductService
{
    private SallaConnection $connection;
    private SallaApiClient $apiClient;

    public function __construct(SallaConnection $connection, SallaApiClient $apiClient)
    {
        $this->connection = $connection;
        $this->apiClient = $apiClient;
    }

    /**
     * List products from Salla
     *
     * @param  array  $query  Query parameters (page, per_page, keyword, status, category, format)
     * @return array Paginated product list from Salla API
     */
    public function getProducts(array $query = []): array
    {
        return $this->apiClient->get('products', $query);
    }

    /**
     * Get a single product by ID
     *
     * @param  int|string  $id  Product ID
     * @return array Product details from Salla API
     */
    public function getProduct(int|string $id): array
    {
        return $this->apiClient->get("products/{$id}");
    }
}
