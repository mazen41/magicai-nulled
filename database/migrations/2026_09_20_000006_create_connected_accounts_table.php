<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('connected_accounts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();
            $table->string('platform', 50);
            $table->string('account_identifier')->nullable();
            $table->string('account_name')->nullable();
            $table->string('account_username')->nullable();
            $table->string('account_avatar', 500)->nullable();
            $table->text('access_token')->nullable();
            $table->text('refresh_token')->nullable();
            $table->timestamp('token_expires_at')->nullable();
            $table->enum('connection_status', ['connected', 'disconnected', 'error', 'pending'])->default('pending');
            $table->boolean('webhook_registered')->default(false);
            $table->text('webhook_secret')->nullable();
            $table->json('metadata')->nullable();
            $table->timestamp('connected_at')->nullable();
            $table->timestamp('last_synced_at')->nullable();
            $table->timestamps();

            $table->index(['user_id', 'platform']);
            $table->index(['platform', 'account_identifier']);
            $table->index('connection_status');
            $table->unique(['user_id', 'platform', 'account_identifier'], 'unique_user_platform_account');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('connected_accounts');
    }
};
