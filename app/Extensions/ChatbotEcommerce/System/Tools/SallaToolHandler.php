<?php

namespace App\Extensions\ChatbotEcommerce\System\Tools;

use App\Models\SallaConnection;
use App\Services\Salla\SallaApiClient;
use App\Services\Salla\SallaOAuthService;
use Illuminate\Support\Facades\Log;

class SallaToolHandler
{
    private SallaConnection $connection;
    private SallaApiClient $apiClient;
    private SallaOAuthService $oauthService;

    public function __construct(SallaConnection $connection)
    {
        $this->connection = $connection;
        $this->oauthService = app(SallaOAuthService::class);
        $this->apiClient = new SallaApiClient($connection, $this->oauthService);
    }

    /**
     * Handle tool calls for Salla integration.
     */
    public function handleToolCall(string $functionName, array $functionArgs): array
    {
        if (method_exists($this, $functionName)) {
            return $this->{$functionName}(...$functionArgs);
        }

        return ['error' => 'The requested tool is not available.'];
    }

    /**
     * Search products in Salla store.
     */
    private function getProducts(string $query = '', string $orderby = 'date', string $order = 'desc'): array
    {
        $params = [
            'per_page' => 5,
        ];

        if (!empty($query)) {
            $params['keyword'] = $query;
        }

        // Map orderby to Salla's sort options
        $sortMap = [
            'date' => 'created_at',
            'price' => 'price',
            'popularity' => 'orders_count',
            'name' => 'name',
        ];

        $sortKey = $sortMap[$orderby] ?? 'created_at';
        $params['sort'] = $sortKey;
        $params['order'] = strtolower($order);

        try {
            $response = $this->apiClient->get('products', $params);
            $products = $this->formatProducts($response['data'] ?? []);

            return ['products' => $products];
        } catch (\Exception $e) {
            Log::error('Salla getProducts error: ' . $e->getMessage(), [
                'connection_id' => $this->connection->id,
            ]);

            return ['products' => []];
        }
    }

    /**
     * Get product categories from Salla.
     */
    private function getCategories(): array
    {
        try {
            $response = $this->apiClient->get('categories', ['per_page' => 50]);
            $categories = [];

            foreach ($response['data'] ?? [] as $category) {
                $categories[] = [
                    'id' => $category['id'] ?? null,
                    'name' => $category['name'] ?? 'Unknown',
                    'description' => $category['description'] ?? '',
                ];
            }

            return ['categories' => $categories];
        } catch (\Exception $e) {
            Log::error('Salla getCategories error: ' . $e->getMessage(), [
                'connection_id' => $this->connection->id,
            ]);

            return ['categories' => []];
        }
    }

    /**
     * Get orders from Salla.
     */
    private function getOrders(string $status = '', int $per_page = 10): array
    {
        $params = [
            'per_page' => $per_page,
        ];

        if (!empty($status)) {
            $params['status'] = $status;
        }

        try {
            $response = $this->apiClient->get('orders', $params);
            $orders = $this->formatOrders($response['data'] ?? []);

            return ['orders' => $orders];
        } catch (\Exception $e) {
            Log::error('Salla getOrders error: ' . $e->getMessage(), [
                'connection_id' => $this->connection->id,
            ]);

            return ['orders' => []];
        }
    }

    /**
     * Format Salla products to match Shopify/WooCommerce structure.
     */
    private function formatProducts(array $sallaProducts): array
    {
        $products = [];

        foreach ($sallaProducts as $product) {
            $images = [];
            if (!empty($product['images'])) {
                foreach ($product['images'] as $image) {
                    if (is_array($image)) {
                        $images[] = $image['url'] ?? $image['src'] ?? null;
                    } else {
                        $images[] = $image;
                    }
                }
            }

            // Format price
            $price = $product['price']['amount'] ?? $product['price'] ?? '0';
            $currency = $product['price']['currency_code'] ?? 'SAR';

            $products[] = [
                'id' => (string) ($product['id'] ?? ''),
                'title' => $product['name'] ?? 'Unknown',
                'description' => strip_tags($product['description'] ?? ''),
                'url' => $product['url'] ?? '',
                'images' => array_filter($images),
                'variants' => $this->formatVariants($product),
                'options' => $this->formatOptions($product),
                'price' => $price . ' ' . $currency,
            ];
        }

        return $products;
    }

    /**
     * Format product variants.
     */
    private function formatVariants(array $product): array
    {
        $variants = [];

        if (!empty($product['variations'])) {
            foreach ($product['variations'] as $variation) {
                $variants[] = [
                    'id' => (string) ($variation['id'] ?? ''),
                    'title' => $variation['name'] ?? 'Variant',
                    'price' => ($variation['price']['amount'] ?? $variation['price'] ?? '0') . ' ' . ($variation['price']['currency_code'] ?? 'SAR'),
                    'stock' => $variation['quantity'] ?? null,
                ];
            }
        }

        return $variants;
    }

    /**
     * Format product options.
     */
    private function formatOptions(array $product): array
    {
        $options = [];

        if (!empty($product['options'])) {
            foreach ($product['options'] as $option) {
                $options[] = [
                    'name' => $option['name'] ?? '',
                    'values' => $option['values'] ?? [],
                ];
            }
        }

        return $options;
    }

    /**
     * Format Salla orders.
     */
    private function formatOrders(array $sallaOrders): array
    {
        $orders = [];

        foreach ($sallaOrders as $order) {
            $orders[] = [
                'id' => (string) ($order['id'] ?? ''),
                'reference_id' => $order['reference_id'] ?? $order['id'] ?? '',
                'status' => $order['status']['name'] ?? $order['status'] ?? 'Unknown',
                'total' => $order['total']['amount'] ?? '0',
                'currency' => $order['total']['currency'] ?? 'SAR',
                'customer_name' => $order['customer']['first_name'] . ' ' . $order['customer']['last_name'],
                'created_at' => $order['created_at'] ?? '',
            ];
        }

        return $orders;
    }

    /**
     * Parse products into view for frontend display.
     */
    public function parseProducts(array $products): \Illuminate\Contracts\View\View
    {
        return view('chatbot-ecommerce::frontend-ui.components.product-carousel', [
            'products' => $products,
            'shop_source' => 'salla',
        ]);
    }
}
