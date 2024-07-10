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
        Schema::create('orders', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('order_number', 191)->unique();
            $table->unsignedBigInteger('user_id')->nullable()->index('orders_user_id_foreign');
            $table->double('sub_total', 10, 2);
            $table->unsignedBigInteger('shipping_id')->nullable()->index('orders_shipping_id_foreign');
            $table->double('coupon', 10, 2)->nullable();
            $table->double('total_amount', 10, 2);
            $table->integer('quantity');
            $table->enum('payment_method', ['cod', 'paypal'])->default('cod');
            $table->enum('payment_status', ['paid', 'unpaid'])->default('unpaid');
            $table->enum('status', ['new', 'process', 'delivered', 'cancel'])->default('new');
            $table->string('first_name', 191);
            $table->string('last_name', 191);
            $table->string('email', 191);
            $table->string('phone', 191);
            $table->string('country', 191);
            $table->string('post_code', 191)->nullable();
            $table->text('address1');
            $table->text('address2')->nullable();
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
        Schema::dropIfExists('orders');
    }
};
