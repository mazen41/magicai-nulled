<?php

namespace Tests\Unit;

use App\Models\SallaConnection;
use App\Models\SallaOrder;
use App\Models\SallaWebhookEvent;
use App\Services\Salla\SallaApiClient;
use App\Services\Salla\SallaOAuthService;
use App\Services\Salla\SallaOrderService;
use App\Services\Salla\SallaOrderWebhookProcessor;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Tests\TestCase;

class SallaOrderWebhookProcessorTest extends TestCase
{
    public function test_processor_instantiates_with_connection_and_service()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        $processor = new SallaOrderWebhookProcessor($connection, $orderService);

        $this->assertInstanceOf(SallaOrderWebhookProcessor::class, $processor);
    }

    public function test_supported_order_event_is_processed()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->willReturn([
                'data' => [
                    'id' => 123456,
                    'reference_id' => 789012,
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

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'order.created',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $processor = new SallaOrderWebhookProcessor($connection, $orderService);
        $processor->process($event);

        $this->assertDatabaseHas('salla_orders', [
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
        ]);
    }

    public function test_unsupported_event_is_not_processed()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        $orderService->expects($this->never())->method('getOrder');

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'product.created',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $processor = new SallaOrderWebhookProcessor($connection, $orderService);
        $processor->process($event);

        $this->assertDatabaseMissing('salla_orders', [
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
        ]);
    }

    public function test_unsupported_order_event_is_not_processed()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        $orderService->expects($this->never())->method('getOrder');

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'order.status.updated',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $processor = new SallaOrderWebhookProcessor($connection, $orderService);
        $processor->process($event);

        $this->assertDatabaseMissing('salla_orders', [
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
        ]);
    }

    public function test_correct_salla_connection_is_used()
    {
        $connection1 = SallaConnection::factory()->create();
        $connection2 = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->willReturn([
                'data' => [
                    'id' => 123456,
                    'status' => ['slug' => 'completed'],
                    'currency' => 'SAR',
                    'amounts' => ['total' => ['amount' => 100.00]],
                    'date' => ['date' => '2024-01-01 12:00:00'],
                ],
            ]);

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection1->id,
            'event_type' => 'order.created',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $processor = new SallaOrderWebhookProcessor($connection1, $orderService);
        $processor->process($event);

        $this->assertDatabaseHas('salla_orders', [
            'salla_connection_id' => $connection1->id,
            'salla_order_id' => 123456,
        ]);

        $this->assertDatabaseMissing('salla_orders', [
            'salla_connection_id' => $connection2->id,
            'salla_order_id' => 123456,
        ]);
    }

    public function test_existing_order_snapshot_is_updated()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        // Create existing order
        SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
            'status' => 'pending',
            'total' => 50.00,
        ]);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->willReturn([
                'data' => [
                    'id' => 123456,
                    'reference_id' => 789012,
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

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'order.updated',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $processor = new SallaOrderWebhookProcessor($connection, $orderService);
        $processor->process($event);

        // Should be one record (updated, not duplicated)
        $orders = SallaOrder::where('salla_connection_id', $connection->id)
            ->where('salla_order_id', 123456)
            ->get();

        $this->assertCount(1, $orders);

        $order = $orders->first();
        $this->assertEquals('completed', $order->status);
        $this->assertEquals(100.00, $order->total);
    }

    public function test_different_connections_can_have_same_order_id()
    {
        $connection1 = SallaConnection::factory()->create();
        $connection2 = SallaConnection::factory()->create();
        $orderService1 = $this->createMock(SallaOrderService::class);
        $orderService2 = $this->createMock(SallaOrderService::class);

        $orderService1->expects($this->once())
            ->method('getOrder')
            ->willReturn([
                'data' => [
                    'id' => 123456,
                    'status' => ['slug' => 'completed'],
                    'currency' => 'SAR',
                    'amounts' => ['total' => ['amount' => 100.00]],
                    'date' => ['date' => '2024-01-01 12:00:00'],
                ],
            ]);

        $orderService2->expects($this->once())
            ->method('getOrder')
            ->willReturn([
                'data' => [
                    'id' => 123456,
                    'status' => ['slug' => 'pending'],
                    'currency' => 'SAR',
                    'amounts' => ['total' => ['amount' => 50.00]],
                    'date' => ['date' => '2024-01-01 12:00:00'],
                ],
            ]);

        $event1 = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection1->id,
            'event_type' => 'order.created',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $event2 = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection2->id,
            'event_type' => 'order.created',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $processor1 = new SallaOrderWebhookProcessor($connection1, $orderService1);
        $processor1->process($event1);

        $processor2 = new SallaOrderWebhookProcessor($connection2, $orderService2);
        $processor2->process($event2);

        // Both connections should have the same order ID
        $this->assertDatabaseHas('salla_orders', [
            'salla_connection_id' => $connection1->id,
            'salla_order_id' => 123456,
        ]);

        $this->assertDatabaseHas('salla_orders', [
            'salla_connection_id' => $connection2->id,
            'salla_order_id' => 123456,
        ]);
    }

    public function test_missing_order_id_is_handled_safely()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        $orderService->expects($this->never())->method('getOrder');

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'order.created',
            'payload' => json_encode(['data' => []]), // Missing ID
        ]);

        $processor = new SallaOrderWebhookProcessor($connection, $orderService);
        $processor->process($event);

        // Should not create order record
        $this->assertDatabaseMissing('salla_orders', [
            'salla_connection_id' => $connection->id,
        ]);
    }

    public function test_salla_api_failure_is_not_silently_marked_completed()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->willThrowException(new \RuntimeException('API Error'));

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'order.created',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $processor = new SallaOrderWebhookProcessor($connection, $orderService);

        $this->expectException(\RuntimeException::class);
        $processor->process($event);
    }

    public function test_no_credentials_stored_in_order_records()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        $orderService->expects($this->once())
            ->method('getOrder')
            ->willReturn([
                'data' => [
                    'id' => 123456,
                    'status' => ['slug' => 'completed'],
                    'currency' => 'SAR',
                    'amounts' => ['total' => ['amount' => 100.00]],
                    'date' => ['date' => '2024-01-01 12:00:00'],
                ],
            ]);

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'order.created',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $processor = new SallaOrderWebhookProcessor($connection, $orderService);
        $processor->process($event);

        $order = SallaOrder::where('salla_order_id', 123456)->first();

        // Verify no credential fields exist in order model
        $this->assertNotContains('access_token', $order->getFillable());
        $this->assertNotContains('refresh_token', $order->getFillable());
        $this->assertNotContains('webhook_secret', $order->getFillable());
    }

    public function test_order_deleted_marks_local_record_as_deleted()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        // Create existing order
        SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
            'status' => 'completed',
            'total' => 100.00,
        ]);

        // Should NOT call getOrder for deleted events
        $orderService->expects($this->never())->method('getOrder');

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'order.deleted',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $processor = new SallaOrderWebhookProcessor($connection, $orderService);
        $processor->process($event);

        $order = SallaOrder::where('salla_order_id', 123456)->first();

        $this->assertEquals('deleted', $order->status);
        $this->assertNotNull($order->deleted_at);
    }

    public function test_order_deleted_without_local_record_is_handled_safely()
    {
        $connection = SallaConnection::factory()->create();
        $orderService = $this->createMock(SallaOrderService::class);

        // Should NOT call getOrder for deleted events
        $orderService->expects($this->never())->method('getOrder');

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'order.deleted',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $processor = new SallaOrderWebhookProcessor($connection, $orderService);
        $processor->process($event);

        // Should not create a new record for deleted order
        $this->assertDatabaseMissing('salla_orders', [
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 123456,
        ]);
    }
}
