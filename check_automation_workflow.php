<?php

// Run this file using: php artisan tinker --execute="include 'check_automation_workflow.php';"

echo "=== CHECKING AUTOMATION #2 WORKFLOW GRAPH ===\n\n";

$automation = \App\Extensions\SocialMediaAutomation\System\Models\Automation::find(2);
if (!$automation) {
    echo "ERROR: No automation found with ID 2\n";
    exit;
}

echo "FLAT DB FIELDS:\n";
echo "enable_public_replies: " . ($automation->enable_public_replies ? 'TRUE' : 'FALSE') . "\n";
echo "social_media_platform_id: " . ($automation->social_media_platform_id ?? 'NULL') . "\n";
echo "trigger_target: " . ($automation->trigger_target ?? 'NULL') . "\n";
echo "keyword_mode: " . ($automation->keyword_mode ?? 'NULL') . "\n";
echo "delay_seconds: " . ($automation->delay_seconds ?? 'NULL') . "\n";

echo "\nWORKFLOW GRAPH:\n";
$workflow = $automation->workflow_graph;
if ($workflow) {
    echo "Workflow exists: YES\n";
    echo "Nodes count: " . count($workflow['nodes'] ?? []) . "\n";
    echo "Edges count: " . count($workflow['edges'] ?? []) . "\n";
    
    if (isset($workflow['nodes'])) {
        foreach ($workflow['nodes'] as $node) {
            echo "\nNode ID: " . ($node['id'] ?? 'N/A') . "\n";
            echo "Node Type: " . ($node['type'] ?? 'N/A') . "\n";
            if (isset($node['data'])) {
                echo "Node Data:\n";
                print_r($node['data']);
            }
        }
    }
} else {
    echo "Workflow exists: NO\n";
}

echo "\n=== ACTIONS FROM DB ===\n";
$actions = $automation->actions;
echo "Actions count: " . $actions->count() . "\n";
foreach ($actions as $action) {
    echo "  - ID: {$action->id}, Type: {$action->type}, Content: " . json_encode($action->content) . "\n";
}

echo "\n=== REPLIES FROM DB ===\n";
$replies = $automation->replies;
echo "Replies count: " . $replies->count() . "\n";
foreach ($replies as $reply) {
    echo "  - ID: {$reply->id}, Content: " . substr($reply->content, 0, 50) . "...\n";
}

echo "\n=== DONE ===\n";
