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
        Schema::table('posts', function (Blueprint $table) {
            $table->foreign(['post_cat_id'])->references(['id'])->on('post_categories')->onDelete('SET NULL');
            $table->foreign(['added_by'])->references(['id'])->on('users')->onDelete('SET NULL');
            $table->foreign(['post_tag_id'])->references(['id'])->on('post_tags')->onDelete('SET NULL');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('posts', function (Blueprint $table) {
            $table->dropForeign('posts_post_cat_id_foreign');
            $table->dropForeign('posts_added_by_foreign');
            $table->dropForeign('posts_post_tag_id_foreign');
        });
    }
};
