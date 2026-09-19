<?php

namespace Database\Factories;

use App\Models\SallaOrder;
use Illuminate\Database\Eloquent\Factories\Factory;

class SallaOrderFactory extends Factory
{
    protected $model = SallaOrder::class;

    public function definition(): array
    {
        return [
            'salla_connection_id' => null,
            'salla_order_id' => $this->faker->randomNumber(9),
            'reference_id' => $this->faker->randomNumber(8),
            'status' => 'under_review',
            'status_name' => 'Under Review',
            'currency' => 'SAR',
            'total' => $this->faker->randomFloat(2, 10, 1000),
            'sub_total' => $this->faker->randomFloat(2, 10, 900),
            'shipping_cost' => $this->faker->randomFloat(2, 0, 50),
            'tax_amount' => $this->faker->randomFloat(2, 0, 100),
            'payment_method' => 'bank',
            'order_date' => now(),
            'deleted_at' => null,
            'order_data' => null,
            'last_synced_at' => now(),
        ];
    }
}
