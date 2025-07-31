<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\RolePermission;

class RolePermissionsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        RolePermission::create([
            'role_id' => '1',
            'permission_id' => '1'
        ]);

        RolePermission::create([
            'role_id' => '1',
            'permission_id' => '2'
        ]);

        RolePermission::create([
            'role_id' => '1',
            'permission_id' => '3'
        ]);

        RolePermission::create([
            'role_id' => '1',
            'permission_id' => '4'
        ]);
    }
}
