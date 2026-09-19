<?php

declare(strict_types=1);

namespace App\Services\Salla;

use App\Models\Chatbot\Chatbot;
use App\Models\SallaConnection;
use App\Models\SallaOrder;
use Illuminate\Support\Facades\Log;

class SallaOrderToolService
{
    /**
     * Handle an OpenAI-format tool call.
     * $call['function']['arguments'] is a JSON string.
     */
    public function handleToolCall(Chatbot $chatbot, string $function, array $call): ?string
    {
        $functionArgs = (array) json_decode($call['function']['arguments']);

        return $this->resolveToolCall($chatbot, $function, $functionArgs);
    }

    /**
     * Handle an Anthropic-format tool call.
     * $input is already a parsed array.
     */
    public function handleAnthropicToolCall(Chatbot $chatbot, string $function, array $input): ?string
    {
        return $this->resolveToolCall($chatbot, $function, $input);
    }

    /**
     * Handle a Gemini-format function call.
     * $args is already a parsed array.
     */
    public function handleGeminiToolCall(Chatbot $chatbot, string $function, array $args): ?string
    {
        return $this->resolveToolCall($chatbot, $function, $args);
    }

    /**
     * Core tool call logic shared across all providers.
     *
     * @param  array<string, mixed>  $functionArgs
     */
    private function resolveToolCall(Chatbot $chatbot, string $function, array $functionArgs): ?string
    {
        if ($function === 'salla_order_status') {
            return $this->handleSallaOrderStatus($chatbot, $functionArgs);
        }

        return null;
    }

    /**
     * Handle Salla order status lookup.
     *
     * @param  array<string, mixed>  $functionArgs
     */
    private function handleSallaOrderStatus(Chatbot $chatbot, array $functionArgs): ?string
    {
        // Get Salla connection from chatbot
        $connection = $chatbot->sallaConnection;

        if (! $connection) {
            Log::info('[SallaOrderTool] Chatbot has no Salla connection', [
                'chatbot_id' => $chatbot->id,
            ]);

            return json_encode([
                'found' => false,
                'reason' => 'salla_not_connected',
            ]);
        }

        // Verify connection ownership
        if ($connection->user_id !== $chatbot->user_id) {
            Log::warning('[SallaOrderTool] Connection ownership mismatch', [
                'chatbot_id' => $chatbot->id,
                'chatbot_user_id' => $chatbot->user_id,
                'connection_user_id' => $connection->user_id,
            ]);

            return json_encode([
                'found' => false,
                'reason' => 'integration_unavailable',
            ]);
        }

        $orderReference = $functionArgs['order_reference'] ?? null;

        if (! $orderReference) {
            Log::warning('[SallaOrderTool] Missing order_reference', [
                'chatbot_id' => $chatbot->id,
            ]);

            return json_encode([
                'found' => false,
                'reason' => 'invalid_order_reference',
            ]);
        }

        // Use SallaOrderQueryService to find order by reference ID
        $orderQueryService = new SallaOrderQueryService();
        $order = $orderQueryService->findByReferenceId($connection, $orderReference);

        if (! $order) {
            Log::info('[SallaOrderTool] Order not found', [
                'chatbot_id' => $chatbot->id,
                'connection_id' => $connection->id,
                'order_reference' => $orderReference,
            ]);

            return json_encode([
                'found' => false,
                'reason' => 'order_not_found',
            ]);
        }

        // Return safe order metadata
        return json_encode([
            'found' => true,
            'order' => [
                'reference_id' => $order->reference_id,
                'status' => $order->status,
                'status_name' => $order->status_name,
                'currency' => $order->currency,
                'total' => (string) $order->total,
                'sub_total' => (string) $order->sub_total,
                'shipping_cost' => (string) $order->shipping_cost,
                'tax_amount' => (string) $order->tax_amount,
                'payment_method' => $order->payment_method,
                'order_date' => $order->order_date ? $order->order_date->format('Y-m-d H:i:s') : null,
                'last_synced_at' => $order->last_synced_at ? $order->last_synced_at->format('Y-m-d H:i:s') : null,
                'deleted' => $order->deleted_at !== null,
            ],
        ]);
    }

    /**
     * OpenAI tool definitions format.
     *
     * @return array<int, array<string, mixed>>
     */
    public function getToolDefinitions(Chatbot $chatbot): array
    {
        if (! $chatbot->salla_connection_id) {
            return [];
        }

        return [
            [
                'type'     => 'function',
                'function' => $this->getSallaOrderStatusDeclaration(),
            ],
        ];
    }

    /**
     * Anthropic tool definitions format (uses input_schema instead of parameters).
     *
     * @return array<int, array<string, mixed>>
     */
    public function getAnthropicToolDefinitions(Chatbot $chatbot): array
    {
        if (! $chatbot->salla_connection_id) {
            return [];
        }

        return [
            $this->toAnthropicFormat($this->getSallaOrderStatusDeclaration()),
        ];
    }

    /**
     * Gemini function declarations format (no outer wrapper, uses parameters key).
     * Returns declarations only — to be merged into functionDeclarations[].
     *
     * @return array<int, array<string, mixed>>
     */
    public function getGeminiToolDefinitions(Chatbot $chatbot): array
    {
        if (! $chatbot->salla_connection_id) {
            return [];
        }

        return [
            $this->getSallaOrderStatusDeclaration(),
        ];
    }

    /**
     * Convert an OpenAI-style function declaration to Anthropic format.
     * Renames 'parameters' to 'input_schema'.
     *
     * @param  array<string, mixed>  $declaration
     *
     * @return array<string, mixed>
     */
    private function toAnthropicFormat(array $declaration): array
    {
        return [
            'name'         => $declaration['name'],
            'description'  => $declaration['description'],
            'input_schema' => $declaration['parameters'],
        ];
    }

    /**
     * @return array<string, mixed>
     */
    private function getSallaOrderStatusDeclaration(): array
    {
        return [
            'name'        => 'salla_order_status',
            'description' => 'Retrieves the status and details of a Salla order by its reference ID. This is a read-only tool that should be used when a customer asks about an existing order, its status, or order details. It should not be used to create, change, cancel, or refund orders, or when the customer is merely asking about products.',
            'parameters'  => [
                'type'       => 'object',
                'properties' => [
                    'order_reference' => [
                        'type'        => 'string',
                        'description' => 'The Salla order reference ID (e.g., #1001, REF-12345). This is the order identifier the customer provides.',
                    ],
                ],
                'required' => ['order_reference'],
            ],
        ];
    }
}
