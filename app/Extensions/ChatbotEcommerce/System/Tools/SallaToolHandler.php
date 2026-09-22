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
     *
     * Salla Admin API v2 /products accepted params:
     *   page, per_page, keyword, status, category_id, format
     *
     * NOTE: The API does NOT accept separate 'sort' and 'order' params.
     * Sending them causes HTTP 422. The $orderby and $order arguments
     * are accepted from Gemini's function call but intentionally not
     * forwarded to Salla. Salla returns newest products by default.
     */
    private function getProducts(string $query = '', string $orderby = 'date', string $order = 'desc'): array
    {
        $params = [
            'per_page' => 5,
        ];

        if (!empty($query)) {
            $params['keyword'] = $query;
        }

        Log::info('Salla getProducts request', [
            'params'  => $params,
            'orderby' => $orderby,
            'order'   => $order,
        ]);

        try {
            $response = $this->apiClient->get('products', $params);
            $products = $this->formatProducts($response['data'] ?? []);

            Log::info('Salla getProducts success', [
                'count' => count($products),
            ]);

            return ['products' => $products];
        } catch (\Exception $e) {
            Log::error('Salla getProducts error: ' . $e->getMessage(), [
                'connection_id' => $this->connection->id,
                'params'        => $params,
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
            // Collect image URLs — Salla may return strings, arrays with 'url'/'src',
            // or nested objects. Always extract a plain string URL.
            $images = [];
            if (!empty($product['images'])) {
                foreach ($product['images'] as $image) {
                    if (is_string($image) && !empty($image)) {
                        $images[] = $image;
                    } elseif (is_array($image)) {
                        $url = $image['url'] ?? $image['src'] ?? $image['original'] ?? null;
                        if (is_string($url) && !empty($url)) {
                            $images[] = $url;
                        }
                    }
                }
            }

            // Also try the main image field (Salla sometimes puts it there)
            if (empty($images) && !empty($product['image'])) {
                $img = $product['image'];
                if (is_string($img)) {
                    $images[] = $img;
                } elseif (is_array($img)) {
                    $url = $img['url'] ?? $img['src'] ?? $img['original'] ?? null;
                    if (is_string($url)) {
                        $images[] = $url;
                    }
                }
            }

            // Format price — Salla price is usually ['amount' => 99.00, 'currency_code' => 'SAR']
            $priceData = $product['price'] ?? [];
            if (is_array($priceData)) {
                $price    = $priceData['amount'] ?? '0';
                $currency = $priceData['currency_code'] ?? 'SAR';
            } else {
                $price    = (string) $priceData;
                $currency = 'SAR';
            }

            Log::debug('Salla formatProducts: raw product sample', [
                'id'          => $product['id'] ?? null,
                'name'        => $product['name'] ?? null,
                'image_count' => count($images),
                'has_options' => !empty($product['options']),
                'has_variants'=> !empty($product['variations']),
            ]);

            $products[] = [
                'id'          => (string) ($product['id'] ?? ''),
                'title'       => (string) ($product['name'] ?? 'Unknown'),
                'description' => strip_tags((string) ($product['description'] ?? '')),
                'url'         => (string) ($product['url'] ?? ''),
                'images'      => $images,
                'variants'    => $this->formatVariants($product),
                'options'     => $this->formatOptions($product),
                'price'       => $price . ' ' . $currency,
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
     *
     * Salla option values may be plain strings OR objects like
     * [{'id': 1, 'title': 'Red', 'display_value': '#FF0000'}, ...]
     * The carousel view iterates values with {{ $value }}, so each
     * entry must be a plain string.
     */
    private function formatOptions(array $product): array
    {
        $options = [];

        if (!empty($product['options'])) {
            foreach ($product['options'] as $option) {
                $rawValues = $option['values'] ?? [];
                $values    = [];

                foreach ($rawValues as $value) {
                    if (is_string($value)) {
                        $values[] = $value;
                    } elseif (is_array($value)) {
                        // Extract the human-readable label
                        $label = $value['title']
                            ?? $value['name']
                            ?? $value['display_value']
                            ?? $value['value']
                            ?? null;
                        if ($label !== null) {
                            $values[] = (string) $label;
                        }
                    }
                }

                if (!empty($values)) {
                    $options[] = [
                        'name'   => (string) ($option['name'] ?? ''),
                        'values' => $values,
                    ];
                }
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
