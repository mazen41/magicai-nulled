<?php

namespace Tests\Unit;

use App\Http\Controllers\SallaWebhookController;
use App\Jobs\Salla\ProcessSallaWebhookEvent;
use App\Models\SallaConnection;
use App\Models\SallaWebhookEvent;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Queue;
use Tests\TestCase;

class SallaWebhookControllerTest extends TestCase
{
    private SallaWebhookController $controller;

    protected function setUp(): void
    {
        parent::setUp();

        $this->controller = new SallaWebhookController();
    }

    public function test_controller_instantiates()
    {
        $this->assertInstanceOf(SallaWebhookController::class, $this->controller);
    }

    public function test_valid_signature_is_accepted()
    {
        $secret = 'test-secret';
        $payload = ['event' => 'order.created', 'merchant' => 12345];
        $rawPayload = json_encode($payload);
        $signature = hash_hmac('sha256', $rawPayload, $secret);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');
        $request->headers->set('X-Salla-Signature', $signature);

        config(['salla.webhook_secret' => $secret]);

        // Create a connection for the merchant
        SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        Queue::fake();

        $response = $this->controller->handle($request);

        $this->assertEquals(200, $response->status());

        // Verify job was dispatched
        Queue::assertPushed(ProcessSallaWebhookEvent::class);
    }

    public function test_invalid_signature_is_rejected()
    {
        $payload = ['event' => 'order.created', 'merchant' => 12345];
        $rawPayload = json_encode($payload);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');
        $request->headers->set('X-Salla-Signature', 'invalid-signature');

        config(['salla.webhook_secret' => 'test-secret']);

        $response = $this->controller->handle($request);

        $this->assertEquals(401, $response->status());
    }

    public function test_missing_signature_is_rejected()
    {
        $payload = ['event' => 'order.created', 'merchant' => 12345];
        $rawPayload = json_encode($payload);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');

        config(['salla.webhook_secret' => 'test-secret']);

        $response = $this->controller->handle($request);

        $this->assertEquals(401, $response->status());
    }

    public function test_raw_request_body_is_used_for_signature()
    {
        $secret = 'test-secret';
        $payload = ['event' => 'order.created', 'merchant' => 12345];
        $rawPayload = json_encode($payload);
        $signature = hash_hmac('sha256', $rawPayload, $secret);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');
        $request->headers->set('X-Salla-Signature', $signature);

        config(['salla.webhook_secret' => $secret]);

        SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        $response = $this->controller->handle($request);

        $this->assertEquals(200, $response->status());
    }

    public function test_correct_salla_connection_is_identified()
    {
        $secret = 'test-secret';
        $payload = ['event' => 'order.created', 'merchant' => 12345];
        $rawPayload = json_encode($payload);
        $signature = hash_hmac('sha256', $rawPayload, $secret);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');
        $request->headers->set('X-Salla-Signature', $signature);

        config(['salla.webhook_secret' => $secret]);

        $connection = SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        $response = $this->controller->handle($request);

        $this->assertEquals(200, $response->status());

        // Verify event was recorded with correct connection
        $event = SallaWebhookEvent::where('salla_connection_id', $connection->id)->first();
        $this->assertNotNull($event);
    }

    public function test_unknown_merchant_event_is_recorded_for_diagnostics()
    {
        $secret = 'test-secret';
        $payload = ['event' => 'order.created', 'merchant' => 99999];
        $rawPayload = json_encode($payload);
        $signature = hash_hmac('sha256', $rawPayload, $secret);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');
        $request->headers->set('X-Salla-Signature', $signature);

        config(['salla.webhook_secret' => $secret]);

        // No connection for merchant 99999
        $response = $this->controller->handle($request);

        $this->assertEquals(200, $response->status());

        // Event should still be recorded for diagnostics (connection_id is null)
        $event = SallaWebhookEvent::where('merchant_id', 99999)->first();
        $this->assertNotNull($event);
        $this->assertNull($event->salla_connection_id);
    }

    public function test_event_is_recorded()
    {
        $secret = 'test-secret';
        $payload = ['event' => 'order.created', 'merchant' => 12345];
        $rawPayload = json_encode($payload);
        $signature = hash_hmac('sha256', $rawPayload, $secret);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');
        $request->headers->set('X-Salla-Signature', $signature);

        config(['salla.webhook_secret' => $secret]);

        SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        Queue::fake();

        $this->controller->handle($request);

        $event = SallaWebhookEvent::where('event_type', 'order.created')->first();
        $this->assertNotNull($event);
        $this->assertEquals('verified', $event->signature_verification_status);
        $this->assertEquals('pending', $event->processing_status);
        $this->assertNotNull($event->payload_hash);

        // Verify job was dispatched
        Queue::assertPushed(ProcessSallaWebhookEvent::class);
    }

    public function test_duplicate_event_is_handled()
    {
        $secret = 'test-secret';
        $payload = ['event' => 'order.created', 'merchant' => 12345, 'created_at' => '2024-01-01T00:00:00Z'];
        $rawPayload = json_encode($payload);
        $signature = hash_hmac('sha256', $rawPayload, $secret);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');
        $request->headers->set('X-Salla-Signature', $signature);

        config(['salla.webhook_secret' => $secret]);

        SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        Queue::fake();

        // First request
        $this->controller->handle($request);

        // Second request (duplicate - same payload)
        $response = $this->controller->handle($request);

        $this->assertEquals(200, $response->status());

        // Should only have one event recorded (idempotency via payload hash)
        $events = SallaWebhookEvent::where('event_type', 'order.created')->get();
        $this->assertCount(1, $events);

        // Job should only be dispatched once
        Queue::assertPushed(ProcessSallaWebhookEvent::class, 1);
    }

    public function test_different_payloads_with_same_timestamp_are_not_duplicates()
    {
        $secret = 'test-secret';
        $timestamp = '2024-01-01T00:00:00Z';

        // First payload
        $payload1 = ['event' => 'order.created', 'merchant' => 12345, 'created_at' => $timestamp, 'data' => ['id' => 1]];
        $rawPayload1 = json_encode($payload1);
        $signature1 = hash_hmac('sha256', $rawPayload1, $secret);

        $request1 = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload1);
        $request1->headers->set('X-Salla-Security-Strategy', 'signature');
        $request1->headers->set('X-Salla-Signature', $signature1);

        config(['salla.webhook_secret' => $secret]);

        SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        $this->controller->handle($request1);

        // Second payload (different data, same timestamp)
        $payload2 = ['event' => 'order.created', 'merchant' => 12345, 'created_at' => $timestamp, 'data' => ['id' => 2]];
        $rawPayload2 = json_encode($payload2);
        $signature2 = hash_hmac('sha256', $rawPayload2, $secret);

        $request2 = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload2);
        $request2->headers->set('X-Salla-Security-Strategy', 'signature');
        $request2->headers->set('X-Salla-Signature', $signature2);

        $response = $this->controller->handle($request2);

        $this->assertEquals(200, $response->status());

        // Should have two events (different payloads)
        $events = SallaWebhookEvent::where('event_type', 'order.created')->get();
        $this->assertCount(2, $events);
    }

    public function test_concurrent_duplicate_insert_is_handled_safely()
    {
        $secret = 'test-secret';
        $payload = ['event' => 'order.created', 'merchant' => 12345];
        $rawPayload = json_encode($payload);
        $signature = hash_hmac('sha256', $rawPayload, $secret);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');
        $request->headers->set('X-Salla-Signature', $signature);

        config(['salla.webhook_secret' => $secret]);

        SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        Queue::fake();

        // Create an event first
        SallaWebhookEvent::factory()->create([
            'salla_connection_id' => SallaConnection::where('salla_store_id', 12345)->first()->id,
            'event_type' => 'order.created',
            'merchant_id' => 12345,
            'payload_hash' => hash('sha256', $rawPayload),
            'processing_status' => 'pending',
        ]);

        // Try to insert duplicate (simulates race condition)
        $response = $this->controller->handle($request);

        $this->assertEquals(200, $response->status());

        // Should still only have one event
        $events = SallaWebhookEvent::where('event_type', 'order.created')->get();
        $this->assertCount(1, $events);
    }

    public function test_secrets_do_not_appear_in_logs()
    {
        $secret = 'super-secret-value-12345';
        $payload = ['event' => 'order.created', 'merchant' => 12345];
        $rawPayload = json_encode($payload);
        $signature = hash_hmac('sha256', $rawPayload, $secret);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');
        $request->headers->set('X-Salla-Signature', $signature);

        config(['salla.webhook_secret' => $secret]);

        SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        // Mock Log facade to capture log messages
        Log::spy();

        $this->controller->handle($request);

        // Verify secret is not in any log messages
        Log::assertNotLogged(function ($message) use ($secret) {
            return str_contains($message, $secret);
        });
    }

    public function test_full_payload_is_not_logged()
    {
        $secret = 'test-secret';
        $payload = [
            'event' => 'order.created',
            'merchant' => 12345,
            'data' => [
                'customer' => ['name' => 'John Doe', 'email' => 'john@example.com'],
                'order' => ['id' => 12345, 'total' => 100],
            ],
        ];
        $rawPayload = json_encode($payload);
        $signature = hash_hmac('sha256', $rawPayload, $secret);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');
        $request->headers->set('X-Salla-Signature', $signature);

        config(['salla.webhook_secret' => $secret]);

        SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        Log::spy();

        $this->controller->handle($request);

        // Verify full payload is not in log messages
        Log::assertNotLogged(function ($message) use ($payload) {
            return str_contains($message, json_encode($payload));
        });
    }

    public function test_job_is_dispatched_after_event_creation()
    {
        $secret = 'test-secret';
        $payload = ['event' => 'order.created', 'merchant' => 12345];
        $rawPayload = json_encode($payload);
        $signature = hash_hmac('sha256', $rawPayload, $secret);

        $request = Request::create('/webhooks/salla', 'POST', [], [], [], [], $rawPayload);
        $request->headers->set('X-Salla-Security-Strategy', 'signature');
        $request->headers->set('X-Salla-Signature', $signature);

        config(['salla.webhook_secret' => $secret]);

        SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        Queue::fake();

        $this->controller->handle($request);

        Queue::assertPushed(ProcessSallaWebhookEvent::class, function ($job) {
            return $job->webhookEventId > 0;
        });
    }
}
