<?php

namespace Tests\Unit;

use App\Models\SallaConnection;
use App\Services\Salla\SallaApiClient;
use App\Services\Salla\SallaProductService;
use RuntimeException;
use Tests\TestCase;

class SallaProductServiceTest extends TestCase
{
    private SallaConnection $connection;
    private SallaApiClient $apiClient;
    private SallaProductService $service;

    protected function setUp(): void
    {
        parent::setUp();

        $this->connection = new SallaConnection([
            'id' => 1,
            'user_id' => 1,
            'salla_store_id' => 'test-store',
            'store_name' => 'Test Store',
            'connection_status' => 'connected',
        ]);

        $this->apiClient = $this->createMock(SallaApiClient::class);
        $this->service = new SallaProductService($this->connection, $this->apiClient);
    }

    public function test_service_instantiates_with_connection_and_client()
    {
        $this->assertInstanceOf(SallaProductService::class, $this->service);
    }

    public function test_get_products_calls_products_endpoint()
    {
        $expectedResponse = [
            'data' => [
                ['id' => 1, 'name' => 'Product 1'],
                ['id' => 2, 'name' => 'Product 2'],
            ],
            'pagination' => [
                'total' => 2,
                'per_page' => 20,
                'current_page' => 1,
            ],
        ];

        $this->apiClient->expects($this->once())
            ->method('get')
            ->with('products', [])
            ->willReturn($expectedResponse);

        $result = $this->service->getProducts();

        $this->assertEquals($expectedResponse, $result);
    }

    public function test_get_products_forwards_query_parameters()
    {
        $query = ['page' => 2, 'per_page' => 10, 'status' => 'sale'];

        $this->apiClient->expects($this->once())
            ->method('get')
            ->with('products', $query)
            ->willReturn(['data' => []]);

        $this->service->getProducts($query);
    }

    public function test_get_product_calls_product_details_endpoint()
    {
        $productId = 123;
        $expectedResponse = [
            'data' => [
                'id' => 123,
                'name' => 'Test Product',
                'price' => ['amount' => 100, 'currency' => 'SAR'],
            ],
        ];

        $this->apiClient->expects($this->once())
            ->method('get')
            ->with("products/{$productId}", [])
            ->willReturn($expectedResponse);

        $result = $this->service->getProduct($productId);

        $this->assertEquals($expectedResponse, $result);
    }

    public function test_response_is_returned_without_inventing_fields()
    {
        $apiResponse = [
            'data' => [['id' => 1, 'name' => 'Product']],
            'meta' => ['custom_field' => 'value'],
        ];

        $this->apiClient->method('get')
            ->willReturn($apiResponse);

        $result = $this->service->getProducts();

        // Response should be exactly what the API returned
        $this->assertEquals($apiResponse, $result);
    }

    public function test_api_exceptions_propagate_correctly()
    {
        $this->apiClient->method('get')
            ->willThrowException(new RuntimeException('API request failed'));

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('API request failed');

        $this->service->getProducts();
    }

    public function test_no_real_external_request_occurs()
    {
        // This test verifies that the service uses the mocked API client
        // and does not make real HTTP requests
        $this->apiClient->expects($this->once())
            ->method('get')
            ->willReturn(['data' => []]);

        $this->service->getProducts();

        // If we reach here, the mock was used (no real request)
        $this->assertTrue(true);
    }
}
