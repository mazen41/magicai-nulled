<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('ext_chatbots', function (Blueprint $table) {
            $table->foreignId('connected_account_id')
                ->nullable()
                ->after('user_id')
                ->constrained('connected_accounts')
                ->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('ext_chatbots', function (Blueprint $table) {
            $table->dropForeign(['connected_account_id']);
            $table->dropColumn('connected_account_id');
        });
    }
};
