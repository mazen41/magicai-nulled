#!/bin/bash

# Script to install the git post-merge hook on production server
# Run this once on the production server to enable automatic deployment fixes

cd /home/nammoai-magicai/htdocs/magicai.nammoai.com

# Create the hooks directory if it doesn't exist
mkdir -p .git/hooks

# Create the post-merge hook
cat > .git/hooks/post-merge << 'EOF'
#!/bin/bash

# Git post-merge hook - runs automatically after git pull
# This script fixes Laravel permissions and cache issues automatically

echo "🔄 Post-merge hook: Running deployment fixes..."

# Navigate to project directory
cd "$(git rev-parse --show-toplevel)"

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

echo "✅ Automatic deployment fixes completed!"
EOF

# Make the hook executable
chmod +x .git/hooks/post-merge

echo "✅ Git post-merge hook installed successfully!"
echo "🎉 Now every 'git pull' will automatically fix permissions and clear caches"
