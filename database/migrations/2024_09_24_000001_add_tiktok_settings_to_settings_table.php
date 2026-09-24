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
        Schema::table('settings', function (Blueprint $table) {
            $table->string('tiktok_app_id')->nullable()->after('instagram_verify_token');
            $table->string('tiktok_app_key')->nullable()->after('tiktok_app_id');
            $table->string('tiktok_app_secret')->nullable()->after('tiktok_app_key');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('settings', function (Blueprint $table) {
            $table->dropColumn(['tiktok_app_id', 'tiktok_app_key', 'tiktok_app_secret']);
        });
    }
};
