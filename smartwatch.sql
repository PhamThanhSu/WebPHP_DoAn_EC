-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for ec
CREATE DATABASE IF NOT EXISTS `ec` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `ec`;

-- Dumping structure for table ec.carts
CREATE TABLE IF NOT EXISTS `carts` (
  `user_id` int(11) NOT NULL,
  `product_variation_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  PRIMARY KEY (`user_id`,`product_variation_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_product_variation_id` (`product_variation_id`),
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`product_variation_id`) REFERENCES `product_variations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.carts: ~1 rows (approximately)
INSERT INTO `carts` (`user_id`, `product_variation_id`, `quantity`) VALUES
	(2, 1, 1);

-- Dumping structure for table ec.goods_receipt_notes
CREATE TABLE IF NOT EXISTS `goods_receipt_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `total_price_cents` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_provider_id` (`provider_id`),
  KEY `idx_staff_id` (`staff_id`),
  CONSTRAINT `goods_receipt_notes_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`),
  CONSTRAINT `goods_receipt_notes_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.goods_receipt_notes: ~2 rows (approximately)
INSERT INTO `goods_receipt_notes` (`id`, `name`, `provider_id`, `staff_id`, `total_price_cents`, `quantity`, `created_at`) VALUES
	(1, 'Apple Delivery', 1, 3, 1000000, 10, '2025-02-21 08:49:40'),
	(2, 'Samsung Delivery', 2, 3, 800000, 8, '2025-02-21 08:49:40');

-- Dumping structure for table ec.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `total_cents` int(11) NOT NULL,
  `delivery_address` varchar(255) DEFAULT NULL,
  `delivery_state_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `estimate_received_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `received_date` timestamp NULL DEFAULT NULL,
  `payment_method` enum('COD','Momo') NOT NULL DEFAULT 'COD',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_delivery_state_id` (`delivery_state_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`delivery_state_id`) REFERENCES `order_delivery_states` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.orders: ~6 rows (approximately)
INSERT INTO `orders` (`id`, `user_id`, `total_cents`, `delivery_address`, `delivery_state_id`, `order_date`, `estimate_received_date`, `received_date`, `payment_method`) VALUES
	(1, 2, 198000, '123 Main St, New York, NY', 1, '2025-02-21 08:49:40', '2025-02-24 17:00:00', NULL, 'COD'),
	(2, 3, 99900, '456 Elm St, Los Angeles, CA', 2, '2025-02-22 03:30:00', '2025-02-25 05:00:00', NULL, 'COD'),
	(3, 1, 79900, '789 Oak St, Chicago, IL', 2, '2025-02-23 07:45:00', '2025-02-26 08:30:00', '2025-02-26 08:00:00', 'COD'),
	(4, 2, 149900, '101 Pine St, Houston, TX', 1, '2025-02-24 02:15:00', '2025-02-27 11:00:00', NULL, 'COD'),
	(5, 3, 59900, '202 Maple St, Miami, FL', 1, '2025-02-25 04:00:00', '2025-02-28 13:00:00', NULL, 'COD'),
	(6, 2, 129900, '303 Birch St, San Francisco, CA', 1, '2025-02-26 09:20:00', '2025-03-01 03:00:00', '2025-03-01 02:30:00', 'COD');

-- Dumping structure for table ec.order_delivery_states
CREATE TABLE IF NOT EXISTS `order_delivery_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(155) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.order_delivery_states: ~2 rows (approximately)
INSERT INTO `order_delivery_states` (`id`, `name`) VALUES
	(2, 'Approved'),
	(1, 'Pending');

-- Dumping structure for table ec.order_items
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_instance_sku` varchar(255) NOT NULL,
  `price_cents` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_product_instance_sku` (`product_instance_sku`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_instance_sku`) REFERENCES `product_instances` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.order_items: ~6 rows (approximately)
INSERT INTO `order_items` (`id`, `order_id`, `product_instance_sku`, `price_cents`) VALUES
	(1, 1, 'SW-APL-S8-45-BLK-SIL', 49900),
	(6, 2, 'SW-SAM-GW5-44-SLV-BLU', 99900),
	(7, 3, 'SW-GAR-F7-47-BLK-GRY', 79900),
	(8, 1, 'SW-APL-S8-41-GLD-PNK', 149900),
	(9, 5, 'SW-SAM-GW5-40-BLK-WHT', 59900),
	(10, 6, 'SW-GAR-F7-51-TIT-BLK', 129900);

-- Dumping structure for table ec.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_name` varchar(155) NOT NULL,
  `action_code` varchar(155) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `action_name` (`action_name`),
  UNIQUE KEY `action_code` (`action_code`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.permissions: ~32 rows (approximately)
INSERT INTO `permissions` (`id`, `action_name`, `action_code`) VALUES
	(1, 'Create Provider', 'PROVIDER_C'),
	(2, 'Read Provider', 'PROVIDER_R'),
	(3, 'Update Provider', 'PROVIDER_U'),
	(4, 'Delete Provider', 'PROVIDER_D'),
	(37, 'Create Order', 'ORDER_C'),
	(38, 'Read Order', 'ORDER_R'),
	(39, 'Update Order', 'ORDER_U'),
	(40, 'Delete Order', 'ORDER_D'),
	(41, 'Create Permission', 'PERMISSION_C'),
	(42, 'Read Permission', 'PERMISSION_R'),
	(43, 'Update Permission', 'PERMISSION_U'),
	(44, 'Delete Permission', 'PERMISSION_D'),
	(45, 'Create Product', 'PRODUCT_C'),
	(46, 'Read Product', 'PRODUCT_R'),
	(47, 'Update Product', 'PRODUCT_U'),
	(48, 'Delete Product', 'PRODUCT_D'),
	(49, 'Create Category', 'CATEGORY_C'),
	(50, 'Read Category', 'CATEGORY_R'),
	(51, 'Update Category', 'CATEGORY_U'),
	(52, 'Delete Category', 'CATEGORY_D'),
	(53, 'Create Brand', 'BRAND_C'),
	(54, 'Read Brand', 'BRAND_R'),
	(55, 'Update Brand', 'BRAND_U'),
	(56, 'Delete Brand', 'BRAND_D'),
	(57, 'Create OS', 'OS_C'),
	(58, 'Read OS', 'OS_R'),
	(59, 'Update OS', 'OS_U'),
	(60, 'Delete OS', 'OS_D'),
	(65, 'Create Account', 'ACCOUNT_C'),
	(66, 'Read Account', 'ACCOUNT_R'),
	(67, 'Update Account', 'ACCOUNT_U'),
	(69, 'Delete Account', 'ACCOUNT_D');

-- Dumping structure for table ec.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `model` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `stop_selling` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `model` (`model`),
  KEY `idx_name_model` (`name`,`model`),
  KEY `idx_stop_selling` (`stop_selling`),
  KEY `idx_brand_id` (`brand_id`),
  KEY `idx_category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `product_brands` (`id`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.products: ~3 rows (approximately)
INSERT INTO `products` (`id`, `name`, `brand_id`, `model`, `category_id`, `description`, `stop_selling`) VALUES
	(1, 'Apple Watch Series 8', 1, 'S8', 1, 'Latest Apple Watch with advanced health features', 0),
	(2, 'Samsung Galaxy Watch 5', 2, 'GW5', 1, 'Samsung premium smartwatch', 0),
	(3, 'Garmin Fenix 7', 3, 'F7', 1, 'High-end sports smartwatch from Garmin', 0);

-- Dumping structure for table ec.product_brands
CREATE TABLE IF NOT EXISTS `product_brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.product_brands: ~3 rows (approximately)
INSERT INTO `product_brands` (`id`, `name`) VALUES
	(1, 'Apple'),
	(3, 'Garmin'),
	(2, 'Samsung');

-- Dumping structure for table ec.product_categories
CREATE TABLE IF NOT EXISTS `product_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.product_categories: ~2 rows (approximately)
INSERT INTO `product_categories` (`id`, `name`) VALUES
	(2, 'Fitness Tracker'),
	(1, 'Smartwatch');

-- Dumping structure for table ec.product_instances
CREATE TABLE IF NOT EXISTS `product_instances` (
  `sku` varchar(255) NOT NULL,
  `product_variation_id` int(11) NOT NULL,
  `goods_receipt_note_id` int(11) NOT NULL,
  `is_sold` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`sku`),
  KEY `idx_product_variation_id` (`product_variation_id`),
  KEY `idx_is_sold` (`is_sold`),
  KEY `idx_variation_id_is_sold` (`product_variation_id`,`is_sold`),
  KEY `idx_goods_id` (`goods_receipt_note_id`),
  CONSTRAINT `product_instances_ibfk_1` FOREIGN KEY (`product_variation_id`) REFERENCES `product_variations` (`id`),
  CONSTRAINT `product_instances_ibfk_2` FOREIGN KEY (`goods_receipt_note_id`) REFERENCES `goods_receipt_notes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.product_instances: ~7 rows (approximately)
INSERT INTO `product_instances` (`sku`, `product_variation_id`, `goods_receipt_note_id`, `is_sold`) VALUES
	('SW-APL-S8-41-GLD-PNK', 1, 1, 0),
	('SW-APL-S8-45-BLK-SIL', 1, 1, 0),
	('SW-GAR-F7-47-BLK-GRY', 3, 2, 1),
	('SW-GAR-F7-51-TIT-BLK', 3, 2, 0),
	('SW-SAM-GW5-40-BLK-WHT', 2, 2, 0),
	('SW-SAM-GW5-44-SIL', 2, 2, 0),
	('SW-SAM-GW5-44-SLV-BLU', 2, 2, 1);

-- Dumping structure for table ec.product_os
CREATE TABLE IF NOT EXISTS `product_os` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.product_os: ~3 rows (approximately)
INSERT INTO `product_os` (`id`, `name`) VALUES
	(3, 'Garmin OS'),
	(1, 'watchOS'),
	(2, 'Wear OS');

-- Dumping structure for table ec.product_variations
CREATE TABLE IF NOT EXISTS `product_variations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `watch_size_mm` int(11) NOT NULL,
  `watch_color` varchar(155) NOT NULL,
  `stock_quantity` int(11) DEFAULT 0,
  `price_cents` int(11) DEFAULT 0,
  `base_price_cents` int(11) DEFAULT 0,
  `image_name` varchar(255) DEFAULT 'default.webp',
  `display_size_mm` int(11) NOT NULL,
  `display_type` varchar(155) NOT NULL,
  `resolution_h_px` int(11) NOT NULL,
  `resolution_w_px` int(11) NOT NULL,
  `ram_bytes` int(11) DEFAULT NULL,
  `rom_bytes` int(11) DEFAULT NULL,
  `os_id` int(11) NOT NULL,
  `connectivity` varchar(255) NOT NULL,
  `battery_life_mah` int(11) NOT NULL,
  `water_resistance_value` int(11) DEFAULT NULL,
  `water_resistance_unit` varchar(155) DEFAULT NULL,
  `sensor` varchar(155) NOT NULL,
  `case_material` varchar(155) NOT NULL,
  `band_material` varchar(155) NOT NULL,
  `band_size_mm` int(11) NOT NULL,
  `band_color` varchar(155) NOT NULL,
  `weight_milligrams` int(11) NOT NULL,
  `release_date` datetime NOT NULL,
  `stop_selling` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_price_cents` (`price_cents`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_os_id` (`os_id`),
  KEY `idx_stop_selling` (`stop_selling`),
  CONSTRAINT `product_variations_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_variations_ibfk_2` FOREIGN KEY (`os_id`) REFERENCES `product_os` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.product_variations: ~3 rows (approximately)
INSERT INTO `product_variations` (`id`, `product_id`, `watch_size_mm`, `watch_color`, `stock_quantity`, `price_cents`, `base_price_cents`, `image_name`, `display_size_mm`, `display_type`, `resolution_h_px`, `resolution_w_px`, `ram_bytes`, `rom_bytes`, `os_id`, `connectivity`, `battery_life_mah`, `water_resistance_value`, `water_resistance_unit`, `sensor`, `case_material`, `band_material`, `band_size_mm`, `band_color`, `weight_milligrams`, `release_date`, `stop_selling`) VALUES
	(1, 1, 45, 'Black', 10, 49900, 0, 'cf-xl.webp', 0, '', 0, 0, NULL, NULL, 1, '', 0, NULL, NULL, '', '', '', 0, '', 0, '0000-00-00 00:00:00', 0),
	(2, 2, 44, 'Silver', 8, 39900, 0, 'default.webp', 0, '', 0, 0, NULL, NULL, 2, '', 0, NULL, NULL, '', '', '', 0, '', 0, '0000-00-00 00:00:00', 0),
	(3, 3, 47, 'Gray', 5, 59900, 0, 'default.webp', 0, '', 0, 0, NULL, NULL, 3, '', 0, NULL, NULL, '', '', '', 0, '', 0, '0000-00-00 00:00:00', 0);

-- Dumping structure for table ec.providers
CREATE TABLE IF NOT EXISTS `providers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.providers: ~2 rows (approximately)
INSERT INTO `providers` (`id`, `full_name`, `email`, `phone_number`, `created_at`, `updated_at`) VALUES
	(1, 'Apple Inc.', 'apple@provider.com', '1234567890', '2025-02-21 08:49:40', '2025-02-21 08:49:40'),
	(2, 'Samsung Corp.', 'samsung@provider.com', '0987654321', '2025-02-21 08:49:40', '2025-02-21 08:49:40');

-- Dumping structure for table ec.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(155) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.roles: ~3 rows (approximately)
INSERT INTO `roles` (`id`, `name`) VALUES
	(1, 'Admin'),
	(2, 'Customer'),
	(3, 'Staff');

-- Dumping structure for table ec.role_permissions
CREATE TABLE IF NOT EXISTS `role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.role_permissions: ~4 rows (approximately)
INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
	(1, 1),
	(1, 2),
	(2, 3),
	(3, 60);

-- Dumping structure for table ec.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(155) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.users: ~3 rows (approximately)
INSERT INTO `users` (`id`, `full_name`, `email`, `phone_number`, `password`, `created_at`, `updated_at`) VALUES
	(1, 'Alice Johnson', 'alice@example.com', '1234567890', 'hashed_password1', '2025-02-21 08:49:40', '2025-02-21 08:49:40'),
	(2, 'Bob Smith', 'bob@example.com', '0987654321', 'hashed_password2', '2025-02-21 08:49:40', '2025-02-21 08:49:40'),
	(3, 'Charlie Brown', 'charlie@example.com', '1122334455', 'hashed_password3', '2025-02-21 08:49:40', '2025-02-21 08:49:40');

-- Dumping structure for table ec.user_addresses
CREATE TABLE IF NOT EXISTS `user_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `apartment_number` varchar(155) NOT NULL,
  `ward` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL,
  `city_province` varchar(255) NOT NULL,
  `phone_number` varchar(155) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_user_id_is_default` (`user_id`,`is_default`),
  CONSTRAINT `user_addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.user_addresses: ~1 rows (approximately)
INSERT INTO `user_addresses` (`id`, `user_id`, `name`, `street`, `apartment_number`, `ward`, `district`, `city_province`, `phone_number`, `is_default`) VALUES
	(1, 2, 'Bob Home', '123 Main St', 'Apt 1', 'Ward 5', 'District 1', 'New York', '0987654321', 1);

-- Dumping structure for table ec.user_roles
CREATE TABLE IF NOT EXISTS `user_roles` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table ec.user_roles: ~3 rows (approximately)
INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
	(1, 1),
	(2, 2),
	(3, 3);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
