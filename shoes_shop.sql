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

 Date: 06/07/2024 00:01:32
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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of banners
-- ----------------------------
INSERT INTO `banners` VALUES (2, '.', 'lorem-ipsum', 'banner_img/1720190137.jpg', '<h2><span style=\"font-weight: bold; color: rgb(99, 99, 99);\">Giảm tới 30%</span></h2>', 'active', '2020-08-14 08:50:23', '2024-07-05 14:35:37');
INSERT INTO `banners` VALUES (4, '.', 'banner', 'banner_img/1720190191.jpg', '<blockquote><h2><span style=\"font-weight: bold; color: rgb(99, 99, 99);\">Miễn phí giao hàng cho đơn trên 1.000.000đ</span></h2><h6><span style=\"font-family: &quot;Arial Black&quot;;\">﻿</span></h6></blockquote><h2><span style=\"color: rgb(156, 0, 255);\"></span></h2>', 'active', '2020-08-18 03:46:59', '2024-07-05 14:36:31');
INSERT INTO `banners` VALUES (5, '.', 'banner-test', 'banner_img/1720190283.jpg', '<h2><span style=\"font-weight: bold; color: rgb(99, 99, 99);\">Giảm tới 10%</span></h2>', 'active', '2022-04-10 16:30:00', '2024-07-05 14:38:03');

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO `brands` VALUES (1, 'Adidas', 'adidas', 'active', '2020-08-14 11:23:00', '2024-06-28 15:54:08');
INSERT INTO `brands` VALUES (2, 'Nike', 'nike', 'active', '2020-08-14 11:23:08', '2020-08-14 11:23:08');
INSERT INTO `brands` VALUES (3, 'Vans', 'vans', 'active', '2020-08-14 11:23:48', '2024-07-05 15:42:49');
INSERT INTO `brands` VALUES (4, 'Converse', 'converse', 'active', '2020-08-14 11:24:08', '2024-07-05 15:42:58');
INSERT INTO `brands` VALUES (8, 'sad', 'sad', 'active', '2024-07-05 15:44:38', '2024-07-05 15:44:38');
INSERT INTO `brands` VALUES (9, 'sadfasdfasdfsadf', 'sadfasdfasdfsadf', 'active', '2024-07-05 15:44:50', '2024-07-05 15:44:50');
INSERT INTO `brands` VALUES (10, 'Sfasdsadsad', 'sadfd', 'active', '2024-07-05 15:46:12', '2024-07-05 15:47:00');
INSERT INTO `brands` VALUES (11, 'ASDASFDUATSGFD', 'asdasfduatsgfd', 'active', '2024-07-05 15:46:53', '2024-07-05 15:46:53');

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NULL DEFAULT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `price` double(10, 2) NOT NULL,
  `status` enum('new','progress','delivered','cancel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `quantity` int NOT NULL,
  `amount` double(10, 2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `carts_product_id_foreign`(`product_id` ASC) USING BTREE,
  INDEX `carts_user_id_foreign`(`user_id` ASC) USING BTREE,
  INDEX `carts_order_id_foreign`(`order_id` ASC) USING BTREE,
  CONSTRAINT `carts_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carts
-- ----------------------------
INSERT INTO `carts` VALUES (37, 32, 20, 57, 8550000.00, 'new', 2, 17100000.00, '2024-07-05 14:42:07', '2024-07-05 16:22:59');
INSERT INTO `carts` VALUES (38, 33, 20, 57, 474600.00, 'new', 1, 474600.00, '2024-07-05 16:19:46', '2024-07-05 16:22:59');

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
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (26, 'Vans', 'giay-the-thaos', '<p>Giày thể thao nam nữ<br></p>', '/storage/photos/33/download.jpg', 1, NULL, NULL, 'active', '2023-09-06 06:08:19', '2024-07-05 15:48:16');
INSERT INTO `categories` VALUES (27, 'Giày Nữ', 'giay-nu', '<p>Giày Nữ đa dạng<br></p>', '/storage/photos/33/istockphoto-907926200-1024x1024.jpg', 1, NULL, NULL, 'active', '2023-09-06 06:10:27', '2023-09-06 06:10:27');
INSERT INTO `categories` VALUES (28, 'Giày trẻ em', 'giay-tre-em', '<p>Giày trẻ em đa dạng<br></p>', '/storage/photos/33/Product/4297giay-tre-em-new-blance-running-fs996rdi-(3).jpg', 1, NULL, NULL, 'active', '2023-09-06 06:11:10', '2023-09-06 06:11:10');
INSERT INTO `categories` VALUES (29, 'Giày khuyến mãi', 'giay-khuyen-mai', '<p>Giày khuyến mãi tháng 9<br></p>', '/storage/photos/33/Product/8737242048-1620862535 (1).jpg', 1, NULL, NULL, 'active', '2023-09-06 06:12:06', '2023-09-06 06:12:06');
INSERT INTO `categories` VALUES (30, 'asdasdas', 'asdasdas', '<p>asdas</p>', 'category_img/1719674641.jpg', 1, NULL, NULL, 'active', '2024-06-29 15:20:40', '2024-07-05 14:40:04');

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of coupons
-- ----------------------------
INSERT INTO `coupons` VALUES (6, 'GIAMGIAT4', 'percent', 11.00, 'active', '2022-04-25 18:42:51', '2022-04-25 18:43:59');
INSERT INTO `coupons` VALUES (7, 'LOVE-JELLY', 'percent', 20.00, 'active', '2022-04-25 18:43:49', '2022-04-25 18:43:49');
INSERT INTO `coupons` VALUES (8, 'abc123', 'fixed', 300.00, 'active', NULL, NULL);
INSERT INTO `coupons` VALUES (9, '111111', 'percent', 10.00, 'active', NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of messages
-- ----------------------------
INSERT INTO `messages` VALUES (1, 'sadaskd', 'sdaf', 'datem10111@gmail.com', NULL, '3241242134', 'asdasdsadsdfadsafsdaf', NULL, '2024-07-05 15:02:34', '2024-07-05 15:02:34');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2020_07_10_021010_create_brands_table', 1);
INSERT INTO `migrations` VALUES (5, '2020_07_10_025334_create_banners_table', 1);
INSERT INTO `migrations` VALUES (6, '2020_07_10_112147_create_categories_table', 1);
INSERT INTO `migrations` VALUES (7, '2020_07_11_063857_create_products_table', 1);
INSERT INTO `migrations` VALUES (8, '2020_07_12_073132_create_post_categories_table', 1);
INSERT INTO `migrations` VALUES (9, '2020_07_12_073701_create_post_tags_table', 1);
INSERT INTO `migrations` VALUES (10, '2020_07_12_083638_create_posts_table', 1);
INSERT INTO `migrations` VALUES (11, '2020_07_13_151329_create_messages_table', 1);
INSERT INTO `migrations` VALUES (12, '2020_07_14_023748_create_shippings_table', 1);
INSERT INTO `migrations` VALUES (13, '2020_07_15_054356_create_orders_table', 1);
INSERT INTO `migrations` VALUES (14, '2020_07_15_102626_create_carts_table', 1);
INSERT INTO `migrations` VALUES (15, '2020_07_16_041623_create_notifications_table', 1);
INSERT INTO `migrations` VALUES (16, '2020_07_16_053240_create_coupons_table', 1);
INSERT INTO `migrations` VALUES (17, '2020_07_23_143757_create_wishlists_table', 1);
INSERT INTO `migrations` VALUES (18, '2020_07_24_074930_create_product_reviews_table', 1);
INSERT INTO `migrations` VALUES (19, '2020_07_24_131727_create_post_comments_table', 1);
INSERT INTO `migrations` VALUES (20, '2020_08_01_143408_create_settings_table', 1);

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
INSERT INTO `notifications` VALUES ('02a497a6-8ef1-4c7a-8156-3ed925794d19', 'App\\Notifications\\StatusNotification', 'App\\User', 52, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('150cdcf5-c912-4383-a96d-5538d878448c', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/5\",\"fas\":\"fa-file-alt\"}', NULL, '2022-04-10 15:56:44', '2022-04-10 15:56:44');
INSERT INTO `notifications` VALUES ('2145a8e3-687d-444a-8873-b3b2fb77a342', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New Comment created\",\"actionURL\":\"http:\\/\\/e-shop.loc\\/blog-detail\\/where-can-i-get-some\",\"fas\":\"fas fa-comment\"}', NULL, '2020-08-15 14:31:21', '2020-08-15 14:31:21');
INSERT INTO `notifications` VALUES ('25297909-8b8d-4294-94f1-1a3b23681156', 'App\\Notifications\\StatusNotification', 'App\\User', 45, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('2c5806eb-93e9-4f06-883b-26025fe63175', 'App\\Notifications\\StatusNotification', 'App\\User', 49, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('3187be3e-6f59-440b-bd73-6592d05e05f7', 'App\\Notifications\\StatusNotification', 'App\\User', 51, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('33fbcd3a-160e-417c-b742-c46af5288b2f', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/11\",\"fas\":\"fa-file-alt\"}', '2022-05-19 18:30:41', '2022-04-27 07:57:49', '2022-05-19 18:30:41');
INSERT INTO `notifications` VALUES ('3637d38e-c067-4a16-8d9b-b177418f8e48', 'App\\Notifications\\StatusNotification', 'App\\User', 53, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('3762a12a-e923-4815-8054-e7ca59d9e605', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/17\",\"fas\":\"fa-file-alt\"}', NULL, '2022-05-21 16:09:44', '2022-05-21 16:09:44');
INSERT INTO `notifications` VALUES ('3af39f84-cab4-4152-9202-d448435c67de', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/localhost:8000\\/admin\\/order\\/4\",\"fas\":\"fa-file-alt\"}', NULL, '2020-08-15 14:54:52', '2020-08-15 14:54:52');
INSERT INTO `notifications` VALUES ('3c496f77-eaac-468c-b202-afd69c7445e7', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/16\",\"fas\":\"fa-file-alt\"}', NULL, '2022-05-21 14:29:07', '2022-05-21 14:29:07');
INSERT INTO `notifications` VALUES ('49e28d05-dc44-4650-b427-20e9136c6bfd', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"B\\u00ecnh lu\\u1eadn m\\u1edbi \\u0111\\u01b0\\u1ee3c t\\u1ea1o\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/blog-detail\\/mua-quan-ao-online-lieu-co-thuc-su-tot\",\"fas\":\"fas fa-comment\"}', '2022-04-25 18:44:37', '2022-04-25 18:32:08', '2022-04-25 18:44:37');
INSERT INTO `notifications` VALUES ('4a0afdb0-71ad-4ce6-bc70-c92ef491a525', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New Comment created\",\"actionURL\":\"http:\\/\\/localhost:8000\\/blog-detail\\/the-standard-lorem-ipsum-passage-used-since-the-1500s\",\"fas\":\"fas fa-comment\"}', NULL, '2020-08-18 04:13:51', '2020-08-18 04:13:51');
INSERT INTO `notifications` VALUES ('503c7c00-3587-462b-bafd-a36dfb7355b8', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/19\",\"fas\":\"fa-file-alt\"}', NULL, '2022-07-03 14:33:08', '2022-07-03 14:33:08');
INSERT INTO `notifications` VALUES ('51a4117f-998a-42bc-82f8-feefeaa79cc9', 'App\\Notifications\\StatusNotification', 'App\\User', 47, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('540ca3e9-0ff9-4e2e-9db3-6b5abc823422', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New Comment created\",\"actionURL\":\"http:\\/\\/e-shop.loc\\/blog-detail\\/where-can-i-get-some\",\"fas\":\"fas fa-comment\"}', '2020-08-15 14:30:44', '2020-08-14 14:12:28', '2020-08-15 14:30:44');
INSERT INTO `notifications` VALUES ('5677318f-b53e-46a9-9203-45cd58be8ce9', 'App\\Notifications\\StatusNotification', 'App\\User', 56, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('583cca10-9a7e-4c08-a51f-ebe18f0f5df6', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"B\\u00ecnh lu\\u1eadn m\\u1edbi \\u0111\\u01b0\\u1ee3c t\\u1ea1o\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/blog-detail\\/mua-quan-ao-online-lieu-co-thuc-su-tot\",\"fas\":\"fas fa-comment\"}', NULL, '2022-07-03 14:34:44', '2022-07-03 14:34:44');
INSERT INTO `notifications` VALUES ('598c4988-99ff-44c6-8bee-a8c692b573c0', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/6\",\"fas\":\"fa-file-alt\"}', NULL, '2022-04-11 15:26:33', '2022-04-11 15:26:33');
INSERT INTO `notifications` VALUES ('5c589337-cb66-4e08-b4bb-dfacb2e6a682', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/12\",\"fas\":\"fa-file-alt\"}', '2022-05-19 18:30:46', '2022-04-29 07:56:30', '2022-05-19 18:30:46');
INSERT INTO `notifications` VALUES ('5d8b5057-0447-4c06-817e-e3dbdd424170', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/product-detail\\/bo-tap-gym-nu\",\"fas\":\"fa-star\"}', '2022-05-19 18:30:49', '2022-04-28 16:59:54', '2022-05-19 18:30:49');
INSERT INTO `notifications` VALUES ('5da09dd1-3ffc-43b0-aba2-a4260ba4cc76', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New Comment created\",\"actionURL\":\"http:\\/\\/localhost:8000\\/blog-detail\\/the-standard-lorem-ipsum-passage\",\"fas\":\"fas fa-comment\"}', NULL, '2020-08-15 14:51:02', '2020-08-15 14:51:02');
INSERT INTO `notifications` VALUES ('5e91e603-024e-45c5-b22f-36931fef0d90', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New Product Rating!\",\"actionURL\":\"http:\\/\\/localhost:8000\\/product-detail\\/white-sports-casual-t\",\"fas\":\"fa-star\"}', NULL, '2020-08-15 14:44:07', '2020-08-15 14:44:07');
INSERT INTO `notifications` VALUES ('73a3b51a-416a-4e7d-8ca2-53b216d9ad8e', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New Comment created\",\"actionURL\":\"http:\\/\\/e-shop.loc\\/blog-detail\\/where-can-i-get-some\",\"fas\":\"fas fa-comment\"}', NULL, '2020-08-14 14:11:03', '2020-08-14 14:11:03');
INSERT INTO `notifications` VALUES ('754c75a1-ccc0-4200-b6df-95f85fd8813e', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/18\",\"fas\":\"fa-file-alt\"}', NULL, '2022-05-22 01:28:12', '2022-05-22 01:28:12');
INSERT INTO `notifications` VALUES ('81942209-edba-4829-b459-24de3fcc621b', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/12\",\"fas\":\"fa-file-alt\"}', '2022-05-09 16:36:53', '2022-05-09 16:35:18', '2022-05-09 16:36:53');
INSERT INTO `notifications` VALUES ('835896e0-7ef2-43fd-8a67-cb037f80d816', 'App\\Notifications\\StatusNotification', 'App\\User', 50, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('8605db5d-1462-496e-8b5f-8b923d88912c', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/e-shop.loc\\/admin\\/order\\/1\",\"fas\":\"fa-file-alt\"}', NULL, '2020-08-14 14:20:44', '2020-08-14 14:20:44');
INSERT INTO `notifications` VALUES ('86cc4893-9589-4508-8f2c-7b8fe3d6868c', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/14\",\"fas\":\"fa-file-alt\"}', '2022-05-19 18:30:24', '2022-05-11 18:00:52', '2022-05-19 18:30:24');
INSERT INTO `notifications` VALUES ('8b7a7abf-1305-4c4a-a733-518611bb5a25', 'App\\Notifications\\StatusNotification', 'App\\User', 46, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('912b1969-f22f-487b-a816-178e14758278', 'App\\Notifications\\StatusNotification', 'App\\User', 55, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('97542d15-92d0-441a-8db2-2e6fd6ac8ea9', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/15\",\"fas\":\"fa-file-alt\"}', '2022-05-19 18:34:35', '2022-05-19 18:34:04', '2022-05-19 18:34:35');
INSERT INTO `notifications` VALUES ('9a44d5e2-0e99-4f56-b514-e18d619834eb', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/13\",\"fas\":\"fa-file-alt\"}', '2022-05-19 18:30:38', '2022-05-09 16:47:04', '2022-05-19 18:30:38');
INSERT INTO `notifications` VALUES ('a6ec5643-748c-4128-92e2-9a9f293f53b5', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/localhost:8000\\/admin\\/order\\/5\",\"fas\":\"fa-file-alt\"}', NULL, '2020-08-18 04:17:03', '2020-08-18 04:17:03');
INSERT INTO `notifications` VALUES ('a8e2cdc0-722b-47d6-a410-45eafdea38b7', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"B\\u00ecnh lu\\u1eadn m\\u1edbi \\u0111\\u01b0\\u1ee3c t\\u1ea1o\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/blog-detail\\/mua-quan-ao-online-lieu-co-thuc-su-tot\",\"fas\":\"fas fa-comment\"}', '2022-04-25 18:39:30', '2022-04-25 18:32:29', '2022-04-25 18:39:30');
INSERT INTO `notifications` VALUES ('aab7f84a-357c-4b07-b5ae-92e6a4f06681', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/8\",\"fas\":\"fa-file-alt\"}', NULL, '2022-04-11 16:23:01', '2022-04-11 16:23:01');
INSERT INTO `notifications` VALUES ('b186a883-42f2-4a05-8fc5-f0d3e10309ff', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/e-shop.loc\\/admin\\/order\\/2\",\"fas\":\"fa-file-alt\"}', '2020-08-15 11:17:24', '2020-08-15 05:14:55', '2020-08-15 11:17:24');
INSERT INTO `notifications` VALUES ('ca86d4ba-c0b9-465b-a16f-868b76b50dda', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('d2fd7c33-b0fe-47d6-8bc6-f377d404080d', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New Comment created\",\"actionURL\":\"http:\\/\\/e-shop.loc\\/blog-detail\\/where-can-i-get-some\",\"fas\":\"fas fa-comment\"}', NULL, '2020-08-14 14:08:50', '2020-08-14 14:08:50');
INSERT INTO `notifications` VALUES ('d5578f59-dd6b-4b66-b033-42503d720fec', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/9\",\"fas\":\"fa-file-alt\"}', NULL, '2022-04-11 16:28:24', '2022-04-11 16:28:24');
INSERT INTO `notifications` VALUES ('d7d2fe11-1dbe-414b-8b6e-a7cc2d4b6d3a', 'App\\Notifications\\StatusNotification', 'App\\User', 33, '{\"title\":\"C\\u00f3 \\u0111\\u01a1n h\\u00e0ng m\\u1edbi\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/20\",\"fas\":\"fa-file-alt\"}', NULL, '2024-07-05 16:22:59', '2024-07-05 16:22:59');
INSERT INTO `notifications` VALUES ('d95fe96e-78e3-46bb-8808-4179a2947bc4', 'App\\Notifications\\StatusNotification', 'App\\User', 54, '{\"title\":\"C\\u00f3 \\u0111\\u00e1nh gi\\u00e1 s\\u1ea3n ph\\u1ea9m m\\u1edbi!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/giay-sandal-nu-mwc-nusd-2889\",\"fas\":\"fa-star\"}', NULL, '2024-07-05 15:36:53', '2024-07-05 15:36:53');
INSERT INTO `notifications` VALUES ('dff78b90-85c8-42ee-a5b1-de8ad0b21be4', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/e-shop.loc\\/admin\\/order\\/3\",\"fas\":\"fa-file-alt\"}', NULL, '2020-08-15 13:40:54', '2020-08-15 13:40:54');
INSERT INTO `notifications` VALUES ('e28b0a73-4819-4016-b915-0e525d4148f5', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New Product Rating!\",\"actionURL\":\"http:\\/\\/localhost:8000\\/product-detail\\/lorem-ipsum-is-simply\",\"fas\":\"fa-star\"}', NULL, '2020-08-18 04:08:16', '2020-08-18 04:08:16');
INSERT INTO `notifications` VALUES ('e2c9c58b-a066-4bee-ae6e-48c191dc1d39', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/jellyboutique.vtest:85\\/admin\\/order\\/7\",\"fas\":\"fa-file-alt\"}', NULL, '2022-04-11 15:37:28', '2022-04-11 15:37:28');
INSERT INTO `notifications` VALUES ('ffffa177-c54e-4dfe-ba43-27c466ff1f4b', 'App\\Notifications\\StatusNotification', 'App\\User', 1, '{\"title\":\"New Comment created\",\"actionURL\":\"http:\\/\\/localhost:8000\\/blog-detail\\/the-standard-lorem-ipsum-passage-used-since-the-1500s\",\"fas\":\"fas fa-comment\"}', NULL, '2020-08-18 04:13:29', '2020-08-18 04:13:29');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `sub_total` double(10, 2) NOT NULL,
  `shipping_id` bigint UNSIGNED NULL DEFAULT NULL,
  `coupon` double(10, 2) NULL DEFAULT NULL,
  `total_amount` double(10, 2) NOT NULL,
  `quantity` int NOT NULL,
  `payment_method` enum('cod','paypal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cod',
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
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (20, 'ORD-HNPCMIAE1K', 57, 17574600.00, 2, NULL, 17604600.00, 3, 'cod', 'unpaid', 'cancel', 'sdafasdf', 'dsafasdf', 'datem10111@gmail.com', '0906913419', 'VN', NULL, 'sadsadsad', NULL, '2024-07-05 16:22:59', '2024-07-05 16:28:44');

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
INSERT INTO `password_resets` VALUES ('thinhtest222@gmail.com', '$2y$10$UpffYw4dpalbkPbK4U.G0eESzAPNL51Z4mMMKJa7Isx5h5Z/owehy', '2022-04-21 14:10:03');
INSERT INTO `password_resets` VALUES ('thinhtest111@gmail.com', '$2y$10$Bs7ZIpjeJxaXkcZJVQsA2OdoPec6PNN6Co7CWD4OwEGeKnldJqgg2', '2022-04-21 14:15:47');
INSERT INTO `password_resets` VALUES ('thinhphuongxa1@gmail.com', '$2y$10$zrt0Y16waKaRz4oX1sYgteMUFa2PGL9.ubqeQwA1f9nObdcg4MvXO', '2022-05-19 16:44:24');

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of post_categories
-- ----------------------------
INSERT INTO `post_categories` VALUES (6, 'Thể thao', 'the-thao', 'active', '2022-04-25 18:20:11', '2022-04-25 18:20:11');
INSERT INTO `post_categories` VALUES (7, 'Công sở', 'cong-so', 'active', '2022-04-25 18:20:18', '2022-04-25 18:20:18');
INSERT INTO `post_categories` VALUES (8, 'Bảo quản quần áo', 'bao-quan-quan-ao', 'active', '2022-04-25 18:20:27', '2022-04-25 18:20:27');
INSERT INTO `post_categories` VALUES (9, 'Cách chọn quần áo', 'cach-chon-quan-ao', 'active', '2022-04-25 18:27:59', '2022-04-25 18:27:59');

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
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of post_comments
-- ----------------------------
INSERT INTO `post_comments` VALUES (8, 33, 10, 'Có khả năng', 'active', NULL, NULL, '2022-04-25 18:32:08', '2022-04-27 08:59:30');
INSERT INTO `post_comments` VALUES (9, 33, 10, 'Tớ tự rep comment của tớ nè', 'inactive', NULL, 8, '2022-04-25 18:32:29', '2022-04-27 08:59:34');
INSERT INTO `post_comments` VALUES (10, NULL, 10, 'bài viết hay (Đã sửa) (Admin sửa)', 'active', NULL, NULL, '2022-07-03 14:34:44', '2022-07-03 14:46:09');

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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of post_tags
-- ----------------------------
INSERT INTO `post_tags` VALUES (5, 'Công sở', 'cong-so', 'active', '2022-04-25 18:34:58', '2022-04-25 18:34:58');
INSERT INTO `post_tags` VALUES (6, 'Thể thao', 'the-thao', 'active', '2022-04-25 18:35:05', '2022-04-25 18:35:05');
INSERT INTO `post_tags` VALUES (7, 'Bảo quản quần áo', 'bao-quan-quan-ao', 'active', '2022-04-25 18:35:17', '2022-04-25 18:35:17');

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
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES (7, 'Đồ công sở, màu nào phù hợp với bạn ?', 'do-cong-so-mau-nao-phu-hop-voi-ban', '<p>Đồ công sở, màu nào phù hợp với bạn ?<br></p>', '<p>Đồ công sở, màu nào phù hợp với bạn ?<br></p>', '<p>Đồ công sở, màu nào phù hợp với bạn ?<br></p>', '/storage/photos/33/Blog/blog1.jpg', '', 7, NULL, NULL, 'active', '2022-04-25 18:24:08', '2022-04-25 18:24:08');
INSERT INTO `posts` VALUES (9, 'Chọn quần áo sao cho phù hợp ?', 'chon-quan-ao-sao-cho-phu-hop', '<p>Chọn quần áo sao cho phù hợp ?<br></p>', '<p>Chọn quần áo sao cho phù hợp ?<br></p>', '<p>Chọn quần áo sao cho phù hợp ?<br></p>', '/storage/photos/33/Blog/blog2.jpg', '', 9, NULL, NULL, 'active', '2022-04-25 18:28:27', '2022-04-25 18:28:27');
INSERT INTO `posts` VALUES (10, 'Mua Giày  Online, liệu có thực sự tốt ?', 'mua-quan-ao-online-lieu-co-thuc-su-tot', '<p>Mua Giày&nbsp;&nbsp;Online, liệu có thực sự tốt ?<br></p>', '<p>Mua Giày&nbsp;&nbsp;Online, liệu có thực sự tốt ?<br></p>', '<p>Mua Giày Online, liệu có thực sự tốt ?<br></p>', '/storage/photos/33/gia-y-the-thao-nike-downshifter-11-black-coast-cw3411-001-mau-den-size-42-5-636efcabc6d13-12112022085347.jpg', '', 9, NULL, NULL, 'active', '2022-04-25 18:31:35', '2023-09-06 06:33:06');

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_reviews
-- ----------------------------
INSERT INTO `product_reviews` VALUES (4, 57, 33, 5, 'asdasdasd', 'active', '2024-07-05 15:36:53', '2024-07-05 15:36:53');

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
  `price` double(20, 2) NOT NULL,
  `discount` double(10, 2) NOT NULL,
  `is_featured` tinyint(1) NOT NULL,
  `cat_id` bigint UNSIGNED NULL DEFAULT NULL,
  `child_cat_id` bigint UNSIGNED NULL DEFAULT NULL,
  `brand_id` bigint UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `products_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `products_brand_id_foreign`(`brand_id` ASC) USING BTREE,
  INDEX `products_cat_id_foreign`(`cat_id` ASC) USING BTREE,
  INDEX `products_child_cat_id_foreign`(`child_cat_id` ASC) USING BTREE,
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `products_cat_id_foreign` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `products_child_cat_id_foreign` FOREIGN KEY (`child_cat_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (21, 'Giày Thể Thao Nam MWC - 5417 Giày Thể Thao Nam Phối Sọc Thể Thao,', 'giay-the-thao-nam-mwc-5417-giay-the-thao-nam-phoi-soc-the-thao', '<p dir=\"ltr\" style=\"padding: 0px; margin: 0pt 0px 3pt; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; line-height: 1.716; text-align: justify; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); font-weight: 700; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space-collapse: preserve; outline: none !important;\">MÔ TẢ SẢN PHẨM : Giày Thể Thao Nam MWC - 5417</span></p><ul style=\"padding: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; padding-inline-start: 48px; outline: none !important;\"><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Giày được thiết kế kiểu dáng buộc dây sneaker cực ngầu phối sọc thể thao năng động, phong cách hiện đại,màu sắc khỏe khoắn.</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Với chất vải Flyknit chuyên dụng tạo cảm giác thoải mái cho bạn trong suốt quá trình vận động, mang lại một phong cách thật thời thượng mỗi khi xuống phố.&nbsp;</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0px; margin: 0pt 0px 3pt; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Sản phẩm có thiết kế tinh tế cùng đường may tỉ mỉ, chắc chắn, thích hợp trong các hoạt động thể thao, dạo chơi, picnic</span></p></li></ul>', '<p dir=\"ltr\" style=\"padding: 0px; margin: 0pt 0px 3pt; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; line-height: 1.716; text-align: justify; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); font-weight: 700; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space-collapse: preserve; outline: none !important;\">CHI TIẾT SẢN PHẨM</span></p><p style=\"padding: 0px; margin-right: 0px; margin-left: 0px; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; outline: none !important;\"><span id=\"docs-internal-guid-9dc2c2d1-7fff-5a91-2ba2-ec284d3dc9da\" style=\"padding: 0px; margin: 0px; outline: none !important;\"></span></p><ul style=\"padding: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; padding-inline-start: 48px; outline: none !important;\"><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Chiều cao giày 3cm</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Chất liệu vải Flyknit cao cấp</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Chất liệu đế cao su đúc êm mềm, độ đàn hồi tốt, chống trơn trượt</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Kiểu dáng giày thể thao nam cổ thấp</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Màu sắc: Kem - Đen</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Size: 39 - 40- 41 - 42 -43</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0px; margin: 0pt 0px 3pt; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Xuất xứ: Việt Nam </span></p></li></ul>', '/storage/photos/33/Product/11593421642-242872808.jpg', 8, '39,41,42', 'new', 'active', 679000.00, 10.00, 1, 26, NULL, 1, '2023-09-06 06:14:55', '2023-09-06 06:14:55');
INSERT INTO `products` VALUES (22, 'Giày Thể Thao Nam MWC NATT- 5444 Giày Thể Thao Nam Cao Cấp, Sneaker Nam Cổ Thấp Năng Động Cá Tính', 'giay-the-thao-nam-mwc-natt-5444-giay-the-thao-nam-cao-cap-sneaker-nam-co-thap-nang-dong-ca-tinh', '<p dir=\"ltr\" style=\"padding: 0px; margin: 0pt 0px 2pt; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; line-height: 1.716; text-align: justify; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); font-weight: 700; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space-collapse: preserve; outline: none !important;\">MÔ TẢ SẢN PHẨM : Giày Thể Thao Nam MWC NATT - 5444</span></p><ul style=\"padding: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; padding-inline-start: 48px; outline: none !important;\"><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 2pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Giày được thiết kế theo phong cách hiện đại, phối màu thời trang,phong cách khỏe khoắn,sang trọng mang đến cho bạn 1 diện mạo hoàn toàn cá tính.&nbsp;</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 2pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Đặc biệt sản phẩm sử dụng chất liệu cao cấp có độ bền tối ưu giúp bạn thoải mái trong mọi hoàn cảnh.</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0px; margin: 0pt 0px 2pt; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Chất liệu cao cấp : thoáng khí cả mặt trong lẫn mặt ngoài khiến người mang luôn cảm thấy dễ chịu dù hoạt động trong thời gian dài.</span></p></li></ul>', '<p dir=\"ltr\" style=\"padding: 0px; margin: 0pt 0px 2pt; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; line-height: 1.716; text-align: justify; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); font-weight: 700; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space-collapse: preserve; outline: none !important;\">CHI TIẾT SẢN PHẨM</span></p><p style=\"padding: 0px; margin-right: 0px; margin-left: 0px; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; outline: none !important;\"><span id=\"docs-internal-guid-d2cba49e-7fff-9f01-f041-66fd73691d58\" style=\"padding: 0px; margin: 0px; outline: none !important;\"></span></p><ul style=\"padding: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; padding-inline-start: 48px; outline: none !important;\"><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 2pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Chiều cao giày 3cm</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 2pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Chất liệu : da PU cao cấp</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 2pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Chất liệu đế cao su đúc êm mềm, độ đàn hồi tốt, chống trơn trượt</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 2pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Kiểu dáng giày Sneaker cổ thấp</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 2pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Màu sắc: Xanh Rêu - Xanh Biển</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 2pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Size: 39 - 40- 41 - 42 -43</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 2pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Xuất xứ : Việt Nam&nbsp;</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 2pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Chú ý : Kích thước so sánh một cách cẩn thận,vui lòng cho phép sai số 1-3 cm do đo lường thủ công</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 2pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Do màn hình hiển thị khác nhau và ánh sáng khác nhau, hình ảnh có thể chênh lệch 5-&gt;10% màu sắc thật của sản phẩm.</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(67, 67, 67); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0px; margin: 0pt 0px 2pt; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Cảm ơn bạn đã thông cảm.</span></p></li></ul>', '/storage/photos/33/Product/mwc (2).jpg', 88, '', 'hot', 'active', 790000.00, 15.00, 1, 29, NULL, 2, '2023-09-06 06:16:28', '2024-07-05 14:41:52');
INSERT INTO `products` VALUES (32, 'Giày Thể Thao Nam Phối Sọc Thể Thao,Sneaker Nam Cổ Thấp Năng Động Cá Tính', 'x', '<p dir=\"ltr\" style=\"padding: 0px; margin: 0pt 0px 3pt; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; line-height: 1.716; text-align: justify; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); font-weight: 700; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space-collapse: preserve; outline: none !important;\">MÔ TẢ SẢN PHẨM : Giày Thể Thao Nam MWC - 5419</span></p><ul style=\"padding: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; padding-inline-start: 48px; outline: none !important;\"><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Giày được thiết kế kiểu dáng buộc dây sneaker cực ngầu phối sọc thể thao năng động, phong cách hiện đại,màu sắc khỏe khoắn.</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Với chất vải Flyknit chuyên dụng tạo cảm giác thoải mái cho bạn trong suốt quá trình vận động, mang lại một phong cách thật thời thượng mỗi khi xuống phố.&nbsp;</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0px; margin: 0pt 0px 3pt; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Sản phẩm có thiết kế tinh tế cùng đường may tỉ mỉ, chắc chắn, thích hợp trong các hoạt động thể thao, dạo chơi, picnic</span></p></li></ul>', '<p dir=\"ltr\" style=\"padding: 0px; margin: 0pt 0px 3pt; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; line-height: 1.716; text-align: justify; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); font-weight: 700; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space-collapse: preserve; outline: none !important;\">CHI TIẾT SẢN PHẨM</span></p><p style=\"padding: 0px; margin-right: 0px; margin-left: 0px; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; outline: none !important;\"><span id=\"docs-internal-guid-9e61816e-7fff-b862-55c2-b7146dc5ec60\" style=\"padding: 0px; margin: 0px; outline: none !important;\"></span></p><ul style=\"padding: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; padding-inline-start: 48px; outline: none !important;\"><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Chiều cao giày 3cm</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Chất liệu vải Flyknit cao cấp</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Chất liệu đế cao su đúc êm mềm, độ đàn hồi tốt, chống trơn trượt</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Kiểu dáng giày thể thao nam cổ thấp</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Màu sắc: Xám - Đen - Trắng</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0pt 0pt 3pt; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Size: 39 - 40- 41 - 42 -43</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0px; margin: 0pt 0px 3pt; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Xuất xứ: Việt Nam </span></p></li></ul>', '/storage/photos/33/Product/mwc (3).jpg', 0, '', 'new', 'active', 9000000.00, 5.00, 1, 26, NULL, 3, '2023-09-06 06:28:27', '2024-07-05 16:28:08');
INSERT INTO `products` VALUES (33, 'Giày sandal nữ MWC NUSD- 2889', 'giay-sandal-nu-mwc-nusd-2889', '<p dir=\"ltr\" style=\"padding: 0px; margin: 0pt 0px; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; line-height: 1.716; text-align: justify; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-weight: 700; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space-collapse: preserve; outline: none !important;\">MÔ TẢ SẢN PHẨM</span></p><p style=\"padding: 0px; margin-right: 0px; margin-left: 0px; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; outline: none !important;\"><span id=\"docs-internal-guid-ed5e58dd-7fff-5ae1-7e95-8796749b1d7f\" style=\"padding: 0px; margin: 0px; outline: none !important;\"></span></p><ul style=\"padding: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; list-style: none; color: rgba(0, 0, 0, 0.85); font-family: MuliDisplayVN, sans-serif; font-size: 14px; padding-inline-start: 48px; outline: none !important;\"><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0px; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Giày sandal nữ MWC NUSD- 2889 sử dụng chất liệu da bóng bền đẹp, lớp lót giày mềm mại cực kỳ êm chân.&nbsp;</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0px; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Đường may tỉ mỉ, form giày chuẩn đem lại cảm giác thoải mái cho bạn gái khi mang.</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0px; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Bên cạnh đó, sản phẩm Giày sandal nữ MWC NUSD- 2889 có kiểu dáng hiện đại, thời trang giúp tôn vinh đôi chân của phái nữ.</span></p></li><li dir=\"ltr\" aria-level=\"1\" style=\"padding: 0px; margin: 0px; list-style: disc; font-size: 10.5pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; white-space: pre; outline: none !important;\"><p dir=\"ltr\" role=\"presentation\" style=\"padding: 0px; margin: 0pt 0px; line-height: 1.716; outline: none !important;\"><span style=\"padding: 0px; margin: 0px; font-size: 10.5pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; vertical-align: baseline; text-wrap: wrap; outline: none !important;\">Có thể phối hợp với nhiều phong cách, phù hợp với nhiều hoàn cảnh như đi làm, đi học, đi chơi</span></p></li></ul>', '<p>z</p>', 'product_img/1720193622.png', 31, '', 'new', 'active', 678000.00, 30.00, 1, 27, NULL, 3, '2023-09-06 06:32:03', '2024-07-05 16:28:08');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO `settings` VALUES (1, 'Mong muốn đáp ứng nhu cầu của khách hàng.', 'Mong muốn đáp ứng nhu cầu của khách hàng.', 'logo_img/1720193913.png', 'setting_img/1720193944.png', 'Bến Tre', '0909090909', 'admin@gmail.com', NULL, '2024-07-05 15:39:04');

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shippings
-- ----------------------------
INSERT INTO `shippings` VALUES (1, 'Hồ Chí Minh', 0.00, 'active', '2020-08-14 11:22:17', '2024-06-29 14:42:57');
INSERT INTO `shippings` VALUES (2, 'Nơi Khác', 30000.00, 'active', '2020-08-14 11:22:41', '2024-06-29 14:43:11');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
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
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (33, 'Admin', 'admin@gmail.com', NULL, '$2y$10$J56ypr5kia9iVvw1UEX9Auk2AwUQ9uO.eHE1.CuwP6ZxH4wgzaIyW', 'user_img/1719678190.png', 'admin', NULL, NULL, 'active', 'gdzsCgQlaxurWrKxnE31akm7B5nD9cTzqpNTl40sNDZ1gvlOsRJ2deookRRa', NULL, '2024-06-29 16:23:10');
INSERT INTO `users` VALUES (37, 'user1', 'user1@gmail.com', NULL, '$2y$10$kxkc4NscWvCxh0t/7nYIqOCOSJPwfrMLmawfwmxnJlCAFcbLvZWfC', 'user_img/1719676922.png', 'user', NULL, NULL, 'active', NULL, '2022-05-11 17:04:16', '2024-06-29 16:02:02');
INSERT INTO `users` VALUES (38, 'user2', 'user2@gmail.com', NULL, '$2y$10$RwduGWnyr96mK.DqvYi5Cex7ZujywKNJQ9lTfR9tuds36mUvc7Jie', NULL, 'user', NULL, NULL, 'active', NULL, '2022-05-19 15:11:39', '2022-05-19 15:11:39');
INSERT INTO `users` VALUES (39, 'user3', 'user3@gmail.com', NULL, '$2y$10$DCyzfOKCmgt2njr8D7Z.ZeZ2pFVly/chBrJeqJFwYBjXipliyPs26', NULL, 'user', NULL, NULL, 'active', NULL, '2022-05-20 15:12:05', '2022-05-20 15:12:05');
INSERT INTO `users` VALUES (40, 'user4', 'user4@gmail.com', NULL, '$2y$10$IbppthaqLsoS9QOEH3gWtu7cPiEzhY.lUeEFEz4EGVXBivJL8kN8y', NULL, 'user', NULL, NULL, 'active', NULL, '2022-05-21 15:12:28', '2022-05-21 15:12:28');
INSERT INTO `users` VALUES (44, 'ppp', 'pppppp@gmail.com', NULL, '$2y$10$J56ypr5kia9iVvw1UEX9Auk2AwUQ9uO.eHE1.CuwP6ZxH4wgzaIyW', NULL, 'user', NULL, NULL, 'active', NULL, '2023-09-06 06:01:19', '2023-09-06 06:01:19');
INSERT INTO `users` VALUES (45, 'Admin', 'admin2@gmail.com', NULL, '$2y$10$JRaHyrJyzBBCYsWqiB5t9eMTlApJzN4X.xASx9tIyoci05KlfaTle', 'user_img/1719677340.png', 'admin', NULL, NULL, 'active', NULL, NULL, '2024-06-29 16:09:00');
INSERT INTO `users` VALUES (46, 'sadasd', 'testminh@gmail.com', NULL, '$2y$10$tQBhB8ZP3sKiS4gFyd.PfOQV3XyyQVfHGzKreM4csvJ1w8ZcEWX/S', 'user/1719673888.png', 'admin', NULL, NULL, 'active', NULL, '2024-06-29 15:07:24', '2024-06-29 15:11:28');
INSERT INTO `users` VALUES (47, 'safsad', 'asdfsda@gmail.com', NULL, '$2y$10$FAwhN2jiy4NhIHqnK0mavuqIL6WlEUEh6cN0d9C6kBmrybS6QweuW', 'user_img/safsad_1719674756.png', 'admin', NULL, NULL, 'active', NULL, '2024-06-29 15:25:56', '2024-06-29 15:25:56');
INSERT INTO `users` VALUES (49, 'asd', 'asdsadsa@gmail.com', NULL, '$2y$10$QzUW715A1VMXvprvl4Pt2emteM1RxO2DWKHq8mEVhfr2AwD/7M17y', 'user_img/asd_1719677486.png', 'admin', NULL, NULL, 'active', NULL, '2024-06-29 16:11:26', '2024-06-29 16:11:26');
INSERT INTO `users` VALUES (50, 'sadas', 'sadsadas@gmail.com', NULL, '$2y$10$h1qoRR37LyffBfTnCuijs.EanGDvWD2LEj.fnh.C7YEPvXCCK8Mcm', 'user_img/sadas_1719677543.png', 'admin', NULL, NULL, 'active', NULL, '2024-06-29 16:12:23', '2024-06-29 16:12:23');
INSERT INTO `users` VALUES (51, 'sadasdsa', 'datem10111@gmail.com', NULL, '$2y$10$u4axzRSomV45r7UICSlND.Ii0qmgXcbjE.lyymJsZQ9wRTm0yg36W', 'user_img/sadasdsa_1719677635.png', 'admin', NULL, NULL, 'active', NULL, '2024-06-29 16:13:55', '2024-06-29 16:13:55');
INSERT INTO `users` VALUES (52, 'sadfsadf', 'adminasdas2@gmail.com', NULL, '$2y$10$ytTCXIF74unuYuGEDIh/uOMzYSy/.QNT2Fq1.WEVCbBiOLFLtSfnK', 'user_img/sadfsadf_1719677733.png', 'admin', NULL, NULL, 'active', NULL, '2024-06-29 16:15:33', '2024-06-29 16:15:33');
INSERT INTO `users` VALUES (53, 'sadfsa', 'safdasf@gmail.com', NULL, '$2y$10$kLxyODEM7FLBUIjAYUDUbuWueXAGEKv6BJ.0NrAHwhdK6jjx/1Lmq', 'user_img/sadfsa_1719677868.png', 'admin', NULL, NULL, 'active', NULL, '2024-06-29 16:17:48', '2024-06-29 16:17:48');
INSERT INTO `users` VALUES (54, 'sadfsa', 'safdsadfasf@gmail.com', NULL, '$2y$10$3pSfGjbKAz6w316owbw90uz0aG8ys7qzhKUYxsCOtHBu6Bl/S8P6K', 'user_img/sadfsa_1719677878.png', 'admin', NULL, NULL, 'active', NULL, '2024-06-29 16:17:58', '2024-06-29 16:17:58');
INSERT INTO `users` VALUES (55, 'asdas', 'asdasd@gmail.com', NULL, '$2y$10$3WX1vQhw1R/Tr3mioo6CfeLMVhB3QP4DJJj92.ds1SWkCM2yJ84Da', 'user_img/asdas_1719677972.png', 'admin', NULL, NULL, 'active', NULL, '2024-06-29 16:19:32', '2024-06-29 16:19:32');
INSERT INTO `users` VALUES (56, 'sadas', 'asdasdasf@gmail.com', NULL, '$2y$10$CFGPd74cyUblornvMTcLYOJ0nj2Iq55NzLAB/48/gjKFvexeRpTMK', 'user_img/sadas_1719678115.png', 'admin', NULL, NULL, 'active', NULL, '2024-06-29 16:21:55', '2024-06-29 16:21:55');
INSERT INTO `users` VALUES (57, 'Lê Đức Minh', 'ducminh@gmail.com', NULL, '$2y$10$VK4NkIenU9z7wtaIJB5PkeOf0Y5fvatd3W7.4I8q09EQ0p/1cjxWK', 'user_img/1720198003.png', 'user', NULL, NULL, 'active', NULL, '2024-07-05 14:24:38', '2024-07-05 16:46:43');

-- ----------------------------
-- Table structure for wishlists
-- ----------------------------
DROP TABLE IF EXISTS `wishlists`;
CREATE TABLE `wishlists`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint UNSIGNED NOT NULL,
  `cart_id` bigint UNSIGNED NULL DEFAULT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `price` double(10, 2) NOT NULL,
  `quantity` int NOT NULL,
  `amount` double(10, 2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `wishlists_product_id_foreign`(`product_id` ASC) USING BTREE,
  INDEX `wishlists_user_id_foreign`(`user_id` ASC) USING BTREE,
  INDEX `wishlists_cart_id_foreign`(`cart_id` ASC) USING BTREE,
  CONSTRAINT `wishlists_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `wishlists_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `wishlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wishlists
-- ----------------------------
INSERT INTO `wishlists` VALUES (8, 22, 37, 57, 671500.00, 1, 671500.00, '2024-07-05 14:42:00', '2024-07-05 14:42:07');
INSERT INTO `wishlists` VALUES (9, 32, 38, 57, 8550000.00, 1, 8550000.00, '2024-07-05 14:58:59', '2024-07-05 16:19:46');

SET FOREIGN_KEY_CHECKS = 1;
