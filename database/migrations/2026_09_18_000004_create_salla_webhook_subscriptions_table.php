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
        Schema::create('salla_webhook_subscriptions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('salla_connection_id')->nullable()->constrained('salla_connections')->nullOnDelete();
            $table->bigInteger('salla_webhook_id')->nullable()->comment('Salla webhook ID from API');
            $table->string('name');
            $table->string('event');
            $table->string('url');
            $table->integer('version')->default(2);
            $table->string('type')->nullable()->comment('Webhook type (e.g., manual)');
            $table->string('rule')->nullable()->comment('Conditional rule for webhook');
            $table->json('headers')->nullable()->comment('Custom headers for webhook');
            $table->string('status')->default('active')->comment('active, inactive, failed');
            $table->timestamp('synced_at')->nullable()->comment('Last sync with Salla API');
            $table->timestamps();

            // Indexes
            $table->index('salla_connection_id');
            $table->index('event');
            $table->index('status');
            $table->index('salla_webhook_id');

            // Compound index for idempotency check
            // Salla behavior: "New subscriptions with the same URL will update events / restore old webhooks"
            // So unique constraint is on connection + URL, not connection + event + URL
            $table->unique(['salla_connection_id', 'url'], 'unique_subscription_per_connection');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('salla_webhook_subscriptions');
    }
};
