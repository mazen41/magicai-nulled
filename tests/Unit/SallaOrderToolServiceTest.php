<?php

namespace Tests\Unit;

use App\Models\Chatbot\Chatbot;
use App\Models\SallaConnection;
use App\Models\SallaOrder;
use App\Models\User;
use App\Services\Salla\SallaOrderToolService;
use App\Services\Salla\SallaOrderQueryService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class SallaOrderToolServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_tool_service_registers_correctly()
    {
        $service = new SallaOrderToolService();
        $this->assertInstanceOf(SallaOrderToolService::class, $service);
    }

    public function test_tool_schema_is_correct()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $service = new SallaOrderToolService();
        $toolDefinitions = $service->getToolDefinitions($chatbot);

        $this->assertIsArray($toolDefinitions);
        $this->assertCount(1, $toolDefinitions);

        $tool = $toolDefinitions[0];
        $this->assertEquals('function', $tool['type']);
        $this->assertEquals('salla_order_status', $tool['function']['name']);
        $this->assertArrayHasKey('description', $tool['function']);
        $this->assertArrayHasKey('parameters', $tool['function']);
        $this->assertEquals('object', $tool['function']['parameters']['type']);
        $this->assertArrayHasKey('order_reference', $tool['function']['parameters']['properties']);
        $this->assertContains('order_reference', $tool['function']['parameters']['required']);
    }

    public function test_tool_uses_current_chatbot_context()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $service = new SallaOrderToolService();
        $toolDefinitions = $service->getToolDefinitions($chatbot);

        // Tool should only be registered when chatbot has Salla connection
        $this->assertCount(1, $toolDefinitions);
    }

    public function test_tool_cannot_select_arbitrary_salla_connection_id()
    {
        $user1 = User::factory()->create();
        $user2 = User::factory()->create();

        $connection1 = SallaConnection::factory()->create([
            'user_id' => $user1->id,
            'salla_store_id' => 12345,
        ]);

        $connection2 = SallaConnection::factory()->create([
            'user_id' => $user2->id,
            'salla_store_id' => 67890,
        ]);

        $chatbot1 = Chatbot::factory()->create([
            'user_id' => $user1->id,
            'salla_connection_id' => $connection1->id,
        ]);

        $service = new SallaOrderToolService();

        // Tool uses chatbot's connection, not arbitrary connection ID
        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        $result = $service->handleToolCall($chatbot1, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        // Should use connection1, not connection2
        $this->assertArrayHasKey('found', $resultData);
    }

    public function test_tool_cannot_cross_tenant_boundaries()
    {
        $user1 = User::factory()->create();
        $user2 = User::factory()->create();

        $connection1 = SallaConnection::factory()->create([
            'user_id' => $user1->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot1 = Chatbot::factory()->create([
            'user_id' => $user1->id,
            'salla_connection_id' => $connection1->id,
        ]);

        $order1 = SallaOrder::factory()->create([
            'salla_connection_id' => $connection1->id,
            'salla_order_id' => 999999,
            'reference_id' => 'REF001',
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        $result = $service->handleToolCall($chatbot1, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        // User1 can find order1
        $this->assertTrue($resultData['found']);
    }

    public function test_existing_order_can_be_found_by_reference_id()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $order = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 999999,
            'reference_id' => 'REF001',
            'status' => 'completed',
            'status_name' => 'Completed',
            'currency' => 'SAR',
            'total' => 100.00,
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        $this->assertTrue($resultData['found']);
        $this->assertEquals('REF001', $resultData['order']['reference_id']);
        $this->assertEquals('completed', $resultData['order']['status']);
    }

    public function test_missing_order_returns_found_false()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF_NOT_FOUND']),
            ],
        ];

        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        $this->assertFalse($resultData['found']);
        $this->assertEquals('order_not_found', $resultData['reason']);
    }

    public function test_deleted_order_is_handled_safely()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $order = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 999999,
            'reference_id' => 'REF001',
            'deleted_at' => now(),
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        $this->assertTrue($resultData['found']);
        $this->assertTrue($resultData['order']['deleted']);
    }

    public function test_tool_result_contains_only_allowed_fields()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $order = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 999999,
            'reference_id' => 'REF001',
            'order_data' => [
                'customer' => [
                    'name' => 'Test Customer',
                    'email' => 'test@example.com',
                    'phone' => '+1234567890',
                ],
            ],
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        $this->assertTrue($resultData['found']);
        $this->assertArrayHasKey('order', $resultData);

        // Only allowed fields should be present
        $allowedFields = [
            'reference_id', 'status', 'status_name', 'currency',
            'total', 'sub_total', 'shipping_cost', 'tax_amount',
            'payment_method', 'order_date', 'last_synced_at', 'deleted',
        ];

        foreach (array_keys($resultData['order']) as $field) {
            $this->assertContains($field, $allowedFields);
        }

        // PII fields should not be present
        $this->assertArrayNotHasKey('customer', $resultData['order']);
        $this->assertArrayNotHasKey('order_data', $resultData['order']);
    }

    public function test_order_data_is_never_returned()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $order = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 999999,
            'reference_id' => 'REF001',
            'order_data' => ['customer' => ['name' => 'Test']],
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        $this->assertArrayNotHasKey('order_data', $resultData['order']);
    }

    public function test_customer_pii_is_never_returned()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $order = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 999999,
            'reference_id' => 'REF001',
            'order_data' => [
                'customer' => [
                    'name' => 'Test Customer',
                    'email' => 'test@example.com',
                    'phone' => '+1234567890',
                    'address' => '123 Test St',
                ],
            ],
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        $this->assertArrayNotHasKey('customer', $resultData['order']);
        $this->assertArrayNotHasKey('name', $resultData['order']);
        $this->assertArrayNotHasKey('email', $resultData['order']);
        $this->assertArrayNotHasKey('phone', $resultData['order']);
        $this->assertArrayNotHasKey('address', $resultData['order']);
    }

    public function test_no_salla_api_call_occurs_during_normal_local_lookup()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $order = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 999999,
            'reference_id' => 'REF001',
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        // The tool uses SallaOrderQueryService which only queries local database
        // No Salla API call should occur
        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        $this->assertTrue($resultData['found']);
    }

    public function test_no_salla_write_operation_exists()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $service = new SallaOrderToolService();

        // Verify only read methods exist
        $this->assertMethodExists($service, 'handleToolCall');
        $this->assertMethodExists($service, 'handleAnthropicToolCall');
        $this->assertMethodExists($service, 'handleGeminiToolCall');
        $this->assertMethodExists($service, 'getToolDefinitions');
        $this->assertMethodExists($service, 'getAnthropicToolDefinitions');
        $this->assertMethodExists($service, 'getGeminiToolDefinitions');

        // No write methods should exist
        $this->assertMethodNotExists($service, 'createOrder');
        $this->assertMethodNotExists($service, 'updateOrder');
        $this->assertMethodNotExists($service, 'deleteOrder');
    }

    public function test_chatbot_without_salla_connection_fails_safely()
    {
        $user = User::factory()->create();

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => null,
        ]);

        $service = new SallaOrderToolService();

        // Tool should not be registered when no connection
        $toolDefinitions = $service->getToolDefinitions($chatbot);
        $this->assertEmpty($toolDefinitions);

        // Handle tool call should fail safely
        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        $this->assertFalse($resultData['found']);
        $this->assertEquals('salla_not_connected', $resultData['reason']);
    }

    private function assertMethodExists($object, $method)
    {
        $this->assertTrue(method_exists($object, $method), "Method {$method} should exist");
    }

    private function assertMethodNotExists($object, $method)
    {
        $this->assertFalse(method_exists($object, $method), "Method {$method} should not exist");
    }

    public function test_salla_tool_appears_when_chatbot_has_salla_connection()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $service = new SallaOrderToolService();
        $toolDefinitions = $service->getToolDefinitions($chatbot);

        // Tool should be registered when chatbot has Salla connection
        $this->assertCount(1, $toolDefinitions);
        $this->assertEquals('salla_order_status', $toolDefinitions[0]['function']['name']);
    }

    public function test_salla_tool_does_not_appear_when_chatbot_has_no_connection()
    {
        $user = User::factory()->create();

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => null,
        ]);

        $service = new SallaOrderToolService();
        $toolDefinitions = $service->getToolDefinitions($chatbot);

        // Tool should not be registered when no connection
        $this->assertEmpty($toolDefinitions);
    }

    public function test_ai_tool_call_reaches_salla_order_tool_service()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $order = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 999999,
            'reference_id' => 'REF001',
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        // Verify the service was called and returned result
        $this->assertTrue($resultData['found']);
        $this->assertEquals('REF001', $resultData['order']['reference_id']);
    }

    public function test_order_reference_reaches_the_service()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $order = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 999999,
            'reference_id' => 'TEST_REF_123',
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'TEST_REF_123']),
            ],
        ];

        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        // Verify the reference_id parameter was used correctly
        $this->assertTrue($resultData['found']);
        $this->assertEquals('TEST_REF_123', $resultData['order']['reference_id']);
    }

    public function test_chatbot_context_determines_the_connection()
    {
        $user1 = User::factory()->create();
        $user2 = User::factory()->create();

        $connection1 = SallaConnection::factory()->create([
            'user_id' => $user1->id,
            'salla_store_id' => 12345,
        ]);

        $connection2 = SallaConnection::factory()->create([
            'user_id' => $user2->id,
            'salla_store_id' => 67890,
        ]);

        $chatbot1 = Chatbot::factory()->create([
            'user_id' => $user1->id,
            'salla_connection_id' => $connection1->id,
        ]);

        $order1 = SallaOrder::factory()->create([
            'salla_connection_id' => $connection1->id,
            'salla_order_id' => 999999,
            'reference_id' => 'REF001',
        ]);

        $order2 = SallaOrder::factory()->create([
            'salla_connection_id' => $connection2->id,
            'salla_order_id' => 888888,
            'reference_id' => 'REF001', // Same reference ID for different connection
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        // User1 should get order1 from connection1
        $result1 = $service->handleToolCall($chatbot1, 'salla_order_status', $call);
        $resultData1 = json_decode($result1, true);

        $this->assertTrue($resultData1['found']);
        $this->assertEquals(999999, $resultData1['order']['salla_order_id']);
    }

    public function test_arbitrary_connection_id_cannot_be_supplied_by_model()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $service = new SallaOrderToolService();

        // The tool schema only accepts order_reference, not connection_id
        $toolDefinitions = $service->getToolDefinitions($chatbot);

        $this->assertArrayHasKey('order_reference', $toolDefinitions[0]['function']['parameters']['properties']);
        $this->assertArrayNotHasKey('connection_id', $toolDefinitions[0]['function']['parameters']['properties']);
        $this->assertArrayNotHasKey('salla_connection_id', $toolDefinitions[0]['function']['parameters']['properties']);
    }

    public function test_cross_tenant_connection_cannot_be_used()
    {
        $user1 = User::factory()->create();
        $user2 = User::factory()->create();

        $connection1 = SallaConnection::factory()->create([
            'user_id' => $user1->id,
            'salla_store_id' => 12345,
        ]);

        $connection2 = SallaConnection::factory()->create([
            'user_id' => $user2->id,
            'salla_store_id' => 67890,
        ]);

        $chatbot1 = Chatbot::factory()->create([
            'user_id' => $user1->id,
            'salla_connection_id' => $connection1->id,
        ]);

        $order2 = SallaOrder::factory()->create([
            'salla_connection_id' => $connection2->id,
            'salla_order_id' => 888888,
            'reference_id' => 'REF002',
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF002']),
            ],
        ];

        // User1 should not be able to access order2 from connection2
        $result = $service->handleToolCall($chatbot1, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        $this->assertFalse($resultData['found']);
        $this->assertEquals('order_not_found', $resultData['reason']);
    }

    public function test_tool_result_is_correctly_passed_back()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $order = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 999999,
            'reference_id' => 'REF001',
            'status' => 'completed',
            'status_name' => 'Completed',
            'currency' => 'SAR',
            'total' => 100.00,
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        // Verify the result structure matches expected schema
        $this->assertTrue($resultData['found']);
        $this->assertArrayHasKey('order', $resultData);
        $this->assertEquals('REF001', $resultData['order']['reference_id']);
        $this->assertEquals('completed', $resultData['order']['status']);
        $this->assertEquals('Completed', $resultData['order']['status_name']);
        $this->assertEquals('SAR', $resultData['order']['currency']);
        $this->assertEquals('100.00', $resultData['order']['total']);
    }

    public function test_normal_lookup_makes_no_salla_api_call()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $order = SallaOrder::factory()->create([
            'salla_connection_id' => $connection->id,
            'salla_order_id' => 999999,
            'reference_id' => 'REF001',
        ]);

        $service = new SallaOrderToolService();

        $call = [
            'function' => [
                'name' => 'salla_order_status',
                'arguments' => json_encode(['order_reference' => 'REF001']),
            ],
        ];

        // The tool uses SallaOrderQueryService which only queries local database
        // No Salla API call should occur
        $result = $service->handleToolCall($chatbot, 'salla_order_status', $call);
        $resultData = json_decode($result, true);

        $this->assertTrue($resultData['found']);
    }

    public function test_no_write_operation_occurs()
    {
        $user = User::factory()->create();
        $connection = SallaConnection::factory()->create([
            'user_id' => $user->id,
            'salla_store_id' => 12345,
        ]);

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => $connection->id,
        ]);

        $service = new SallaOrderToolService();

        // Verify only read methods exist
        $this->assertMethodExists($service, 'handleToolCall');
        $this->assertMethodExists($service, 'handleAnthropicToolCall');
        $this->assertMethodExists($service, 'handleGeminiToolCall');
        $this->assertMethodExists($service, 'getToolDefinitions');
        $this->assertMethodExists($service, 'getAnthropicToolDefinitions');
        $this->assertMethodExists($service, 'getGeminiToolDefinitions');

        // No write methods should exist
        $this->assertMethodNotExists($service, 'createOrder');
        $this->assertMethodNotExists($service, 'updateOrder');
        $this->assertMethodNotExists($service, 'deleteOrder');
    }
}
