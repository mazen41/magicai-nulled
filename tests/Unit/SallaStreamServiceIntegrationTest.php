<?php

namespace Tests\Unit;

use App\Models\Chatbot\Chatbot;
use App\Models\SallaConnection;
use App\Models\SallaOrder;
use App\Models\User;
use App\Models\UserOpenaiChat;
use App\Services\Salla\SallaOrderToolService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class SallaStreamServiceIntegrationTest extends TestCase
{
    use RefreshDatabase;

    public function test_salla_tool_registration_in_stream_service()
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

        $chat = UserOpenaiChat::factory()->create([
            'user_id' => $user->id,
            'chatbot_id' => $chatbot->id,
        ]);

        $service = new SallaOrderToolService();
        $toolDefinitions = $service->getToolDefinitions($chatbot);

        // Verify tool is registered when chatbot has connection
        $this->assertCount(1, $toolDefinitions);
        $this->assertEquals('salla_order_status', $toolDefinitions[0]['function']['name']);
    }

    public function test_salla_tool_not_registered_without_connection()
    {
        $user = User::factory()->create();

        $chatbot = Chatbot::factory()->create([
            'user_id' => $user->id,
            'salla_connection_id' => null,
        ]);

        $service = new SallaOrderToolService();
        $toolDefinitions = $service->getToolDefinitions($chatbot);

        // Verify tool is not registered when no connection
        $this->assertEmpty($toolDefinitions);
    }

    public function test_stream_service_can_resolve_chatbot_from_chat()
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

        $chat = UserOpenaiChat::factory()->create([
            'user_id' => $user->id,
            'chatbot_id' => $chatbot->id,
        ]);

        // Simulate chatbot resolution logic
        $resolvedChatbot = Chatbot::find($chat->chatbot_id);

        $this->assertNotNull($resolvedChatbot);
        $this->assertEquals($chatbot->id, $resolvedChatbot->id);
        $this->assertEquals($connection->id, $resolvedChatbot->salla_connection_id);
    }

    public function test_anthropic_tool_definition_format()
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
        $anthropicTools = $service->getAnthropicToolDefinitions($chatbot);

        // Verify Anthropic format uses input_schema instead of parameters
        $this->assertCount(1, $anthropicTools);
        $this->assertEquals('salla_order_status', $anthropicTools[0]['name']);
        $this->assertArrayHasKey('input_schema', $anthropicTools[0]);
        $this->assertArrayNotHasKey('parameters', $anthropicTools[0]);
    }

    public function test_gemini_tool_definition_format()
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
        $geminiTools = $service->getGeminiToolDefinitions($chatbot);

        // Verify Gemini format uses parameters (no outer wrapper)
        $this->assertCount(1, $geminiTools);
        $this->assertEquals('salla_order_status', $geminiTools[0]['name']);
        $this->assertArrayHasKey('parameters', $geminiTools[0]);
    }

    public function test_anthropic_tool_call_execution()
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

        $input = ['order_reference' => 'REF001'];
        $result = $service->handleAnthropicToolCall($chatbot, 'salla_order_status', $input);
        $resultData = json_decode($result, true);

        $this->assertTrue($resultData['found']);
        $this->assertEquals('REF001', $resultData['order']['reference_id']);
    }

    public function test_gemini_tool_call_execution()
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

        $args = ['order_reference' => 'REF001'];
        $result = $service->handleGeminiToolCall($chatbot, 'salla_order_status', $args);
        $resultData = json_decode($result, true);

        $this->assertTrue($resultData['found']);
        $this->assertEquals('REF001', $resultData['order']['reference_id']);
    }

    public function test_tool_execution_with_deleted_order()
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

    public function test_tool_execution_without_order()
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

    public function test_tool_result_does_not_contain_order_data()
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

    public function test_tool_result_does_not_contain_pii()
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
}
