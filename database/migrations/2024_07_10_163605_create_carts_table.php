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
        Schema::create('carts', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('product_id')->index('carts_product_id_foreign');
            $table->unsignedBigInteger('order_id')->nullable()->index('carts_order_id_foreign');
            $table->unsignedBigInteger('user_id')->nullable()->index('carts_user_id_foreign');
            $table->double('price', 10, 2);
            $table->enum('status', ['new', 'progress', 'delivered', 'cancel'])->default('new');
            $table->integer('quantity');
            $table->double('amount', 10, 2);
            $table->integer('size');
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
        Schema::dropIfExists('carts');
    }
};
