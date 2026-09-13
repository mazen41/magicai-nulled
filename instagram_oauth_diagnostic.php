<?php

/**
 * Instagram OAuth Diagnostic Script
 * Run this from the OneClick-V11 directory to see the exact OAuth URL being generated
 * Usage: php instagram_oauth_diagnostic.php
 */

// Check if we're in the right directory
if (!file_exists('artisan')) {
    die("Error: Run this script from the Laravel project root (where artisan.php exists)\n");
}

// Bootstrap Laravel
require __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Log;

echo "=== INSTAGRAM OAUTH DIAGNOSTIC ===\n\n";

// 1. Check APP_URL
$appUrl = config('app.url');
echo "APP_URL from config: " . $appUrl . "\n";

// 2. Check Instagram config
$instagramConfig = config('social-media.instagram');
echo "\nInstagram config:\n";
echo "  redirect_uri: " . ($instagramConfig['redirect_uri'] ?? 'NOT SET') . "\n";
echo "  base_url: " . ($instagramConfig['base_url'] ?? 'NOT SET') . "\n";
echo "  api_url: " . ($instagramConfig['api_url'] ?? 'NOT SET') . "\n";
echo "  api_version: " . ($instagramConfig['api_version'] ?? 'NOT SET') . "\n";

// 3. Check database settings
echo "\nDatabase settings:\n";
try {
    $instagramAppId = setting('INSTAGRAM_APP_ID');
    $instagramAppSecret = setting('INSTAGRAM_APP_SECRET');
    echo "  INSTAGRAM_APP_ID: " . ($instagramAppId ?: 'NOT SET') . "\n";
    echo "  INSTAGRAM_APP_SECRET: " . ($instagramAppSecret ? '*** SET ***' : 'NOT SET') . "\n";
} catch (Exception $e) {
    echo "  Error reading settings: " . $e->getMessage() . "\n";
}

// 4. Simulate the Instagram helper constructor
echo "\nSimulating Instagram helper:\n";
$redirectUri = secure_url(config('social-media.instagram.redirect_uri'));
echo "  Generated redirect_uri: " . $redirectUri . "\n";

// 5. Construct the OAuth URL
echo "\n=== GENERATED OAUTH URL ===\n";
$oauthUrl = ($instagramConfig['base_url'] ?? 'https://www.facebook.com') . '/' . ($instagramConfig['api_version'] ?? 'v18.0') . '/dialog/oauth';
echo "OAuth endpoint: " . $oauthUrl . "\n";

$params = [
    'response_type' => 'code',
    'client_id' => $instagramAppId ?: 'MISSING',
    'redirect_uri' => $redirectUri,
    'scope' => 'instagram_basic,instagram_content_publish,instagram_manage_comments,instagram_manage_messages,pages_read_engagement,pages_show_list,business_management,instagram_manage_insights',
];

echo "\nOAuth parameters:\n";
foreach ($params as $key => $value) {
    echo "  " . $key . ": " . $value . "\n";
}

echo "\nFull OAuth URL:\n";
$fullUrl = $oauthUrl . '?' . http_build_query($params);
echo $fullUrl . "\n";

echo "\n=== DIAGNOSTIC COMPLETE ===\n";
echo "\nNOTE: This URL should match exactly what Meta expects in your OAuth redirect whitelist.\n";
echo "If the redirect_uri doesn't match what's in Meta Developer Console, that's the issue.\n";
