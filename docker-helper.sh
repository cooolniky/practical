#!/bin/bash

# Laravel Docker Helper Script
# Quick commands for managing the Laravel Docker environment

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_usage() {
    echo "Laravel Docker Helper"
    echo ""
    echo "Usage: ./docker-helper.sh [command]"
    echo ""
    echo "Commands:"
    echo "  start         Start all containers"
    echo "  stop          Stop all containers"
    echo "  restart       Restart all containers"
    echo "  rebuild       Rebuild and start containers"
    echo "  logs          Show container logs"
    echo "  shell         Access app container shell"
    echo "  artisan       Run artisan commands (e.g., ./docker-helper.sh artisan migrate)"
    echo "  composer      Run composer commands"
    echo "  npm           Run npm commands"
    echo "  fresh         Fresh install (reset everything)"
    echo "  status        Show container status"
    echo "  cleanup       Remove unused Docker resources"
    echo ""
}

case "$1" in
    "start")
        echo -e "${BLUE}Starting containers...${NC}"
        docker-compose up -d
        ;;
    "stop")
        echo -e "${YELLOW}Stopping containers...${NC}"
        docker-compose down
        ;;
    "restart")
        echo -e "${YELLOW}Restarting containers...${NC}"
        docker-compose restart
        ;;
    "rebuild")
        echo -e "${BLUE}Rebuilding and starting containers...${NC}"
        docker-compose down
        docker-compose up -d --build
        ;;
    "logs")
        docker-compose logs -f
        ;;
    "shell")
        echo -e "${BLUE}Accessing app container shell...${NC}"
        docker-compose exec app bash
        ;;
    "artisan")
        shift
        echo -e "${BLUE}Running artisan command: $@${NC}"
        docker-compose exec app php artisan "$@"
        ;;
    "composer")
        shift
        echo -e "${BLUE}Running composer command: $@${NC}"
        docker-compose exec app composer "$@"
        ;;
    "npm")
        shift
        echo -e "${BLUE}Running npm command: $@${NC}"
        docker-compose exec app npm "$@"
        ;;
    "fresh")
        echo -e "${RED}Fresh install - This will reset everything!${NC}"
        read -p "Are you sure? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            docker-compose down --volumes
            docker system prune -f
            docker-compose up -d --build
            sleep 10
            docker-compose exec app composer install
            docker-compose exec app php artisan key:generate
            docker-compose exec app php artisan migrate --force
            docker-compose exec app php artisan db:seed --force
            echo -e "${GREEN}Fresh install completed!${NC}"
        fi
        ;;
    "status")
        docker-compose ps
        ;;
    "cleanup")
        echo -e "${YELLOW}Cleaning up unused Docker resources...${NC}"
        docker system prune -f
        docker volume prune -f
        echo -e "${GREEN}Cleanup completed!${NC}"
        ;;
    *)
        print_usage
        exit 1
        ;;
esac
