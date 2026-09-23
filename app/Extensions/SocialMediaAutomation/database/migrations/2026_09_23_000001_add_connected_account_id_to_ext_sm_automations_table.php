<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('ext_sm_automations', function (Blueprint $table) {
            // Allow social_media_platform_id to be nullable for ConnectedAccount-based automations
            $table->unsignedBigInteger('connected_account_id')->nullable()->after('social_media_platform_id');

            // Make the legacy FK nullable so automations can use EITHER system
            $table->unsignedBigInteger('social_media_platform_id')->nullable()->change();
        });

        // Add index for efficient lookup
        Schema::table('ext_sm_automations', function (Blueprint $table) {
            $table->index(['connected_account_id', 'status']);
        });
    }

    public function down(): void
    {
        Schema::table('ext_sm_automations', function (Blueprint $table) {
            $table->dropColumn('connected_account_id');
            $table->unsignedBigInteger('social_media_platform_id')->nullable(false)->change();
        });
    }
};
