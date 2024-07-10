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
        Schema::create('wishlists', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('product_id')->index('wishlists_product_id_foreign');
            $table->unsignedBigInteger('cart_id')->nullable()->index('wishlists_cart_id_foreign');
            $table->unsignedBigInteger('user_id')->nullable()->index('wishlists_user_id_foreign');
            $table->double('price', 10, 2);
            $table->integer('quantity');
            $table->double('amount', 10, 2);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('wishlists');
    }
};
