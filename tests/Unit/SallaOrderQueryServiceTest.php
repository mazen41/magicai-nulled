<?php

namespace Tests\Unit;

use App\Models\SallaConnection;
use App\Models\SallaOrder;
use App\Services\Salla\SallaOrderQueryService;
use App\Services\Salla\SallaOrderService;
use Tests\TestCase;

class SallaOrderQueryServiceTest extends TestCase
{
    public function test_find_by_salla_order_id_scopes_by_connection()
    {
        $connection1 = SallaConnection::factory()->create();
        $connection2 = SallaConnection::factory()->create();

        // Create order for connection1
        $order1 = SallaOrder::factory()->create([
            'salla_connection_id' => $connection1->id,
            'salla_order_id' => 123456,
        ]);

        // Create order for connection2 with same order ID
        $order2 = SallaOrder::factory()->create([
            'salla_connection_id' => $connection2->id,
            'salla_order_id' => 123456,
        ]);

        $orderService = $this->createMock(SallaOrderService::class);
        $queryService1 = new SallaOrderQueryService($connection1, $orderService);
        $queryService2 = new SallaOrderQueryService($connection2, $orderService);

        $result1 = $queryService1->findBySallaOrderId($connection1, 123456);
        $result2 = $queryService2->findBySallaOrderId($connection2, 123456);

        // Each connection should retrieve its own order
        $this->assertEquals($order1->id, $result1->id);
        $this->assertEquals($order2->id, $result2->id);
    }

    public function test_connection_a_cannot_retrieve_connection_b_order()
    {
        $connection1 = SallaConnection::factory()->create();
        $connection2 = SallaConnection::factory()->create();

        // Create order for connection2 only
        SallaOrder::factory()->create([
            'salla_connection_id' => $connection2->id,
            'salla_order_id' => 123456,
        ]);

        $orderService = $this->createMock(SallaOrderService::class);
        $queryService1 = new SallaOrderQueryService($connection1, $orderService);

        $result = $queryService1->findBySallaOrderId($connection1, 123456);

        // Connection1 should not find connection2's order
        $this->assertNull($result);
    }

    public function test_same_salla_order_id_can_exist_under_different_connections()
    {
        $connection1 = SallaConnection::factory()->create();
        $connection2 = SallaConnection::factory()->create();

        // Same order ID under different connections
        SallaOrder::factory()->create([
            'salla_connection_id' => $connection1->id,
            'salla_order_id' => 123456,
            'total' => 100.00,
        ]);

        SallaOrder::factory()->create([
            'salla_connection_id' => $connection2->id,
            'salla_order_id' => 123456,
            'total' => 200.00,
        ]);

        $orderService = $this->createMock(SallaOrderService::class);
        $queryService1 = new SallaOrderQueryService($connection1, $orderService);
        $queryService2 = new SallaOrderQueryService($connection2, $orderService);

        $result1 = $queryService1->findBySallaOrderId($connection1, 123456);
        $result2 = $queryService2->findBySallaOrderId($connection2, 123456);

        // Both should exist independently
        $this->assertNotNull($result1);
        $this->assertNotNull($result2);
        $this->assertEquals(100.00, $result1->total);
        $this->assertEquals(200.00, $result2->total);
    }

    public function test_find_by_reference_id_scopes_by_connection()
    {
        $connection1 = SallaConnection::factory()->create();
        $connection2 = SallaConnection::factory()->create();

        // Create order for connection1
        $order1 = SallaOrder::factory()->create([
            'salla_connection_id' => $connection1->id,
            'reference_id' => 'REF001',
        ]);

        // Create order for connection2 with same reference ID
        $order2 = SallaOrder::factory()->create([
            'salla_connection_id' => $connection2->id,
            'reference_id' => 'REF001',
        ]);

        $orderService = $this->createMock(SallaOrderService::class);
        $queryService1 = new SallaOrderQueryService($connection1, $orderService);
        $queryService2 = new SallaOrderQueryService($connection2, $orderService);

        $result1 = $queryService1->findByReferenceId($connection1, 'REF001');
        $result2 = $queryService2->findByReferenceId($connection2, 'REF001');

        // Each connection should retrieve its own order
        $this->assertEquals($order1->id, $result1->id);
        $this->assertEquals($order2->id, $result2->id);
    }

    public function test_same_reference_id_can_exist_under_different_connections()
    {
        $connection1 = SallaConnection::factory()->create();
        $connection2 = SallaConnection::factory()->create();

        // Same reference ID under different connections
        SallaOrder::factory()->create([
            'salla_connection_id' => $connection1->id,
            'reference_id' => 'REF001',
            'total' => 100.00,
        ]);

        SallaOrder::factory()->create([
            'salla_connection_id' => $connection2->id,
            'reference_id' => 'REF001',
            'total' => 200.00,
        ]);

        $orderService = $this->createMock(SallaOrderService::class);
        $queryService1 = new SallaOrderQueryService($connection1, $orderService);
        $queryService2 = new SallaOrderQueryService($connection2, $orderService);

        $result1 = $queryService1->findByReferenceId($connection1, 'REF001');
        $result2 = $queryService2->findByReferenceId($connection2, 'REF001');

        // Both should exist independently
        $this->assertNotNull($result1);
        $this->assertNotNull($result2);
        $this->assertEquals(100.00, $result1->total);
        $this->assertEquals(200.00, $result2->total);
    }

    public function test_local_lookup_never_crosses_connection_boundaries()
    {
        $connection1 = SallaConnection::factory()->create();
        $connection2 = SallaConnection::factory()->create();

        // Create orders for both connections
        SallaOrder::factory()->create([
            'salla_connection_id' => $connection1->id,
            'salla_order_id' => 111111,
            'reference_id' => 'REF111',
        ]);

        SallaOrder::factory()->create([
            'salla_connection_id' => $connection2->id,
            'salla_order_id' => 222222,
            'reference_id' => 'REF222',
        ]);

        $orderService = $this->createMock(SallaOrderService::class);
        $queryService1 = new SallaOrderQueryService($connection1, $orderService);

        // Connection1 should only find its own orders
        $this->assertNotNull($queryService1->findBySallaOrderId($connection1, 111111));
        $this->assertNull($queryService1->findBySallaOrderId($connection1, 222222));
        $this->assertNotNull($queryService1->findByReferenceId($connection1, 'REF111'));
        $this->assertNull($queryService1->findByReferenceId($connection1, 'REF222'));
    }

    public function test_get_latest_snapshot_returns_local_order_without_api_call()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        // Should NOT call API
        $orderService->expects($this->never())->method('getOrder');

        // Create local order
        $localOrder = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
            'total' => 100.00,
        ]);

        $queryService = new SallaOrderQueryService($connection, $orderService);
        $result = $queryService->getLatestSnapshot($connection, 123456);

        $this->assertEquals($localOrder->id, $result->id);
        $this->assertEquals(100.00, $result->total);
    }

    public function test_get_latest_snapshot_returns_deleted_local_order_without_api_call()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        // Should NOT call API
        $orderService->expects($this->never())->method('getOrder');

        // Create deleted local order
        $localOrder = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
            'status' => 'deleted',
            'deleted_at' => now(),
        ]);

        $queryService = new SallaOrderQueryService($connection, $orderService);
        $result = $queryService->getLatestSnapshot($connection, 123456);

        $this->assertEquals($localOrder->id, $result->id);
        $this->assertEquals('deleted', $result->status);
        $this->assertNotNull($result->deleted_at);
    }

    public function test_refresh_calls_salla_order_service_using_supplied_connection()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->with(123456)
            ->willReturn([
                'data' => [
                    'id' => 123456,
                    'reference_id' => 'REF001',
                    'status' => ['slug' => 'completed', 'name' => 'Completed'],
                    'currency' => 'SAR',
                    'amounts' => [
                        'total' => ['amount' => 100.00],
                        'sub_total' => ['amount' => 90.00],
                        'shipping_cost' => ['amount' => 10.00],
                        'tax' => ['amount' => ['amount' => 0.00]],
                    ],
                    'payment_method' => 'bank',
                    'date' => ['date' => '2024-01-01 12:00:00'],
                ],
            ]);

        $queryService = new SallaOrderQueryService($connection, $orderService);
        $result = $queryService->refreshOrder($connection, 123456);

        $this->assertNotNull($result);
        $this->assertEquals(123456, $result->salla_order_id);
    }

    public function test_successful_refresh_updates_local_snapshot()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        // Create existing local order with old data
        $existingOrder = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
            'total' => 50.00,
            'status' => 'pending',
        ]);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->with(123456)
            ->willReturn([
                'data' => [
                    'id' => 123456,
                    'reference_id' => 'REF001',
                    'status' => ['slug' => 'completed', 'name' => 'Completed'],
                    'currency' => 'SAR',
                    'amounts' => [
                        'total' => ['amount' => 100.00],
                        'sub_total' => ['amount' => 90.00],
                        'shipping_cost' => ['amount' => 10.00],
                        'tax' => ['amount' => ['amount' => 0.00]],
                    ],
                    'payment_method' => 'bank',
                    'date' => ['date' => '2024-01-01 12:00:00'],
                ],
            ]);

        $queryService = new SallaOrderQueryService($connection, $orderService);
        $result = $queryService->refreshOrder($connection, 123456);

        // Should be the same record, updated
        $this->assertEquals($existingOrder->id, $result->id);
        $this->assertEquals(100.00, $result->total);
        $this->assertEquals('completed', $result->status);
    }

    public function test_api_failure_throws_exception()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->willThrowException(new \RuntimeException('API Error'));

        $queryService = new SallaOrderQueryService($connection, $orderService);

        $this->expectException(\RuntimeException::class);
        $queryService->refreshOrder($connection, 123456);
    }

    public function test_api_failure_does_not_write_partial_snapshot()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        // Create existing local order
        $existingOrder = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
            'total' => 50.00,
        ]);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->willThrowException(new \RuntimeException('API Error'));

        $queryService = new SallaOrderQueryService($connection, $orderService);

        try {
            $queryService->refreshOrder($connection, 123456);
        } catch (\RuntimeException $e) {
            // Expected
        }

        // Local order should remain unchanged
        $existingOrder->refresh();
        $this->assertEquals(50.00, $existingOrder->total);
    }

    public function test_refresh_creates_new_snapshot_if_not_exists()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->with(123456)
            ->willReturn([
                'data' => [
                    'id' => 123456,
                    'reference_id' => 'REF001',
                    'status' => ['slug' => 'completed', 'name' => 'Completed'],
                    'currency' => 'SAR',
                    'amounts' => [
                        'total' => ['amount' => 100.00],
                        'sub_total' => ['amount' => 90.00],
                        'shipping_cost' => ['amount' => 10.00],
                        'tax' => ['amount' => ['amount' => 0.00]],
                    ],
                    'payment_method' => 'bank',
                    'date' => ['date' => '2024-01-01 12:00:00'],
                ],
            ]);

        $queryService = new SallaOrderQueryService($connection, $orderService);
        $result = $queryService->refreshOrder($connection, 123456);

        // Should create new record
        $this->assertDatabaseHas('salla_orders', [
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
        ]);
    }

    public function test_refresh_deleted_order_updates_status()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        // Create deleted local order
        $existingOrder = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
            'status' => 'deleted',
            'deleted_at' => now(),
        ]);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->with(123456)
            ->willReturn([
                'data' => [
                    'id' => 123456,
                    'reference_id' => 'REF001',
                    'status' => ['slug' => 'completed', 'name' => 'Completed'],
                    'currency' => 'SAR',
                    'amounts' => [
                        'total' => ['amount' => 100.00],
                        'sub_total' => ['amount' => 90.00],
                        'shipping_cost' => ['amount' => 10.00],
                        'tax' => ['amount' => ['amount' => 0.00]],
                    ],
                    'payment_method' => 'bank',
                    'date' => ['date' => '2024-01-01 12:00:00'],
                ],
            ]);

        $queryService = new SallaOrderQueryService($connection, $orderService);
        $result = $queryService->refreshOrder($connection, 123456);

        // Should update the deleted order with new status
        $this->assertEquals($existingOrder->id, $result->id);
        $this->assertEquals('completed', $result->status);
    }

    public function test_refresh_deleted_order_404_throws_exception()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        // Create deleted local order
        SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
            'status' => 'deleted',
            'deleted_at' => now(),
        ]);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->with(123456)
            ->willThrowException(new \RuntimeException('404 Not Found'));

        $queryService = new SallaOrderQueryService($connection, $orderService);

        // Should throw exception - no special handling for 404
        $this->expectException(\RuntimeException::class);
        $queryService->refreshOrder($connection, 123456);
    }
}
