<?php

namespace App\Http\Controllers;

use App\Jobs\Salla\ProcessSallaWebhookEvent;
use App\Models\SallaConnection;
use App\Models\SallaWebhookEvent;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use RuntimeException;

class SallaWebhookController extends Controller
{
    /**
     * Handle incoming Salla webhook
     */
    public function handle(Request $request)
    {
        // Get raw request body for signature verification
        $rawPayload = $request->getContent();

        // Parse payload
        $payload = $request->json()->all();

        // Validate basic structure
        if (! isset($payload['event']) || ! isset($payload['merchant'])) {
            Log::warning('Salla webhook missing required fields', [
                'has_event' => isset($payload['event']),
                'has_merchant' => isset($payload['merchant']),
            ]);

            return response()->json(['error' => 'Invalid payload structure'], 400);
        }

        // Identify Salla connection by merchant ID FIRST
        $merchantId = $payload['merchant'];
        $connection = SallaConnection::where('salla_store_id', $merchantId)->first();

        // Verify signature with per-connection secret
        if (! $this->verifySignature($request, $rawPayload, $connection)) {
            Log::warning('Salla webhook signature verification failed', [
                'merchant_id' => $merchantId,
                'security_strategy' => $request->header('X-Salla-Security-Strategy'),
            ]);

            return response()->json(['error' => 'Invalid signature'], 401);
        }

        // Calculate payload hash for idempotency
        $payloadHash = hash('sha256', $rawPayload);

        // Check for duplicate event using payload hash
        $existingEvent = SallaWebhookEvent::where('payload_hash', $payloadHash)->first();

        if ($existingEvent) {
            Log::info('Salla webhook duplicate event detected', [
                'merchant_id' => $merchantId,
                'event_type' => $payload['event'],
                'webhook_event_id' => $existingEvent->id,
            ]);

            return response()->json(['message' => 'Duplicate event'], 200);
        }

        // Record the webhook event
        $eventCreatedAt = $payload['created_at'] ?? now();
        $eventType = $payload['event'];

        try {
            $webhookEvent = SallaWebhookEvent::create([
                'salla_connection_id' => $connection?->id,
                'event_type' => $eventType,
                'merchant_id' => $merchantId,
                'payload_hash' => $payloadHash,
                'payload' => json_encode($payload),
                'signature_verification_status' => 'verified',
                'processing_status' => 'pending',
                'received_at' => $eventCreatedAt,
            ]);

            Log::info('Salla webhook event recorded', [
                'webhook_event_id' => $webhookEvent->id,
                'merchant_id' => $merchantId,
                'event_type' => $eventType,
                'connection_id' => $connection?->id,
            ]);

            // Dispatch job for async processing
            ProcessSallaWebhookEvent::dispatch($webhookEvent->id);

        } catch (\Illuminate\Database\QueryException $e) {
            // Handle unique constraint violation (race condition)
            if (str_contains($e->getMessage(), 'payload_hash')) {
                Log::info('Salla webhook duplicate detected via unique constraint', [
                    'merchant_id' => $merchantId,
                    'event_type' => $eventType,
                ]);

                return response()->json(['message' => 'Duplicate event'], 200);
            }

            // Re-throw other database errors
            throw $e;
        }

        // Return success response
        return response()->json(['message' => 'Webhook received'], 200);
    }

    /**
     * Verify webhook signature
     */
    private function verifySignature(Request $request, string $rawPayload, ?SallaConnection $connection = null): bool
    {
        $securityStrategy = $request->header('X-Salla-Security-Strategy');

        // Only signature strategy is supported
        if ($securityStrategy !== 'signature') {
            Log::warning('Salla webhook unsupported security strategy', [
                'security_strategy' => $securityStrategy,
            ]);

            return false;
        }

        $signature = $request->header('X-Salla-Signature');

        if (! $signature) {
            Log::warning('Salla webhook missing signature header');

            return false;
        }

        // Prefer per-connection secret, fall back to global config
        $secret = $connection?->webhook_secret ?? config('salla.webhook_secret');

        if (! $secret) {
            Log::error('Salla webhook secret not configured');

            return false;
        }

        // Calculate HMAC-SHA256
        $computedSignature = hash_hmac('sha256', $rawPayload, $secret);

        // Timing-safe comparison
        return hash_equals($signature, $computedSignature);
    }
}
