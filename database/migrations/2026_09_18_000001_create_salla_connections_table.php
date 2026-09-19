<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('salla_connections', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();
            $table->string('salla_store_id')->nullable()->index();
            $table->string('store_name')->nullable();
            $table->string('store_domain')->nullable();
            $table->string('merchant_email')->nullable();
            $table->string('merchant_name')->nullable();
            $table->text('access_token')->nullable();
            $table->text('refresh_token')->nullable();
            $table->timestamp('token_expires_at')->nullable();
            $table->enum('connection_status', ['connected', 'disconnected', 'error'])->default('disconnected');
            $table->enum('webhook_status', ['active', 'inactive', 'error'])->default('inactive');
            $table->text('webhook_secret')->nullable();
            $table->json('store_data')->nullable();
            $table->timestamp('last_synced_at')->nullable();
            $table->timestamp('connected_at')->nullable();
            $table->timestamps();
            
            $table->index(['user_id', 'salla_store_id']);
            $table->index('connection_status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('salla_connections');
    }
};
