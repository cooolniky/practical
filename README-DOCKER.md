# Laravel Application with Docker

This Laravel application has been upgraded to Laravel 11 and configured to run with Docker.

## Prerequisites

- Docker
- Docker Compose

## Quick Start

1. **Run the setup script:**
   ```bash
   ./.setup
   ```

2. **Access your application:**
   - Application: http://localhost:8000
   - Database: localhost:3306 (user: laravel, password: laravel)
   - Redis: localhost:6379

## Docker Services

- **app**: PHP 8.3-FPM with Laravel application
- **webserver**: Nginx web server
- **db**: MySQL 8.0 database
- **redis**: Redis cache server

## Useful Commands

### Using the helper script:
```bash
./docker-helper.sh start          # Start containers
./docker-helper.sh stop           # Stop containers
./docker-helper.sh restart        # Restart containers
./docker-helper.sh rebuild        # Rebuild containers
./docker-helper.sh logs           # View logs
./docker-helper.sh shell          # Access app container
./docker-helper.sh artisan migrate # Run artisan commands
./docker-helper.sh composer install # Run composer commands
./docker-helper.sh fresh          # Fresh installation
```

### Direct Docker Compose commands:
```bash
docker-compose up -d              # Start containers
docker-compose down               # Stop containers
docker-compose logs -f            # View logs
docker-compose exec app bash      # Access app container
docker-compose exec app php artisan migrate
```

## Development Workflow

1. **Make code changes** in your local files
2. **Run database migrations:**
   ```bash
   ./docker-helper.sh artisan migrate
   ```
3. **Clear caches when needed:**
   ```bash
   ./docker-helper.sh artisan cache:clear
   ./docker-helper.sh artisan config:clear
   ```

## Troubleshooting

### Container Issues
```bash
./docker-helper.sh logs           # Check logs
./docker-helper.sh restart        # Restart services
./docker-helper.sh rebuild        # Rebuild containers
```

### Permission Issues
```bash
docker-compose exec app chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
```

### Database Issues
```bash
./docker-helper.sh artisan migrate:fresh --seed
```

### Reset Everything
```bash
./docker-helper.sh fresh
```

## File Structure

```
├── docker/
│   └── nginx/
│       └── app.conf          # Nginx configuration
├── Dockerfile                # PHP application container
├── docker-compose.yml        # Docker services configuration
├── .setup                    # Setup script
├── docker-helper.sh          # Helper script for common tasks
└── .dockerignore             # Docker ignore file
```

## Environment Variables

Copy `.env.example` to `.env` and modify as needed. Key Docker-related variables:

```env
APP_URL=http://localhost:8000
DB_HOST=db
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
REDIS_HOST=redis
```

## Laravel Version

This application has been upgraded to **Laravel 11** with:
- PHP 8.2+ support
- Updated middleware structure
- Modern exception handling
- Improved configuration management

## Support

If you encounter issues:
1. Check the container logs: `./docker-helper.sh logs`
2. Restart services: `./docker-helper.sh restart`
3. Reset everything: `./docker-helper.sh fresh`
