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

 Date: 15/07/2024 23:50:29
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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of banners
-- ----------------------------
INSERT INTO `banners` VALUES (1, '.', '', 'banner_img/_1720632165.jpg', '<p>banner1</p>', 'active', '2024-07-10 17:22:45', '2024-07-10 17:22:45');
INSERT INTO `banners` VALUES (2, '.', '-2407102302-394', 'banner_img/_1720632182.jpg', '<p>banner2</p>', 'active', '2024-07-10 17:23:02', '2024-07-10 17:23:02');
INSERT INTO `banners` VALUES (3, '.', '-2407102345-0', 'banner_img/_1720632225.jpg', '<p>banner3</p>', 'active', '2024-07-10 17:23:45', '2024-07-10 17:23:45');

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO `brands` VALUES (1, 'Vans', 'vans', 'active', '2024-07-10 17:06:07', '2024-07-10 17:06:07');
INSERT INTO `brands` VALUES (2, 'Converse', 'converse', 'active', '2024-07-10 17:06:36', '2024-07-10 17:06:36');
INSERT INTO `brands` VALUES (3, 'Nike', 'nike', 'active', '2024-07-10 17:06:44', '2024-07-10 17:06:44');
INSERT INTO `brands` VALUES (4, 'Adidas', 'adidas', 'active', '2024-07-10 17:06:52', '2024-07-10 17:07:50');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `carts_product_id_foreign`(`product_id` ASC) USING BTREE,
  INDEX `carts_order_id_foreign`(`order_id` ASC) USING BTREE,
  INDEX `carts_user_id_foreign`(`user_id` ASC) USING BTREE,
  CONSTRAINT `carts_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Giày Sneaker', 'giay-sneaker', NULL, NULL, 1, NULL, NULL, 'active', '2024-07-10 17:09:15', '2024-07-10 17:15:14');
INSERT INTO `categories` VALUES (2, 'Giày Đá Bóng', 'giay-da-bong', NULL, NULL, 1, NULL, NULL, 'active', '2024-07-10 17:09:27', '2024-07-10 17:17:31');
INSERT INTO `categories` VALUES (3, 'Giày Thể Thao', 'giay-the-thao', NULL, NULL, 1, NULL, NULL, 'active', '2024-07-10 17:18:56', '2024-07-10 17:18:56');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of coupons
-- ----------------------------
INSERT INTO `coupons` VALUES (1, 'caothangckc', 'percent', 8.00, 'active', '2024-07-10 17:19:33', '2024-07-10 17:21:10');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notifications
-- ----------------------------
INSERT INTO `notifications` VALUES ('13bfe906-da76-4258-a3ec-d37310fb6a34', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"https:\\/\\/giayxin.io.vn\\/admin\\/order\\/9\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-12 09:52:34', '2024-07-12 09:52:34');
INSERT INTO `notifications` VALUES ('19c732fe-78b5-4e29-91d8-43c88295eb4b', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/14\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-15 16:10:46', '2024-07-15 16:10:46');
INSERT INTO `notifications` VALUES ('19ec69c0-de1d-4dda-8fd0-d63f3c0f84f8', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/localhost:8000\\/admin\\/order\\/5\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-11 16:49:42', '2024-07-11 16:49:42');
INSERT INTO `notifications` VALUES ('1d45ce4f-ed8b-4f6c-a864-3633a0986fab', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"https:\\/\\/giayxin.io.vn\\/admin\\/order\\/12\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-12 17:17:09', '2024-07-12 17:17:09');
INSERT INTO `notifications` VALUES ('3bf53214-f6af-48ce-9547-fa00854afd8d', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"https:\\/\\/giayxin.io.vn\\/product-detail\\/chuck-taylor-all-star-1970s\",\"fas\":\"fa-star\"}', NULL, '2024-07-13 05:03:10', '2024-07-13 05:03:10');
INSERT INTO `notifications` VALUES ('3ef97760-ec5a-4b34-bd83-4c386df7d1fa', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/13\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-15 16:09:26', '2024-07-15 16:09:26');
INSERT INTO `notifications` VALUES ('40f21707-7b90-4d63-9adc-b6c1c3c29f45', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"https:\\/\\/giayxin.io.vn\\/admin\\/order\\/10\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-12 14:55:58', '2024-07-12 14:55:58');
INSERT INTO `notifications` VALUES ('62a31802-38cb-4b11-8ca9-5d02e893ecee', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/1\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-11 14:42:04', '2024-07-11 14:42:04');
INSERT INTO `notifications` VALUES ('72e52083-30e8-433a-bb43-2cb0f7dd3b2e', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/localhost:8000\\/admin\\/order\\/3\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-11 16:42:38', '2024-07-11 16:42:38');
INSERT INTO `notifications` VALUES ('7672855d-3733-4eb5-8ecd-106ee7ef6288', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/2\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-11 15:07:32', '2024-07-11 15:07:32');
INSERT INTO `notifications` VALUES ('7719c38e-fc4c-44ab-b829-d98f911b7de2', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"https:\\/\\/giayxin.io.vn\\/admin\\/order\\/8\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-12 04:08:13', '2024-07-12 04:08:13');
INSERT INTO `notifications` VALUES ('7fa315ea-c78f-4b73-9613-fafb872e4abf', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/localhost:8000\\/admin\\/order\\/4\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-11 16:47:37', '2024-07-11 16:47:37');
INSERT INTO `notifications` VALUES ('adbe9928-cd88-4f63-8339-c07f408c024a', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"https:\\/\\/giayxin.io.vn\\/product-detail\\/vans-old-skool-classic-blackwhite\",\"fas\":\"fa-star\"}', NULL, '2024-07-13 05:02:47', '2024-07-13 05:02:47');
INSERT INTO `notifications` VALUES ('b3b8a574-5c14-4fe9-8a10-46fd0aabbd8b', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/15\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-15 16:30:58', '2024-07-15 16:30:58');
INSERT INTO `notifications` VALUES ('bb4e9975-9f9d-4f10-b9f5-17f9954188d7', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/localhost:8000\\/admin\\/order\\/7\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-11 17:00:27', '2024-07-11 17:00:27');
INSERT INTO `notifications` VALUES ('d8a00fc8-4226-4b08-a2c3-99af5332d6fd', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"https:\\/\\/giayxin.io.vn\\/admin\\/order\\/11\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-12 14:58:05', '2024-07-12 14:58:05');
INSERT INTO `notifications` VALUES ('fc07a84f-53f8-4a85-8442-1204f6dba587', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/localhost:8000\\/admin\\/order\\/6\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-11 16:53:23', '2024-07-11 16:53:23');

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
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of password_resets
-- ----------------------------
INSERT INTO `password_resets` VALUES ('nhannguyen147147@gmail.com', '$2y$10$.J4jkhxMOrSXc5UkxiC8WukRQG/9v/49GCLNI3HrWcoEMwcEj.PUK', '2024-07-15 16:47:59');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_reviews
-- ----------------------------
INSERT INTO `product_reviews` VALUES (1, 5, 1, 4, 'Sản phẩm tốt', 'active', '2024-07-13 05:02:47', '2024-07-13 05:02:47');
INSERT INTO `product_reviews` VALUES (2, 5, 3, 5, 'Quá tốt', 'active', '2024-07-13 05:03:10', '2024-07-13 05:03:10');

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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'VANS OLD SKOOL CLASSIC BLACK/WHITE', 'vans-old-skool-classic-blackwhite', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Thiết kế Vans Old Skool Classic trắng đen kinh điển, sử dụng kết hợp chất liệu vải Canvas mềm, nhẹ ở thân giày và chất liệu da lộn ở mũi giày và đế giày mang đến cho bạn sự thoải mái khi di chuyển. Đế cao su chuyên dùng cho bộ môn trượt ván đảm bảo độ bền chắc và có độ bám tốt. Khả năng kết hợp nhiều outfit mà không sợ bị lệch tông.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">VN000D3HY28</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Old Skool</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam / Trung Quốc</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Vans 01 tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Vans<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1720632434.jpg', 22, '40,41,43', 'default', 'active', 1500000, 5, 1, 1, NULL, 1, '2024-07-10 17:27:14', '2024-07-15 16:34:37');
INSERT INTO `products` VALUES (2, 'Vans Old Skool Navy', 'vans-old-skool-navy', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Giữ nguyên thiết kế của Vans Old Skool với sự kết hợp của chất liệu vải Canvas màu xanh ở phần thân giày và da lộn đen ở phần mũi giày, đế giày. Sự phối hợp giữa 3 tone màu xanh - đen - trắng chắc chắn sẽ mang đến cho bạn sự độc đáo mới lạ hơn khi mix&amp;match với các outfit.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">VN000D3HNVY</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Old Skool</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam / Trung Quốc</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Vans 01 tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Vans<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1720632712.jpg', 29, '38,39,40,41,42,43', 'new', 'active', 1600000, 5, 1, 1, NULL, 1, '2024-07-10 17:31:52', '2024-07-12 14:55:58');
INSERT INTO `products` VALUES (3, 'Chuck Taylor All Star 1970s', 'chuck-taylor-all-star-1970s', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Ấn tượng với phối màu mới mẻ được lấy cảm hứng từ lông chim mòng két, Converse Chuck 70s Teal Universe nổi bật với tone màu xanh lam ấn tượng. Tone màu đại diện cho sự cởi mở, sáng suốt và sáng tạo mang đến cảm giác nhẹ nhàng Thiết kế cổ cao và cổ thấp cùng kết cấu nội thất tiện nghi sẽ làm bạn hài lòng với item này.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">A05589C</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Chuck Taylor All Star 1970s</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Converse một tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Converse<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1720632858.jpg', 33, '38,39,40', 'new', 'active', 1700000, 3, 1, 1, NULL, 2, '2024-07-10 17:34:18', '2024-07-12 17:17:09');
INSERT INTO `products` VALUES (4, 'Converse Chuck Taylor All Star Construct', 'converse-chuck-taylor-all-star-construct', '<p><span style=\"color: rgb(51, 51, 51); font-family: Roboto, sans-serif; font-size: 15px;\">Phá bỏ những định kiến cũ, Converse Chuck Taylor All Star Construct bứt phá hoàn hảo với diện mạo “độc bản”. Thiết kế thông minh từ phần thân giày đến phần đế đều thể hiện sự tinh tế và cầu kỳ trong từng chi tiết. Bắt mắt với phần đế cao ấn tượng và đế ngoài kim cương truyền thống được phủ bằng kết cấu xương cá để có độ bám tốt hơn. Item với vẻ ngoài táo bạo cùng những nội thất cao cấp, hứa hẹn sẽ đồng hành cùng bạn trên mọi hành trình bền vững.</span><br></p>', '<ul class=\"attribute-list\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; padding: 0px; color: rgb(51, 51, 51); font-family: Roboto, sans-serif;\"><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">MÃ SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">A05094C</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">DÒNG SẢN PHẨM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Chuck Taylor All Star</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">BỘ SƯU TẬP</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Chuck Taylor All Star</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">NƠI SẢN XUẤT</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Việt Nam</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">CHẾ ĐỘ BẢO HÀNH</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Bảo hành chính hãng Converse một tháng<br>Hỗ trợ bảo hành 3 tháng từ Nhà phân phối Drake VN</span></div></li><li style=\"font-size: 13px; border-bottom: 1px solid rgb(219, 223, 229); margin-bottom: 10px; padding-bottom: 8px; float: left; width: 547.455px;\"><label class=\"label\" style=\"display: inline; max-width: 100%; margin: 0px; font-weight: 600; padding: 0px; line-height: 18px; color: rgb(36, 39, 43); vertical-align: baseline; border-radius: 0.25em; text-transform: uppercase; float: left; width: 257.295px;\">PHỤ KIỆN THEO KÈM</label><div class=\"attribute-data\" style=\"float: left; line-height: 18px; color: rgb(0, 0, 0); width: 290.148px; font-family: Tahoma, sans-serif;\"><span class=\"data\">Túi Converse<br>Phiếu bảo hành chính hãng<br>Hộp giày</span></div></li></ul>', 'product_img/_1720632990.jpg', 20, '38,39,40,41', 'new', 'active', 2200000, 4, 1, 1, NULL, 2, '2024-07-10 17:36:30', '2024-07-10 17:36:30');
INSERT INTO `products` VALUES (5, 'ADIDAS X CRAZYFAST ELITE TF ENERGY CITRUS - SOLAR RED', 'adidas-x-crazyfast-elite-tf-energy-citrus-solar-red', '<p style=\"padding: 0px; font-family: &quot;Roboto Condensed&quot;, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; line-height: 21px; max-width: 100%; color: rgb(85, 85, 85); font-size: 14px; text-align: justify;\">Hòa mình trong không khí sôi động của mùa giải sắp tới,&nbsp;<span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">Adidas&nbsp;</span>đã chính thức cho ra mắt bộ sưu tập mới “<span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">Energy Citrus”</span>&nbsp;sử dụng những gam màu rực rỡ và nổi bật. Bộ sưu tập này sẽ bao gồm ba mẫu thiết kế là&nbsp;<span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">Copa Pure 2, X Crazyfast và Predator 24.</span></p><p style=\"padding: 0px; font-family: &quot;Roboto Condensed&quot;, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; line-height: 21px; max-width: 100%; color: rgb(85, 85, 85); font-size: 14px; text-align: justify;\">Adidas X Crazyfast - đôi giày đánh dấu dòng&nbsp;<a href=\"https://neymarsport.com/collections/adidas-x\" style=\"padding: 0px; margin: 0px; outline: none; max-width: 100%; color: rgb(241, 198, 22) !important;\">adidas X</a>&nbsp;cuối cùng được ra mắt trước khi bị thay thế bởi Adidas F50.&nbsp;<a href=\"https://neymarsport.com/\" style=\"padding: 0px; margin: 0px; outline: none; max-width: 100%; color: rgb(241, 198, 22) !important;\">Giày đá banh</a>&nbsp;X Crazyfast nổi bật nhờ những gam màu rực rỡ Solar Red, White và Solar Yellow, đây là một sự đảo ngược bất ngờ so với phiên bản \"Solar Energy\" đầu tiên được thương hiệu Adidas phát hành vào đầu năm 2024.&nbsp;</p>', '<p style=\"padding: 0px; font-family: &quot;Roboto Condensed&quot;, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; line-height: 21px; max-width: 100%; color: rgb(85, 85, 85); font-size: 14px;\"><span style=\"padding: 0px; margin: 0px; max-width: 100%; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">Cầu thủ nổi tiếng đại diện:</span>&nbsp;Mohamed Salah, Son Hueng Min, Lionel Messi...</span></p><p style=\"padding: 0px; font-family: &quot;Roboto Condensed&quot;, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; line-height: 21px; max-width: 100%; color: rgb(85, 85, 85); font-size: 14px;\"><span style=\"padding: 0px; margin: 0px; max-width: 100%; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">Bộ sưu tập:&nbsp;</span></span>Energy Citrus</p><p style=\"padding: 0px; font-family: &quot;Roboto Condensed&quot;, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; line-height: 21px; max-width: 100%; color: rgb(85, 85, 85); font-size: 14px;\"><span style=\"padding: 0px; margin: 0px; max-width: 100%; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">Năm sản xuất:&nbsp;</span>2024.</span></p><p style=\"padding: 0px; font-family: &quot;Roboto Condensed&quot;, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; line-height: 21px; max-width: 100%; color: rgb(85, 85, 85); font-size: 14px;\"><span style=\"padding: 0px; margin: 0px; max-width: 100%; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">Chất liệu:</span>&nbsp;<span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">AEROPACITY SPEEDSKIN</span>&nbsp;- một lớp lưới đơn có khả năng thoáng khí, tạo cảm giác thoải mái cho đôi chân của người chơi hơn bao giờ hết.</span></p><p style=\"padding: 0px; font-family: &quot;Roboto Condensed&quot;, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; line-height: 21px; max-width: 100%; color: rgb(85, 85, 85); font-size: 14px;\"><span style=\"padding: 0px; margin: 0px; max-width: 100%; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">Công nghệ:</span>&nbsp;Stability Wing Carbon mới, cổ thun Primknit ôm chân và đệm Lightstrike êm ái.</span></p><p style=\"padding: 0px; font-family: &quot;Roboto Condensed&quot;, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; line-height: 21px; max-width: 100%; color: rgb(85, 85, 85); font-size: 14px;\"><span style=\"padding: 0px; margin: 0px; max-width: 100%; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">Trọng lượng:&nbsp;</span>241 gram/chiếc (Size 41).</span></p><p style=\"padding: 0px; font-family: &quot;Roboto Condensed&quot;, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; line-height: 21px; max-width: 100%; color: rgb(85, 85, 85); font-size: 14px;\"><span style=\"padding: 0px; margin: 0px; max-width: 100%; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">Phong cách:&nbsp;</span>Tấn công, tốc độ.</span></p><p style=\"padding: 0px; font-family: &quot;Roboto Condensed&quot;, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; line-height: 21px; max-width: 100%; color: rgb(85, 85, 85); font-size: 14px;\"><span style=\"padding: 0px; margin: 0px; max-width: 100%; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px; font-weight: 700; max-width: 100%;\">Vị trí:&nbsp;</span>Tiền vệ cánh, tiền đạo.</span></p>', 'product_img/_1720633222.jpg', 26, '38,39,40', 'hot', 'active', 2600000, 7, 1, 2, NULL, 4, '2024-07-10 17:40:22', '2024-07-15 16:10:46');
INSERT INTO `products` VALUES (6, 'Nike Flex Experience Rn 12', 'nike-flex-experience-rn-12', '<p><span style=\"color: rgb(27, 27, 27); font-family: NunitoSans-Regular; font-size: 14px;\">Đặt những mục tiêu chạy bộ đầy tham vọng và chinh phục chúng cùng Giày Chạy Bộ Nam Nike Flex Experience Run 12! Được thiết kế với phong cách tối giản nhưng đầy tính năng,được thiết kế với sự tối giản và linh hoạt tối ưu, giúp bạn cảm nhận trọn vẹn từng chuyển động trên mọi cung đường. Đôi giày này sẽ trở thành người bạn đồng hành đáng tin cậy, giúp bạn chuyển động tự do và thoải mái trên mọi cung đường.</span><br></p>', '<ul style=\"margin: 1em 0px; padding: 0px 0px 0px 40px; color: rgb(27, 27, 27); font-family: NunitoSans-Regular; font-size: 14px;\"><li>Phần thân giày dệt kim mềm mại, ôm sát chân, co giãn nhẹ nhàng</li><li>Lớp lót giày được thiết kế đệm êm ái, giúp hấp thụ lực chạm đất hiệu quả</li><li>Các rãnh dẻo dân ở phần đế ngoài giúp chuyển động một cách linh hoạt</li><li>Phần gót giày được thiết kế với độ cao vừa phải, giúp ôm sát cổ chân một cách chắc chắn</li><li>Đế giày có độ cao thấp lý tưởng giúp giảm thiểu trọng lượng tổng thể của giày</li><li>Mã sản phẩm: DV0740-004</li></ul>', 'product_img/_1720633336.jpg', 16, '39,40,41', 'new', 'active', 1400000, 6, 1, 3, NULL, 3, '2024-07-10 17:42:16', '2024-07-15 16:09:27');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shippings
-- ----------------------------
INSERT INTO `shippings` VALUES (1, 'Hồ Chí Minh', 0.00, 'active', '2024-07-10 17:05:14', '2024-07-10 17:05:14');
INSERT INTO `shippings` VALUES (2, 'Nơi Khác', 30000.00, 'active', '2024-07-10 17:05:26', '2024-07-10 17:05:26');

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Admin', 'admin@gmail.com', NULL, '$2y$10$urskJdHzyjUaG2wu/I0GD.PO3kFFSdybxnAOANlugY011vZGo0AhC', NULL, 'admin', NULL, NULL, 'active', NULL, NULL, NULL);
INSERT INTO `users` VALUES (5, 'nhan', 'nhannguyen147147@gmail.com', NULL, '$2y$10$I.pYtEnlv5A1pzrydMfXjecbA8s5rW7px7Z5.9aTAgZO59vMEu9I.', NULL, 'user', NULL, NULL, 'active', NULL, '2024-07-12 14:54:32', '2024-07-15 16:48:32');
INSERT INTO `users` VALUES (7, 'quyen', 'duphuquyenan@gmail.com', NULL, '$2y$10$laL3dkjhFBx4Q.R8yZEkLe44UQ5t.mCkqfwn5oHRbY.sfVxG3C4eS', NULL, 'user', NULL, NULL, 'active', NULL, '2024-07-13 03:48:13', '2024-07-13 03:48:13');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wishlists
-- ----------------------------
INSERT INTO `wishlists` VALUES (2, 6, NULL, NULL, 1316000, 1, 1316000, '2024-07-13 10:02:31', '2024-07-13 10:02:31');

SET FOREIGN_KEY_CHECKS = 1;
