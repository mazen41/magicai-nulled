#!/bin/bash

# Add this to your ~/.bashrc or ~/.bash_profile for easy deployment
# Usage: alias deploy='cd /home/nammoai-magicai/htdocs/magicai.nammoai.com && bash post-pull.sh'

cd /home/nammoai-magicai/htdocs/magicai.nammoai.com

echo "🔄 Pulling latest changes..."
git pull

echo "📁 Fixing storage permissions..."
mkdir -p storage/framework/cache/data
mkdir -p storage/framework/views
mkdir -p storage/framework/sessions
mkdir -p storage/logs
chmod -R 775 storage
chmod -R 775 bootstrap/cache

echo "🧹 Clearing caches..."
php artisan cache:clear
php artisan config:clear
php artisan view:clear
php artisan route:clear

echo "✅ Deployment completed!"
