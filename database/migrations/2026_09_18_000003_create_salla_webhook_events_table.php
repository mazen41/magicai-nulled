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
        Schema::create('salla_webhook_events', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('salla_connection_id')->nullable();
            $table->string('event_type')->index();
            $table->string('merchant_id')->nullable()->index();
            $table->string('payload_hash', 64)->nullable()->unique();
            $table->text('payload')->nullable();
            $table->string('signature_verification_status')->default('pending')->index();
            $table->string('processing_status')->default('pending')->index();
            $table->timestamp('received_at')->index();
            $table->timestamp('processed_at')->nullable();
            $table->timestamps();

            $table->foreign('salla_connection_id')
                ->references('id')
                ->on('salla_connections')
                ->nullOnDelete();

            $table->index(['salla_connection_id', 'event_type']);
            $table->index(['merchant_id', 'event_type', 'received_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('salla_webhook_events');
    }
};
