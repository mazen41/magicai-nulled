#!/bin/bash

# Quick Deployment Script - Minimal version for quick pulls
# Run this after git pull to fix common Laravel issues

cd /home/nammoai-magicai/htdocs/magicai.nammoai.com

# Fix storage directory structure
mkdir -p storage/framework/cache/data
mkdir -p storage/framework/views
mkdir -p storage/framework/sessions
mkdir -p storage/logs

# Fix permissions
chmod -R 775 storage
chmod -R 775 bootstrap/cache

# Clear caches
php artisan cache:clear
php artisan config:clear
php artisan view:clear

echo "✅ Quick deployment completed!"
