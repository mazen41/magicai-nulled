<?php

// Run this file using: php artisan tinker --execute="include 'check_comment_ownership.php';"

echo "=== CHECKING COMMENT OWNERSHIP ===\n\n";

$platform = \App\Extensions\SocialMedia\System\Models\SocialMediaPlatform::find(1);
$creds = $platform->credentials;
$token = $creds['access_token'];
$pageId = $creds['platform_id'];

$commentId = '122117209269436887_1100018399278408';

echo "Page ID: {$pageId}\n";
echo "Comment ID: {$commentId}\n\n";

// Extract post ID from comment ID
$parts = explode('_', $commentId);
$postId = $parts[0];

echo "Post ID: {$postId}\n\n";

// Check if the post belongs to this page
echo "=== CHECKING POST OWNERSHIP ===\n";
$response = \Illuminate\Support\Facades\Http::withToken($token)
    ->get("https://graph.facebook.com/v18.0/{$postId}");

echo "Post Status: " . $response->status() . "\n";
$postData = $response->json();

if (isset($postData['from'])) {
    echo "Post Owner ID: " . $postData['from']['id'] . "\n";
    echo "Post Owner Name: " . $postData['from']['name'] . "\n";
    echo "Matches Page ID: " . ($postData['from']['id'] == $pageId ? 'YES' : 'NO') . "\n";
}

if (isset($postData['error'])) {
    echo "Error: " . $postData['error']['message'] . "\n";
}

echo "\n=== CHECKING COMMENT DETAILS ===\n";
$response = \Illuminate\Support\Facades\Http::withToken($token)
    ->get("https://graph.facebook.com/v18.0/{$commentId}");

echo "Comment Status: " . $response->status() . "\n";
$commentData = $response->json();

if (isset($commentData['from'])) {
    echo "Comment Author ID: " . $commentData['from']['id'] . "\n";
    echo "Comment Author Name: " . $commentData['from']['name'] . "\n";
}

if (isset($commentData['error'])) {
    echo "Error: " . $commentData['error']['message'] . "\n";
}

echo "\n=== DONE ===\n";
