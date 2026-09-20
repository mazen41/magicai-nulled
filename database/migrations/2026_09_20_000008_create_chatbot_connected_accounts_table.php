<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('chatbot_connected_accounts', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('chatbot_id');
            $table->unsignedBigInteger('connected_account_id');
            $table->timestamps();

            $table->foreign('chatbot_id')
                ->references('id')
                ->on('ext_chatbots')
                ->onDelete('cascade');

            $table->foreign('connected_account_id')
                ->references('id')
                ->on('connected_accounts')
                ->onDelete('cascade');

            $table->unique(['chatbot_id', 'connected_account_id'], 'chatbot_connected_accounts_unique');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('chatbot_connected_accounts');
    }
};
