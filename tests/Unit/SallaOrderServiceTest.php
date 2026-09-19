<?php

namespace Tests\Unit;

use App\Models\SallaConnection;
use App\Services\Salla\SallaApiClient;
use App\Services\Salla\SallaOrderService;
use RuntimeException;
use Tests\TestCase;

class SallaOrderServiceTest extends TestCase
{
    private SallaConnection $connection;
    private SallaApiClient $apiClient;
    private SallaOrderService $service;

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
        $this->service = new SallaOrderService($this->connection, $this->apiClient);
    }

    public function test_service_instantiates_with_connection_and_client()
    {
        $this->assertInstanceOf(SallaOrderService::class, $this->service);
    }

    public function test_get_orders_calls_orders_endpoint()
    {
        $expectedResponse = [
            'data' => [
                ['id' => 1001, 'status' => 'completed'],
                ['id' => 1002, 'status' => 'pending'],
            ],
            'pagination' => [
                'total' => 2,
                'per_page' => 30,
                'current_page' => 1,
            ],
        ];

        $this->apiClient->expects($this->once())
            ->method('get')
            ->with('orders', [])
            ->willReturn($expectedResponse);

        $result = $this->service->getOrders();

        $this->assertEquals($expectedResponse, $result);
    }

    public function test_get_orders_forwards_query_parameters()
    {
        $query = [
            'page' => 1,
            'per_page' => 30,
            'status' => 'completed',
            'from_date' => '2024-01-01',
            'to_date' => '2024-12-31',
        ];

        $this->apiClient->expects($this->once())
            ->method('get')
            ->with('orders', $query)
            ->willReturn(['data' => []]);

        $this->service->getOrders($query);
    }

    public function test_get_order_calls_order_details_endpoint()
    {
        $orderId = 3155923424;
        $expectedResponse = [
            'data' => [
                'id' => 3155923424,
                'status' => 'completed',
                'reference_id' => 'REF-123',
            ],
        ];

        $this->apiClient->expects($this->once())
            ->method('get')
            ->with("orders/{$orderId}", [])
            ->willReturn($expectedResponse);

        $result = $this->service->getOrder($orderId);

        $this->assertEquals($expectedResponse, $result);
    }

    public function test_get_order_forwards_query_parameters()
    {
        $orderId = 3155923424;
        $query = ['format' => 'light'];

        $this->apiClient->expects($this->once())
            ->method('get')
            ->with("orders/{$orderId}", $query)
            ->willReturn(['data' => []]);

        $this->service->getOrder($orderId, $query);
    }

    public function test_response_is_returned_without_inventing_fields()
    {
        $apiResponse = [
            'data' => [['id' => 1001, 'status' => 'pending']],
            'meta' => ['custom_field' => 'value'],
        ];

        $this->apiClient->method('get')
            ->willReturn($apiResponse);

        $result = $this->service->getOrders();

        // Response should be exactly what the API returned
        $this->assertEquals($apiResponse, $result);
    }

    public function test_api_exceptions_propagate_correctly()
    {
        $this->apiClient->method('get')
            ->willThrowException(new RuntimeException('API request failed'));

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('API request failed');

        $this->service->getOrders();
    }

    public function test_no_real_external_request_occurs()
    {
        // This test verifies that the service uses the mocked API client
        // and does not make real HTTP requests
        $this->apiClient->expects($this->once())
            ->method('get')
            ->willReturn(['data' => []]);

        $this->service->getOrders();

        // If we reach here, the mock was used (no real request)
        $this->assertTrue(true);
    }
}
