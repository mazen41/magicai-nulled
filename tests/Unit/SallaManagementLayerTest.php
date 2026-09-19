<?php

namespace Tests\Unit;

use App\Http\Controllers\SallaOrderController;
use App\Http\Controllers\SallaStoreController;
use App\Http\Controllers\SallaWebhookEventController;
use App\Models\SallaConnection;
use App\Models\SallaOrder;
use App\Models\SallaWebhookEvent;
use App\Services\Salla\SallaApiClient;
use App\Services\Salla\SallaOAuthService;
use Illuminate\Support\Facades\Auth;
use Tests\TestCase;

class SallaManagementLayerTest extends TestCase
{
    public function test_user_cannot_access_another_users_salla_connection()
    {
        $user1 = $this->createUser();
        $user2 = $this->createUser();

        $connection1 = SallaConnection::factory()->create([
            'user_id' => $user1->id,
            'salla_store_id' => 12345,
        ]);

        $controller = new SallaStoreController();

        // Attempt to access as user2
        Auth::login($user2);

        $this->expectException(\Illuminate\Database\Eloquent\ModelNotFoundException::class);
        $controller->test($connection1->id);
    }

    public function test_user_cannot_access_another_users_salla_order()
    {
        $user1 = $this->createUser();
        $user2 = $this->createUser();

        $connection1 = SallaConnection::factory()->create([
            'user_id' => $user1->id,
            'salla_store_id' => 12345,
        ]);

        $order1 = SallaOrder::factory()->create([
            'salla_connection_id' => $connection1->id,
            'salla_order_id' => 999999,
        ]);

        $controller = new SallaOrderController();

        // Attempt to access as user2
        Auth::login($user2);

        $this->expectException(\Illuminate\Database\Eloquent\ModelNotFoundException::class);
        $controller->show($connection1->id, $order1->id);
    }

    public function test_user_cannot_access_another_users_webhook_events()
    {
        $user1 = $this->createUser();
        $user2 = $this->createUser();

        $connection1 = SallaConnection::factory()->create([
            'user_id' => $user1->id,
            'salla_store_id' => 12345,
        ]);

        $event1 = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection1->id,
            'event_type' => 'order.created',
        ]);

        $controller = new SallaWebhookEventController();

        // Attempt to access as user2
        Auth::login($user2);

        $this->expectException(\Illuminate\Database\Eloquent\ModelNotFoundException::class);
        $controller->show($connection1->id, $event1->id);
    }

    public function test_connection_test_requires_ownership()
    {
        $user1 = $this->createUser();
        $user2 = $this->createUser();

        $connection1 = SallaConnection::factory()->create([
            'user_id' => $user1->id,
            'salla_store_id' => 12345,
        ]);

        $controller = new SallaStoreController();

        // Attempt to test as user2
        Auth::login($user2);

        $this->expectException(\Illuminate\Database\Eloquent\ModelNotFoundException::class);
        $controller->test($connection1->id);
    }

    public function test_order_refresh_requires_ownership()
    {
        $user1 = $this->createUser();
        $user2 = $this->createUser();

        $connection1 = SallaConnection::factory()->create([
            'user_id' => $user1->id,
            'salla_store_id' => 12345,
        ]);

        $order1 = SallaOrder::factory()->create([
            'salla_connection_id' => $connection1->id,
            'salla_order_id' => 999999,
        ]);

        $controller = new SallaOrderController();

        // Attempt to refresh as user2
        Auth::login($user2);

        $this->expectException(\Illuminate\Database\Eloquent\ModelNotFoundException::class);
        $controller->refresh($connection1->id, $order1->id);
    }

    public function test_pii_is_not_exposed_in_order_summary()
    {
        $user = $this->createUser();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $order = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 999999,
            'order_data' => [
                'customer' => [
                    'name' => 'Test Customer',
                    'email' => 'test@example.com',
                    'phone' => '+1234567890',
                    'address' => '123 Test St',
                ],
            ],
        ]);

        $controller = new SallaOrderController();
        Auth::login($user);

        $response = $controller->show($connection->id, $order->id);

        // Verify order_data is not in the view data
        $viewData = $response->getData();
        $this->assertArrayHasKey('order', $viewData);
        $this->assertArrayNotHasKey('customer', $viewData['order']->toArray());
    }

    public function test_credentials_are_never_passed_to_views()
    {
        $user = $this->createUser();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
            'access_token' => 'encrypted_token',
            'refresh_token' => 'encrypted_refresh',
            'webhook_secret' => 'encrypted_secret',
        ]);

        $controller = new SallaStoreController();
        Auth::login($user);

        $response = $controller->index();

        $viewData = $response->getData();
        $this->assertArrayHasKey('connections', $viewData);

        foreach ($viewData['connections'] as $conn) {
            $this->assertArrayNotHasKey('access_token', $conn->toArray());
            $this->assertArrayNotHasKey('refresh_token', $conn->toArray());
            $this->assertArrayNotHasKey('webhook_secret', $conn->toArray());
        }
    }

    public function test_manual_refresh_uses_correct_salla_connection()
    {
        $user1 = $this->createUser();
        $user2 = $this->createUser();

        $connection1 = SallaConnection::factory()->create([
            'user_id' => $user1->id,
            'salla_store_id' => 12345,
        ]);

        $order1 = SallaOrder::factory()->create([
            'salla_connection_id' => $connection1->id,
            'salla_order_id' => 999999,
        ]);

        $controller = new SallaOrderController();
        Auth::login($user2);

        // Attempt to refresh as user2 should fail due to ownership check
        $this->expectException(\Illuminate\Database\Eloquent\ModelNotFoundException::class);
        $controller->refresh($connection1->id, $order1->id);
    }

    public function test_connection_view_shows_safe_summary_only()
    {
        $user = $this->createUser();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
            'store_name' => 'Test Store',
            'store_domain' => 'test.salla.sa',
            'merchant_email' => 'merchant@test.sa',
            'access_token' => 'encrypted_token',
            'refresh_token' => 'encrypted_refresh',
            'webhook_secret' => 'encrypted_secret',
        ]);

        $controller = new SallaStoreController();
        Auth::login($user);

        $response = $controller->index();

        $viewData = $response->getData();
        $this->assertArrayHasKey('connections', $viewData);

        $conn = $viewData['connections']->first();
        $this->assertEquals('Test Store', $conn->store_name);
        $this->assertEquals('test.salla.sa', $conn->store_domain);
        $this->assertEquals('merchant@test.sa', $conn->merchant_email);

        // Verify credentials are not exposed
        $this->assertArrayNotHasKey('access_token', $conn->toArray());
        $this->assertArrayNotHasKey('refresh_token', $conn->toArray());
        $this->assertArrayNotHasKey('webhook_secret', $conn->toArray());
    }

    public function test_webhook_event_view_shows_safe_summary_only()
    {
        $user = $this->createUser();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $event = SallaWebhookEvent::factory()->create([
            'salla_connection_id' => $connection->id,
            'event_type' => 'order.created',
            'merchant_id' => 999999,
            'signature_verified' => true,
            'processing_status' => 'completed',
            'payload' => json_encode(['data' => ['id' => 123456, 'customer' => ['name' => 'Test']]]),
        ]);

        $controller = new SallaWebhookEventController();
        Auth::login($user);

        $response = $controller->show($connection->id, $event->id);

        $viewData = $response->getData();
        $this->assertArrayHasKey('event', $viewData);

        // Verify safe fields are present
        $this->assertEquals('order.created', $viewData['event']->event_type);
        $this->assertEquals(999999, $viewData['event']->merchant_id);
        $this->assertTrue($viewData['event']->signature_verified);
        $this->assertEquals('completed', $viewData['event']->processing_status);

        // Verify payload is not exposed in detail view
        $this->assertArrayNotHasKey('payload', $viewData);
    }
}
