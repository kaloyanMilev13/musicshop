-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 23, 2026 at 09:27 AM
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
  `subtitle` varchar(255) DEFAULT NULL,
  `content` text NOT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `title`, `subtitle`, `content`, `image_url`, `created_at`) VALUES
(1, 'sdqwwc', NULL, 'dc', NULL, '2025-11-27 08:16:54'),
(2, 'ciac', NULL, 'jfewioco', NULL, '2025-11-27 08:17:05'),
(6, 'Robbie Williams teases future reunion with Take That: “I’m sure we will ride again”', NULL, 'Robbie Williams played his smallest-ever ticketed show in London last night, where he ran through his debut album in full, as well as performing his upcoming record ‘BRITPOP’ in its entirety. Check out photos and the full setlist below, along with everything that went down.\n\nThe solo icon and former Take That member took to the stage at the 500-capacity venue Dingwalls in Camden Town just before 11pm with a mammoth two-hour set, bookending his almost three-decade career. He told many a tale behind the tunes, and revealed how some of his heroes had influenced his new material – with the odd dig at some music biz rivals thrown in.\n\nThe phone-free gig had been announced to celebrate the release of the 90s-inspired ‘BRITPOP’, which was initially set to arrive today (Friday October 10). However, the LP was recently delayed until early 2026 due to “scheduling issues”. “We’re all pretending it’s not about Taylor Swift, but it fucking is,” Williams told the crowd.\n\n“Here’s the truth: I want 16 Number One albums. Taylor then decided to put her album out the same weekend as me. I was like, ‘For fuck’s sake! I’ll put it out the next week’, and they were like, ‘She does these other deluxe versions’. I was like, ‘Fucking hell! Can I put it out the week after that then?’ They were like, ‘Oasis might be around then’… ‘For fuck’s sake! Let’s do it in fucking February when no one’s got an album out’.”\n\nHe continued: “I was worried about making you all fucking wait, and then I was like, ‘Fuck it! I want a 16th Number One album!’ I’m sorry, but I’m fucking being selfish. How many times in your life do you get to have the most Number One albums the UK’s ever fucking had?”\n\nBefore Williams jumped into ‘BRITPOP’, he ran through his 1997 first LP ‘Life Thru A Lens’ front to back. He arrived on stage donning the iconic red Adidas tracksuit jacket he wore at Glastonbury 1995 – a photo from which appears on the cover of his forthcoming full-length. This image was also projected onto the side of Dingwalls as fans queued outside. Some attendees wore the same jacket in homage, while others sported Williams-branded football shirts.', NULL, '2026-01-13 09:57:24'),
(7, 'nowina test 1', NULL, 'nowina iwnqcasndc  aifsv ii os afsvoijsdvio uidfvn odfn i vnfo s nowina iwnqcasndc  aifsv ii os afsvoijsdvio uidfvn odfn i vnfo snowina iwnqcasndc  aifsv ii os afsvoijsdvio uidfvn odfn i vnfo snowina iwnqcasndc  aifsv ii os afsvoijsdvio uidfvn odfn i vnfo snowina iwnqcasndc  aifsv ii os afsvoijsdvio uidfvn odfn i vnfo s', NULL, '2026-01-13 09:58:47');

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
(1, 'Fender Stratocaster', 'Fender', 'Instruments', 'Guitars', 999.99, 6, 'Fender Stratocaster е електрическа китара, която от десетилетия задава стандарта за удобство, гъвкав тон и разпознаваем външен вид. Този модел е предпочитан както от начинаещи, които търсят надежден инструмент за първите си уроци и репетиции, така и от опитни музиканти, които искат ясна атака, добра динамика и усещане за прецизен контрол при всяко докосване на струните. Ергономичното тяло стои удобно както в седнало, така и в изправено свирене, а грифът позволява плавно движение по целия диапазон, което е важно при ритъм партии, сола и импровизации. Характерният звук е ясен, отворен и добре артикулиран, което прави Stratocaster подходящ за рок, блус, фънк, поп и алтернативна музика. Инструментът реагира отлично както на чист канал, така и на овърдрайв, като запазва отчетливост и характер дори в по-плътни миксове. Това е китара, с която можеш да репетираш у дома, да записваш в студио и да излизаш на сцена с увереност. Ако търсиш класически дизайн, удобство при дълго свирене и звук, който остава актуален независимо от стила, Fender Stratocaster е сигурен избор с истинска музикална стойност. Подходяща е за музиканти, които ценят баланс между традиция и универсалност, защото позволява лесно да изградиш собствен почерк и да се чувстваш естествено във всяка репетиционна, клуб или студио. Това е модел, който вдъхва увереност още от първото хващане.', 'images/strat.jpg', NULL, NULL, NULL, NULL, NULL, 'Електрически', NULL, '2025-11-20 16:19:14', '2026-03-23 09:10:14'),
(2, 'Gibson Les Paul Standard', 'Gibson', 'Instruments', 'Guitars', 1499.00, 3, 'Gibson Les Paul Standard е модел, който носи усещане за масивен тон, стабилност и силно сценично присъствие още от първия акорд. Това е китара, създадена за музиканти, които искат плътен звук с дълъг сустейн, богати среди и гладка реакция както при ритъм свирене, така и при изразителни сола. Формата и конструкцията вдъхват усещане за сериозен инструмент, а грифът е удобен за сигурен захват, прецизни преходи и уверен контрол върху динамиката. Les Paul Standard се справя еднакво добре с класически рок, хард рок, блус, метъл и модерни продукции, където е нужен по-дебел и наситен тон. На чист канал китарата звучи топло и обемно, а при усилване разгръща характерната си сила без да губи яснота в отделните ноти. Това я прави отличен избор за студийна работа, репетиции и живи участия, при които всеки детайл в звука има значение. Визията също е част от нейния чар, защото съчетава традиция, класа и незабавно разпознаваем стил. Ако търсиш инструмент с характер, тежест в тона и усещане за професионално ниво, Gibson Les Paul Standard остава една от най-уважаваните китари в историята на съвременната музика. Това е избор за музиканти, които не искат просто добра китара, а инструмент с авторитетен глас, плътно присъствие в микса и усещане за истинска сценична тежест. Подходяща е и за записи, в които се търси силен, запомнящ се характер.', 'images/lespaul.jpg', NULL, NULL, NULL, 'Cherry', NULL, 'Electric Guitar', NULL, '2025-11-20 16:19:14', NULL),
(3, 'Yamaha P-45 Digital Piano', 'Yamaha', 'Instruments', 'Keyboards', 499.00, 7, 'Yamaha P-45 Digital Piano е практично и музикално решение за всеки, който иска усещане, близко до акустично пиано, без да прави компромис с удобството на съвременния дигитален инструмент. Моделът разполага с 88 клавиша и балансирано поведение, което подпомага правилната техника, развива контрола върху динамиката и прави упражненията по-естествени както за начинаещи, така и за напреднали пианисти. Звукът е чист, ясен и приятен за продължително свирене, независимо дали използваш инструмента за домашна практика, уроци, композиция или малки сценични участия. Компактният корпус позволява лесно разполагане в апартамент, учебна стая или студио, а семплият интерфейс прави работата с пианото интуитивна още от първото включване. Yamaha P-45 е подходящ избор за хора, които търсят надежден инструмент за ежедневни упражнения, защото съчетава стабилно усещане под пръстите, приятен тон и функционалност без излишно усложняване. Може да се използва със слушалки за тиха практика, което е голямо предимство в домашна среда, а лекотата при пренасяне го прави удобен и за преподаватели или музиканти в движение. Това е дигитално пиано, което поставя фокус върху най-важното: добра клавиатура, музикален звук и уверен комфорт при всяко свирене. Подходящо е и за хора, които преминават от синтезатор към по-сериозно обучение по пиано и имат нужда от инструмент, който насърчава правилни навици още от самото начало.', 'images/p45.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 09:00:21'),
(4, 'Pearl Drum Kit EXX725S', 'Pearl', 'Instruments', 'Drums', 799.00, 2, 'Complete drum kit perfect for beginners and advanced players.', 'images/drumkit.jpg', NULL, NULL, NULL, NULL, NULL, 'Акустичен', NULL, '2025-11-20 16:19:14', '2026-03-23 09:00:41'),
(5, 'Boss DS-1 Distortion Pedal', 'Boss', 'Instruments', 'Effects', 59.00, 20, 'Classic distortion pedal that delivers bright attack, long sustain and the unmistakable DS-1 character.', 'images/ds1.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 09:00:54'),
(6, 'Pink Floyd - The Wall', 'Pink Floyd', 'Music', 'Vinyl', 29.99, 15, 'Classic double album from Pink Floyd.', 'images/thewall.jpg', NULL, 'Рок', NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 09:09:26'),
(7, 'Metallica - Black Album', 'Metallica', 'Music', 'Vinyl', 24.99, 12, 'Heavy metal classic with hits like Enter Sandman.', 'images/blackalbum.jpg', NULL, 'Метъл', NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 09:11:45'),
(8, 'Taylor Swift - Midnights', 'Taylor Swift', 'Music', 'CD', 14.99, 10, 'Pop album from Taylor Swift.', 'images/midnights.jpg', NULL, 'Поп', NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 09:13:43'),
(9, 'Eminem - Curtain Call', 'Eminem', 'Music', 'CD', 13.49, 18, 'Greatest hits collection.', 'images/curtaincall.jpg', NULL, 'Хип-Хоп', NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 09:12:27'),
(10, 'Beethoven - Symphony No.9', 'Beethoven', 'Music', 'Vinyl', 19.99, 8, 'Beethoven - Symphony No.9 е издание, което носи величието на едно от най-влиятелните произведения в историята на класическата музика. Деветата симфония впечатлява с мащаб, драматично развитие и емоционален заряд, който остава еднакво силен както при първо слушане, така и при многократно връщане към отделните части. Още от началото произведението изгражда усещане за движение и напрежение, а финалът с Одата на радостта превръща записа в истинско културно преживяване, познато далеч извън концертната зала. Това винилово издание е подходящо както за колекционери, така и за слушатели, които искат да добавят в своята музикална библиотека класика с доказана художествена стойност. Форматът на плоча допринася за по-специален ритуал при слушане и насърчава внимателното потапяне в богатата оркестрация, хоровите моменти и контраста между тишина, драматизъм и тържественост. Албумът е отличен избор за спокойни вечери, за фокусирано слушане у дома или като подарък за човек с интерес към класическата традиция. Ако търсиш произведение, което съчетава историческо значение, силна емоция и музикална дълбочина, Beethoven - Symphony No.9 е заглавие, което заслужава постоянно място във всяка сериозна колекция. Това е запис, към който човек може да се връща отново и отново, откривайки нови детайли в темите, оркестъра и силата на човешкия глас. Всяко следващо слушане носи нов пласт смисъл.', 'images/beethoven9.jpg', NULL, 'Класически', NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 09:13:05'),
(11, 'MusicShop T-Shirt', NULL, 'Merch', 'Clothing', 19.99, 30, 'Soft cotton T-shirt with MusicShop logo.', 'images/tshirt.jpg', NULL, NULL, 'L', 'Black', 'T-Shirt', NULL, NULL, '2025-11-20 16:19:14', NULL),
(12, 'Metallica Hoodie', 'Metallica', 'Merch', 'Clothing', 49.99, 12, 'Official Metallica merchandise hoodie.', 'images/hoodie.jpg', NULL, NULL, 'S, M, L', 'Черен', 'Худи', NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 09:03:25'),
(13, 'Pink Floyd Mug', 'Pink Floyd', 'Merch', 'Drinkware', 9.99, 25, 'Ceramic mug with Dark Side Of The Moon artwork.', 'images/mug.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 08:39:33'),
(14, 'AC/DC Keychain', 'AC/DC', 'Merch', 'Other', 4.99, 50, 'High quality band logo keychain.', 'images/keychain.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 09:03:52'),
(15, 'Nirvana Cap', 'Nirvana', 'Merch', 'Clothing', 24.99, 14, 'Adjustable black cap with iconic smiley face.', 'images/cap.jpg', NULL, NULL, 'All-Size', 'Черен', 'Шапка', NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 09:04:23'),
(16, 'Guitar Stand', '', 'Other', 'Stands', 15.99, 40, 'Universal stand for acoustic and electric guitars.', 'images/stand.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-20 16:19:14', '2026-03-23 09:05:29'),
(17, 'Instrument Cable 3m', '', 'Other', 'Cables', 9.99, 60, 'Durable 3-meter jack cable.', 'images/cable.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 'JACK - JACK', '2025-11-20 16:19:14', '2026-03-23 09:05:08'),
(18, 'Microphone Pop Filter', '', 'Other', 'Accessories', 12.99, 22, 'Perfect for home recording studios.', 'images/popfilter.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 'Поп-филтри', '2025-11-20 16:19:14', '2026-03-23 09:05:52'),
(19, 'Studio Headphones', '', 'Other', 'Audio', 89.99, 10, 'Closed-back monitoring headphones.', 'images/headphones.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 'Closed-Back', '2025-11-20 16:19:14', '2026-03-23 09:06:36'),
(20, 'USB Audio Interface', 'Focusrite', 'Other', 'Recording', 129.99, 6, '2-input USB audio interface for home studios.', 'images/interface.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 'Audio Interface', '2025-11-20 16:19:14', '2026-03-23 09:07:10'),
(21, 'Ibanez GSR200 Bass', 'Ibanez', 'Instruments', 'Basses', 269.00, 3, 'Affordable 4-string bass with comfortable neck, punchy tone and versatile controls for beginners and bands.', 'images/placeholder.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-13 09:02:57', NULL),
(22, 'Akustichna kitara', '', 'Instruments', 'Guitars', 20.00, 5, 'snimkata e online url', 'https://images.squarespace-cdn.com/content/v1/57f5648637c581229b2e436f/1561988003374-K92XU2EQFH13QJOPOMU2/80-front.jpg?format=500w', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-13 10:01:59', '2026-01-13 10:03:19'),
(23, 'elektricheska kitara', '', 'Instruments', 'Guitars', 4000.00, 0, 'snimkata e ot lokalna papka w proekta', 'images/elektricheska_kitara.jpg', NULL, NULL, NULL, NULL, NULL, 'Electric', NULL, '2026-01-13 10:05:22', NULL),
(24, 'Focusrite Scarlett Solo Studio Pack', 'Focusrite', 'Instruments', 'Studio', 249.00, 5, 'Compact home studio bundle with audio interface, condenser microphone and headphones for recording vocals and instruments.', 'images/interface.jpg', NULL, NULL, NULL, 'Red', NULL, NULL, NULL, '2026-03-23 11:00:00', NULL),
(25, 'Pioneer DJ DDJ-FLX4', 'Pioneer DJ', 'Instruments', 'DJ', 329.00, 4, '2-channel DJ controller with rekordbox and Serato support, ideal for beginners and mobile sets.', 'images/headphones.jpg', NULL, NULL, NULL, 'Black', NULL, NULL, NULL, '2026-03-23 11:00:00', NULL),
(26, 'Marshall MG15G Practice Amp', 'Marshall', 'Instruments', 'Amps', 139.00, 6, '15-watt practice amplifier with clean and overdrive channels for home rehearsals and small rooms.', 'images/stand.jpg', NULL, NULL, NULL, 'Black', NULL, NULL, NULL, '2026-03-23 11:00:00', NULL),
(27, 'Shure SM58 Vocal Microphone', 'Shure', 'Instruments', 'Microphones', 119.00, 9, 'Industry-standard dynamic vocal microphone with clear presence and reliable feedback rejection.', 'images/popfilter.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-23 11:00:00', NULL),
(28, 'DAddario Guitar Care Kit', 'DAddario', 'Instruments', 'Accessories', 24.90, 11, 'Essential accessory bundle with polish, cleaner and cloth to keep guitars in good playing condition.', 'images/cable.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 'Maintenance', '2026-03-23 11:00:00', NULL),
(29, 'Ortega Instrument Starter Bundle', 'Ortega', 'Instruments', 'Other', 49.00, 7, 'Useful starter bundle with tuner, picks, strap and soft essentials for new instrument owners.', 'images/products/placeholder.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-23 11:00:00', NULL),
(30, 'Daft Punk - Random Access Memories Download Card', 'Daft Punk', 'Music', 'Digital', 11.99, 25, 'Official digital edition with high-quality audio files and album booklet download.', 'images/products/daft-punk-random-access-memories.jpg', 'Digital Download', 'Electronic', NULL, NULL, NULL, NULL, NULL, '2026-03-23 12:00:00', NULL),
(31, 'Nirvana - Nevermind Cassette', 'Nirvana', 'Music', 'Cassette', 12.49, 8, 'Collectible cassette release of the grunge classic with retro packaging and analog character.', 'images/products/nirvana-nevermind-cassette.jpg', 'Cassette', 'Rock', NULL, NULL, NULL, NULL, NULL, '2026-03-23 12:00:00', NULL),
(32, 'Queen - Greatest Hits Collector Box', 'Queen', 'Music', 'Boxset', 44.90, 6, 'Collector boxset featuring Queen hits, booklet and premium packaging for fans and gift buyers.', 'images/products/queen-greatest-hits-boxset.jpg', 'Boxset', 'Rock', NULL, NULL, NULL, NULL, NULL, '2026-03-23 12:00:00', NULL),
(33, 'Movie Score Essentials Compilation', 'Various Artists', 'Music', 'Other', 16.50, 9, 'Curated soundtrack compilation spanning iconic film themes and orchestral highlights.', 'images/products/movie-score-essentials.jpg', 'Compilation', 'Soundtrack', NULL, NULL, NULL, NULL, NULL, '2026-03-23 12:00:00', NULL),
(34, 'MusicShop Logo Beanie', 'MusicShop', 'Merch', 'Headwear', 17.90, 18, 'Warm ribbed beanie with embroidered MusicShop logo for everyday wear in colder months.', 'images/products/musicshop-logo-beanie.jpg', NULL, NULL, 'One Size', 'Black', 'Beanie', NULL, NULL, '2026-03-23 12:00:00', NULL),
(35, 'Arctic Monkeys Tour Poster', 'Arctic Monkeys', 'Merch', 'Posters', 8.90, 14, 'Large wall poster printed on matte paper with bold tour artwork for music rooms and studios.', 'images/products/arctic-monkeys-tour-poster.jpg', NULL, NULL, '50x70 cm', NULL, 'Poster', NULL, NULL, '2026-03-23 12:00:00', NULL),
(36, 'Band Sticker Pack', 'Various Artists', 'Merch', 'Stickers', 5.50, 40, 'Pack of durable glossy stickers with assorted music-inspired graphics for laptops and cases.', 'images/products/band-sticker-pack.jpg', NULL, NULL, NULL, 'Multi', 'Sticker Pack', NULL, NULL, '2026-03-23 12:00:00', NULL),
(37, 'MusicShop Canvas Tote Bag', 'MusicShop', 'Merch', 'Accessories', 13.90, 20, 'Reusable canvas tote bag with simple MusicShop branding and enough room for records or accessories.', 'images/products/musicshop-canvas-tote-bag.jpg', NULL, NULL, NULL, 'Natural', 'Tote Bag', NULL, NULL, '2026-03-23 12:00:00', NULL),
(38, 'Pedalboard Flight Case', 'RockBoard', 'Other', 'Cases', 59.90, 5, 'Rigid transport case that protects pedals, cables and small accessories during travel and gigs.', 'images/products/pedalboard-flight-case.jpg', NULL, NULL, NULL, 'Black', NULL, NULL, 'Case', '2026-03-23 12:00:00', NULL),
(39, 'Vinyl Cleaning Kit', 'SpinCare', 'Other', 'Maintenance', 18.90, 16, 'Cleaning set with brush and fluid designed to remove dust and keep vinyl playback crisp.', 'images/products/vinyl-cleaning-kit.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 'Cleaning', '2026-03-23 12:00:00', NULL);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

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
