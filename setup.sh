#!/bin/bash

# Laravel Docker Setup Script
# Based on the working /var/www/Projects/laravel-app/setup.sh

echo "🐳 Setting up Laravel Docker Environment..."

# Copy environment file
echo "📝 Setting up environment configuration..."
cp .env.docker .env

# Stop any existing containers
echo "🛑 Stopping existing containers..."
docker compose down --volumes --remove-orphans 2>/dev/null || true

# Build and start containers
echo "📦 Building Docker containers..."
docker compose up -d --build

# Wait for MySQL to be ready
echo "⏳ Waiting for MySQL to be ready..."
sleep 30

# Test MySQL connection
echo "🔍 Testing MySQL connection..."
for i in {1..10}; do
    if docker compose exec -T mysql mysqladmin ping -h"localhost" --silent; then
        echo "✅ MySQL is ready!"
        break
    else
        echo "⏳ Waiting for MySQL... ($i/10)"
        sleep 5
    fi
done

# Install Composer dependencies
echo "📝 Installing Composer dependencies..."
docker compose exec -T php composer install --no-dev --optimize-autoloader --no-interaction

# Generate application key
echo "🔑 Generating application key..."
docker compose exec -T php php artisan key:generate --force

# Run database migrations
echo "🗄️ Running database migrations..."
docker compose exec -T php php artisan migrate --force

# Install Node dependencies and build assets
echo "🎨 Installing Node dependencies and building assets..."
if docker compose exec -T php npm install; then
    docker compose exec -T php npm run build
else
    echo "⚠️ Node.js setup failed - continuing without frontend assets"
fi

# Set permissions
echo "🔒 Setting proper permissions..."
docker compose exec -T php chown -R www:www /var/www/html/storage /var/www/html/bootstrap/cache 2>/dev/null || true
docker compose exec -T php chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache 2>/dev/null || true

# Clear and cache config
echo "🧹 Clearing and caching configuration..."
docker compose exec -T php php artisan config:cache || true
docker compose exec -T php php artisan route:cache || true
docker compose exec -T php php artisan view:cache || true

# Create sessions table if using database sessions
echo "🗄️ Setting up sessions..."
docker compose exec -T php php artisan session:table --force 2>/dev/null || true
docker compose exec -T php php artisan migrate --force

echo ""
echo "✅ Setup complete!"
echo "🌐 Your Laravel application is running at: http://localhost:8000"
echo "📧 MailHog is available at: http://localhost:8025"
echo "🗄️ MySQL is available at: localhost:3306"
echo ""
echo "Useful commands:"
echo "  docker compose logs -f         # View logs"
echo "  docker compose down            # Stop containers"
echo "  docker compose exec php bash   # Access PHP container"
echo "  docker compose exec php php artisan [command]  # Run artisan commands"
echo ""

# Test application
echo "🔍 Testing application..."
sleep 5
if curl -f -s http://localhost:8000 > /dev/null; then
    echo "✅ Application is responding successfully!"
else
    echo "⚠️ Application may not be ready yet. Check logs: docker compose logs"
fi

echo ""
echo "🎉 Laravel Docker setup completed successfully!"
