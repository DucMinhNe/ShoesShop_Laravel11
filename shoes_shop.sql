/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 100428 (10.4.28-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : shoes_shop

 Target Server Type    : MySQL
 Target Server Version : 100428 (10.4.28-MariaDB)
 File Encoding         : 65001

 Date: 18/07/2024 02:26:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for banners
-- ----------------------------
DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `banners_slug_unique`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banners
-- ----------------------------
INSERT INTO `banners` VALUES (1, '.', '', 'banner_img/_1721237738.jpg', NULL, 'active', '2024-07-17 17:35:38', '2024-07-17 17:35:38');
INSERT INTO `banners` VALUES (2, '.', '-2407173603-987', 'banner_img/_1721237763.jpg', NULL, 'active', '2024-07-17 17:36:03', '2024-07-17 17:36:03');
INSERT INTO `banners` VALUES (3, '.', '-2407173620-417', 'banner_img/_1721237780.jpg', NULL, 'active', '2024-07-17 17:36:20', '2024-07-17 17:36:20');

-- ----------------------------
-- Table structure for brands
-- ----------------------------
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `brands_slug_unique`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO `brands` VALUES (1, 'Vans', 'vans', 'active', '2024-07-17 17:37:05', '2024-07-17 17:37:05');
INSERT INTO `brands` VALUES (2, 'Converse', 'converse', 'active', '2024-07-17 17:37:17', '2024-07-17 17:37:17');
INSERT INTO `brands` VALUES (3, 'Nike', 'nike', 'active', '2024-07-17 17:37:23', '2024-07-17 17:37:23');
INSERT INTO `brands` VALUES (4, 'Adidas', 'adidas', 'active', '2024-07-17 17:37:40', '2024-07-17 17:37:40');

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NULL DEFAULT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `price` double NOT NULL,
  `status` enum('new','progress','delivered','cancel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `quantity` int NOT NULL,
  `amount` double NOT NULL,
  `size` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `carts_product_id_foreign`(`product_id` ASC) USING BTREE,
  INDEX `carts_order_id_foreign`(`order_id` ASC) USING BTREE,
  INDEX `carts_user_id_foreign`(`user_id` ASC) USING BTREE,
  CONSTRAINT `carts_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of carts
-- ----------------------------

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_parent` tinyint(1) NOT NULL DEFAULT 1,
  `parent_id` bigint UNSIGNED NULL DEFAULT NULL,
  `added_by` bigint UNSIGNED NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `categories_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `categories_parent_id_foreign`(`parent_id` ASC) USING BTREE,
  INDEX `categories_added_by_foreign`(`added_by` ASC) USING BTREE,
  CONSTRAINT `categories_added_by_foreign` FOREIGN KEY (`added_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Giày sneakers', 'giay-sneakers', NULL, NULL, 1, NULL, NULL, 'active', '2024-07-17 17:37:56', '2024-07-17 17:37:56');
INSERT INTO `categories` VALUES (2, 'Giày sandal', 'giay-sandal', NULL, NULL, 1, NULL, NULL, 'active', '2024-07-17 17:38:13', '2024-07-17 18:39:21');
INSERT INTO `categories` VALUES (3, 'Giày thể thao', 'giay-the-thao', NULL, NULL, 1, NULL, NULL, 'active', '2024-07-17 17:38:25', '2024-07-17 17:38:25');

-- ----------------------------
-- Table structure for coupons
-- ----------------------------
DROP TABLE IF EXISTS `coupons`;
CREATE TABLE `coupons`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('fixed','percent') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `value` decimal(20, 2) NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `coupons_code_unique`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupons
-- ----------------------------

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of messages
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2024_07_10_163605_create_banners_table', 1);
INSERT INTO `migrations` VALUES (2, '2024_07_10_163605_create_brands_table', 1);
INSERT INTO `migrations` VALUES (3, '2024_07_10_163605_create_carts_table', 1);
INSERT INTO `migrations` VALUES (4, '2024_07_10_163605_create_categories_table', 1);
INSERT INTO `migrations` VALUES (5, '2024_07_10_163605_create_coupons_table', 1);
INSERT INTO `migrations` VALUES (6, '2024_07_10_163605_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (7, '2024_07_10_163605_create_messages_table', 1);
INSERT INTO `migrations` VALUES (8, '2024_07_10_163605_create_notifications_table', 1);
INSERT INTO `migrations` VALUES (9, '2024_07_10_163605_create_orders_table', 1);
INSERT INTO `migrations` VALUES (10, '2024_07_10_163605_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (11, '2024_07_10_163605_create_post_categories_table', 1);
INSERT INTO `migrations` VALUES (12, '2024_07_10_163605_create_post_comments_table', 1);
INSERT INTO `migrations` VALUES (13, '2024_07_10_163605_create_post_tags_table', 1);
INSERT INTO `migrations` VALUES (14, '2024_07_10_163605_create_posts_table', 1);
INSERT INTO `migrations` VALUES (15, '2024_07_10_163605_create_product_reviews_table', 1);
INSERT INTO `migrations` VALUES (16, '2024_07_10_163605_create_products_table', 1);
INSERT INTO `migrations` VALUES (17, '2024_07_10_163605_create_settings_table', 1);
INSERT INTO `migrations` VALUES (18, '2024_07_10_163605_create_shippings_table', 1);
INSERT INTO `migrations` VALUES (19, '2024_07_10_163605_create_users_table', 1);
INSERT INTO `migrations` VALUES (20, '2024_07_10_163605_create_wishlists_table', 1);
INSERT INTO `migrations` VALUES (21, '2024_07_10_163608_add_foreign_keys_to_carts_table', 1);
INSERT INTO `migrations` VALUES (22, '2024_07_10_163608_add_foreign_keys_to_categories_table', 1);
INSERT INTO `migrations` VALUES (23, '2024_07_10_163608_add_foreign_keys_to_orders_table', 1);
INSERT INTO `migrations` VALUES (24, '2024_07_10_163608_add_foreign_keys_to_post_comments_table', 1);
INSERT INTO `migrations` VALUES (25, '2024_07_10_163608_add_foreign_keys_to_posts_table', 1);
INSERT INTO `migrations` VALUES (26, '2024_07_10_163608_add_foreign_keys_to_product_reviews_table', 1);
INSERT INTO `migrations` VALUES (27, '2024_07_10_163608_add_foreign_keys_to_products_table', 1);
INSERT INTO `migrations` VALUES (28, '2024_07_10_163608_add_foreign_keys_to_wishlists_table', 1);

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications`  (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notifications_notifiable_type_notifiable_id_index`(`notifiable_type` ASC, `notifiable_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notifications
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `sub_total` double NOT NULL,
  `shipping_id` bigint UNSIGNED NULL DEFAULT NULL,
  `coupon` double NULL DEFAULT NULL,
  `total_amount` double NOT NULL,
  `quantity` int NOT NULL,
  `payment_method` enum('cod','vnpay','momo') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cod',
  `payment_status` enum('paid','unpaid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `status` enum('new','process','delivered','cancel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `orders_order_number_unique`(`order_number` ASC) USING BTREE,
  INDEX `orders_user_id_foreign`(`user_id` ASC) USING BTREE,
  INDEX `orders_shipping_id_foreign`(`shipping_id` ASC) USING BTREE,
  CONSTRAINT `orders_shipping_id_foreign` FOREIGN KEY (`shipping_id`) REFERENCES `shippings` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for post_categories
-- ----------------------------
DROP TABLE IF EXISTS `post_categories`;
CREATE TABLE `post_categories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `post_categories_slug_unique`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post_categories
-- ----------------------------

-- ----------------------------
-- Table structure for post_comments
-- ----------------------------
DROP TABLE IF EXISTS `post_comments`;
CREATE TABLE `post_comments`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `post_id` bigint UNSIGNED NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `replied_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `parent_id` bigint UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post_comments_user_id_foreign`(`user_id` ASC) USING BTREE,
  INDEX `post_comments_post_id_foreign`(`post_id` ASC) USING BTREE,
  CONSTRAINT `post_comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `post_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post_comments
-- ----------------------------

-- ----------------------------
-- Table structure for post_tags
-- ----------------------------
DROP TABLE IF EXISTS `post_tags`;
CREATE TABLE `post_tags`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `post_tags_slug_unique`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post_tags
-- ----------------------------

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `quote` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tags` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `post_cat_id` bigint UNSIGNED NULL DEFAULT NULL,
  `post_tag_id` bigint UNSIGNED NULL DEFAULT NULL,
  `added_by` bigint UNSIGNED NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `posts_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `posts_post_cat_id_foreign`(`post_cat_id` ASC) USING BTREE,
  INDEX `posts_post_tag_id_foreign`(`post_tag_id` ASC) USING BTREE,
  INDEX `posts_added_by_foreign`(`added_by` ASC) USING BTREE,
  CONSTRAINT `posts_added_by_foreign` FOREIGN KEY (`added_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `posts_post_cat_id_foreign` FOREIGN KEY (`post_cat_id`) REFERENCES `post_categories` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `posts_post_tag_id_foreign` FOREIGN KEY (`post_tag_id`) REFERENCES `post_tags` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of posts
-- ----------------------------

-- ----------------------------
-- Table structure for product_reviews
-- ----------------------------
DROP TABLE IF EXISTS `product_reviews`;
CREATE TABLE `product_reviews`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `product_id` bigint UNSIGNED NULL DEFAULT NULL,
  `rate` tinyint NOT NULL DEFAULT 0,
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_reviews_user_id_foreign`(`user_id` ASC) USING BTREE,
  INDEX `product_reviews_product_id_foreign`(`product_id` ASC) USING BTREE,
  CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `product_reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_reviews
-- ----------------------------

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock` int NOT NULL DEFAULT 1,
  `size` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'M',
  `condition` enum('default','new','hot') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `price` double NOT NULL,
  `discount` double NOT NULL,
  `is_featured` tinyint(1) NOT NULL,
  `cat_id` bigint UNSIGNED NULL DEFAULT NULL,
  `child_cat_id` bigint UNSIGNED NULL DEFAULT NULL,
  `brand_id` bigint UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `products_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `products_cat_id_foreign`(`cat_id` ASC) USING BTREE,
  INDEX `products_child_cat_id_foreign`(`child_cat_id` ASC) USING BTREE,
  INDEX `products_brand_id_foreign`(`brand_id` ASC) USING BTREE,
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `products_cat_id_foreign` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `products_child_cat_id_foreign` FOREIGN KEY (`child_cat_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'Vans Old Skool', 'vans-old-skool', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Thiết kế Vans Old Skool Classic trắng đen kinh điển, sử dụng kết hợp chất liệu vải Canvas mềm, nhẹ ở thân giày và chất liệu da lộn ở mũi giày và đế giày mang đến cho bạn sự thoải mái khi di chuyển. Đế cao su chuyên dùng cho bộ môn trượt ván đảm bảo độ bền chắc và có độ bám tốt. Khả năng kết hợp nhiều outfit mà không sợ bị lệch tông.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NHÃN HIỆU</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Vans</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">TÊN</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Vans Old Skool Black Canvas Ox</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">VN000D3HY28</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Old Skool</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam / Trung Quốc</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Vans 01 tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Vans<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1721238313.jpg', 34, '39,41,42', 'default', 'active', 1850000, 15, 1, 1, NULL, 1, '2024-07-17 17:45:13', '2024-07-17 17:46:34');
INSERT INTO `products` VALUES (2, 'Vans Old Skool Navy Canvas Ox', 'vans-old-skool-navy-canvas-ox', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Giữ nguyên thiết kế của Vans Old Skool với sự kết hợp của chất liệu vải Canvas màu xanh ở phần thân giày và da lộn đen ở phần mũi giày, đế giày. Sự phối hợp giữa 3 tone màu xanh - đen - trắng chắc chắn sẽ mang đến cho bạn sự độc đáo mới lạ hơn khi mix&amp;match với các outfit.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NHÃN HIỆU</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Vans</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">TÊN</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Vans Old Skool Navy Canvas Ox</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">VN000D3HNVY</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Old Skool</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam / Trung Quốc</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Vans 01 tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Vans<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1721238527.jpg', 38, '39,41,42', 'new', 'active', 1700000, 12, 1, 1, NULL, 1, '2024-07-17 17:48:47', '2024-07-17 17:48:47');
INSERT INTO `products` VALUES (3, 'Vans SK8 Black Canvas/Suede Hi', 'vans-sk8-black-canvassuede-hi', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Vans SK8-Hi với thiết kế cổ cao qua mắt cá chân và giữ lại chi tiết lượn sóng đặc trưng 2 bên thân giày. Sử dụng kết hợp cả 2 chất liệu Canvas và da lộn mềm mại giúp form giày ôm chân hơn. Sản phẩm dành cho phong cách đường phố cực kỳ cá tính, thời thượng.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NHÃN HIỆU</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Vans</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">TÊN</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Vans SK8 Black Canvas/Suede Hi</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">VN000D5IB8C</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">SK8</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam / Trung Quốc / Cambodia</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Vans 01 tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Vans<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1721238648.jpg', 36, '39,41,42', 'new', 'active', 1650000, 10, 1, 1, NULL, 1, '2024-07-17 17:50:48', '2024-07-17 17:50:48');
INSERT INTO `products` VALUES (4, 'Vans UA Old Skool Color Theory', 'vans-ua-old-skool-color-theory', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Vans Color Theory với hình bóng kinh điển quen thuộc được làm mới trên phối màu Color Theory Rose Smoke, đem đến một làn gió mới cho trang phục street style của bạn. BST mang đến nguồn năng lượng tươi mới, đánh bại mọi rào cản về giới tính và khám phá vẻ đẹp của từng cá nhân. Upper bền bỉ với chất vải canvas huyền thoại, đệm lót êm ái và form dáng “Off The Wall” kinh điển làm tăng sức hấp dẫn của đôi giày vượt thời gian.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NHÃN HIỆU</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Vans</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">TÊN</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Vans UA Old Skool Color Theory</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">VN0005UFBQL</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Old Skool</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">BỘ SƯU TẬP</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Color Theory</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Vans 01 tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Vans<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1721238802.jpg', 35, '38,40,41', 'hot', 'active', 1400000, 6, 1, 1, NULL, 1, '2024-07-17 17:53:22', '2024-07-17 17:53:22');
INSERT INTO `products` VALUES (5, 'Vans UA Old Skool Checkerboard Suede', 'vans-ua-old-skool-checkerboard-suede', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Vans Old Skool Checkerboard Suede được tạo điểm nhấn với họa tiết Checkerboard full Upper với tông màu xám - vàng chủ đạo. Đường lượn sóng bên hông thân giày bằng chất liệu da và tông vàng nổi bật làm tăng thêm sự thu hút cho thiết kế.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NHÃN HIỆU</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Vans</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">TÊN</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Vans UA Old Skool Checkerboard Suede</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">VN0A4U3BXF9</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Old Skool</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">BỘ SƯU TẬP</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">SUEDE</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Trung Quốc</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Vans 01 tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Vans<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1721238954.jpg', 40, '39,41,42', 'new', 'active', 950000, 6, 1, 1, NULL, 1, '2024-07-17 17:55:54', '2024-07-17 17:55:54');
INSERT INTO `products` VALUES (6, 'Chuck Taylor All Star 1970s Black Canvas Hi', 'chuck-taylor-all-star-1970s-black-canvas-hi', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Thiết kế cổ điển của Converse Chuck 70s với tone đen huyền thoại hiện đang được các bạn trẻ săn đón liên tục. Với sự thay đổi ở phần đế giày được phủ bóng và làm cao hơn, logo nền đen đặc trưng của dòng Chuck 70s mang đến điểm nhấn cho đôi giày. Chất vải Canvas dày, nhẹ ở phiên bản cổ cao giúp người dùng có được sự thoải mái, từng đường kim mũi chỉ được chăm chút tỉ mỉ hơn rất nhiều.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NHÃN HIỆU</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Converse</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">TÊN</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Chuck Taylor All Star 1970s Black Canvas Hi</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">162050C</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Chuck Taylor All Star 1970s</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Converse một tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Converse<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1721239112.jpg', 47, '38,40,42,43', 'new', 'active', 1700000, 4, 1, 1, NULL, 2, '2024-07-17 17:58:32', '2024-07-17 17:58:32');
INSERT INTO `products` VALUES (7, 'Chuck Taylor All Star 1970s White Canvas Hi', 'chuck-taylor-all-star-1970s-white-canvas-hi', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Thiết kế cổ điển của Converse Chuck 1970s với tone trắng chưa bao giờ lỗi mốt, hiện đang được các bạn trẻ săn đón liên tục . Với sự thay đổi ở phần đế giày được phủ bóng và làm cao hơn, đường viền xanh - đỏ chạy quanh đế giày. Logo nền đen đặc trưng của dòng Chuck 70s mang đến điểm nhấn nổi bật. Chất vải Canvas dày, nhẹ ở phiên bản cổ cao giúp người dùng có được sự thoải mái, từng đường kim mũi chỉ được chăm chút tỉ mỉ hơn rất nhiều.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NHÃN HIỆU</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Converse</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">TÊN</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Chuck Taylor All Star 1970s White Canvas Hi</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">162056C</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Chuck Taylor All Star 1970s</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Converse một tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Converse<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1721239232.jpg', 25, '40,41', 'new', 'active', 1700000, 8, 1, 1, NULL, 2, '2024-07-17 18:00:32', '2024-07-17 18:00:32');
INSERT INTO `products` VALUES (8, 'Converse Chuck Taylor All Star Fall Tone', 'converse-chuck-taylor-all-star-fall-tone', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Mang trong mình hình bóng mới mẻ nhưng vẫn giữ nguyên những nét đặc trưng, Converse Chuck Taylor All Star Fall Tone với phối màu lạ mắt sẽ làm bạn xao xuyến. Sở hữu phối màu Dragon Scale lấy cảm hứng từ cây môn vảy rồng với tone màu xanh đại diện cho thiên nhiên mướt mắt. Với những đặc tính vốn có của Converse, item chắc hẳn sẽ đem đến cho bạn những phong cách vô cùng thời trang và thời thượng mang âm hưởng của “giai điệu mùa thu”.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NHÃN HIỆU</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Converse</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">TÊN</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Converse Chuck Taylor All Star Fall Tone</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">A04544C</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Chuck Taylor All Star</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Converse 1 tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Converse<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1721239347.jpg', 54, '38,39,40', 'hot', 'active', 1400000, 9, 1, 1, NULL, 2, '2024-07-17 18:02:27', '2024-07-17 18:02:27');
INSERT INTO `products` VALUES (9, 'Chuck Taylor All Star 1970s Sunflower', 'chuck-taylor-all-star-1970s-sunflower', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Converse Chuck 70s Sunflower Được đánh giá là một trong những đôi giày được giới trẻ yêu thích nhất hiện nay bởi phối màu vàng trendy thời thượng cùng thiết kế cổ cao cá tính. Bên cạnh đó, phần đế giày với chất liệu cao su cao cấp được phủ một lớp bóng tạo điểm nhấn riêng cho dòng 1970s. Đặc biệt chất vải Canvas mềm mại, không chỉ khiến đôi chân của bạn luôn cảm thấy thoải mái mà còn giúp những outfit của bạn trở nên cuốn hút và highfashion hơn đấy nhé.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NHÃN HIỆU</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Converse</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">TÊN</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Chuck Taylor All Star 1970s Sunflower</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">162054C</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Chuck Taylor All Star 1970s</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Converse 1 tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Converse<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1721239470.jpg', 37, '39,41,42', 'default', 'active', 1100000, 3, 1, 1, NULL, 2, '2024-07-17 18:04:30', '2024-07-17 18:04:30');
INSERT INTO `products` VALUES (10, 'Nike Dunk Low Retro White Black', 'nike-dunk-low-retro-white-black', '<p><span style=\"color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\">Từ chương trình Colors College đến loạt sản phẩm CO.JP sôi động của Nike, giày Nike Dunk đã được thể hiện nhiều màu sắc kể từ khi thiết kế ra mắt vào năm 1985. Nhưng với mỗi màu sắc mới, giày Dunk vẫn giữ được đặc điểm color-blocking truyền thống trong một số mức nào đó. Nike đã áp dụng color-blocking truyền thống của mình vào giày Nike Dunk Low Retro White Black.</span><br></p>', '<p style=\"margin-bottom: 1.3em; color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\"><span style=\"font-weight: bolder;\">Mã sản phẩm:</span>&nbsp;DD1391-100</p><p style=\"margin-bottom: 1.3em; color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\"><span style=\"font-weight: bolder;\">Màu sắc:</span>&nbsp;WHITE/BLACK</p><p style=\"margin-bottom: 1.3em; color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\"><span style=\"font-weight: bolder;\">Ngày phát hành:</span>&nbsp;10/03/2021</p>', 'product_img/_1721239842.jpg', 34, '39,40,41', 'default', 'active', 3300000, 4, 1, 1, NULL, 3, '2024-07-17 18:10:42', '2024-07-17 18:10:42');
INSERT INTO `products` VALUES (11, 'Jordan 1 Low Marina Blue', 'jordan-1-low-marina-blue', '<p><span style=\"color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\">Giày dép nữ Jordan 1 Low Marina Blue (W) đến với mặt trên da bò trắng với các lớp phủ da bò Marina Blue và Swoosh. Tại vót, một logo Jordan Wings được khâu tỉ mỉ như trên giày dép Air Jordan 1 gốc. Từ đó, đế Air trắng và Marina Blue thêm đắp tạo thành một vẻ ngoài hoàn hảo.</span><br></p>', '<p style=\"margin-bottom: 1.3em; color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\"><span style=\"font-weight: bolder;\">Mã sản phẩm:</span>&nbsp;DC0774-114</p><p style=\"margin-bottom: 1.3em; color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\"><span style=\"font-weight: bolder;\">Màu sắc:</span>&nbsp;WHITE/DARK MARINA BLUE</p><p style=\"margin-bottom: 1.3em; color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\"><span style=\"font-weight: bolder;\">Ngày phát hành:</span>&nbsp;29/01/2022</p>', 'product_img/_1721239989.jpg', 36, '38,40,41', 'new', 'active', 5500000, 20, 1, 1, NULL, 3, '2024-07-17 18:13:09', '2024-07-17 18:13:09');
INSERT INTO `products` VALUES (12, 'Nike Air Jordan 1 Low Shattered Backboard', 'nike-air-jordan-1-low-shattered-backboard', '<p><span style=\"color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\">Giày Air Jordan 1&nbsp;Low&nbsp;“Shattered Backboard” là một trong những phối màu bán chạy nhất của&nbsp;</span><a href=\"https://authentic-shoes.com/collections/air-jordan\" target=\"_blank\" rel=\"noopener\" style=\"background-color: rgb(255, 255, 255); touch-action: manipulation; color: blue; font-family: Roboto, sans-serif;\">Jordan Brand</a><span style=\"color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\">&nbsp;năm 2020. Kể từ khi trở lại năm 2015, phối màu&nbsp;“Shattered Backboard” trên&nbsp;</span><a href=\"https://authentic-shoes.com/collections/air-jordan-1\" target=\"_blank\" rel=\"noopener\" style=\"background-color: rgb(255, 255, 255); touch-action: manipulation; color: blue; font-family: Roboto, sans-serif;\">Air Jordan 1</a><span style=\"color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\">&nbsp;đã trở thành&nbsp;một trong những lựa chọn được săn đón bậc nhất hiện nay. Hiển nhiên, khi thấy&nbsp;được sức hút khổng lồ của đôi giày, Jordan Brand mới đây đã tung ra một phiên bản cổ thấp dành cho đôi giày, và không ngoài mong đợi, dĩ nhiên là đôi giày vẫn rất đẹp mắt, ấn tượng và thu hút.</span><br></p>', '<ul style=\"list-style-position: initial; list-style-image: initial; padding: 0px; margin-bottom: 1.3em; color: rgb(10, 10, 10); font-family: Roboto, sans-serif;\"><li style=\"margin-bottom: 0.6em;\">Thương hiệu: Nike&nbsp;</li><li style=\"margin-bottom: 0.6em;\">Nhà thiết kế: Peter Moore</li><li style=\"margin-bottom: 0.6em;\">Công nghệ: Air&nbsp;</li><li style=\"margin-bottom: 0.6em;\">Màu sắc: Trắng/ Da Cam/ Đen</li><li style=\"margin-bottom: 0.6em;\">Kiểu dáng: giày bóng rổ</li><li style=\"margin-bottom: 0.6em;\">Fit size: true to size hoặc up 0.5 size</li><li style=\"margin-bottom: 0.6em;\">Mã sản phẩm: 553558 128</li></ul>', 'product_img/_1721240123.jpg', 34, '39,40', 'default', 'active', 12900000, 15, 1, 1, NULL, 3, '2024-07-17 18:15:23', '2024-07-17 18:15:23');
INSERT INTO `products` VALUES (13, 'Adidas Runfalcon 2.0 GV9559', 'adidas-runfalcon-20-gv9559', '<h3 _ngcontent-ng-c1104152164=\"\" class=\"pin-title\" style=\"margin-right: 0px; margin-bottom: var(--gap10); margin-left: 0px; padding: 0px; font-weight: var(--bold600); font-size: 17px; color: rgb(49, 49, 49); font-family: Arial, Helvetica, sans-serif;\">Giày Thể Thao Nam Adidas Runfalcon 2.0 GV9559 Màu Đen Size 39</h3>', '<ul _ngcontent-ng-c1104152164=\"\" class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; list-style: none; color: rgb(49, 49, 49); font-family: Arial, Helvetica, sans-serif; background-color: rgb(243, 244, 246);\"><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">GIỚI TÍNH</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Nam</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">MÀU SẮC</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Đen</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">KIỂU DÁNG</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Giày thể thao</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">CHẤT LIỆU</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Vải cao cấp</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">XUẤT XỨ</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Đức</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">PROMOTION</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Mã giảm giá</span></li></ul>', 'product_img/1721241186.jpg', 5, '40,42', 'new', 'active', 1300000, 5, 1, 3, NULL, 4, '2024-07-17 18:31:24', '2024-07-17 19:00:22');
INSERT INTO `products` VALUES (14, 'Adidas Team Court White', 'adidas-runfalcon-20-gv9559-2407173124-956', '<h3 _ngcontent-ng-c1104152164=\"\" class=\"pin-title\" style=\"margin-right: 0px; margin-bottom: var(--gap10); margin-left: 0px; padding: 0px; font-weight: var(--bold600); font-size: 17px; color: rgb(49, 49, 49); font-family: Arial, Helvetica, sans-serif;\">Giày Thể Thao Nam Adidas Runfalcon 2.0 GV9559 Màu Đen Size 39</h3>', '<ul _ngcontent-ng-c1104152164=\"\" class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; list-style: none; color: rgb(49, 49, 49); font-family: Arial, Helvetica, sans-serif; background-color: rgb(243, 244, 246);\"><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">GIỚI TÍNH</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Nam</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">MÀU SẮC</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Đen</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">KIỂU DÁNG</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Giày thể thao</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">CHẤT LIỆU</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Vải cao cấp</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">XUẤT XỨ</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Đức</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">PROMOTION</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Mã giảm giá</span></li></ul>', 'product_img/1721241173.jpg', 5, '', 'hot', 'active', 1300000, 5, 1, 3, NULL, 4, '2024-07-17 18:31:24', '2024-07-17 19:08:26');
INSERT INTO `products` VALUES (15, 'Adidas Adifom Q Shoes', 'adidas-adifom-q-shoes', '<ul _ngcontent-ng-c1104152164=\"\" class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; list-style: none; color: rgb(49, 49, 49); font-family: Arial, Helvetica, sans-serif; background-color: rgb(243, 244, 246);\"><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">GIỚI TÍNH</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Unisex</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">MÀU SẮC</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Xanh ghi</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">KIỂU DÁNG</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Giày thể thao</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">CHẤT LIỆU</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Vải &amp; Cao Su</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">XUẤT XỨ</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Đức</span></li><li _ngcontent-ng-c1104152164=\"\" class=\"attribute-item\" style=\"margin: 0px 0px 8px; padding: 0px 0px 8px; border-bottom: 1px solid rgb(219, 223, 229); width: 416.638px; display: grid; grid-template-columns: 45% 55%; font-size: var(--fontsize);\"><label _ngcontent-ng-c1104152164=\"\" style=\"margin: 0px; padding: 0px; font-weight: var(--bold600); color: rgb(36, 39, 43); text-transform: uppercase;\">PROMOTION</label><span _ngcontent-ng-c1104152164=\"\" class=\"data\" style=\"margin: 0px; padding: 0px; display: grid;\">Mã giảm giá</span></li></ul>', '<h1 _ngcontent-ng-c1104152164=\"\" class=\"product-name-dk\" style=\"margin-right: 0px; margin-bottom: var(--gap10); margin-left: 0px; padding: 0px; font-size: var(--subHeaderSize); font-weight: var(--bold600); color: var(--black); font-family: Arial, Helvetica, sans-serif;\">Giày Thể Thao Adidas Adifom Q Shoes MDD79 Màu Xanh Ghi Size 39</h1>', 'product_img/_1721241304.jpg', 29, '39,40,41', 'default', 'active', 2800000, 5, 1, 1, NULL, 4, '2024-07-17 18:35:04', '2024-07-17 18:35:04');
INSERT INTO `products` VALUES (16, 'Adidas Sandal Mehana', 'adidas-sandal-mehana', '<p><span style=\"font-family: &quot;Noto Sans&quot;, AdihausDIN, Helvetica, Arial, sans-serif; white-space-collapse: preserve-breaks;\">Với hơi hướng tương lai và kiểu dáng thanh thoát, đôi dép sandal adidas này sẽ đồng hành cùng bạn suốt những ngày nắng nóng. Thân dép thoáng khí và linh hoạt, cho phép bạn vận động thoải mái. Khóa cài tùy chỉnh cho độ ôm hoàn hảo.</span><br></p>', '<ul class=\"gl-list\" style=\"list-style-position: initial; list-style-image: initial; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; font-family: &quot;Noto Sans&quot;, AdihausDIN, Helvetica, Arial, sans-serif; line-height: var(--gl-body-font-set-lineheight-functional-7); width: calc(50% - 15px);\"><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Dáng regular fit</li><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Có khóa cài</li><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Thân dép đúc bằng chất liệu EVA</li><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Lớp lót bằng vải dệt</li></ul><ul class=\"gl-list\" style=\"list-style-position: initial; list-style-image: initial; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; font-family: &quot;Noto Sans&quot;, AdihausDIN, Helvetica, Arial, sans-serif; line-height: var(--gl-body-font-set-lineheight-functional-7); width: calc(50% - 15px);\"><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Lòng dép bằng polyurethane</li><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Màu sản phẩm: Core Black / Cloud White / Core Black</li><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Mã sản phẩm: IF7365</li></ul>', 'product_img/_1721241694.jpg', 33, '40', 'new', 'active', 2000000, 4, 1, 2, NULL, 4, '2024-07-17 18:41:34', '2024-07-17 18:41:34');
INSERT INTO `products` VALUES (17, 'Adidas Sandal Mehana Pink', 'adidas-sandal-mehana-pink', '<p><span style=\"font-family: &quot;Noto Sans&quot;, AdihausDIN, Helvetica, Arial, sans-serif; white-space-collapse: preserve-breaks;\">Với hơi hướng tương lai và kiểu dáng thanh thoát, đôi dép sandal adidas này sẽ đồng hành cùng bạn suốt những ngày nắng nóng. Thân dép thoáng khí và linh hoạt, cho phép bạn vận động thoải mái. Khóa cài tùy chỉnh cho độ ôm hoàn hảo.</span><br></p>', '<ul class=\"gl-list\" style=\"list-style-position: initial; list-style-image: initial; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; font-family: &quot;Noto Sans&quot;, AdihausDIN, Helvetica, Arial, sans-serif; line-height: var(--gl-body-font-set-lineheight-functional-7); width: calc(50% - 15px);\"><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Dáng regular fit</li><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Có khóa cài</li><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Thân dép đúc bằng chất liệu EVA</li><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Lớp lót bằng vải dệt</li></ul><ul class=\"gl-list\" style=\"list-style-position: initial; list-style-image: initial; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding: 0px; font-family: &quot;Noto Sans&quot;, AdihausDIN, Helvetica, Arial, sans-serif; line-height: var(--gl-body-font-set-lineheight-functional-7); width: calc(50% - 15px);\"><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Lòng dép bằng polyurethane</li><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Màu sản phẩm: Preloved Scarlet / Crystal White / Crystal Sand</li><li class=\"gl-vspace-bpall-small\" style=\"margin-top: var(--gl-spacing-0150); padding-left: var(--gl-spacing-0100); margin-left: 18px;\">Mã sản phẩm: IG3537</li></ul>', 'product_img/_1721241802.jpg', 34, '39,41', 'new', 'active', 2600000, 4, 1, 1, NULL, 4, '2024-07-17 18:43:22', '2024-07-17 18:43:22');

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_des` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of settings
-- ----------------------------

-- ----------------------------
-- Table structure for shippings
-- ----------------------------
DROP TABLE IF EXISTS `shippings`;
CREATE TABLE `shippings`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(8, 2) NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shippings
-- ----------------------------
INSERT INTO `shippings` VALUES (1, 'Nơi Khác', 30000.00, 'active', '2024-07-17 17:39:47', '2024-07-17 17:39:47');
INSERT INTO `shippings` VALUES (2, 'Hồ Chí Minh', 0.00, 'active', '2024-07-17 17:39:57', '2024-07-17 17:39:57');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `role` enum('admin','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `provider` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `provider_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Admin', 'admin@gmail.com', NULL, '$2y$10$17s46cckBG3H/o4J74EyY.bo6N77n.T6SCPLQ/Y3F.M758KNGWy.2', NULL, 'admin', NULL, NULL, 'active', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for wishlists
-- ----------------------------
DROP TABLE IF EXISTS `wishlists`;
CREATE TABLE `wishlists`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint UNSIGNED NOT NULL,
  `cart_id` bigint UNSIGNED NULL DEFAULT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `wishlists_product_id_foreign`(`product_id` ASC) USING BTREE,
  INDEX `wishlists_cart_id_foreign`(`cart_id` ASC) USING BTREE,
  INDEX `wishlists_user_id_foreign`(`user_id` ASC) USING BTREE,
  CONSTRAINT `wishlists_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `wishlists_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `wishlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wishlists
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
