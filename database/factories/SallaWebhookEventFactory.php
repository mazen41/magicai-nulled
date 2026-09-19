<?php

namespace Database\Factories;

use App\Models\SallaWebhookEvent;
use Illuminate\Database\Eloquent\Factories\Factory;

class SallaWebhookEventFactory extends Factory
{
    protected $model = SallaWebhookEvent::class;

    public function definition(): array
    {
        return [
            'salla_connection_id' => null,
            'event_type' => 'order.created',
            'merchant_id' => $this->faker->randomNumber(6),
            'payload_hash' => hash('sha256', json_encode(['test' => 'payload'])),
            'payload' => json_encode(['test' => 'payload']),
            'signature_verification_status' => 'verified',
            'processing_status' => 'pending',
            'received_at' => now(),
            'processed_at' => null,
        ];
    }
}
