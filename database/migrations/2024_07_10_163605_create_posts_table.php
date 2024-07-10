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
        Schema::create('posts', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('title', 191);
            $table->string('slug', 191)->unique();
            $table->text('summary');
            $table->longText('description')->nullable();
            $table->text('quote')->nullable();
            $table->string('photo', 191)->nullable();
            $table->string('tags', 191)->nullable();
            $table->unsignedBigInteger('post_cat_id')->nullable()->index('posts_post_cat_id_foreign');
            $table->unsignedBigInteger('post_tag_id')->nullable()->index('posts_post_tag_id_foreign');
            $table->unsignedBigInteger('added_by')->nullable()->index('posts_added_by_foreign');
            $table->enum('status', ['active', 'inactive'])->default('active');
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
        Schema::dropIfExists('posts');
    }
};
