<?php

namespace Tests\Unit;

use App\Models\SallaConnection;
use App\Models\SallaWebhookSubscription;
use App\Services\Salla\SallaApiClient;
use App\Services\Salla\SallaOAuthService;
use App\Services\Salla\SallaWebhookService;
use Illuminate\Support\Facades\Log;
use Tests\TestCase;

class SallaWebhookServiceTest extends TestCase
{
    public function test_service_instantiates_with_connection_and_client()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        $service = new SallaWebhookService($connection, $apiClient);

        $this->assertInstanceOf(SallaWebhookService::class, $service);
    }

    public function test_subscribe_calls_correct_endpoint()
    {
        $connection = SallaConnection::factory()->create([
            'salla_store_id' => 12345,
            'connection_status' => 'connected',
        ]);

        $apiClient = $this->createMock(SallaApiClient::class);
        $apiClient->expects($this->once())
            ->method('post')
            ->with('webhooks/subscribe', $this->callback(function ($payload) {
                return isset($payload['event']) && isset($payload['url']) && isset($payload['version']);
            }))
            ->willReturn([
                'data' => [
                    'id' => 123456,
                    'name' => 'MagicAI order.created',
                    'event' => 'order.created',
                    'url' => 'https://example.com/webhooks/salla',
                    'version' => 2,
                ],
            ]);

        config(['salla.webhook_url' => 'https://example.com/webhooks/salla']);

        $service = new SallaWebhookService($connection, $apiClient);
        $result = $service->subscribe('order.created');

        $this->assertEquals('created', $result['status']);
        $this->assertNotNull($result['subscription']);
    }

    public function test_subscribe_uses_configured_webhook_url()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        $apiClient->expects($this->once())
            ->method('post')
            ->with('webhooks/subscribe', $this->callback(function ($payload) {
                return $payload['url'] === 'https://configured.url/webhooks';
            }))
            ->willReturn(['data' => ['id' => 123456]]);

        config(['salla.webhook_url' => 'https://configured.url/webhooks']);

        $service = new SallaWebhookService($connection, $apiClient);
        $service->subscribe('order.created');
    }

    public function test_subscribe_throws_if_webhook_url_not_configured()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        config(['salla.webhook_url' => null]);

        $service = new SallaWebhookService($connection, $apiClient);

        $this->expectException(\RuntimeException::class);
        $this->expectExceptionMessage('SALLA_WEBHOOK_URL is not configured');

        $service->subscribe('order.created');
    }

    public function test_existing_subscription_is_not_duplicated()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        // Create existing subscription for the same URL
        SallaWebhookSubscription::factory()->create([
            'salla_connection_id' => $connection->id,
            'event' => 'order.created',
            'url' => 'https://example.com/webhooks/salla',
            'status' => 'active',
        ]);

        config(['salla.webhook_url' => 'https://example.com/webhooks/salla']);

        // API should NOT be called because URL already has a subscription
        $apiClient->expects($this->never())->method('post');

        $service = new SallaWebhookService($connection, $apiClient);
        $result = $service->subscribe('order.created');

        $this->assertEquals('exists', $result['status']);
    }

    public function test_different_event_same_url_finds_existing_subscription()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        // Create existing subscription for the same URL with different event
        SallaWebhookSubscription::factory()->create([
            'salla_connection_id' => $connection->id,
            'event' => 'order.created',
            'url' => 'https://example.com/webhooks/salla',
            'status' => 'active',
        ]);

        config(['salla.webhook_url' => 'https://example.com/webhooks/salla']);

        // API should NOT be called because URL already has a subscription
        // Salla will update the events on the existing webhook
        $apiClient->expects($this->never())->method('post');

        $service = new SallaWebhookService($connection, $apiClient);
        $result = $service->subscribe('order.updated');

        $this->assertEquals('exists', $result['status']);
    }

    public function test_list_webhooks_calls_correct_endpoint()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        $apiClient->expects($this->once())
            ->method('get')
            ->with('webhooks')
            ->willReturn(['data' => []]);

        $service = new SallaWebhookService($connection, $apiClient);
        $service->listWebhooks();
    }

    public function test_update_webhook_calls_correct_endpoint()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        $apiClient->expects($this->once())
            ->method('put')
            ->with('webhooks/123456', $this->anything())
            ->willReturn(['data' => ['id' => 123456]]);

        $service = new SallaWebhookService($connection, $apiClient);
        $service->updateWebhook(123456, ['name' => 'Updated Name']);
    }

    public function test_unsubscribe_calls_correct_endpoint()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        $apiClient->expects($this->once())
            ->method('delete')
            ->with('webhooks/unsubscribe', ['id' => 123456])
            ->willReturn(['data' => ['message' => 'deleted']]);

        $service = new SallaWebhookService($connection, $apiClient);
        $service->unsubscribe(123456);
    }

    public function test_unsubscribe_uses_id_not_url()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        // Verify that unsubscribe uses ID parameter, not URL
        // Using URL would delete ALL webhooks for that URL
        $apiClient->expects($this->once())
            ->method('delete')
            ->with('webhooks/unsubscribe', $this->callback(function ($params) {
                return isset($params['id']) && !isset($params['url']);
            }))
            ->willReturn(['data' => ['message' => 'deleted']]);

        $service = new SallaWebhookService($connection, $apiClient);
        $service->unsubscribe(123456);
    }

    public function test_sync_subscriptions_synchronizes_with_api()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        $apiClient->expects($this->once())
            ->method('get')
            ->with('webhooks')
            ->willReturn([
                'data' => [
                    ['id' => 123456, 'event' => 'order.created', 'url' => 'https://example.com/webhooks', 'type' => 'manual'],
                ],
            ]);

        $service = new SallaWebhookService($connection, $apiClient);
        $result = $service->syncSubscriptions();

        $this->assertArrayHasKey('synced', $result);
        $this->assertArrayHasKey('created', $result);
        $this->assertArrayHasKey('marked_inactive', $result);
    }

    public function test_sync_marks_inactive_subscriptions_missing_from_api()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        // Create local subscription
        SallaWebhookSubscription::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_webhook_id' => 999999,
            'status' => 'active',
        ]);

        $apiClient->expects($this->once())
            ->method('get')
            ->with('webhooks')
            ->willReturn([
                'data' => [
                    ['id' => 123456, 'event' => 'order.created', 'url' => 'https://example.com/webhooks', 'type' => 'manual'],
                ],
            ]);

        $service = new SallaWebhookService($connection, $apiClient);
        $result = $service->syncSubscriptions();

        $this->assertEquals(1, $result['marked_inactive']);

        // Verify the old subscription is now inactive
        $oldSubscription = SallaWebhookSubscription::where('salla_webhook_id', 999999)->first();
        $this->assertEquals('inactive', $oldSubscription->status);
    }

    public function test_service_does_not_log_credentials()
    {
        $connection = SallaConnection::factory()->create();
        $apiClient = $this->createMock(SallaApiClient::class);

        Log::spy();

        $service = new SallaWebhookService($connection, $apiClient);

        // Any operation that logs
        try {
            $service->subscribe('order.created');
        } catch (\Exception $e) {
            // Expected if webhook URL not configured
        }

        // Verify no credentials in logs
        Log::assertNotLogged(function ($message) {
            return str_contains($message, 'access_token') ||
                   str_contains($message, 'refresh_token') ||
                   str_contains($message, 'webhook_secret');
        });
    }

    public function test_configured_events_are_valid()
    {
        $configuredEvents = config('salla.webhook_events');

        // Verify these are the configured events
        $expectedEvents = [
            'order.created',
            'order.updated',
            'order.cancelled',
            'order.refunded',
            'order.deleted',
            'product.created',
            'product.updated',
            'product.deleted',
        ];

        $this->assertEquals($expectedEvents, $configuredEvents);
    }
}
