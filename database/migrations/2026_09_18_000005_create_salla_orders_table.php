<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('salla_orders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('salla_connection_id')->constrained('salla_connections')->cascadeOnDelete();
            $table->bigInteger('salla_order_id')->comment('Salla order ID from API');
            $table->string('reference_id')->nullable()->comment('Salla order reference number');
            $table->string('status')->comment('Order status slug');
            $table->string('status_name')->nullable()->comment('Order status display name');
            $table->string('currency', 3)->default('SAR');
            $table->decimal('total', 10, 2)->nullable()->comment('Order total amount');
            $table->decimal('sub_total', 10, 2)->nullable()->comment('Order subtotal');
            $table->decimal('shipping_cost', 10, 2)->nullable()->comment('Shipping cost');
            $table->decimal('tax_amount', 10, 2)->nullable()->comment('Tax amount');
            $table->string('payment_method')->nullable()->comment('Payment method');
            $table->timestamp('order_date')->nullable()->comment('Order creation date from Salla');
            $table->timestamp('deleted_at')->nullable()->comment('When order was deleted in Salla');
            $table->json('order_data')->nullable()->comment('Structured order snapshot');
            $table->timestamp('last_synced_at')->nullable()->comment('Last sync with Salla API');
            $table->timestamps();

            // Indexes
            $table->index('salla_connection_id');
            $table->index('salla_order_id');
            $table->index('status');
            $table->index('reference_id');
            $table->index('deleted_at');

            // Unique constraint for business idempotency
            $table->unique(['salla_connection_id', 'salla_order_id'], 'unique_order_per_connection');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('salla_orders');
    }
};
