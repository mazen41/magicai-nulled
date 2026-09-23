<?php

// Run this file using: php artisan tinker --execute="include 'check_login.php';"

echo "=== CHECKING LOGIN SETTINGS ===\n\n";

$settings = \App\Models\Setting::getCache();

echo "login_without_confirmation: " . ($settings->login_without_confirmation ?? 'NULL') . "\n";
echo "login_with_otp: " . ($settings->login_with_otp ?? 'NULL') . "\n";
echo "recaptcha_login: " . ($settings->recaptcha_login ?? 'NULL') . "\n";
echo "recaptcha_sitekey: " . ($settings->recaptcha_sitekey ?? 'NULL') . "\n";
echo "recaptcha_secretkey: " . ($settings->recaptcha_secretkey ?? 'NULL') . "\n";
echo "dash_theme: " . ($settings->dash_theme ?? 'NULL') . "\n";
echo "hard_redirect_to_user_dashboard: " . ($settings->hard_redirect_to_user_dashboard ?? 'NULL') . "\n";

echo "\n=== CHECKING USER ACCOUNT ===\n";
$user = \App\Models\User::where('email', 'admin@admin.com')->first();
if ($user) {
    echo "User found: YES\n";
    echo "Email: " . $user->email . "\n";
    echo "Email confirmed: " . ($user->email_confirmed ? 'YES' : 'NO') . "\n";
    echo "Is admin: " . ($user->isAdmin() ? 'YES' : 'NO') . "\n";
    echo "Status: " . $user->status . "\n";
    echo "Password hash check: " . (\Illuminate\Support\Facades\Hash::check('12345678', $user->password) ? 'CORRECT' : 'INCORRECT') . "\n";
    
    // Check 2FA - use the correct method
    try {
        $twoFaEnabled = \Google2FA::isActivated();
        echo "2FA enabled (system): " . ($twoFaEnabled ? 'YES' : 'NO') . "\n";
    } catch (\Exception $e) {
        echo "2FA check error: " . $e->getMessage() . "\n";
    }
} else {
    echo "User not found with email admin@admin.com\n";
}

echo "\n=== DONE ===\n";
