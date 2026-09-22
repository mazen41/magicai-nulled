<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('ext_social_media_posts', function (Blueprint $table) {
            $table->unsignedBigInteger('connected_account_id')->nullable()->after('social_media_platform_id');
            $table->index('connected_account_id');
            $table->foreign('connected_account_id')->references('id')->on('connected_accounts')->onDelete('set null');
        });
    }

    public function down(): void
    {
        Schema::table('ext_social_media_posts', function (Blueprint $table) {
            $table->dropForeign(['connected_account_id']);
            $table->dropIndex(['connected_account_id']);
            $table->dropColumn('connected_account_id');
        });
    }
};
