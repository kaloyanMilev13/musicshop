/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.1.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: musicshop
-- ------------------------------------------------------
-- Server version	12.1.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Current Database: `musicshop`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `musicshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `musicshop`;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_favorites_user_product` (`user_id`,`product_id`),
  KEY `idx_favorites_user` (`user_id`),
  KEY `idx_favorites_product` (`product_id`),
  CONSTRAINT `fk_favorites_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_favorites_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `favorites` VALUES
(3,1,2,'2025-11-20 21:58:25'),
(5,1,14,'2025-11-25 11:37:44'),
(6,1,1,'2025-12-11 14:54:32'),
(7,1,3,'2025-12-11 14:54:58');
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `news` VALUES
(1,'sdqwwc','dc','2025-11-27 08:16:54'),
(2,'ciac','jfewioco','2025-11-27 08:17:05');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_items_order` (`order_id`),
  KEY `idx_order_items_product` (`product_id`),
  CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `order_items` VALUES
(1,1,1,1,999.99),
(2,2,9,2,13.49),
(3,2,16,1,15.99),
(4,2,2,1,1499.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_email` varchar(190) DEFAULT NULL,
  `customer_phone` varchar(50) DEFAULT NULL,
  `shipping_address` varchar(255) NOT NULL,
  `shipping_city` varchar(100) NOT NULL,
  `shipping_postcode` varchar(20) NOT NULL,
  `shipping_country` varchar(100) NOT NULL,
  `customer_note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_orders_user` (`user_id`),
  KEY `idx_orders_created_at` (`created_at`),
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `orders` VALUES
(1,1,999.99,'kaloyan','','','sofia','sofia','1750','bg','','2025-11-20 16:21:10'),
(2,1,1541.97,'kaloyan','kala@abv.gb','','mladost','sofia','1740','bg','helo hi fries','2025-11-25 08:18:09');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_products_category` (`category`),
  KEY `idx_products_genre` (`genre`),
  KEY `idx_products_music_genre` (`music_genre`),
  FULLTEXT KEY `ft_products_search` (`name`,`artist`,`description`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `products` VALUES
(1,'Fender Stratocaster','Fender','Instruments','Guitars',999.99,6,'Legendary electric guitar with classic single-coil tones.','images/strat.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-20 16:19:14','2025-11-26 10:17:04'),
(2,'Gibson Les Paul Standard','Gibson','Instruments','Guitars',1499.00,3,'Iconic rock guitar with thick, warm tone.','images/lespaul.jpg',NULL,NULL,NULL,'Cherry',NULL,'Electric Guitar',NULL,'2025-11-20 16:19:14',NULL),
(3,'Yamaha P-45 Digital Piano','Yamaha','Instruments','Keyboards',499.00,7,'88-key digital piano with weighted action.','images/p45.jpg',NULL,NULL,NULL,'Black',NULL,'Piano',NULL,'2025-11-20 16:19:14',NULL),
(4,'Pearl Drum Kit EXX725S','Pearl','Instruments','Drums',799.00,2,'Complete drum kit perfect for beginners and advanced players.','images/drumkit.jpg',NULL,NULL,NULL,'Black',NULL,'Drum Set',NULL,'2025-11-20 16:19:14',NULL),
(5,'Boss DS-1 Distortion Pedal','Boss','Instruments','Effects',59.00,20,'Classic distortion pedal used by thousands of guitarists.','images/ds1.jpg',NULL,NULL,NULL,'Orange',NULL,'Guitar Pedal','Effect','2025-11-20 16:19:14',NULL),
(6,'Pink Floyd - The Wall','Pink Floyd','Music','',29.99,15,'Classic double album from Pink Floyd.','images/thewall.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-20 16:19:14','2025-11-20 16:32:13'),
(7,'Metallica - Black Album','Metallica','Music','Vinyl',24.99,12,'Heavy metal classic with hits like Enter Sandman.','images/blackalbum.jpg','Vinyl','Metal',NULL,NULL,NULL,NULL,NULL,'2025-11-20 16:19:14',NULL),
(8,'Taylor Swift - Midnights','Taylor Swift','Music','CD',14.99,10,'Pop album from Taylor Swift.','images/midnights.jpg','CD','Pop',NULL,NULL,NULL,NULL,NULL,'2025-11-20 16:19:14',NULL),
(9,'Eminem - Curtain Call','Eminem','Music','CD',13.49,18,'Greatest hits collection.','images/curtaincall.jpg','CD','Hip-Hop',NULL,NULL,NULL,NULL,NULL,'2025-11-20 16:19:14',NULL),
(10,'Beethoven - Symphony No.9','Beethoven','Music','Vinyl',19.99,8,'Classical masterpiece on high-quality vinyl.','images/beethoven9.jpg','Vinyl','Classical',NULL,NULL,NULL,NULL,NULL,'2025-11-20 16:19:14',NULL),
(11,'MusicShop T-Shirt',NULL,'Merch','Clothing',19.99,30,'Soft cotton T-shirt with MusicShop logo.','images/tshirt.jpg',NULL,NULL,'L','Black','T-Shirt',NULL,NULL,'2025-11-20 16:19:14',NULL),
(12,'Metallica Hoodie','Metallica','Merch','Clothing',49.99,12,'Official Metallica merchandise hoodie.','images/hoodie.jpg',NULL,NULL,'XL','Black','Hoodie',NULL,NULL,'2025-11-20 16:19:14',NULL),
(13,'Pink Floyd Mug','Pink Floyd','Merch','Accessories',9.99,25,'Ceramic mug with The Wall artwork.','images/mug.jpg',NULL,NULL,NULL,'White','Mug',NULL,NULL,'2025-11-20 16:19:14',NULL),
(14,'AC/DC Keychain','AC/DC','Merch','Accessories',4.99,50,'High quality band logo keychain.','images/keychain.jpg',NULL,NULL,NULL,'Silver','Keychain',NULL,NULL,'2025-11-20 16:19:14',NULL),
(15,'Nirvana Cap','Nirvana','Merch','Clothing',24.99,14,'Adjustable black cap with iconic smiley face.','images/cap.jpg',NULL,NULL,'M','Black','Cap',NULL,NULL,'2025-11-20 16:19:14',NULL),
(16,'Guitar Stand',NULL,'Other','Accessories',15.99,40,'Universal stand for acoustic and electric guitars.','images/stand.jpg',NULL,NULL,NULL,'Black',NULL,NULL,'Stand','2025-11-20 16:19:14',NULL),
(17,'Instrument Cable 3m','','Other','Cables',9.99,60,'Durable 3-meter jack cable.','images/cable.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-20 16:19:14','2025-11-27 08:49:19'),
(18,'Microphone Pop Filter',NULL,'Other','Accessories',12.99,22,'Perfect for home recording studios.','images/popfilter.jpg',NULL,NULL,NULL,'Black',NULL,NULL,'Pop Filter','2025-11-20 16:19:14',NULL),
(19,'Studio Headphones',NULL,'Other','Audio',89.99,10,'Closed-back monitoring headphones.','images/headphones.jpg',NULL,NULL,NULL,'Black',NULL,NULL,'Headphones','2025-11-20 16:19:14',NULL),
(20,'USB Audio Interface',NULL,'Other','Recording',129.99,6,'2-input USB audio interface for home studios.','images/interface.jpg',NULL,NULL,NULL,'Red',NULL,NULL,'Interface','2025-11-20 16:19:14',NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_email` (`email`),
  UNIQUE KEY `uq_users_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES
(1,'admin','admin@shop.com','$2y$12$x9AbPXrgAeYICKd4rAOZgO3auA8Ai2yVoF/Vj6s4zHQlJAcMRGPoO','admin',0,'2025-11-20 16:04:39');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-12-16 15:25:04
