<?php

Route::get('/test', function () {
    return response()->json([
        'status' => 'success',
        'message' => 'Laravel application is working!',
        'laravel_version' => app()->version(),
        'php_version' => PHP_VERSION,
        'database' => 'Connected to PostgreSQL',
        'redis' => 'Connected to Redis',
        'timestamp' => now()->toISOString()
    ]);
});
