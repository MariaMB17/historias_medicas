-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 14-03-2021 a las 20:08:35
-- Versión del servidor: 10.4.10-MariaDB
-- Versión de PHP: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

create database clinica;
use clinica;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `historias_medicas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

DROP TABLE IF EXISTS `area`;
CREATE TABLE IF NOT EXISTS `area` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL COMMENT 'DESCRIPCION DEL AREA DE TRABAJO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `area`
--

INSERT INTO `area` (`id`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'EMERGENCIA', NULL, NULL),
(2, 'NINGUNO(a)', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `diagnostico`
--

DROP TABLE IF EXISTS `diagnostico`;
CREATE TABLE IF NOT EXISTS `diagnostico` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID UNICO',
  `descripcion` varchar(255) NOT NULL COMMENT 'DESCRIPCION DE DIAGNOSTICO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emergencia`
--

DROP TABLE IF EXISTS `emergencia`;
CREATE TABLE IF NOT EXISTS `emergencia` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID UNICO',
  `persona_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'REFERENCIA DE PERSONA EMPLEADO',
  `turno` enum('M','T','N') NOT NULL COMMENT 'M-MAÑANA',
  `fecha` datetime DEFAULT NULL COMMENT 'FECHA DE INGRESO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `emergencia_persona_id_foreign` (`persona_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emergencia_detalle`
--

DROP TABLE IF EXISTS `emergencia_detalle`;
CREATE TABLE IF NOT EXISTS `emergencia_detalle` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID UNICO',
  `emergencia_id` int(10) UNSIGNED NOT NULL COMMENT 'REFERENCIA DE EMERGENCIA',
  `paciente_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'REFERENCIA DE PERSONA PACIENTE',
  `motivoing_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'REFERENCIA DE MOTIVO DE INGRESO',
  `diagnostico_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'REFERENCIA DE DIAGNOSTICO',
  `observaciones` text NOT NULL COMMENT 'OBSERVACIONES DE LA EMERGENCIA',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `emergencia_detalle_emergencia_id_foreign` (`emergencia_id`),
  KEY `emergencia_detalle_paciente_id_foreign` (`paciente_id`),
  KEY `emergencia_detalle_motivoing_id_foreign` (`motivoing_id`),
  KEY `emergencia_detalle_diagnostico_id_foreign` (`diagnostico_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emerg_det_proc`
--

DROP TABLE IF EXISTS `emerg_det_proc`;
CREATE TABLE IF NOT EXISTS `emerg_det_proc` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID UNICO',
  `emerdetproc_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'REFERENCIA A LA TABLA DETALLE DE EMERGENCIA',
  `observaciones` text NOT NULL COMMENT 'OBSERVACIONES DEL PROCEDIMIENTO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `emerg_det_proc_emerdetproc_id_foreign` (`emerdetproc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

DROP TABLE IF EXISTS `especialidad`;
CREATE TABLE IF NOT EXISTS `especialidad` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL COMMENT 'DESCRIPCION DE LA ESPECIALIDAD',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`id`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'MEDICINA GENERAL', NULL, NULL),
(2, 'NINGUNO(a)', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

DROP TABLE IF EXISTS `estado`;
CREATE TABLE IF NOT EXISTS `estado` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID ESTADO',
  `cod_edo` varchar(3) NOT NULL COMMENT 'CODIGO ESTADO',
  `des_edo` varchar(30) NOT NULL COMMENT 'DESCRIPCION DE ESTADO',
  `abrv_edo` varchar(4) NOT NULL COMMENT 'ABREV. ESTADO',
  `pais_edo` int(10) UNSIGNED NOT NULL,
  `status_edo` int(11) NOT NULL DEFAULT 0 COMMENT 'ESTATUS ESTADO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `estado_cod_edo_unique` (`cod_edo`),
  KEY `estado_pais_edo_foreign` (`pais_edo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(8, '2019_08_19_000000_create_failed_jobs_table', 1),
(9, '2020_12_30_205341_create_pais_table', 1),
(10, '2020_12_30_225635_create_estado_table', 1),
(11, '2021_01_09_150611_create_especialidad_table', 1),
(12, '2021_01_09_150857_create_area_table', 1),
(13, '2021_01_09_160923_create_tipo_persona_table', 1),
(14, '2021_01_09_175452_create_persona_table', 1),
(15, '2021_01_16_002133_create_diagnostico_table', 1),
(16, '2021_01_16_002156_create_motivo_ingreso_table', 1),
(17, '2021_01_16_002317_create_emergencia_table', 1),
(18, '2021_01_16_002614_create_emergencia_detalle_table', 1),
(19, '2021_01_16_004814_create_emerg_det_proc_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivo_ingreso`
--

DROP TABLE IF EXISTS `motivo_ingreso`;
CREATE TABLE IF NOT EXISTS `motivo_ingreso` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID UNICO',
  `descripcion` varchar(255) NOT NULL COMMENT 'DESCRIPCION MOTIVO DE INGRESO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('3a7c4f4dcde1ce2fa10d07d5d9b3bccff419b842d65a6c42ce3b7a693d811f6368096e83f036b92a', 1, 1, 'Personal Access Token', '[]', 0, '2021-01-24 21:39:20', '2021-01-24 21:39:20', '2021-01-25 17:09:19'),
('28e075ffcbd727ab094e9319260b8064d9b102d348c145c0da7cd5227f07ece0a1d754cdb8a7e5da', 1, 1, 'Personal Access Token', '[]', 0, '2021-01-31 19:52:38', '2021-01-31 19:52:38', '2021-02-01 15:22:36'),
('718fcad3bf81ccfc586bff5722b90f1b58b4456f7ff5ba11e2232395276df0be16177bbd5ebb1362', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-15 02:36:27', '2021-02-15 02:36:27', '2021-02-15 22:06:26'),
('b9a42414fc3ca9f3559632d5468d0a04a3047481c7b3e40580d5aedff40f57bb2a336c76a4b43e7a', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-17 05:08:20', '2021-02-17 05:08:20', '2021-02-18 00:38:17'),
('c0c02969d6bdc3aab1ae4089e33b776342fc2629aaff3512f76f24d29c6728774164d25d768bb40c', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-17 05:14:23', '2021-02-17 05:14:23', '2021-02-18 00:44:23'),
('ee54523b1d8bda351eb742b68c08b4dba9c5a46896e2d2189aab4cafd5d744d191e335e93f8a178a', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-17 05:32:21', '2021-02-17 05:32:21', '2021-02-18 01:02:21'),
('bac366d53cd4c45c49cd8ba59e53ccd7df28e3a2da43ec6d28f2d33f6c1b65760963fa1c5dd3c749', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-17 05:33:35', '2021-02-17 05:33:35', '2021-02-18 01:03:35'),
('6db734e728c4bccf6ded2a737ad231fc399645c1c87ceedc056f8f30f053fcc31d941967ff0890e0', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-17 05:38:11', '2021-02-17 05:38:11', '2021-02-18 01:08:11'),
('c2562f6ceb641f59a351fa46a502ceb5e379b7b5ad11717c2aea693fb0f47177aa099cfef9af92d9', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-17 05:44:25', '2021-02-17 05:44:25', '2021-02-18 01:14:24'),
('fced4a73469aecfc831dc78488a991e8795bf8a8edb54ee25df70c989a201de0a23d24f87ec236b9', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-17 05:44:51', '2021-02-17 05:44:51', '2021-02-18 01:14:50'),
('5ec52acc59dc6b8395f36411857d1194dbd16349ca481d33b655b227b98a1ce0200acb7c8c5154a2', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-17 05:54:01', '2021-02-17 05:54:01', '2021-02-18 01:24:01'),
('9e5a903eafbae2241a65ac05700e7ba1271c52222829529f543084b44e3b65973738060c2f1be40d', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-17 06:23:28', '2021-02-17 06:23:28', '2021-02-18 01:53:27'),
('b766be69850a5c4c511b1aaf62405a5ec60607b49a3752b1c1b3182cee462b803cbd45172e118d82', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-17 06:30:00', '2021-02-17 06:30:00', '2021-02-18 02:00:00'),
('40604fee93d9fe1d19a780bf9f3ff740dc9b97474ff2bf52f6f5cb5a07a6e737438f7eed3026e607', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-19 04:42:10', '2021-02-19 04:42:10', '2021-02-20 00:12:04'),
('7c8c98efbab219f7ecba0b1c7dcda957a66063f6de57808e2cfeee44c224578e4b013da56f73bad1', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-19 04:44:42', '2021-02-19 04:44:42', '2021-02-20 00:14:41'),
('1996aa166fa1946c847bed37420f20f9a3238d9d31e782fc587116af315c34231fc4c2fb704da9e9', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-19 04:59:00', '2021-02-19 04:59:00', '2021-02-20 00:29:00'),
('1848cd0cc25e42d1f66753d599240bd784475525c17bee2bf14137f27760a1d52f55a3441e108939', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-19 06:17:33', '2021-02-19 06:17:33', '2021-02-20 01:47:32'),
('6a169b061bbf60e717699dcf5d1b9607bf7ab57ad257eae30f5d8ffdc9221a05dbf74e599db54fcd', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-20 04:38:09', '2021-02-20 04:38:09', '2021-02-21 00:08:08'),
('e3a635ab248cfd76934694d9bca961aed1f3fc13e4b85db64b7278f715e42cbe370b5e6355a037c4', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-20 04:49:10', '2021-02-20 04:49:10', '2021-02-21 00:19:10'),
('4daf5f8763e7ebe1174bad57a807266098a225b5bfd468d24c9fad0adb6a0b5ae8b76d31380117fe', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-20 04:50:06', '2021-02-20 04:50:06', '2021-02-21 00:20:06'),
('76e297bd01766e7bc41a26c3fb247a73e888315ef7b6c2d98f5c06c3c5781c989e708a7ebf9f2849', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-20 04:51:11', '2021-02-20 04:51:11', '2021-02-21 00:21:11'),
('e2bc82cac8e223db8580a3be82dd0db27852a45e83d573cbe8b5caba3f3252c1e0914ca455fbce56', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-20 04:53:50', '2021-02-20 04:53:50', '2021-02-21 00:23:50'),
('e6eee72b894cf588c2f39fe82f1f4b12351b4384d4293229e5b51f2c1a5af0071fd7aad493d46b9e', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-20 06:36:53', '2021-02-20 06:36:53', '2021-02-21 02:06:47'),
('44e7037f92c1e8e6122b1b05c6cad8131d83c4cdea449c921273fbf5ba801e1b8f68b331f04286a9', 1, 1, 'Personal Access Token', '[]', 1, '2021-02-20 06:39:35', '2021-02-20 06:39:35', '2021-02-21 02:09:35'),
('1cd78c0ee8b7e078f335b6e1c806a88c0100532fd846d34cbda4d29647eaa4aeb84e2febbe74c5c9', 1, 1, 'Personal Access Token', '[]', 1, '2021-02-20 06:47:19', '2021-02-20 06:47:19', '2021-02-21 02:17:19'),
('4e034ee5b173aecf7e864af106598959b7a6a9b224348655be4e1e1583f81ed30d8cedbf47906fd1', 1, 1, 'Personal Access Token', '[]', 1, '2021-02-20 06:50:26', '2021-02-20 06:50:26', '2021-02-21 02:20:25'),
('eae55513108def35bf2aac47ea3706e6985f11f5feff2b392f2bfe97a0b6ea86bbd879a81ef90ae8', 1, 1, 'Personal Access Token', '[]', 1, '2021-02-20 06:54:12', '2021-02-20 06:54:12', '2021-02-21 02:24:12'),
('c0fcf7ae26042ca9c6cb83a83ca3fb5221d3774c6a522d5ebba7d5ba7e65b4dc067a03402857c3f5', 1, 1, 'Personal Access Token', '[]', 1, '2021-02-20 06:58:20', '2021-02-20 06:58:20', '2021-02-21 02:28:20'),
('5879bb9dbb5bb7ece15ef446ca270e7cf4d0b14e188753cd0c98d48d461f609d888c9fb425eb485e', 1, 1, 'Personal Access Token', '[]', 1, '2021-02-20 06:59:29', '2021-02-20 06:59:29', '2021-02-21 02:29:28'),
('25c42aa9aadee8f7d1410e07ac4fd4ff12455581191cfbafd600a56a524774dde47aa0f0ba6dad92', 1, 1, 'Personal Access Token', '[]', 1, '2021-02-23 06:55:42', '2021-02-23 06:55:42', '2021-02-24 02:25:32'),
('d58179329baadcee5ba42b64c313ba5062a48d7a6b5815ab6299de5b313476cb242501747e3aa768', 1, 1, 'Personal Access Token', '[]', 1, '2021-02-24 06:16:56', '2021-02-24 06:16:56', '2021-02-25 01:46:50'),
('7e8becb0ebb64724510ba664215d7f5dd8b7bb19c086bd483469b7f689e509b898b7daa735968216', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-24 07:35:00', '2021-02-24 07:35:00', '2021-02-25 03:04:59'),
('c2b006be021642c2e3e9c100c4d106c98888a90c36c0f794b2a73e1eda6dbae090a334532bd07441', 1, 1, 'Personal Access Token', '[]', 1, '2021-02-26 05:13:58', '2021-02-26 05:13:58', '2021-02-27 00:43:53'),
('52b00fb3a502af3374d84762d4dd45200d1c8fbbf26f5fcacfc5ebcee244b1401e515c857b153cdb', 1, 1, 'Personal Access Token', '[]', 0, '2021-02-26 05:42:18', '2021-02-26 05:42:18', '2021-02-27 01:12:17'),
('ad40d65a5a3f821596a4cb895bbf84da9601cdd1999e447d0cdf34a82556446bd0206aabb1f2d742', 1, 1, 'Personal Access Token', '[]', 1, '2021-03-15 00:24:35', '2021-03-15 00:24:35', '2021-03-15 19:54:31'),
('cc7bd70b7508b291a420ebd91e29466f390f512d9802fc9e4f137900aebda4983dee16afd5cdac3d', 1, 1, 'Personal Access Token', '[]', 1, '2021-03-15 00:28:12', '2021-03-15 00:28:12', '2021-03-15 19:58:12'),
('6f80afd8230961b6a938cc07a497f1a251fe284f9305e2c91264d4a7657c409ebe0b9814aa8b3498', 1, 1, 'Personal Access Token', '[]', 1, '2021-03-15 00:28:48', '2021-03-15 00:28:48', '2021-03-15 19:58:48'),
('153f7dd88a55544876363953aabd1722d7226636794f516b073ce1f354611dad4e2ae9414147a86d', 1, 1, 'Personal Access Token', '[]', 0, '2021-03-15 00:37:17', '2021-03-15 00:37:17', '2021-03-15 20:07:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'gpnMmAG2vTl9K56i4FGgcc0jTeQTPjsYI7fRO9S6', NULL, 'http://localhost', 1, 0, 0, '2021-01-24 20:31:21', '2021-01-24 20:31:21'),
(2, NULL, 'Laravel Password Grant Client', '5gX8yxKjfzmGOiv9ld5yFzQwITjWmZ1sdwJSWzTk', 'users', 'http://localhost', 0, 1, 0, '2021-01-24 20:31:21', '2021-01-24 20:31:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2021-01-24 20:31:21', '2021-01-24 20:31:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

DROP TABLE IF EXISTS `pais`;
CREATE TABLE IF NOT EXISTS `pais` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID PAIS',
  `cod_pais` varchar(3) NOT NULL COMMENT 'CODIGO PAIS',
  `des_pais` varchar(100) NOT NULL COMMENT 'DESCRIPCION DE PAIS',
  `status_pais` int(11) NOT NULL DEFAULT 0 COMMENT 'ESTATUS PAIS',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo_id` enum('V','E','P') NOT NULL COMMENT 'V-VENEZOLANO',
  `identificacion` varchar(10) NOT NULL COMMENT 'NUMERO DE IDENTIFICACION',
  `nombres` varchar(50) NOT NULL COMMENT 'NOMBRES DE LA PERSONA',
  `apellidos` varchar(50) NOT NULL COMMENT 'APELLIDOS DE LA PERSONA',
  `sexo` enum('M','F') NOT NULL COMMENT 'SEXO DE LA PERSONA',
  `email` varchar(255) NOT NULL COMMENT 'CORREO ELECTRONICO',
  `fecha_nac` date NOT NULL COMMENT 'FECHA DE NACIMIENTO DE LA PERSONA',
  `direccion` varchar(500) NOT NULL COMMENT 'DIRECCION DE LA PERSONA',
  `especialidad_id` int(10) UNSIGNED DEFAULT NULL,
  `area_id` int(10) UNSIGNED DEFAULT NULL,
  `tipo_persona_id` int(10) UNSIGNED DEFAULT NULL,
  `talla` varchar(191) DEFAULT NULL COMMENT 'TALLA DE LA PERSONA',
  `peso` varchar(191) NOT NULL COMMENT 'PESO DE LA PERSONA',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `persona_identificacion_unique` (`identificacion`),
  KEY `persona_especialidad_id_foreign` (`especialidad_id`),
  KEY `persona_area_id_foreign` (`area_id`),
  KEY `persona_tipo_persona_id_foreign` (`tipo_persona_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id`, `tipo_id`, `identificacion`, `nombres`, `apellidos`, `sexo`, `email`, `fecha_nac`, `direccion`, `especialidad_id`, `area_id`, `tipo_persona_id`, `talla`, `peso`, `created_at`, `updated_at`) VALUES
(2, 'V', '18137464', 'Maria', 'Alvarez', 'F', 'mariana@gmail.com', '1986-05-17', 'SANTA ROSALIA', 1, 1, 1, NULL, '0', '2021-01-24 22:14:32', '2021-01-24 22:14:32'),
(3, 'V', '14235621', 'Luis', 'Alvarado', 'M', 'luis@gmail.com', '1985-02-13', '-', 2, 1, 2, NULL, '0', '2021-01-24 22:44:28', '2021-01-24 22:44:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_persona`
--

DROP TABLE IF EXISTS `tipo_persona`;
CREATE TABLE IF NOT EXISTS `tipo_persona` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL COMMENT 'DESCRIPCION DE TIPO DE PERSONA',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_persona`
--

INSERT INTO `tipo_persona` (`id`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'DOCTOR(a)', NULL, NULL),
(2, 'EMPLEADO', NULL, NULL),
(3, 'ENFERMERO(a)', NULL, NULL),
(4, 'PERSONA EXTERNO', NULL, NULL),
(5, 'NINGUNO(a)', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Maria', 'marialva1705@gmail.com', NULL, '$2y$10$Xf.vJ3.M7VqPE3pksSCX/uGmh4asDDd0NFxYTw6yq7eU0XKDTrple', NULL, '2021-01-24 21:39:05', '2021-01-24 21:39:05');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `emergencia`
--
ALTER TABLE `emergencia`
  ADD CONSTRAINT `emergencia_persona_id_foreign` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `emergencia_detalle`
--
ALTER TABLE `emergencia_detalle`
  ADD CONSTRAINT `emergencia_detalle_diagnostico_id_foreign` FOREIGN KEY (`diagnostico_id`) REFERENCES `diagnostico` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `emergencia_detalle_emergencia_id_foreign` FOREIGN KEY (`emergencia_id`) REFERENCES `emergencia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `emergencia_detalle_motivoing_id_foreign` FOREIGN KEY (`motivoing_id`) REFERENCES `motivo_ingreso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `emergencia_detalle_paciente_id_foreign` FOREIGN KEY (`paciente_id`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `emerg_det_proc`
--
ALTER TABLE `emerg_det_proc`
  ADD CONSTRAINT `emerg_det_proc_emerdetproc_id_foreign` FOREIGN KEY (`emerdetproc_id`) REFERENCES `emergencia_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `estado`
--
ALTER TABLE `estado`
  ADD CONSTRAINT `estado_pais_edo_foreign` FOREIGN KEY (`pais_edo`) REFERENCES `pais` (`id`);

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `persona_especialidad_id_foreign` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `persona_tipo_persona_id_foreign` FOREIGN KEY (`tipo_persona_id`) REFERENCES `tipo_persona` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
