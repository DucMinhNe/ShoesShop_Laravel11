<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('products', function (Blueprint $table) {
            $table->foreign(['cat_id'])->references(['id'])->on('categories')->onDelete('SET NULL');
            $table->foreign(['brand_id'])->references(['id'])->on('brands')->onDelete('SET NULL');
            $table->foreign(['child_cat_id'])->references(['id'])->on('categories')->onDelete('SET NULL');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('products', function (Blueprint $table) {
            $table->dropForeign('products_cat_id_foreign');
            $table->dropForeign('products_brand_id_foreign');
            $table->dropForeign('products_child_cat_id_foreign');
        });
    }
};
