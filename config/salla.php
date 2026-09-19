<?php

return [
    'client_id' => env('SALLA_CLIENT_ID'),
    'client_secret' => env('SALLA_CLIENT_SECRET'),
    'webhook_secret' => env('SALLA_WEBHOOK_SECRET'),
    'redirect_uri' => env('SALLA_REDIRECT_URI'),
    'webhook_url' => env('SALLA_WEBHOOK_URL'),
    
    'oauth' => [
        'auth_url' => 'https://accounts.salla.sa/oauth2/auth',
        'token_url' => 'https://accounts.salla.sa/oauth2/token',
        'user_info_url' => 'https://accounts.salla.sa/oauth2/user/info',
    ],
    
    'api' => [
        'base_url' => 'https://api.salla.dev/admin/v2',
        'timeout' => 30,
        'retry_attempts' => 3,
    ],
    
    'scopes' => [
        'products.read',
        'orders.read',
        'offline_access',
        'webhooks.read_write',
    ],

    'webhook_events' => [
        'order.created',
        'order.updated',
        'order.cancelled',
        'order.refunded',
        'order.deleted',
        'product.created',
        'product.updated',
        'product.deleted',
    ],
];
