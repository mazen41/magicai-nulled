<?php

// Run this file using: php artisan tinker --execute="include 'check_automation_2.php';"

echo "=== CHECKING AUTOMATION #2 ===\n\n";

$automation = \App\Extensions\SocialMediaAutomation\System\Models\Automation::find(2);
if (!$automation) {
    echo "ERROR: No automation found with ID 2\n";
    exit;
}

echo "AUTOMATION DETAILS:\n";
echo "ID: {$automation->id}\n";
echo "Name: {$automation->name}\n";
echo "Status: {$automation->status}\n";
echo "Platform: {$automation->platform}\n";
echo "Connected Account ID: " . ($automation->connected_account_id ?? 'NULL') . "\n";
echo "Social Media Platform ID: " . ($automation->social_media_platform_id ?? 'NULL') . "\n";
echo "Enable Public Replies: " . ($automation->enable_public_replies ? 'TRUE' : 'FALSE') . "\n";
echo "Trigger Target: " . ($automation->trigger_target ?? 'NULL') . "\n";
echo "Trigger Post ID: " . ($automation->trigger_post_id ?? 'NULL') . "\n";
echo "Keyword Mode: " . ($automation->keyword_mode ?? 'NULL') . "\n";
echo "Include Keywords: " . json_encode($automation->include_keywords ?? []) . "\n";
echo "Exclude Keywords: " . json_encode($automation->exclude_keywords ?? []) . "\n";

echo "\n=== REPLIES ===\n";
$replies = $automation->replies;
echo "Replies Count: " . $replies->count() . "\n";
foreach ($replies as $reply) {
    echo "  - ID: {$reply->id}, Content: " . substr($reply->content, 0, 100) . "...\n";
}

echo "\n=== ACTIONS ===\n";
$actions = $automation->actions;
echo "Actions Count: " . $actions->count() . "\n";
foreach ($actions as $action) {
    echo "  - ID: {$action->id}\n";
    echo "    Type: {$action->type}\n";
    echo "    Content: " . json_encode($action->content) . "\n";
    echo "    Order: {$action->order}\n";
    echo "    ---\n";
}

echo "\n=== DONE ===\n";
