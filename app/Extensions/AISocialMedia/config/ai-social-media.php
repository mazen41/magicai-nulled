<?php

return [
    'instagram' => [
        'app_id'        => '',
        'app_secret'    => '',
        // Instagram Login OAuth dialog base
        'base_url'      => 'https://api.instagram.com',
        // Instagram Graph API for all account/post/media calls
        'api_url'       => 'https://graph.instagram.com',
        'redirect_uri'  => '/oauth/callback/instagram',
        'api_version'   => 'v21.0',
        // Short-lived token exchange
        'token_url'     => 'https://api.instagram.com/oauth/access_token',
        // Long-lived token exchange
        'longtoken_url' => 'https://graph.instagram.com/access_token',
        // Instagram Business Login scopes
        'scopes'        => [
            'instagram_business_basic',
            'instagram_business_content_publish',
            'instagram_business_manage_comments',
            'instagram_business_manage_messages',
        ],
        'requirements' => [
            'text' => [
                'limit' => 1000,
            ],
            'images' => [
                'limit'  => 10,
                'width'  => 640,
                'height' => 640,
                'size'   => 1024, // in kb
            ],
            'videos' => [
                'limit'  => 10,
                'width'  => 640,
                'height' => 640,
                'size'   => 1024, // in kb
            ],
        ],
    ],
];
