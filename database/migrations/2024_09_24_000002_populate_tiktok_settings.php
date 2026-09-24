<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        DB::table('settings')->update([
            'tiktok_app_id' => '7688832632410408980',
            'tiktok_app_key' => 'sbawh2mlu605l92uts',
            'tiktok_app_secret' => 'aKGXRnxyBVE17alaH9CgHM1AAXHynV43',
        ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::table('settings')->update([
            'tiktok_app_id' => null,
            'tiktok_app_key' => null,
            'tiktok_app_secret' => null,
        ]);
    }
};
