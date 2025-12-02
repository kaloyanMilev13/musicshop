-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 21, 2025 at 08:23 AM
-- Server version: 12.0.2-MariaDB
-- PHP Version: 8.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `musicshop`
--
CREATE DATABASE IF NOT EXISTS `musicshop` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `musicshop`;

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `product_id`, `created_at`) VALUES
(1, 1, 1, '2025-11-20 16:19:41'),
(3, 1, 2, '2025-11-20 21:58:25');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_email` varchar(190) DEFAULT NULL,
  `customer_phone` varchar(50) DEFAULT NULL,
  `shipping_address` varchar(255) NOT NULL,
  `shipping_city` varchar(100) NOT NULL,
  `shipping_postcode` varchar(20) NOT NULL,
  `shipping_country` varchar(100) NOT NULL,
  `customer_note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total_price`, `customer_name`, `customer_email`, `customer_phone`, `shipping_address`, `shipping_city`, `shipping_postcode`, `shipping_country`, `customer_note`, `created_at`) VALUES
(1, 1, 999.99, 'kaloyan', '', '', 'sofia', 'sofia', '1750', 'bg', '', '2025-11-20 16:21:10');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`) VALUES
(1, 1, 1, 1, 999.99);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `artist` varchar(255) DEFAULT NULL,
  `category` enum('Instruments','Music','Merch','Other') NOT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `format` varchar(50) DEFAULT NULL,
  `music_genre` varchar(100) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `merch_type` varchar(100) DEFAULT NULL,
  `instrument_subtype` varchar(100) DEFAULT NULL,
  `accessory_type` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `artist`, `category`, `genre`, `price`, `stock`, `description`, `image_url`, `format`, `music_genre`, `size`, `color`, `merch_type`, `instrument_subtype`, `accessory_type`, `created_at`, `updated_at`) VALUES
(1, 'Fender Stratocaster', 'Fender', 'Instruments', 'Guitars', 999.99, 5, 'Legendary electric guitar with classic single-coil tones.', 'images/strat.jpg', NULL, NULL, NULL, 'Sunburst', NULL, 'Electric Guitar', NULL, '2025-11-20 16:19:14', NULL),
(2, 'Gibson Les Paul Standard', 'Gibson', 'Instruments', 'Guitars', 1499.00, 3, 'Iconic rock guitar with thick, warm tone.', 'images/lespaul.jpg', NULL, NULL, NULL, 'Cherry', NULL, 'Electric Guitar', NULL, '2025-11-20 16:19:14', NULL),
(3, 'Yamaha P-45 Digital Piano', 'Yamaha', 'Instruments', 'Keyboards', 499.00, 7, '88-key digital piano with weighted action.', 'images/p45.jpg', NULL, NULL, NULL, 'Black', NULL, 'Piano', NULL, '2025-11-20 16:19:14', NULL),
(4, 'Pearl Drum Kit EXX725S', 'Pearl', 'Instruments', 'Drums', 799.00, 2, 'Complete drum kit perfect for beginners and advanced players.', 'images/drumkit.jpg', NULL, NULL, NULL, 'Black', NULL, 'Drum Set', NULL, '2025-11-20 16:19:14', NULL),
(5, 'Boss DS-1 Distortion Pedal', 'Boss', 'Instruments', 'Effects', 59.00, 20, 'Classic distortion pedal used by thousands of guitarists.', 'images/ds1.jpg', NULL, NULL, NULL, 'Orange', NULL, 'Guitar Pedal', 'Effect', '2025-11-20 16:19:14', NULL),
(6, 'Pink Floyd - The Wall', 'Pink Floyd', 'Music', '', 29.99, 15, 'Classic double album from Pink Floyd.', 'images/thewall.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2025-11-20 16:32:13'),
(7, 'Metallica - Black Album', 'Metallica', 'Music', 'Vinyl', 24.99, 12, 'Heavy metal classic with hits like Enter Sandman.', 'images/blackalbum.jpg', 'Vinyl', 'Metal', NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', NULL),
(8, 'Taylor Swift - Midnights', 'Taylor Swift', 'Music', 'CD', 14.99, 10, 'Pop album from Taylor Swift.', 'images/midnights.jpg', 'CD', 'Pop', NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', NULL),
(9, 'Eminem - Curtain Call', 'Eminem', 'Music', 'CD', 13.49, 18, 'Greatest hits collection.', 'images/curtaincall.jpg', 'CD', 'Hip-Hop', NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', NULL),
(10, 'Beethoven - Symphony No.9', 'Beethoven', 'Music', 'Vinyl', 19.99, 8, 'Classical masterpiece on high-quality vinyl.', 'images/beethoven9.jpg', 'Vinyl', 'Classical', NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', NULL),
(11, 'MusicShop T-Shirt', NULL, 'Merch', 'Clothing', 19.99, 30, 'Soft cotton T-shirt with MusicShop logo.', 'images/tshirt.jpg', NULL, NULL, 'L', 'Black', 'T-Shirt', NULL, NULL, '2025-11-20 16:19:14', NULL),
(12, 'Metallica Hoodie', 'Metallica', 'Merch', 'Clothing', 49.99, 12, 'Official Metallica merchandise hoodie.', 'images/hoodie.jpg', NULL, NULL, 'XL', 'Black', 'Hoodie', NULL, NULL, '2025-11-20 16:19:14', NULL),
(13, 'Pink Floyd Mug', 'Pink Floyd', 'Merch', 'Accessories', 9.99, 25, 'Ceramic mug with The Wall artwork.', 'images/mug.jpg', NULL, NULL, NULL, 'White', 'Mug', NULL, NULL, '2025-11-20 16:19:14', NULL),
(14, 'AC/DC Keychain', 'AC/DC', 'Merch', 'Accessories', 4.99, 50, 'High quality band logo keychain.', 'images/keychain.jpg', NULL, NULL, NULL, 'Silver', 'Keychain', NULL, NULL, '2025-11-20 16:19:14', NULL),
(15, 'Nirvana Cap', 'Nirvana', 'Merch', 'Clothing', 24.99, 14, 'Adjustable black cap with iconic smiley face.', 'images/cap.jpg', NULL, NULL, 'M', 'Black', 'Cap', NULL, NULL, '2025-11-20 16:19:14', NULL),
(16, 'Guitar Stand', NULL, 'Other', 'Accessories', 15.99, 40, 'Universal stand for acoustic and electric guitars.', 'images/stand.jpg', NULL, NULL, NULL, 'Black', NULL, NULL, 'Stand', '2025-11-20 16:19:14', NULL),
(17, 'Instrument Cable 3m', NULL, 'Other', 'Cables', 9.99, 60, 'Durable 3-meter jack cable.', 'images/cable.jpg', NULL, NULL, NULL, 'Black', NULL, NULL, 'Cable', '2025-11-20 16:19:14', NULL),
(18, 'Microphone Pop Filter', NULL, 'Other', 'Accessories', 12.99, 22, 'Perfect for home recording studios.', 'images/popfilter.jpg', NULL, NULL, NULL, 'Black', NULL, NULL, 'Pop Filter', '2025-11-20 16:19:14', NULL),
(19, 'Studio Headphones', NULL, 'Other', 'Audio', 89.99, 10, 'Closed-back monitoring headphones.', 'images/headphones.jpg', NULL, NULL, NULL, 'Black', NULL, NULL, 'Headphones', '2025-11-20 16:19:14', NULL),
(20, 'USB Audio Interface', NULL, 'Other', 'Recording', 129.99, 6, '2-input USB audio interface for home studios.', 'images/interface.jpg', NULL, NULL, NULL, 'Red', NULL, NULL, 'Interface', '2025-11-20 16:19:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `role`, `is_admin`, `created_at`) VALUES
(1, 'admin', 'admin@shop.com', '$2y$12$x9AbPXrgAeYICKd4rAOZgO3auA8Ai2yVoF/Vj6s4zHQlJAcMRGPoO', 'admin', 0, '2025-11-20 16:04:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_favorites_user_product` (`user_id`,`product_id`),
  ADD KEY `idx_favorites_user` (`user_id`),
  ADD KEY `idx_favorites_product` (`product_id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_orders_user` (`user_id`),
  ADD KEY `idx_orders_created_at` (`created_at`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_items_order` (`order_id`),
  ADD KEY `idx_order_items_product` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_products_category` (`category`),
  ADD KEY `idx_products_genre` (`genre`),
  ADD KEY `idx_products_music_genre` (`music_genre`);
ALTER TABLE `products` ADD FULLTEXT KEY `ft_products_search` (`name`,`artist`,`description`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD UNIQUE KEY `uq_users_username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `fk_favorites_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_favorites_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
