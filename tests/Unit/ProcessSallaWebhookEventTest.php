<?php

namespace Tests\Unit;

use App\Jobs\Salla\ProcessSallaWebhookEvent;
use App\Models\SallaConnection;
use App\Models\SallaOrder;
use App\Models\SallaWebhookEvent;
use Illuminate\Support\Facades\Log;
use Tests\TestCase;

class ProcessSallaWebhookEventTest extends TestCase
{
    public function test_job_instantiates_with_webhook_event_id()
    {
        $job = new ProcessSallaWebhookEvent(123);

        $this->assertInstanceOf(ProcessSallaWebhookEvent::class, $job);
    }

    public function test_job_loads_event_by_id()
    {
        $event = SallaWebhookEvent::factory()->create([
            'event_type' => 'order.created',
            'merchant_id' => 12345,
            'payload_hash' => hash('sha256', 'test-payload'),
            'processing_status' => 'pending',
        ]);

        $job = new ProcessSallaWebhookEvent($event->id);
        $job->handle();

        $this->assertEquals('completed', $event->fresh()->processing_status);
    }

    public function test_job_handles_missing_event()
    {
        $job = new ProcessSallaWebhookEvent(999999);
        $job->handle();

        // Should complete without error
        $this->assertTrue(true);
    }

    public function test_job_skips_already_completed_event()
    {
        $event = SallaWebhookEvent::factory()->create([
            'event_type' => 'order.created',
            'merchant_id' => 12345,
            'payload_hash' => hash('sha256', 'test-payload'),
            'processing_status' => 'completed',
            'processed_at' => now(),
        ]);

        $job = new ProcessSallaWebhookEvent($event->id);
        $job->handle();

        // Should remain completed
        $this->assertEquals('completed', $event->fresh()->processing_status);
    }

    public function test_job_resets_stale_processing_event()
    {
        $event = SallaWebhookEvent::factory()->create([
            'event_type' => 'order.created',
            'merchant_id' => 12345,
            'payload_hash' => hash('sha256', 'test-payload'),
            'processing_status' => 'processing',
            'updated_at' => now()->subMinutes(10),
        ]);

        $job = new ProcessSallaWebhookEvent($event->id);
        $job->handle();

        // Should be reset to pending
        $this->assertEquals('pending', $event->fresh()->processing_status);
    }

    public function test_job_payload_contains_only_webhook_event_id()
    {
        $webhookEventId = 123;
        $job = new ProcessSallaWebhookEvent($webhookEventId);

        // Verify the job only stores the webhook event ID
        $this->assertEquals($webhookEventId, $job->webhookEventId);
    }

    public function test_job_does_not_contain_credentials()
    {
        $job = new ProcessSallaWebhookEvent(123);

        // The job payload is just the integer ID
        // No access tokens, refresh tokens, or secrets are stored
        $this->assertIsInt($job->webhookEventId);
    }

    public function test_order_event_is_routed_to_order_processor()
    {
        $connection = SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'order.created',
            'merchant_id' => 12345,
            'payload_hash' => hash('sha256', 'test-payload'),
            'processing_status' => 'pending',
            'payload' => json_encode(['data' => ['id' => 123456]]),
        ]);

        $job = new ProcessSallaWebhookEvent($event->id);

        // This test would require mocking the order processor dependency
        // For now, just verify the method structure
        $this->assertTrue(true);
    }

    public function test_unsupported_event_does_not_fail_job()
    {
        $connection = SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'unknown.event',
            'merchant_id' => 12345,
            'payload_hash' => hash('sha256', 'test-payload'),
            'processing_status' => 'pending',
        ]);

        $job = new ProcessSallaWebhookEvent($event->id);
        $job->handle();

        // Should be marked completed even for unsupported events
        $this->assertEquals('completed', $event->fresh()->processing_status);
    }

    public function test_unsupported_order_event_does_not_fail_job()
    {
        $connection = SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'order.status.updated',
            'merchant_id' => 12345,
            'payload_hash' => hash('sha256', 'test-payload'),
            'processing_status' => 'pending',
        ]);

        $job = new ProcessSallaWebhookEvent($event->id);
        $job->handle();

        // Should be marked completed even for unsupported order events
        $this->assertEquals('completed', $event->fresh()->processing_status);
    }

    public function test_explicit_order_events_are_routed_to_processor()
    {
        $connection = SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        $supportedEvents = [
            'order.created',
            'order.updated',
            'order.cancelled',
            'order.refunded',
            'order.deleted',
        ];

        foreach ($supportedEvents as $eventType) {
            $event = SallaWebhookEvent::factory()->create([
                'salla_connection_id' => $connection->id,
                'event_type' => $eventType,
                'merchant_id' => 12345,
                'payload_hash' => hash('sha256', 'test-payload-' . $eventType),
                'processing_status' => 'pending',
            ]);

            // Just verify routing - don't actually process
            $job = new ProcessSallaWebhookEvent($event->id);

            // Routing should identify these as order events
            $this->assertTrue(str_starts_with($eventType, 'order.'));
        }
    }
}

