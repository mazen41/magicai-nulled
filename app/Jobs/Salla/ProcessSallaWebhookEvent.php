<?php

namespace App\Jobs\Salla;

use App\Models\SallaConnection;
use App\Models\SallaWebhookEvent;
use App\Services\Salla\SallaApiClient;
use App\Services\Salla\SallaOAuthService;
use App\Services\Salla\SallaOrderWebhookProcessor;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class ProcessSallaWebhookEvent implements ShouldQueue
{
    use Dispatchable;
    use InteractsWithQueue;
    use Queueable;
    use SerializesModels;

    protected int $webhookEventId;

    /**
     * Create a new job instance.
     */
    public function __construct(int $webhookEventId)
    {
        $this->webhookEventId = $webhookEventId;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        $event = SallaWebhookEvent::find($this->webhookEventId);

        if (! $event) {
            Log::warning('Salla webhook event not found', [
                'webhook_event_id' => $this->webhookEventId,
            ]);

            return;
        }

        // If already completed, skip processing
        if ($event->processing_status === 'completed') {
            Log::info('Salla webhook event already completed', [
                'webhook_event_id' => $this->webhookEventId,
            ]);

            return;
        }

        // If already processing, check if it's stale
        if ($event->processing_status === 'processing') {
            $processingTime = $event->updated_at->diffInMinutes(now());

            // If processing for more than 5 minutes, it's likely stale
            if ($processingTime > 5) {
                Log::warning('Salla webhook event stuck in processing state', [
                    'webhook_event_id' => $this->webhookEventId,
                    'processing_duration_minutes' => $processingTime,
                ]);

                // Reset to pending for retry
                $event->update([
                    'processing_status' => 'pending',
                ]);

                return;
            }

            // If recently started, another worker is handling it
            Log::info('Salla webhook event already being processed', [
                'webhook_event_id' => $this->webhookEventId,
            ]);

            return;
        }

        // Mark as processing
        $event->update([
            'processing_status' => 'processing',
        ]);

        try {
            // Route to appropriate processor based on event type
            $this->routeEvent($event);

            // Mark as completed
            $event->update([
                'processing_status' => 'completed',
                'processed_at' => now(),
            ]);

            Log::info('Salla webhook event processed successfully', [
                'webhook_event_id' => $this->webhookEventId,
                'event_type' => $event->event_type,
                'merchant_id' => $event->merchant_id,
            ]);

        } catch (\Exception $e) {
            // Mark as failed
            $event->update([
                'processing_status' => 'failed',
            ]);

            Log::error('Salla webhook event processing failed', [
                'webhook_event_id' => $this->webhookEventId,
                'event_type' => $event->event_type,
                'merchant_id' => $event->merchant_id,
                'error' => $e->getMessage(),
            ]);

            // Re-throw to allow Laravel's retry mechanism
            throw $e;
        }
    }

    /**
     * Route event to appropriate processor
     */
    private function routeEvent(SallaWebhookEvent $event): void
    {
        $eventType = $event->event_type;

        // Explicitly supported order events (must match SallaOrderWebhookProcessor::SUPPORTED_EVENTS)
        $supportedOrderEvents = [
            'order.created',
            'order.updated',
            'order.cancelled',
            'order.refunded',
            'order.deleted',
        ];

        if (in_array($eventType, $supportedOrderEvents)) {
            $this->processOrderEvent($event);
            return;
        }

        // Future: Add other event processors here
        // Product events, customer events, etc.

        // Unsupported event - log but don't fail
        Log::info('Salla webhook event type not currently implemented', [
            'webhook_event_id' => $event->id,
            'event_type' => $eventType,
        ]);
    }

    /**
     * Process order webhook event
     */
    private function processOrderEvent(SallaWebhookEvent $event): void
    {
        // Load connection
        $connection = SallaConnection::find($event->salla_connection_id);

        if (! $connection) {
            Log::warning('Salla connection not found for webhook event', [
                'webhook_event_id' => $event->id,
                'salla_connection_id' => $event->salla_connection_id,
            ]);

            return;
        }

        // Create services
        $apiClient = new SallaApiClient($connection, app(SallaOAuthService::class));
        $orderService = new \App\Services\Salla\SallaOrderService($connection, $apiClient);
        $processor = new SallaOrderWebhookProcessor($connection, $orderService);

        // Process the event
        $processor->process($event);
    }
}
