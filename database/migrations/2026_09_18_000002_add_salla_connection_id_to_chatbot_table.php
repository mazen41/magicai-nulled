<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('chatbot', function (Blueprint $table) {
            $table->foreignId('salla_connection_id')->nullable()->constrained('salla_connections')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('chatbot', function (Blueprint $table) {
            $table->dropForeign(['salla_connection_id']);
            $table->dropColumn('salla_connection_id');
        });
    }
};
