#!/bin/bash

# Laravel Deployment Script
# Run this after git pull to fix permissions and cache issues

echo "🚀 Starting deployment script..."

# Navigate to project directory
cd /home/nammoai-magicai/htdocs/magicai.nammoai.com

# Fix storage permissions
echo "📁 Fixing storage permissions..."
mkdir -p storage/framework/cache/data
mkdir -p storage/framework/views
mkdir -p storage/framework/sessions
mkdir -p storage/logs
chmod -R 775 storage
chmod -R 775 bootstrap/cache

# Clear all caches
echo "🧹 Clearing caches..."
php artisan cache:clear
php artisan config:clear
php artisan view:clear
php artisan route:clear

# Rebuild cache for better performance
echo "⚡ Optimizing application..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Run migrations if needed
echo "🗄️ Running migrations..."
php artisan migrate --force

# Clear opcode cache if opcache is enabled
echo "🔄 Clearing opcode cache..."
if [ -f /etc/php/*/fpm/php.ini ]; then
    systemctl reload php-fpm
fi

echo "✅ Deployment completed successfully!"
