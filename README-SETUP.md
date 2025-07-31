# Laravel Docker Setup - Single Command Setup

## 🚀 Quick Start

**Just run this ONE command:**

```bash
./.setup
```

That's it! This single script will:

✅ **Fix all permission issues automatically**  
✅ **Set up Docker containers** (PHP 8.3, MySQL 8.0, Redis, Nginx)  
✅ **Install Laravel 11 dependencies**  
✅ **Run database migrations and seeders**  
✅ **Generate application key**  
✅ **Make your app accessible at http://localhost:8000**

## 📋 What You Get

- **Laravel 11.45.1** (latest stable)
- **PHP 8.3** with all required extensions
- **MySQL 8.0** database
- **Redis** for caching
- **Nginx** web server
- **Fully configured** and ready to use

## 🌐 Access Your Application

After setup completes, visit: **http://localhost:8000**

## 🔧 Management Commands

```bash
# View logs
docker-compose logs -f

# Stop everything
docker-compose down

# Start everything
docker-compose up -d

# Run Laravel commands
docker-compose exec app php artisan [command]
```

## 🆘 Need Help?

If setup fails, just run `./.setup` again - it's designed to handle restarts safely.

---

**That's it! No other files, no complicated steps - just run `./.setup` and you're done! 🎉**
