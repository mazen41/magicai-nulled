<?php

namespace Database\Factories;

use App\Models\SallaWebhookSubscription;
use Illuminate\Database\Eloquent\Factories\Factory;

class SallaWebhookSubscriptionFactory extends Factory
{
    protected $model = SallaWebhookSubscription::class;

    public function definition(): array
    {
        return [
            'salla_connection_id' => null,
            'salla_webhook_id' => $this->faker->randomNumber(9),
            'name' => $this->faker->sentence(3),
            'event' => 'order.created',
            'url' => 'https://example.com/webhooks/salla',
            'version' => 2,
            'type' => 'manual',
            'rule' => null,
            'headers' => null,
            'status' => 'active',
            'synced_at' => now(),
        ];
    }
}
