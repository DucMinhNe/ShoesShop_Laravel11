<?php

use Illuminate\Database\Seeder;

class SettingTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data=array(
            'description'=>"test",
            'short_des'=>"test",
            'photo'=>"image.jpg",
            'logo'=>'logo.jpg',
            'address'=>"",
            'email'=>"admin@gmail.com",
            'phone'=>"09090909090",
        );
        DB::table('settings')->insert($data);
    }
}
