<?php

// Run this file using: php artisan tinker --execute="include 'test_facebook_comment.php';"

echo "=== TESTING FACEBOOK COMMENT REPLY ===\n\n";

$platform = \App\Extensions\SocialMedia\System\Models\SocialMediaPlatform::find(1);
if (!$platform) {
    echo "ERROR: No platform found with ID 1\n";
    exit;
}

$creds = $platform->credentials;
if (!isset($creds['access_token'])) {
    echo "ERROR: No access token in credentials\n";
    exit;
}

$token = $creds['access_token'];
$commentId = '122117209269436887_1100018399278408'; // Replace with a real comment ID

echo "Token preview: " . substr($token, 0, 50) . "...\n";
echo "Comment ID: {$commentId}\n";
echo "Platform ID: " . ($creds['platform_id'] ?? 'N/A') . "\n\n";

echo "=== TESTING COMMENT REPLY ===\n";
$response = \Illuminate\Support\Facades\Http::withToken($token)
    ->post("https://graph.facebook.com/v18.0/{$commentId}/comments", [
        'message' => 'Test reply from diagnostic script'
    ]);

echo "Status: " . $response->status() . "\n";
echo "Response:\n";
print_r($response->json());

echo "\n=== TESTING WITH DEBUG INFO ===\n";
$debugResponse = \Illuminate\Support\Facades\Http::get("https://graph.facebook.com/v18.0/debug_token", [
    'input_token' => $token,
    'access_token' => setting('INSTAGRAM_APP_ID') . '|' . setting('INSTAGRAM_APP_SECRET'),
]);

echo "Token Debug:\n";
print_r($debugResponse->json());

echo "\n=== DONE ===\n";
