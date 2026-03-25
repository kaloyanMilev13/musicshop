-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 18, 2026 at 06:32 AM
-- Server version: 12.2.2-MariaDB
-- PHP Version: 8.5.3

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
(3, 1, 2, '2025-11-20 21:58:25'),
(6, 1, 1, '2025-12-11 14:54:32'),
(7, 1, 3, '2025-12-11 14:54:58'),
(8, 1, 10, '2026-02-11 06:10:28'),
(9, 2, 1, '2026-02-18 07:56:50'),
(10, 2, 2, '2026-02-18 07:56:57'),
(11, 1, 23, '2026-02-21 08:18:12');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `title`, `content`, `image_url`, `created_at`) VALUES
(1, 'sdqwwc', 'dc', NULL, '2025-11-27 08:16:54'),
(2, 'ciac', 'jfewioco', NULL, '2025-11-27 08:17:05'),
(6, 'Robbie Williams teases future reunion with Take That: “I’m sure we will ride again”', 'Robbie Williams played his smallest-ever ticketed show in London last night, where he ran through his debut album in full, as well as performing his upcoming record ‘BRITPOP’ in its entirety. Check out photos and the full setlist below, along with everything that went down.\n\nThe solo icon and former Take That member took to the stage at the 500-capacity venue Dingwalls in Camden Town just before 11pm with a mammoth two-hour set, bookending his almost three-decade career. He told many a tale behind the tunes, and revealed how some of his heroes had influenced his new material – with the odd dig at some music biz rivals thrown in.\n\nThe phone-free gig had been announced to celebrate the release of the 90s-inspired ‘BRITPOP’, which was initially set to arrive today (Friday October 10). However, the LP was recently delayed until early 2026 due to “scheduling issues”. “We’re all pretending it’s not about Taylor Swift, but it fucking is,” Williams told the crowd.\n\n“Here’s the truth: I want 16 Number One albums. Taylor then decided to put her album out the same weekend as me. I was like, ‘For fuck’s sake! I’ll put it out the next week’, and they were like, ‘She does these other deluxe versions’. I was like, ‘Fucking hell! Can I put it out the week after that then?’ They were like, ‘Oasis might be around then’… ‘For fuck’s sake! Let’s do it in fucking February when no one’s got an album out’.”\n\nHe continued: “I was worried about making you all fucking wait, and then I was like, ‘Fuck it! I want a 16th Number One album!’ I’m sorry, but I’m fucking being selfish. How many times in your life do you get to have the most Number One albums the UK’s ever fucking had?”\n\nBefore Williams jumped into ‘BRITPOP’, he ran through his 1997 first LP ‘Life Thru A Lens’ front to back. He arrived on stage donning the iconic red Adidas tracksuit jacket he wore at Glastonbury 1995 – a photo from which appears on the cover of his forthcoming full-length. This image was also projected onto the side of Dingwalls as fans queued outside. Some attendees wore the same jacket in homage, while others sported Williams-branded football shirts.', NULL, '2026-01-13 09:57:24'),
(7, 'nowina test 1', 'nowina iwnqcasndc  aifsv ii os afsvoijsdvio uidfvn odfn i vnfo s nowina iwnqcasndc  aifsv ii os afsvoijsdvio uidfvn odfn i vnfo snowina iwnqcasndc  aifsv ii os afsvoijsdvio uidfvn odfn i vnfo snowina iwnqcasndc  aifsv ii os afsvoijsdvio uidfvn odfn i vnfo snowina iwnqcasndc  aifsv ii os afsvoijsdvio uidfvn odfn i vnfo s', NULL, '2026-01-13 09:58:47');

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
(1, 1, 999.99, 'kaloyan', '', '', 'sofia', 'sofia', '1750', 'bg', '', '2025-11-20 16:21:10'),
(2, 1, 1541.97, 'kaloyan', 'kala@abv.gb', '', 'mladost', 'sofia', '1740', 'bg', 'helo hi fries', '2025-11-25 08:18:09'),
(4, 2, 2498.99, 'Kaloyan Milev', 'kala@gmail.com', '0878594004', 'Mladost 1', 'Sofia', '1750', 'Other', 'cniocosid', '2026-02-18 06:19:14');

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
(1, 1, 1, 1, 999.99),
(2, 2, 9, 2, 13.49),
(3, 2, 16, 1, 15.99),
(4, 2, 2, 1, 1499.00),
(6, 4, 1, 1, 999.99),
(7, 4, 2, 1, 1499.00);

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
(1, 'Fender Stratocaster', 'Fender', 'Instruments', 'Guitars', 999.99, 6, 'Legendary electric guitar with classic single-coil tones.', 'images/strat.jpg', NULL, NULL, NULL, NULL, NULL, 'Electric', NULL, '2025-11-20 16:19:14', '2026-01-06 08:47:54'),
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
(17, 'Instrument Cable 3m', '', 'Other', 'Cables', 9.99, 60, 'Durable 3-meter jack cable.', 'images/cable.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2025-11-27 08:49:19'),
(18, 'Microphone Pop Filter', NULL, 'Other', 'Accessories', 12.99, 22, 'Perfect for home recording studios.', 'images/popfilter.jpg', NULL, NULL, NULL, 'Black', NULL, NULL, 'Pop Filter', '2025-11-20 16:19:14', NULL),
(19, 'Studio Headphones', NULL, 'Other', 'Audio', 89.99, 10, 'Closed-back monitoring headphones.', 'images/headphones.jpg', NULL, NULL, NULL, 'Black', NULL, NULL, 'Headphones', '2025-11-20 16:19:14', NULL),
(20, 'USB Audio Interface', NULL, 'Other', 'Recording', 129.99, 6, '2-input USB audio interface for home studios.', 'images/interface.jpg', NULL, NULL, NULL, 'Red', NULL, NULL, 'Interface', '2025-11-20 16:19:14', NULL),
(21, 'test product za id page', '', 'Instruments', 'Basses', 20.00, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-13 09:02:57', NULL),
(22, 'Akustichna kitara', '', 'Instruments', 'Guitars', 20.00, 5, 'snimkata e online url', 'https://images.squarespace-cdn.com/content/v1/57f5648637c581229b2e436f/1561988003374-K92XU2EQFH13QJOPOMU2/80-front.jpg?format=500w', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-13 10:01:59', '2026-01-13 10:03:19'),
(23, 'elektricheska kitara', '', 'Instruments', 'Guitars', 4000.00, 0, 'snimkata e ot lokalna papka w proekta', 'images/elektricheska_kitara.jpg', NULL, NULL, NULL, NULL, NULL, 'Electric', NULL, '2026-01-13 10:05:22', NULL);

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
(1, 'admin', 'admin@shop.com', '$2y$12$x9AbPXrgAeYICKd4rAOZgO3auA8Ai2yVoF/Vj6s4zHQlJAcMRGPoO', 'admin', 0, '2025-11-20 16:04:39'),
(2, 'kala', 'kala@abv.bg', '$2y$12$TAnrw17/qRAAywcS52D/dOmmJsWG.OqVxEOOHHw3waHfrJWb8LkrK', 'user', 0, '2025-12-23 07:13:00'),
(3, 'Kaloyan', 'kaloyan@abv.bg', '$2y$12$4JF8cmyBPw0g31suYZaE3O8fPDeBXgNR.lvj5tXOoS882p48LH83G', 'user', 0, '2026-03-09 10:37:09');

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
