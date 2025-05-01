-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 01, 2025 at 12:24 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `3esh`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `email_verified_at`, `password`, `photo`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin@mail.com', NULL, '$2y$10$mOfdGMuTBn/fFScWhL3K2u72bIawaSOZ8U5yeU8v.TQY89AL5dn8W', NULL, NULL, '2025-02-26 08:10:43', '2025-02-26 08:10:43'),
(2, 'Ahmed', 'Ahmed@gmail.com', NULL, '$2y$10$m.6yBF78nqwvj.dx8Gyvauex0nfUnR8sNsCTDy62.5I383QsLqbua', NULL, NULL, '2025-03-20 10:11:15', '2025-03-20 10:11:15'),
(3, 'osamaeid', 'osam2a@mail.com', NULL, '$2y$10$vvtyvBtdAazPrTGKzqb/9eX3j3nN3sOCEHzJf/452e69HMBLqX09u', NULL, NULL, '2025-03-20 10:14:40', '2025-03-20 10:14:40'),
(4, 'osamaeid', 'osama2@mail.com', NULL, '$2y$10$VEuTURBHdxRNowGI0H10IeeYdfCJXb0DeWK6HaYbhn3h0ewYV6oE2', NULL, NULL, '2025-03-20 10:14:55', '2025-03-20 10:14:55');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `manager_name` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `opening_time` time DEFAULT NULL,
  `closing_time` time DEFAULT NULL,
  `working_days` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`working_days`)),
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `vendor_id`, `name`, `address`, `latitude`, `longitude`, `phone`, `email`, `manager_name`, `photo`, `is_approved`, `is_active`, `opening_time`, `closing_time`, `working_days`, `notes`, `created_at`, `updated_at`) VALUES
(1, 2, 'alexandria', 'alexandria', 12.00000000, 12.00000000, '01116073816', 'tarek@mail.com', 'osama', 'branches/B9ZFba2WmTuPDVxQEMGOKZxK9FRtUrOuSvGjSPzd.jpg', 0, 1, '10:10:00', '17:00:00', '[\"Monday\",\"Tuesday\",\"Wednesday\",\"Thursday\",\"Friday\"]', 'asdsadsadasd', '2025-02-27 11:36:15', '2025-02-27 12:07:35'),
(2, 9, 'bb', 'bb', 32.00000000, 12.00000000, '01116073816', 'osamaeidbm1993@gmail.com', 'osama', 'branches/kw64yb63XCi5zhCnfSpDulerKPKNdhg7EqaeuYia.png', 0, 1, '03:03:00', '15:03:00', '[\"Monday\",\"Tuesday\",\"Wednesday\",\"Thursday\",\"Sunday\"]', NULL, '2025-03-09 11:04:39', '2025-03-09 11:04:39');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `level` int(11) NOT NULL DEFAULT 1,
  `photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name_ar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `parent_id`, `is_active`, `level`, `photo`, `created_at`, `updated_at`, `name_ar`) VALUES
(1, 'aaaaaaaa', 'aa', NULL, 0, 1, 'categories/6D9UQWl1yUEOFoO8lKeibTqzHSETJo4YxCE3BURu.jpg', '2025-02-26 10:25:03', '2025-02-26 11:15:25', NULL),
(4, 'مطاعم', 'مطاعم', NULL, 1, 1, 'categories/Ef5P4XC7uXK4Vme5SS0JZtbSFFOKgupXJqKFivii.png', '2025-03-20 10:16:22', '2025-03-20 10:16:22', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `position` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `vendor_id`, `branch_id`, `name`, `position`, `email`, `phone`, `email_verified_at`, `photo`, `created_at`, `updated_at`, `password`) VALUES
(2, 9, NULL, 'osama', 'aaa', 'osama@mail.com', '01116073816', NULL, 'employees/photos/3J9Xy2EYFE2HUBAwG2NvX8aKqVslbsct6rb9LvL5.png', '2025-03-06 10:39:54', '2025-03-06 10:39:54', '$2y$10$29/Hmh7Q2NWHwjgnmao2XuAh0jlt.Pg7fJfs0WceBQ5EhKbVnBJIe'),
(3, 9, NULL, 'created_at', 'aaa', 'admin22323232@gmail.com', '011160738162', NULL, 'branches/8vW7TT1GSW4zdX4HJ3fnzUF1fP6bL1KMATDxsuv1.png', '2025-03-09 10:11:46', '2025-03-09 10:11:46', '123456789'),
(4, 2, NULL, 'Mohamed', 'مدير', 'Mohamed@gmail.com', '02112112', NULL, 'branches/ciCTUmRFbEK51h2UnKQV34KeFHJ97WMyWnK6lS9R.png', '2025-03-16 11:39:00', '2025-03-16 11:39:00', 'Mohamed@gmail.com'),
(5, 2, NULL, 'User', 'مدير', 'User@gmail.com', '012121545', NULL, 'branches/qmA2OUfz0LMS3KtEF5X0n3snmZMdo0veM4aWPkjK.png', '2025-03-16 11:39:50', '2025-03-16 11:39:50', 'User@gmail.com'),
(8, 2, NULL, 'osamaeid', 'aaa', 'osama7@mail.com', '011160738216', NULL, NULL, '2025-03-25 12:48:18', '2025-03-25 12:48:18', '3077z%5$Bv&'),
(9, 6, NULL, 'أسامة', 'ww', 'aa3auua@mail.com', 'w', NULL, 'branches/vFoqBec2LZDApy7TvQx5pI5pUJBJbzOOXhOU6pBY.jpg', '2025-05-01 06:59:54', '2025-05-01 06:59:54', '123456789');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_02_25_130250_create_vendors_table', 1),
(6, '2025_02_25_131728_create_admins_table', 1),
(7, '2025_02_25_132402_create_categories_table', 1),
(8, '2025_02_25_132543_create_vendor_categories_table', 1),
(9, '2025_02_25_132646_create_subscription_plans_table', 1),
(10, '2025_02_25_133123_create_branches_table', 1),
(11, '2025_02_25_133232_create_employees_table', 1),
(12, '2025_02_25_133233_create_discount_transactions_table', 1),
(13, '2025_02_25_133336_create_reports_table', 1),
(14, '2025_02_26_082848_create_subscription_users_table', 1),
(15, '2025_02_26_084255_create_permission_tables', 2),
(16, '2025_02_26_131822_add_column_name_ar_to_categories', 3),
(17, '2025_02_26_132346_create_settings_table', 4),
(18, '2025_03_02_142258_add_column_password_to_employees_table', 5),
(19, '2025_03_12_133346_add_column_latitude_to_users_table', 6),
(20, '2025_03_12_135744_create_subscription_vendors_table', 7),
(21, '2025_03_12_142706_create_user_offers_table', 8),
(22, '2025_03_12_144454_add_column_phone_to_users_table', 9),
(23, '2025_04_06_102618_create_static_pages_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('eldengaawy@gmail.com', '$2y$10$1oTCznxRGFeo6YVc09NUIOJ1q50q.9/wiO88aihgXAEJBfHQtOiG.', '2025-03-23 07:50:19'),
('john@example.com', '$2y$10$OqKIZgk.JdSXBWBqu6DQ9Oqlrcg1VZgmB8/o/C.LK8Fj7wQQoSkDa', '2025-03-20 13:33:59');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `group` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(4, 'App\\Models\\User', 3, 'auth_token', 'a0c9fe1cc448aa1f6e1c97c19a7e36c5fdb0d00135aa30830e7fb332b7a07c90', '[\"*\"]', NULL, NULL, '2025-03-19 12:18:38', '2025-03-19 12:18:38'),
(5, 'App\\Models\\User', 4, 'auth_token', '2181236de7f85ef728b0c1e100ca89f018e529099ab1d9bfeb50127e74d9ba2d', '[\"*\"]', NULL, NULL, '2025-03-20 08:04:11', '2025-03-20 08:04:11'),
(6, 'App\\Models\\User', 5, 'auth_token', 'c9752e5b57fa164c687d16c6ee45c89e2422e63c3b12b0ef4c360d12e4626a76', '[\"*\"]', NULL, NULL, '2025-03-20 08:16:15', '2025-03-20 08:16:15'),
(7, 'App\\Models\\User', 6, 'auth_token', '1f96996115868f1d1fbb9a4a2b09ea1c3ce4257da2449ad0f519bbb6fb265fae', '[\"*\"]', NULL, NULL, '2025-03-20 08:18:01', '2025-03-20 08:18:01'),
(9, 'App\\Models\\User', 8, 'auth_token', 'd383c563a57bc10e3e417f4685d4534b557960eb94943397e41c0ab1bfa5f6b3', '[\"*\"]', NULL, NULL, '2025-03-20 09:26:45', '2025-03-20 09:26:45'),
(10, 'App\\Models\\User', 9, 'auth_token', '78e5368aba336664b6845c9eaad7b9bce5849f690ca2e05cc4b1816883062317', '[\"*\"]', NULL, NULL, '2025-03-20 09:59:32', '2025-03-20 09:59:32'),
(11, 'App\\Models\\User', 10, 'auth_token', 'acedcf0ac2779588344ec3d2cc10562dc8a9ca12b1d116a689aeca1781b9ba2f', '[\"*\"]', NULL, NULL, '2025-03-20 10:00:54', '2025-03-20 10:00:54'),
(12, 'App\\Models\\User', 11, 'auth_token', '8e36fbfaf094959db0534adfa1d3260dafb15c99c2f33da64886ee94aca972c6', '[\"*\"]', NULL, NULL, '2025-03-20 10:02:33', '2025-03-20 10:02:33'),
(13, 'App\\Models\\User', 12, 'auth_token', '65a78eb773abb77048851ec0e7b33d9987ac93ba4c0ad29b197149a7446b0bc0', '[\"*\"]', NULL, NULL, '2025-03-20 10:03:14', '2025-03-20 10:03:14'),
(14, 'App\\Models\\User', 13, 'auth_token', 'a05f65942bbcdd04c2304e38f1d6153f3a2039614ea4829c04ee04c7e20c77c3', '[\"*\"]', '2025-03-20 10:34:21', NULL, '2025-03-20 10:04:06', '2025-03-20 10:34:21'),
(15, 'App\\Models\\User', 14, 'auth_token', '240fbf9ecb8410375d583e01c18172056520d87f7f15e7bd674130ad9e168a70', '[\"*\"]', '2025-03-20 10:52:47', NULL, '2025-03-20 10:41:12', '2025-03-20 10:52:47'),
(16, 'App\\Models\\User', 15, 'auth_token', '4590bba6670b7a486c2bd0fa707760a1c4d7431d1fb067588fee7f14071f3571', '[\"*\"]', NULL, NULL, '2025-03-20 12:00:19', '2025-03-20 12:00:19'),
(24, 'App\\Models\\User', 2, 'auth_token', '2343d7a20dba59925bae8213180325e769e37254209d52ec12932b3ed2fc3ed4', '[\"*\"]', '2025-04-08 07:17:27', NULL, '2025-03-26 13:06:52', '2025-04-08 07:17:27'),
(25, 'App\\Models\\User', 16, 'auth_token', 'afa53fc90f94a6efbc1c3c6874ec464b67b6a6de35616d0f32e9a6358a897e0c', '[\"*\"]', '2025-04-08 08:38:17', NULL, '2025-03-27 08:14:09', '2025-04-08 08:38:17'),
(26, 'App\\Models\\User', 17, 'auth_token', '6a8c87aee31c539abcd10e6520a38d0317a7e41fca3b553ef3b7850860aa325b', '[\"*\"]', NULL, NULL, '2025-03-27 10:06:34', '2025-03-27 10:06:34'),
(27, 'App\\Models\\User', 7, 'auth_token', 'b2c45bb7a04655ab0c0d8a69d215112886edcf41b7c81c2de5a8973c98b53e26', '[\"*\"]', '2025-04-08 05:53:36', NULL, '2025-04-07 08:54:15', '2025-04-08 05:53:36');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(2, 'logo', 'image:settings/MBWkBp34SkVYaJXEpcIaNHRnev8gtaawufpYBal4.png', '2025-02-26 12:02:52', '2025-02-26 12:43:42'),
(3, 'favicon', 'image:settings/9WpTeY8wLI5Ytl99yqeqD5cMdzAxO7MqsegzFSxj.png', '2025-02-26 12:31:36', '2025-02-26 12:43:53'),
(4, 'site_title', '3esh plus', '2025-02-26 12:31:56', '2025-03-02 11:32:50'),
(5, 'uuuuuuuu', 'hhhhhhhh', '2025-05-01 06:58:05', '2025-05-01 06:58:05');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `blocked` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `latitude` double(8,2) DEFAULT NULL,
  `longitude` double(8,2) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `photo`, `blocked`, `is_active`, `remember_token`, `created_at`, `updated_at`, `address`, `latitude`, `longitude`, `phone`) VALUES
(1, 'oso', 'os@mail.com', NULL, '123456', NULL, 0, 1, NULL, '2025-03-03 11:05:45', NULL, NULL, NULL, NULL, NULL),
(2, 'osama', 'john@example.com', NULL, '$2y$10$Z6U97sHwF9WgoTP0uZGKIeqsUrMFEKhicHWg6wT7uaesLsFkd9FfG', 'users/ahifyLUk90VJv3PzOdoPu3xnUHZ8JtDQLVO5fVMH.png', 0, 1, NULL, '2025-03-12 12:45:36', '2025-03-27 09:02:09', NULL, 30.21, 31.00, NULL),
(3, 'John Doe', 'john2@example.com', NULL, '$2y$10$TMVTEKe4R2q.8ME5rrCMGeNKBR0ndsjvrp3mRpPkcGLu0OhlFpYjW', NULL, 0, 1, NULL, '2025-03-19 12:18:38', '2025-03-19 12:18:38', NULL, NULL, NULL, NULL),
(4, 'John Doe', 'test@example.com', NULL, '$2y$10$B7Zi6IGvKk976C6TpY1qh.9avvGfbtI3yrzxLWxqyQsAZ4hw7.3eG', NULL, 0, 1, NULL, '2025-03-20 08:04:11', '2025-03-20 08:04:11', NULL, NULL, NULL, NULL),
(5, 'John Doe', 'joh@3eame.com', NULL, '$2y$10$F6rjWa70tulWAjCgftorz.scaTPRkV3e/69p3ZsjIuHCjlrLlufH6', NULL, 0, 1, NULL, '2025-03-20 08:16:15', '2025-03-20 08:16:15', NULL, NULL, NULL, NULL),
(6, 'John Doe', 'joh@3eme.com', NULL, '$2y$10$IhZq94yh3DykUAEvq.U6jOKIZbFUkv07eAgoYwFKqlIzLkVCDNCDa', NULL, 0, 1, NULL, '2025-03-20 08:18:01', '2025-03-20 08:18:01', NULL, NULL, NULL, NULL),
(7, 'Mahmoud Eldengawy', 'eldengaawy@gmail.com', NULL, '$2y$10$VV6Y8eiyenZ8mRrTOHnivul6FufxIwFldrsBRrsfqjk81Yn9PlTJm', 'users/kYvdVW8O29v2vcrgYJOi4a9Budyo4WbHXYrK6BI1.jpg', 0, 1, NULL, '2025-03-20 09:25:43', '2025-03-25 13:25:56', NULL, NULL, NULL, NULL),
(8, 'test', 'test@test.com', NULL, '$2y$10$b8PXbliWv46hb3O58kQp8.cmyeFqdE3wiY6oU4SVVxiwdTDGoQHee', NULL, 0, 1, NULL, '2025-03-20 09:26:45', '2025-03-20 09:26:45', NULL, NULL, NULL, NULL),
(9, 'test', 'test2@test.com', NULL, '$2y$10$1189upb1ajRpn2wfj1cAiuOeFvrEG9BQEMkROmZjEmxY1j9yReHiK', NULL, 0, 1, NULL, '2025-03-20 09:59:32', '2025-03-20 09:59:32', NULL, NULL, NULL, NULL),
(10, 'test', 'test3@test.com', NULL, '$2y$10$GvMN9THf3SybpKqa5bFrruOe2Iai.RKTEXoCZ4g/TKyQcAYO3pDf6', NULL, 0, 1, NULL, '2025-03-20 10:00:54', '2025-03-20 10:00:54', NULL, NULL, NULL, NULL),
(11, 'test', 'test4@test.com', NULL, '$2y$10$HUG24XZyISPB7mk6F954.u9pjFitwzcJz/RdzbQIoHXlsLf/zVHd2', NULL, 0, 1, NULL, '2025-03-20 10:02:33', '2025-03-20 10:02:33', NULL, NULL, NULL, NULL),
(12, 'test', 'test5@test.com', NULL, '$2y$10$rapUS91FxBeXm0QJL3WmNOlAhuGSyBOSJ2qGo.DxXV6pWq0RmmXYy', NULL, 0, 1, NULL, '2025-03-20 10:03:14', '2025-03-20 10:03:14', NULL, NULL, NULL, NULL),
(13, 'test', 'test6@test.com', NULL, '$2y$10$XE5WXoQs.jUm0XH4v1xwuu2ffjBhwyD1zW9voNrvLg/QlpQM22zsO', NULL, 0, 1, NULL, '2025-03-20 10:04:06', '2025-03-20 10:04:06', NULL, NULL, NULL, NULL),
(14, 'test', 'test7@test.com', NULL, '$2y$10$t9pyDBpruqRVxeleFvr.7uquAxnWxo2l3B6iWMZhV1SQFWSHJs3kq', NULL, 0, 1, NULL, '2025-03-20 10:41:12', '2025-03-20 10:41:12', NULL, NULL, NULL, NULL),
(15, 'test', 'test8@test.com', NULL, '$2y$10$gjmZ3MEr.Ma4XFpPQ6X0BelsfCm0sJomL/7wSUMWSX2Wlpvklje4e', NULL, 0, 1, NULL, '2025-03-20 12:00:19', '2025-03-20 12:00:19', NULL, NULL, NULL, NULL),
(16, 'test', 'test@test4.com', NULL, '$2y$10$Ks1TjGfRUKznYs04.n5XbO4TizKY0PBkJPIRz9Xq3IVrf2y5RlFaC', NULL, 0, 1, NULL, '2025-03-27 08:14:09', '2025-03-27 08:14:09', NULL, NULL, NULL, NULL),
(17, 'John Doe', 'joh@32eame.com', NULL, '$2y$10$yTEhKgT2.ziubwjo9M6i5O4S8v2BNUbI9aAVsiE9e.OD6hdK.o/MS', NULL, 0, 1, NULL, '2025-03-27 10:06:34', '2025-03-27 10:06:34', NULL, NULL, NULL, 1237890);

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `blocked` tinyint(1) NOT NULL DEFAULT 0,
  `is_approved` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `discount` float DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `business_name`, `email`, `logo`, `photo`, `contact_person`, `blocked`, `is_approved`, `is_active`, `discount`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'tqnia', 'tarek@mail.com', 'vendors/uM6Exd8aiyLXJLxcqywcE39PUIm7hGXv12ec3MRz.png', NULL, 'dasd', 0, 1, 1, 5, NULL, '2025-02-27 10:11:59', '2025-02-27 10:33:56'),
(6, 'tqnia', 'tqnia22@mail.com', 'vendors/logos/u6sXQw5oaTSCSMdlgDxL75uzwjwbPOgKK968qtyO.png', NULL, '2321323', 0, 1, 1, 10, NULL, '2025-03-06 10:21:07', '2025-03-20 10:35:50'),
(9, 'tqnia2', 'aaaa3232@mail.com', 'vendors/logos/3VLbkwmK7Y63hFNoNeDMgAMA3GnzWGkABp1SP1EP.png', NULL, '2323232', 0, 0, 1, 15, NULL, '2025-03-06 10:39:54', '2025-03-06 10:39:54'),
(13, 'tqnia2776', 'tare232k@mail.com', 'vendors/PxqnQg7OOyA2qy7B1juKlV5baJDScWTTMbhDYkyE.png', NULL, '2321323', 0, 1, 1, 20, NULL, '2025-03-25 13:06:52', '2025-03-25 13:07:32');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_categories`
--

CREATE TABLE `vendor_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_categories`
--

INSERT INTO `vendor_categories` (`id`, `vendor_id`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 2, 1, NULL, NULL),
(5, 13, 1, NULL, NULL),
(6, 13, 4, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `branches_vendor_id_foreign` (`vendor_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employees_vendor_id_foreign` (`vendor_id`),
  ADD KEY `employees_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendors_email_unique` (`email`);

--
-- Indexes for table `vendor_categories`
--
ALTER TABLE `vendor_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendor_categories_vendor_id_category_id_unique` (`vendor_id`,`category_id`),
  ADD KEY `vendor_categories_category_id_foreign` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `vendor_categories`
--
ALTER TABLE `vendor_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `branches`
--
ALTER TABLE `branches`
  ADD CONSTRAINT `branches_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `employees_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_categories`
--
ALTER TABLE `vendor_categories`
  ADD CONSTRAINT `vendor_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendor_categories_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
