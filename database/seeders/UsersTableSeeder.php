<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::create([
            'role_id' => '1', 
            'status' => '1',
            'password' => bcrypt('admin123'),
            'name' => 'Nikhil Jain',
            'email' => 'admin@default.com'
        ]);
    }
}
