<?php

echo "=== CHECKING SESSION CONFIGURATION ===\n";

$envFile = file_get_contents('.env');
preg_match('/SESSION_DOMAIN=(.*)/', $envFile, $matches);
$sessionDomain = $matches[1] ?? 'not set';
echo "SESSION_DOMAIN: " . ($sessionDomain === '' ? '(empty - current domain)' : $sessionDomain) . "\n";

preg_match('/APP_URL=(.*)/', $envFile, $matches);
$appUrl = $matches[1] ?? 'not set';
echo "APP_URL: " . $appUrl . "\n";

preg_match('/SANCTUM_STATEFUL_DOMAINS=(.*)/', $envFile, $matches);
$sanctumDomains = $matches[1] ?? 'not set';
echo "SANCTUM_STATEFUL_DOMAINS: " . $sanctumDomains . "\n";

echo "\n=== CHECKING CONFIG.PHP ===\n";
$config = include 'config/session.php';
echo "Session driver: " . $config['driver'] . "\n";
echo "Session lifetime: " . $config['lifetime'] . "\n";
echo "Session expire_on_close: " . ($config['expire_on_close'] ? 'true' : 'false') . "\n";
echo "Session secure: " . ($config['secure'] ? 'true' : 'false') . "\n";
echo "Session http_only: " . ($config['http_only'] ? 'true' : 'false') . "\n";
echo "Session same_site: " . $config['same_site'] . "\n";
echo "Session path: " . $config['path'] . "\n";
echo "Session domain: " . ($config['domain'] ?? 'null') . "\n";

echo "\n=== DONE ===\n";
