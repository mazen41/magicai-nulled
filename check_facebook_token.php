<?php

// Run this file using: php artisan tinker --execute="include 'check_facebook_token.php';"

echo "=== CHECKING FACEBOOK TOKENS ===\n\n";

// Check legacy SocialMediaPlatform
$platform = \App\Extensions\SocialMedia\System\Models\SocialMediaPlatform::find(1);
if ($platform) {
    echo "LEGACY SOCIAL MEDIA PLATFORM (ID: {$platform->id}):\n";
    echo "Platform: {$platform->platform}\n";
    echo "Credentials type: " . gettype($platform->credentials) . "\n";
    $creds = $platform->credentials;
    if (is_array($creds)) {
        echo "Has access_token: " . (isset($creds['access_token']) ? 'YES' : 'NO') . "\n";
        if (isset($creds['access_token'])) {
            echo "Token length: " . strlen($creds['access_token']) . "\n";
            echo "Token preview: " . substr($creds['access_token'], 0, 50) . "...\n";
        }
        echo "Platform ID: " . ($creds['platform_id'] ?? 'N/A') . "\n";
        echo "Updated at: " . $platform->updated_at . "\n";
    }
    echo "\n";
} else {
    echo "NO LEGACY PLATFORM FOUND WITH ID 1\n\n";
}

// Check ConnectedAccount
$connected = \App\Models\ConnectedAccount::where('platform', 'messenger')
    ->where('account_identifier', '1183394208200084')
    ->first();

if ($connected) {
    echo "CONNECTED ACCOUNT (ID: {$connected->id}):\n";
    echo "Platform: {$connected->platform}\n";
    echo "Account Identifier: {$connected->account_identifier}\n";
    echo "Connection Status: {$connected->connection_status}\n";
    echo "Has access_token: " . ($connected->access_token ? 'YES' : 'NO') . "\n";
    if ($connected->access_token) {
        echo "Token length: " . strlen($connected->access_token) . "\n";
        echo "Token preview: " . substr($connected->access_token, 0, 50) . "...\n";
    }
    echo "Updated at: " . $connected->updated_at . "\n";
    echo "\n";
} else {
    echo "NO CONNECTED ACCOUNT FOUND\n\n";
}

// Check Automation
$automation = \App\Extensions\SocialMediaAutomation\System\Models\Automation::find(2);
if ($automation) {
    echo "AUTOMATION (ID: {$automation->id}):\n";
    echo "Name: {$automation->name}\n";
    echo "Social Media Platform ID: " . ($automation->social_media_platform_id ?? 'NULL') . "\n";
    echo "Connected Account ID: " . ($automation->connected_account_id ?? 'NULL') . "\n";
    echo "Status: {$automation->status}\n";

    // Load platform and check token
    $automation->load('platform');
    if ($automation->platform) {
        echo "\nLOADED PLATFORM CREDENTIALS:\n";
        $creds = $automation->platform->credentials;
        echo "Has access_token: " . (isset($creds['access_token']) ? 'YES' : 'NO') . "\n";
        if (isset($creds['access_token'])) {
            echo "Token length: " . strlen($creds['access_token']) . "\n";
            echo "Token preview: " . substr($creds['access_token'], 0, 50) . "...\n";
        }
    }
    echo "\n";
} else {
    echo "NO AUTOMATION FOUND WITH ID 2\n\n";
}

// Test token debug
if ($platform) {
    $creds = $platform->credentials;
    if (is_array($creds) && isset($creds['access_token'])) {
        $token = $creds['access_token'];
        echo "=== TESTING TOKEN PERMISSIONS ===\n";
        $response = \Illuminate\Support\Facades\Http::get("https://graph.facebook.com/v18.0/debug_token", [
            'input_token' => $token,
            'access_token' => setting('INSTAGRAM_APP_ID') . '|' . setting('INSTAGRAM_APP_SECRET'),
        ]);

        echo "Debug Response Status: " . $response->status() . "\n";
        $data = $response->json();
        if (isset($data['data']['scopes'])) {
            echo "Scopes: " . implode(', ', $data['data']['scopes']) . "\n";
        }
        if (isset($data['data']['type'])) {
            echo "Token Type: " . $data['data']['type'] . "\n";
        }
        if (isset($data['data']['granular_scopes'])) {
            echo "Granular Scopes:\n";
            foreach ($data['data']['granular_scopes'] as $scope) {
                echo "  - " . $scope['scope'] . "\n";
            }
        }
    }
}

echo "\n=== DONE ===\n";
