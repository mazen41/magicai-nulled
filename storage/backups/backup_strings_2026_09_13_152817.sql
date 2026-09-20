-- MySQL dump 10.13  Distrib 8.4.10-10, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: magicai
-- ------------------------------------------------------
-- Server version	8.4.10-10

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!50717 SELECT COUNT(*) INTO @rocksdb_has_p_s_session_variables FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'performance_schema' AND TABLE_NAME = 'session_variables' */;
/*!50717 SET @rocksdb_get_is_supported = IF (@rocksdb_has_p_s_session_variables, 'SELECT COUNT(*) INTO @rocksdb_is_supported FROM performance_schema.session_variables WHERE VARIABLE_NAME=\'rocksdb_bulk_load\'', 'SELECT 0') */;
/*!50717 PREPARE s FROM @rocksdb_get_is_supported */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;
/*!50717 SET @rocksdb_enable_bulk_load = IF (@rocksdb_is_supported, 'SET SESSION rocksdb_bulk_load = 1', 'SET @rocksdb_dummy_bulk_load = 0') */;
/*!50717 PREPARE s FROM @rocksdb_enable_bulk_load */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;

--
-- Table structure for table `account_deletion_reqs`
--

DROP TABLE IF EXISTS `account_deletion_reqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_deletion_reqs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_deletion_reqs_user_id_foreign` (`user_id`),
  CONSTRAINT `account_deletion_reqs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_deletion_reqs`
--

LOCK TABLES `account_deletion_reqs` WRITE;
/*!40000 ALTER TABLE `account_deletion_reqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_deletion_reqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `url` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `activity_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activity_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_user_id_foreign` (`user_id`),
  CONSTRAINT `activity_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ads`
--

DROP TABLE IF EXISTS `ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads`
--

LOCK TABLES `ads` WRITE;
/*!40000 ALTER TABLE `ads` DISABLE KEYS */;
INSERT INTO `ads` VALUES (1,'landing-header-section','',0,'2023-08-30 13:10:37','2023-08-30 13:10:37'),(2,'landing-features-section-728x90','',0,'2023-08-30 13:10:37','2023-08-30 13:10:37'),(3,'landing-templates-section-728x90','',0,'2023-08-30 13:10:37','2023-08-30 13:10:37'),(4,'landing-tools-section-728x90','',0,'2023-08-30 13:10:37','2023-08-30 13:10:37'),(5,'landing-how-it-works-section-728x90','',0,'2023-08-30 13:10:37','2023-08-30 13:10:37'),(6,'landing-testimonials-section-728x90','',0,'2023-08-30 13:10:37','2023-08-30 13:10:37'),(7,'landing-pricing-section-728x90','',0,'2023-08-30 13:10:37','2023-08-30 13:10:37'),(8,'landing-faq-section-728x90','',0,'2023-08-30 13:10:37','2023-08-30 13:10:37');
/*!40000 ALTER TABLE `ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advanced_features_section`
--

DROP TABLE IF EXISTS `advanced_features_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advanced_features_section` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advanced_features_section`
--

LOCK TABLES `advanced_features_section` WRITE;
/*!40000 ALTER TABLE `advanced_features_section` DISABLE KEYS */;
INSERT INTO `advanced_features_section` VALUES (1,'Article Wizard','Create a social media post and schedule it to be published directly on Linkedin or X.','/themes/default/assets/landing-page/advanced-feature-1.png',NULL,NULL),(2,'Intelligent AI Assistant','Create a social media post and schedule it to be published directly on Linkedin or X.','/themes/default/assets/landing-page/advanced-feature-1.png',NULL,NULL),(3,'Publish on Social Media','Create a social media post and schedule it to be published directly on Linkedin or X.','/themes/default/assets/landing-page/advanced-feature-1.png',NULL,NULL),(4,'SEO Tool','Create a social media post and schedule it to be published directly on Linkedin or X.','/themes/default/assets/landing-page/advanced-feature-1.png',NULL,NULL),(5,'Real-Time Data','Create a social media post and schedule it to be published directly on Linkedin or X.','/themes/default/assets/landing-page/advanced-feature-1.png',NULL,NULL),(6,'AI Photo Editor','Create a social media post and schedule it to be published directly on Linkedin or X.','/themes/default/assets/landing-page/advanced-feature-1.png',NULL,NULL);
/*!40000 ALTER TABLE `advanced_features_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advertis`
--

DROP TABLE IF EXISTS `advertis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertis` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tracking_code` longtext COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertis`
--

LOCK TABLES `advertis` WRITE;
/*!40000 ALTER TABLE `advertis` DISABLE KEYS */;
/*!40000 ALTER TABLE `advertis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_chat_model_plans`
--

DROP TABLE IF EXISTS `ai_chat_model_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_chat_model_plans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `plan_id` int NOT NULL,
  `entity_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ai_chat_model_plans_entity_id_foreign` (`entity_id`),
  CONSTRAINT `ai_chat_model_plans_entity_id_foreign` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_chat_model_plans`
--

LOCK TABLES `ai_chat_model_plans` WRITE;
/*!40000 ALTER TABLE `ai_chat_model_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_chat_model_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_settings`
--

DROP TABLE IF EXISTS `app_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_settings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_settings_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_settings`
--

LOCK TABLES `app_settings` WRITE;
/*!40000 ALTER TABLE `app_settings` DISABLE KEYS */;
INSERT INTO `app_settings` VALUES (1,'frontend_additional_url_type','default'),(2,'front_theme','social-media-front'),(3,'dash_theme','default'),(4,'default_ai_engine','deep_seek'),(5,'default_external_chatbot_engine','openai'),(6,'default_aw_image_engine','unsplash'),(7,'default_voice_chat_engine','openai'),(8,'chat_setting_for_customer','0'),(9,'user_prompt_library','1'),(10,'user_ai_image_prompt_library','1'),(11,'ai_voice_isolator','1'),(12,'select_model_option','1'),(13,'user_ai_writer_custom_templates','1'),(14,'ai_chat_layout','single'),(15,'ai_automation','1'),(16,'photo_studio','0'),(17,'ai_realtime_image','0'),(18,'social_media_image_model','nano-banana-pro'),(19,'social_media_agent_image_model','nano-banana-pro'),(20,'deepseek_api_secret',',sk-4da1f50a79ec4632ba2ef782117b1e47'),(21,'deepseek_default_model','deepseek-reasoner'),(22,'deepseek_max_output_length','200'),(23,'hide_creativity_option','1'),(24,'hide_tone_of_voice_option','1'),(25,'hide_output_length_option','0'),(26,'dalle_hidden','1'),(27,'realtime_voice_chat','0'),(28,'sora_active','0'),(29,'openai_file_search','1'),(30,'enabled_gpt_image_1','1'),(31,'enabled_gpt_image_1_5','1'),(32,'enabled_gpt_image_2','1'),(33,'openai_reasoning_models_effort','low');
/*!40000 ALTER TABLE `app_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_wizard`
--

DROP TABLE IF EXISTS `article_wizard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_wizard` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `keywords` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra_keywords` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic_keywords` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra_titles` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic_title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `tone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `image_style` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `image_count` int NOT NULL DEFAULT '0',
  `outline` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra_outlines` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic_outline` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_step` int NOT NULL DEFAULT '0',
  `result` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra_images` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic_image` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `generated_count` int NOT NULL DEFAULT '0',
  `creativity` double(8,2) NOT NULL DEFAULT '0.50',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_wizard`
--

LOCK TABLES `article_wizard` WRITE;
/*!40000 ALTER TABLE `article_wizard` DISABLE KEYS */;
/*!40000 ALTER TABLE `article_wizard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automation_campaigns`
--

DROP TABLE IF EXISTS `automation_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automation_campaigns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_audience` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automation_campaigns`
--

LOCK TABLES `automation_campaigns` WRITE;
/*!40000 ALTER TABLE `automation_campaigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `automation_campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automation_platforms`
--

DROP TABLE IF EXISTS `automation_platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automation_platforms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `platform` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credentials` json DEFAULT NULL,
  `connected_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automation_platforms`
--

LOCK TABLES `automation_platforms` WRITE;
/*!40000 ALTER TABLE `automation_platforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `automation_platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automations`
--

DROP TABLE IF EXISTS `automations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `custom` longtext COLLATE utf8mb4_unicode_ci,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automations`
--

LOCK TABLES `automations` WRITE;
/*!40000 ALTER TABLE `automations` DISABLE KEYS */;
/*!40000 ALTER TABLE `automations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bad_words`
--

DROP TABLE IF EXISTS `bad_words`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bad_words` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `words` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bad_words`
--

LOCK TABLES `bad_words` WRITE;
/*!40000 ALTER TABLE `bad_words` DISABLE KEYS */;
/*!40000 ALTER TABLE `bad_words` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner_bottom_texts`
--

DROP TABLE IF EXISTS `banner_bottom_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner_bottom_texts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner_bottom_texts`
--

LOCK TABLES `banner_bottom_texts` WRITE;
/*!40000 ALTER TABLE `banner_bottom_texts` DISABLE KEYS */;
INSERT INTO `banner_bottom_texts` VALUES (1,'No Credit Card Required',NULL,NULL),(2,'Free Trial',NULL,NULL),(3,'30 Day Money Back Guarentee',NULL,NULL);
/*!40000 ALTER TABLE `banner_bottom_texts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `feature_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_description` text COLLATE utf8mb4_unicode_ci,
  `category` text COLLATE utf8mb4_unicode_ci,
  `tag` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blogs_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_category`
--

DROP TABLE IF EXISTS `chat_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_category` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_category`
--

LOCK TABLES `chat_category` WRITE;
/*!40000 ALTER TABLE `chat_category` DISABLE KEYS */;
INSERT INTO `chat_category` VALUES (1,1,'chat Category','2026-09-13 13:28:35','2026-09-13 13:28:35');
/*!40000 ALTER TABLE `chat_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot`
--

DROP TABLE IF EXISTS `chatbot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructions` text COLLATE utf8mb4_unicode_ci,
  `chatbot_interests` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `width` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `height` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'not-trained',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot`
--

LOCK TABLES `chatbot` WRITE;
/*!40000 ALTER TABLE `chatbot` DISABLE KEYS */;
INSERT INTO `chatbot` VALUES (1,1,'Default','Support','gpt-3.5-turbo-16k','I am AI Assistant. How can I help you?','Your name is John Doe. Remember that you are an assistant who only gives information about wordpress and don\'t give any other information.',NULL,NULL,NULL,NULL,NULL,'not-trained',NULL,'2026-09-13 13:37:47');
/*!40000 ALTER TABLE `chatbot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot_data`
--

DROP TABLE IF EXISTS `chatbot_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot_data` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chatbot_id` bigint DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot_data`
--

LOCK TABLES `chatbot_data` WRITE;
/*!40000 ALTER TABLE `chatbot_data` DISABLE KEYS */;
INSERT INTO `chatbot_data` VALUES (1,1,'MagicAI | Home New Unleash the Power of AI Ultimate AI Generator Chatbot Assistant with AI. All-in-one platform to generate AI content and start making money in minutes. Start Making Money Discover MagicAI No credit cart required. 10xFaster Content Creation over 5000+ businesses trust us to boost their social media precense Get Started Contact Us Trusted by these amazing companies AI Text Generator AI Image Generator AI Code Generator AI Chat Bot AI Speech To Text Empower Your Message with AI Say goodbye to writer\'s block AI Intelligent Writing Assistant Writer is designed to help you generate high-quality texts instantly, without breaking a sweat. With our intuitive interface and powerful features, you can easily edit, export, or publish your AI-generated result. Generate, edit, export. Powered by OpenAI. Unleash your creativity AI Create eye-catching images and graphics. Generate high-quality images for a wide range of applications. Imagine, Generate, Publish. Powered by Dall-E. The future of development AI Generate high-quality code in no time. MagicAI is designed to make coding faster, easier, and more efficient than ever before. Whether you’re a seasoned developer or a coding newbie, our tool will help you streamline your coding process and get your projects up and running in no time. Fix. Improve. Generate. Powered by OpenAI. Intuitive / Humanlike Chatbot AI Meet your next virtual assistant. Get instant answers to your questions, no matter the topic. Whether you’re looking to book a reservation, get product recommendations, or just chat about the weather, MagicAI is always ready and willing to help. Chat, Solve, Repeat. Powered by OpenAI. Say goodbye to writer\'s block AI Transcribe your speech into text. Accurately transcribe your recordings in just minutes. With our user-friendly interface, you can upload your files and have them transcribed in a matter of clicks. Upload, Analyze, Generate. Powered by OpenAI. Say goodbye to writer\'s block AI Transcribe your speech into text. From captivating commercials to engaging narrations, our AI voice will bring your words to life. With its seamless delivery, natural intonation, and unrivaled versatility, our AI VoiceOver is the perfect choice for any project. Effortlessly choose from a variety of voices and languages while adjusting the pace to your preference. Upload, Analyze, Generate. Powered by OpenAI. Custom Templates. Unrivaled AI Generators in terms of quality, versatility, and ease of use. Custom Generation Magic Tools. While making content creation effortless for users, it maximizes the quality of the results. Advanced Dashboard Track a wide range of data points, including user traffic and sales. Payment Gateways Securely process credit card or other electronic payment methods. Multilingual Ability to understand and generate content in different languages. Affiliate System Ability to invite friends, and earn commission from their first purchase. Easy Export Export generated content as plain text, PDF, Word or HTML easily. Support Platform Access and mage support tickets from your dashboard. Facebook Our AI tool helps you craft compelling content that resonates with your audience Whether it\'s a status update, promotional post, or a simple interaction. Twitter / X Create impactful X posts with our AI tool in seconds! Whether it\'s a quick update, an engaging tweet, or a conversation starter, generate posts that drive conversations and keep your followers engaged on X. Instagram Design eye-catching Instagram posts in no time with our AI-powered generator. From beautiful visuals to captivating captions, create Instagram content that stands out and grabs your followers\' attention. LinkedIn Build your professional presence with polished LinkedIn posts. Our AI helps you write insightful articles, thought-provoking updates, and attention-grabbing headlines that engage with your network. The future of AI. Easily design, schedule, and publish posts from anywhere, anytime—ensuring you stay productive and connected no matter what device you\'re on. Download for AI Generator Advanced Dashboard Payment Gateways Multi-Lingual Custom Templates Support Platform Built for collaboration Collaborate seamlessly with your team, wherever they are. Our platform allows you to create, edit, and manage content together, making teamwork effortless. 😎 Partner Invite your colleagues and collaborators to join a team and maximize the benefits of AI. 🚀 Collaborate Invite your colleagues and collaborators to join a team and maximize the benefits of AI. 👥 Invite Invite your colleagues and collaborators to join a team and maximize the benefits of AI. So, how does it work? To create content quickly and effectively, here are the steps you can follow: 1 Simply explain what your content is about and adjust settings according to your needs. 2 Simply input some basic information or keywords about your brand or product, and let our AI algorithms do the rest. 3 View, edit or export your result with a few clicks. And you’re done! Want to see? Join Magic Reach global audience AI translates posts into multiple languages and helps you connect with audiences from different countries and cultures. Sarah J. Translates Podcasts into different languages. = 2 && $el.pause()\" x-intersect:enter=\"if ($el.src && 2 === $data.activeSlide && 0 === $data.activeCurtain && $el.readyState >= 2) { $el.play(); }\" @slide-changed-curtain6aa6a5c47a9cb9.56197701.window=\"if (2 === $data.activeSlide && 0 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" @curtain-changed-curtain6aa6a5c47a9cb9.56197701.window=\"if (($data.activeSlide == null || 2 === $data.activeSlide) && 0 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" > = 2 && $el.pause()\" x-intersect:enter=\"if ($el.src && 0 === $data.activeSlide && 1 === $data.activeCurtain && $el.readyState >= 2) { $el.play(); }\" @slide-changed-curtain6aa6a5c47a9cb9.56197701.window=\"if (0 === $data.activeSlide && 1 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" @curtain-changed-curtain6aa6a5c47a9cb9.56197701.window=\"if (($data.activeSlide == null || 0 === $data.activeSlide) && 1 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" > Jason R. Mary J. Mary J. We stay ahead of the curve by adopting the latest technologies and trends. Digital Agencies Product Designers Enterpreneurs Copywriters Digital Marketers Developers Trusted by millions. Peline Jan, Entrepreneur “Not only did it save me time, but it also helped me produce content that was more engaging and effective than what I had been creating on my own.” Tom Daniel, Writer As a freelance writer, I was looking for a tool that could help me generate ideas and write faster. This AI Text website has done that and more. Eric Sanchez, UX Designer The customer support team has been incredibly helpful whenever I’ve had any questions. I can’t imagine going back to my old content-creation methods! Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Flexible Pricing. Flexible pricing options that allow you to choose the best fit for your requirements All payments undergo processing through the associated payment gateway, ensuring complete security with 256-bit SSL encryption. Have a question? Our support team will get assistance from AI-powered suggestions, making it quicker than ever to handle support requests. How does it generate responses? MagicAI uses the most popular AI models such as GPT, Dall-E, Ada to create text, image, code and more within seconds. The process is simple. All you have to do is provide a topic or idea, and our AI-based generator will take care of the rest. Can I create templates or chat bots? You can use pre-made templates and examples for various content types and industries to help you get started quickly. You can even create your own chatbot or custom prompt template for further customization. Should I buy regular or extended license? If you plan to charge end users for the final product or service, you should buy the extended license in compliance with Envato’s terms of service, same as other projects: https://codecanyon.net/licenses/standard Can I translate the script into another language? Yes! MagicAI\'s multilingual capabilities apply to both content generation and dashboard language. You can easily translate it into other languages. A built-in translation tool is coming soon! Is there a mobile app for MagicAI? MagicAI provides an almost native-app experience thanks to its mobile-first approach. The entire layout is responsive and works great on any device regardless of the size.','url','https://magicai.nammoai.com/',NULL,'waiting','2026-09-13 13:31:50','2026-09-13 13:31:50'),(2,1,'MagicAI | Home New Unleash the Power of AI Ultimate AI Generator Chatbot Assistant with AI. All-in-one platform to generate AI content and start making money in minutes. Start Making Money Discover MagicAI No credit cart required. 10xFaster Content Creation over 5000+ businesses trust us to boost their social media precense Get Started Contact Us Trusted by these amazing companies AI Text Generator AI Image Generator AI Code Generator AI Chat Bot AI Speech To Text Empower Your Message with AI Say goodbye to writer\'s block AI Intelligent Writing Assistant Writer is designed to help you generate high-quality texts instantly, without breaking a sweat. With our intuitive interface and powerful features, you can easily edit, export, or publish your AI-generated result. Generate, edit, export. Powered by OpenAI. Unleash your creativity AI Create eye-catching images and graphics. Generate high-quality images for a wide range of applications. Imagine, Generate, Publish. Powered by Dall-E. The future of development AI Generate high-quality code in no time. MagicAI is designed to make coding faster, easier, and more efficient than ever before. Whether you’re a seasoned developer or a coding newbie, our tool will help you streamline your coding process and get your projects up and running in no time. Fix. Improve. Generate. Powered by OpenAI. Intuitive / Humanlike Chatbot AI Meet your next virtual assistant. Get instant answers to your questions, no matter the topic. Whether you’re looking to book a reservation, get product recommendations, or just chat about the weather, MagicAI is always ready and willing to help. Chat, Solve, Repeat. Powered by OpenAI. Say goodbye to writer\'s block AI Transcribe your speech into text. Accurately transcribe your recordings in just minutes. With our user-friendly interface, you can upload your files and have them transcribed in a matter of clicks. Upload, Analyze, Generate. Powered by OpenAI. Say goodbye to writer\'s block AI Transcribe your speech into text. From captivating commercials to engaging narrations, our AI voice will bring your words to life. With its seamless delivery, natural intonation, and unrivaled versatility, our AI VoiceOver is the perfect choice for any project. Effortlessly choose from a variety of voices and languages while adjusting the pace to your preference. Upload, Analyze, Generate. Powered by OpenAI. Custom Templates. Unrivaled AI Generators in terms of quality, versatility, and ease of use. Custom Generation Magic Tools. While making content creation effortless for users, it maximizes the quality of the results. Advanced Dashboard Track a wide range of data points, including user traffic and sales. Payment Gateways Securely process credit card or other electronic payment methods. Multilingual Ability to understand and generate content in different languages. Affiliate System Ability to invite friends, and earn commission from their first purchase. Easy Export Export generated content as plain text, PDF, Word or HTML easily. Support Platform Access and mage support tickets from your dashboard. Facebook Our AI tool helps you craft compelling content that resonates with your audience Whether it\'s a status update, promotional post, or a simple interaction. Twitter / X Create impactful X posts with our AI tool in seconds! Whether it\'s a quick update, an engaging tweet, or a conversation starter, generate posts that drive conversations and keep your followers engaged on X. Instagram Design eye-catching Instagram posts in no time with our AI-powered generator. From beautiful visuals to captivating captions, create Instagram content that stands out and grabs your followers\' attention. LinkedIn Build your professional presence with polished LinkedIn posts. Our AI helps you write insightful articles, thought-provoking updates, and attention-grabbing headlines that engage with your network. The future of AI. Easily design, schedule, and publish posts from anywhere, anytime—ensuring you stay productive and connected no matter what device you\'re on. Download for AI Generator Advanced Dashboard Payment Gateways Multi-Lingual Custom Templates Support Platform Built for collaboration Collaborate seamlessly with your team, wherever they are. Our platform allows you to create, edit, and manage content together, making teamwork effortless. 😎 Partner Invite your colleagues and collaborators to join a team and maximize the benefits of AI. 🚀 Collaborate Invite your colleagues and collaborators to join a team and maximize the benefits of AI. 👥 Invite Invite your colleagues and collaborators to join a team and maximize the benefits of AI. So, how does it work? To create content quickly and effectively, here are the steps you can follow: 1 Simply explain what your content is about and adjust settings according to your needs. 2 Simply input some basic information or keywords about your brand or product, and let our AI algorithms do the rest. 3 View, edit or export your result with a few clicks. And you’re done! Want to see? Join Magic Reach global audience AI translates posts into multiple languages and helps you connect with audiences from different countries and cultures. Sarah J. Translates Podcasts into different languages. = 2 && $el.pause()\" x-intersect:enter=\"if ($el.src && 2 === $data.activeSlide && 0 === $data.activeCurtain && $el.readyState >= 2) { $el.play(); }\" @slide-changed-curtain6aa6a5c4b80584.53225762.window=\"if (2 === $data.activeSlide && 0 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" @curtain-changed-curtain6aa6a5c4b80584.53225762.window=\"if (($data.activeSlide == null || 2 === $data.activeSlide) && 0 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" > = 2 && $el.pause()\" x-intersect:enter=\"if ($el.src && 0 === $data.activeSlide && 1 === $data.activeCurtain && $el.readyState >= 2) { $el.play(); }\" @slide-changed-curtain6aa6a5c4b80584.53225762.window=\"if (0 === $data.activeSlide && 1 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" @curtain-changed-curtain6aa6a5c4b80584.53225762.window=\"if (($data.activeSlide == null || 0 === $data.activeSlide) && 1 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" > Jason R. Mary J. Mary J. We stay ahead of the curve by adopting the latest technologies and trends. Digital Agencies Product Designers Enterpreneurs Copywriters Digital Marketers Developers Trusted by millions. Peline Jan, Entrepreneur “Not only did it save me time, but it also helped me produce content that was more engaging and effective than what I had been creating on my own.” Tom Daniel, Writer As a freelance writer, I was looking for a tool that could help me generate ideas and write faster. This AI Text website has done that and more. Eric Sanchez, UX Designer The customer support team has been incredibly helpful whenever I’ve had any questions. I can’t imagine going back to my old content-creation methods! Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Flexible Pricing. Flexible pricing options that allow you to choose the best fit for your requirements All payments undergo processing through the associated payment gateway, ensuring complete security with 256-bit SSL encryption. Have a question? Our support team will get assistance from AI-powered suggestions, making it quicker than ever to handle support requests. How does it generate responses? MagicAI uses the most popular AI models such as GPT, Dall-E, Ada to create text, image, code and more within seconds. The process is simple. All you have to do is provide a topic or idea, and our AI-based generator will take care of the rest. Can I create templates or chat bots? You can use pre-made templates and examples for various content types and industries to help you get started quickly. You can even create your own chatbot or custom prompt template for further customization. Should I buy regular or extended license? If you plan to charge end users for the final product or service, you should buy the extended license in compliance with Envato’s terms of service, same as other projects: https://codecanyon.net/licenses/standard Can I translate the script into another language? Yes! MagicAI\'s multilingual capabilities apply to both content generation and dashboard language. You can easily translate it into other languages. A built-in translation tool is coming soon! Is there a mobile app for MagicAI? MagicAI provides an almost native-app experience thanks to its mobile-first approach. The entire layout is responsive and works great on any device regardless of the size.','url','https://magicai.nammoai.com',NULL,'waiting','2026-09-13 13:31:50','2026-09-13 13:31:50'),(3,1,'MagicAI | Home New Unleash the Power of AI Ultimate AI Generator Chatbot Assistant with AI. All-in-one platform to generate AI content and start making money in minutes. Start Making Money Discover MagicAI No credit cart required. 10xFaster Content Creation over 5000+ businesses trust us to boost their social media precense Get Started Contact Us Trusted by these amazing companies AI Text Generator AI Image Generator AI Code Generator AI Chat Bot AI Speech To Text Empower Your Message with AI Say goodbye to writer\'s block AI Intelligent Writing Assistant Writer is designed to help you generate high-quality texts instantly, without breaking a sweat. With our intuitive interface and powerful features, you can easily edit, export, or publish your AI-generated result. Generate, edit, export. Powered by OpenAI. Unleash your creativity AI Create eye-catching images and graphics. Generate high-quality images for a wide range of applications. Imagine, Generate, Publish. Powered by Dall-E. The future of development AI Generate high-quality code in no time. MagicAI is designed to make coding faster, easier, and more efficient than ever before. Whether you’re a seasoned developer or a coding newbie, our tool will help you streamline your coding process and get your projects up and running in no time. Fix. Improve. Generate. Powered by OpenAI. Intuitive / Humanlike Chatbot AI Meet your next virtual assistant. Get instant answers to your questions, no matter the topic. Whether you’re looking to book a reservation, get product recommendations, or just chat about the weather, MagicAI is always ready and willing to help. Chat, Solve, Repeat. Powered by OpenAI. Say goodbye to writer\'s block AI Transcribe your speech into text. Accurately transcribe your recordings in just minutes. With our user-friendly interface, you can upload your files and have them transcribed in a matter of clicks. Upload, Analyze, Generate. Powered by OpenAI. Say goodbye to writer\'s block AI Transcribe your speech into text. From captivating commercials to engaging narrations, our AI voice will bring your words to life. With its seamless delivery, natural intonation, and unrivaled versatility, our AI VoiceOver is the perfect choice for any project. Effortlessly choose from a variety of voices and languages while adjusting the pace to your preference. Upload, Analyze, Generate. Powered by OpenAI. Custom Templates. Unrivaled AI Generators in terms of quality, versatility, and ease of use. Custom Generation Magic Tools. While making content creation effortless for users, it maximizes the quality of the results. Advanced Dashboard Track a wide range of data points, including user traffic and sales. Payment Gateways Securely process credit card or other electronic payment methods. Multilingual Ability to understand and generate content in different languages. Affiliate System Ability to invite friends, and earn commission from their first purchase. Easy Export Export generated content as plain text, PDF, Word or HTML easily. Support Platform Access and mage support tickets from your dashboard. Facebook Our AI tool helps you craft compelling content that resonates with your audience Whether it\'s a status update, promotional post, or a simple interaction. Twitter / X Create impactful X posts with our AI tool in seconds! Whether it\'s a quick update, an engaging tweet, or a conversation starter, generate posts that drive conversations and keep your followers engaged on X. Instagram Design eye-catching Instagram posts in no time with our AI-powered generator. From beautiful visuals to captivating captions, create Instagram content that stands out and grabs your followers\' attention. LinkedIn Build your professional presence with polished LinkedIn posts. Our AI helps you write insightful articles, thought-provoking updates, and attention-grabbing headlines that engage with your network. The future of AI. Easily design, schedule, and publish posts from anywhere, anytime—ensuring you stay productive and connected no matter what device you\'re on. Download for AI Generator Advanced Dashboard Payment Gateways Multi-Lingual Custom Templates Support Platform Built for collaboration Collaborate seamlessly with your team, wherever they are. Our platform allows you to create, edit, and manage content together, making teamwork effortless. 😎 Partner Invite your colleagues and collaborators to join a team and maximize the benefits of AI. 🚀 Collaborate Invite your colleagues and collaborators to join a team and maximize the benefits of AI. 👥 Invite Invite your colleagues and collaborators to join a team and maximize the benefits of AI. So, how does it work? To create content quickly and effectively, here are the steps you can follow: 1 Simply explain what your content is about and adjust settings according to your needs. 2 Simply input some basic information or keywords about your brand or product, and let our AI algorithms do the rest. 3 View, edit or export your result with a few clicks. And you’re done! Want to see? Join Magic Reach global audience AI translates posts into multiple languages and helps you connect with audiences from different countries and cultures. Sarah J. Translates Podcasts into different languages. = 2 && $el.pause()\" x-intersect:enter=\"if ($el.src && 2 === $data.activeSlide && 0 === $data.activeCurtain && $el.readyState >= 2) { $el.play(); }\" @slide-changed-curtain6aa6a5c531e2a5.35300453.window=\"if (2 === $data.activeSlide && 0 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" @curtain-changed-curtain6aa6a5c531e2a5.35300453.window=\"if (($data.activeSlide == null || 2 === $data.activeSlide) && 0 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" > = 2 && $el.pause()\" x-intersect:enter=\"if ($el.src && 0 === $data.activeSlide && 1 === $data.activeCurtain && $el.readyState >= 2) { $el.play(); }\" @slide-changed-curtain6aa6a5c531e2a5.35300453.window=\"if (0 === $data.activeSlide && 1 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" @curtain-changed-curtain6aa6a5c531e2a5.35300453.window=\"if (($data.activeSlide == null || 0 === $data.activeSlide) && 1 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" > Jason R. Mary J. Mary J. We stay ahead of the curve by adopting the latest technologies and trends. Digital Agencies Product Designers Enterpreneurs Copywriters Digital Marketers Developers Trusted by millions. Peline Jan, Entrepreneur “Not only did it save me time, but it also helped me produce content that was more engaging and effective than what I had been creating on my own.” Tom Daniel, Writer As a freelance writer, I was looking for a tool that could help me generate ideas and write faster. This AI Text website has done that and more. Eric Sanchez, UX Designer The customer support team has been incredibly helpful whenever I’ve had any questions. I can’t imagine going back to my old content-creation methods! Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Flexible Pricing. Flexible pricing options that allow you to choose the best fit for your requirements All payments undergo processing through the associated payment gateway, ensuring complete security with 256-bit SSL encryption. Have a question? Our support team will get assistance from AI-powered suggestions, making it quicker than ever to handle support requests. How does it generate responses? MagicAI uses the most popular AI models such as GPT, Dall-E, Ada to create text, image, code and more within seconds. The process is simple. All you have to do is provide a topic or idea, and our AI-based generator will take care of the rest. Can I create templates or chat bots? You can use pre-made templates and examples for various content types and industries to help you get started quickly. You can even create your own chatbot or custom prompt template for further customization. Should I buy regular or extended license? If you plan to charge end users for the final product or service, you should buy the extended license in compliance with Envato’s terms of service, same as other projects: https://codecanyon.net/licenses/standard Can I translate the script into another language? Yes! MagicAI\'s multilingual capabilities apply to both content generation and dashboard language. You can easily translate it into other languages. A built-in translation tool is coming soon! Is there a mobile app for MagicAI? MagicAI provides an almost native-app experience thanks to its mobile-first approach. The entire layout is responsive and works great on any device regardless of the size.','url','https://magicai.nammoai.com/language/en/change',NULL,'waiting','2026-09-13 13:31:50','2026-09-13 13:31:50'),(4,1,'MagicAI | Home New Unleash the Power of AI Ultimate AI Generator Chatbot Assistant with AI. All-in-one platform to generate AI content and start making money in minutes. Start Making Money Discover MagicAI No credit cart required. 10xFaster Content Creation over 5000+ businesses trust us to boost their social media precense Get Started Contact Us Trusted by these amazing companies AI Text Generator AI Image Generator AI Code Generator AI Chat Bot AI Speech To Text Empower Your Message with AI Say goodbye to writer\'s block AI Intelligent Writing Assistant Writer is designed to help you generate high-quality texts instantly, without breaking a sweat. With our intuitive interface and powerful features, you can easily edit, export, or publish your AI-generated result. Generate, edit, export. Powered by OpenAI. Unleash your creativity AI Create eye-catching images and graphics. Generate high-quality images for a wide range of applications. Imagine, Generate, Publish. Powered by Dall-E. The future of development AI Generate high-quality code in no time. MagicAI is designed to make coding faster, easier, and more efficient than ever before. Whether you’re a seasoned developer or a coding newbie, our tool will help you streamline your coding process and get your projects up and running in no time. Fix. Improve. Generate. Powered by OpenAI. Intuitive / Humanlike Chatbot AI Meet your next virtual assistant. Get instant answers to your questions, no matter the topic. Whether you’re looking to book a reservation, get product recommendations, or just chat about the weather, MagicAI is always ready and willing to help. Chat, Solve, Repeat. Powered by OpenAI. Say goodbye to writer\'s block AI Transcribe your speech into text. Accurately transcribe your recordings in just minutes. With our user-friendly interface, you can upload your files and have them transcribed in a matter of clicks. Upload, Analyze, Generate. Powered by OpenAI. Say goodbye to writer\'s block AI Transcribe your speech into text. From captivating commercials to engaging narrations, our AI voice will bring your words to life. With its seamless delivery, natural intonation, and unrivaled versatility, our AI VoiceOver is the perfect choice for any project. Effortlessly choose from a variety of voices and languages while adjusting the pace to your preference. Upload, Analyze, Generate. Powered by OpenAI. Custom Templates. Unrivaled AI Generators in terms of quality, versatility, and ease of use. Custom Generation Magic Tools. While making content creation effortless for users, it maximizes the quality of the results. Advanced Dashboard Track a wide range of data points, including user traffic and sales. Payment Gateways Securely process credit card or other electronic payment methods. Multilingual Ability to understand and generate content in different languages. Affiliate System Ability to invite friends, and earn commission from their first purchase. Easy Export Export generated content as plain text, PDF, Word or HTML easily. Support Platform Access and mage support tickets from your dashboard. Facebook Our AI tool helps you craft compelling content that resonates with your audience Whether it\'s a status update, promotional post, or a simple interaction. Twitter / X Create impactful X posts with our AI tool in seconds! Whether it\'s a quick update, an engaging tweet, or a conversation starter, generate posts that drive conversations and keep your followers engaged on X. Instagram Design eye-catching Instagram posts in no time with our AI-powered generator. From beautiful visuals to captivating captions, create Instagram content that stands out and grabs your followers\' attention. LinkedIn Build your professional presence with polished LinkedIn posts. Our AI helps you write insightful articles, thought-provoking updates, and attention-grabbing headlines that engage with your network. The future of AI. Easily design, schedule, and publish posts from anywhere, anytime—ensuring you stay productive and connected no matter what device you\'re on. Download for AI Generator Advanced Dashboard Payment Gateways Multi-Lingual Custom Templates Support Platform Built for collaboration Collaborate seamlessly with your team, wherever they are. Our platform allows you to create, edit, and manage content together, making teamwork effortless. 😎 Partner Invite your colleagues and collaborators to join a team and maximize the benefits of AI. 🚀 Collaborate Invite your colleagues and collaborators to join a team and maximize the benefits of AI. 👥 Invite Invite your colleagues and collaborators to join a team and maximize the benefits of AI. So, how does it work? To create content quickly and effectively, here are the steps you can follow: 1 Simply explain what your content is about and adjust settings according to your needs. 2 Simply input some basic information or keywords about your brand or product, and let our AI algorithms do the rest. 3 View, edit or export your result with a few clicks. And you’re done! Want to see? Join Magic Reach global audience AI translates posts into multiple languages and helps you connect with audiences from different countries and cultures. Sarah J. Translates Podcasts into different languages. = 2 && $el.pause()\" x-intersect:enter=\"if ($el.src && 2 === $data.activeSlide && 0 === $data.activeCurtain && $el.readyState >= 2) { $el.play(); }\" @slide-changed-curtain6aa6a5c5a3fea5.49559386.window=\"if (2 === $data.activeSlide && 0 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" @curtain-changed-curtain6aa6a5c5a3fea5.49559386.window=\"if (($data.activeSlide == null || 2 === $data.activeSlide) && 0 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" > = 2 && $el.pause()\" x-intersect:enter=\"if ($el.src && 0 === $data.activeSlide && 1 === $data.activeCurtain && $el.readyState >= 2) { $el.play(); }\" @slide-changed-curtain6aa6a5c5a3fea5.49559386.window=\"if (0 === $data.activeSlide && 1 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" @curtain-changed-curtain6aa6a5c5a3fea5.49559386.window=\"if (($data.activeSlide == null || 0 === $data.activeSlide) && 1 === $data.activeCurtain) { if(!$el.src) {$el.src = $el.getAttribute(\'data-src\'); $el.load()} $el.play(); } else { $el.pause(); }\" > Jason R. Mary J. Mary J. We stay ahead of the curve by adopting the latest technologies and trends. Digital Agencies Product Designers Enterpreneurs Copywriters Digital Marketers Developers Trusted by millions. Peline Jan, Entrepreneur “Not only did it save me time, but it also helped me produce content that was more engaging and effective than what I had been creating on my own.” Tom Daniel, Writer As a freelance writer, I was looking for a tool that could help me generate ideas and write faster. This AI Text website has done that and more. Eric Sanchez, UX Designer The customer support team has been incredibly helpful whenever I’ve had any questions. I can’t imagine going back to my old content-creation methods! Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Precision and Speed Affiliate Marketing Boost engagement Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Adaptive Intelligence 150% Subscriber Growth 10x Faster Content Creation Flexible Pricing. Flexible pricing options that allow you to choose the best fit for your requirements All payments undergo processing through the associated payment gateway, ensuring complete security with 256-bit SSL encryption. Have a question? Our support team will get assistance from AI-powered suggestions, making it quicker than ever to handle support requests. How does it generate responses? MagicAI uses the most popular AI models such as GPT, Dall-E, Ada to create text, image, code and more within seconds. The process is simple. All you have to do is provide a topic or idea, and our AI-based generator will take care of the rest. Can I create templates or chat bots? You can use pre-made templates and examples for various content types and industries to help you get started quickly. You can even create your own chatbot or custom prompt template for further customization. Should I buy regular or extended license? If you plan to charge end users for the final product or service, you should buy the extended license in compliance with Envato’s terms of service, same as other projects: https://codecanyon.net/licenses/standard Can I translate the script into another language? Yes! MagicAI\'s multilingual capabilities apply to both content generation and dashboard language. You can easily translate it into other languages. A built-in translation tool is coming soon! Is there a mobile app for MagicAI? MagicAI provides an almost native-app experience thanks to its mobile-first approach. The entire layout is responsive and works great on any device regardless of the size.','url','https://magicai.nammoai.com/language/ar/change',NULL,'waiting','2026-09-13 13:31:50','2026-09-13 13:31:50'),(5,1,'MagicAI | Sign in Sign in Email Address Password Remember me Forgot Password? Sign in Don&#039;t have account yet? Sign up Typing Copy Markdown Copy HTML','url','https://magicai.nammoai.com/login',NULL,'waiting','2026-09-13 13:31:50','2026-09-13 13:31:50'),(6,1,'MagicAI | Reset Password Forgot Password Email Address Send Instructions Typing Copy Markdown Copy HTML','url','https://magicai.nammoai.com/forgot-password',NULL,'waiting','2026-09-13 13:31:50','2026-09-13 13:31:50'),(7,1,'MagicAI | Register Sign up Email Address * Password * Confirm Your Password * Sign up Have an account? Sign in Typing Copy Markdown Copy HTML','url','https://magicai.nammoai.com/register',NULL,'waiting','2026-09-13 13:31:50','2026-09-13 13:31:50');
/*!40000 ALTER TABLE `chatbot_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot_data_vectors`
--

DROP TABLE IF EXISTS `chatbot_data_vectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot_data_vectors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chatbot_id` bigint DEFAULT NULL,
  `chatbot_data_id` bigint DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `embedding` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot_data_vectors`
--

LOCK TABLES `chatbot_data_vectors` WRITE;
/*!40000 ALTER TABLE `chatbot_data_vectors` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatbot_data_vectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot_history`
--

DROP TABLE IF EXISTS `chatbot_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `ip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_openai_chat_id` int DEFAULT NULL,
  `openai_chat_category_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot_history`
--

LOCK TABLES `chatbot_history` WRITE;
/*!40000 ALTER TABLE `chatbot_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatbot_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'assets/img/auth/default-avatar.png',
  `alt` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'1c.svg','Envato','Envato','2023-06-02 17:09:35','2023-06-02 17:09:35'),(2,'2c.svg','Envato','Envato','2023-06-02 17:09:35','2023-06-02 17:09:35'),(3,'4c.svg','Envato','Envato','2023-06-02 17:09:35','2023-06-02 17:09:35'),(4,'5c.svg','Envato','Envato','2023-06-02 17:09:35','2023-06-02 17:09:35'),(5,'6c.svg','Envato','Envato','2023-06-02 17:09:35','2023-06-02 17:09:35');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `companies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `industry` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `target_audience` text COLLATE utf8mb4_unicode_ci,
  `website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tagline` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specific_instructions` text COLLATE utf8mb4_unicode_ci,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tone_of_voice` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companies_user_id_foreign` (`user_id`),
  CONSTRAINT `companies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comparison_section_items`
--

DROP TABLE IF EXISTS `comparison_section_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comparison_section_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `others` tinyint(1) NOT NULL DEFAULT '0',
  `ours` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comparison_section_items`
--

LOCK TABLES `comparison_section_items` WRITE;
/*!40000 ALTER TABLE `comparison_section_items` DISABLE KEYS */;
INSERT INTO `comparison_section_items` VALUES (1,'Multiple AI Tools',0,1,NULL,NULL),(2,'Custom Templates and Chatbot Personas',0,1,NULL,NULL),(3,'All-in-one Platform',0,1,NULL,NULL),(4,'Knows Your Brand',0,1,NULL,NULL),(5,'Intelligent AI Assistant',0,1,NULL,NULL),(6,'PrePaid',0,1,NULL,NULL),(7,'Lifetime Access',0,1,NULL,NULL);
/*!40000 ALTER TABLE `comparison_section_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon_users`
--

DROP TABLE IF EXISTS `coupon_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `coupon_users_coupon_id_foreign` (`coupon_id`),
  KEY `coupon_users_user_id_foreign` (`user_id`),
  CONSTRAINT `coupon_users_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `coupon_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_users`
--

LOCK TABLES `coupon_users` WRITE;
/*!40000 ALTER TABLE `coupon_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupon_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount` decimal(5,2) NOT NULL,
  `is_offer` tinyint(1) NOT NULL DEFAULT '0',
  `is_offer_fixed_price` tinyint(1) NOT NULL DEFAULT '0',
  `limit` int DEFAULT NULL,
  `duration` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'once',
  `created_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `offer_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `coupons_created_by_foreign` (`created_by`),
  CONSTRAINT `coupons_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thousand_separator` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decimal_separator` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,'Albania','Leke','ALL','Lek',',','.'),(2,'America','Dollars','USD','$',',','.'),(3,'Afghanistan','Afghanis','AFN','؋',',','.'),(4,'Argentina','Pesos','ARS','$',',','.'),(5,'Aruba','Guilders','AWG','ƒ',',','.'),(6,'Australia','Dollars','AUD','$',',','.'),(7,'Azerbaijan','New Manats','AZN','ман',',','.'),(8,'Bahamas','Dollars','BSD','$',',','.'),(9,'Barbados','Dollars','BBD','$',',','.'),(10,'Belarus','Rubles','BYR','p.',',','.'),(11,'Belgium','Euro','EUR','€',',','.'),(12,'Beliz','Dollars','BZD','BZ$',',','.'),(13,'Bermuda','Dollars','BMD','$',',','.'),(14,'Bolivia','Bolivianos','BOB','$b',',','.'),(15,'Bosnia and Herzegovina','Convertible Marka','BAM','KM',',','.'),(16,'Botswana','Pula\'s','BWP','P',',','.'),(17,'Bulgaria','Leva','BGN','лв',',','.'),(18,'Brazil','Reais','BRL','R$',',','.'),(19,'Britain (United Kingdom)','Pounds','GBP','£',',','.'),(20,'Brunei Darussalam','Dollars','BND','$',',','.'),(21,'Cambodia','Riels','KHR','៛',',','.'),(22,'Canada','Dollars','CAD','$',',','.'),(23,'Cayman Islands','Dollars','KYD','$',',','.'),(24,'Chile','Pesos','CLP','$',',','.'),(25,'China','Yuan Renminbi','CNY','¥',',','.'),(26,'Colombia','Pesos','COP','$',',','.'),(27,'Costa Rica','Colón','CRC','₡',',','.'),(28,'Croatia','Kuna','HRK','kn',',','.'),(29,'Cuba','Pesos','CUP','₱',',','.'),(30,'Cyprus','Euro','EUR','€',',','.'),(31,'Czech Republic','Koruny','CZK','Kč',',','.'),(32,'Denmark','Kroner','DKK','kr',',','.'),(33,'Dominican Republic','Pesos','DOP ','RD$',',','.'),(34,'East Caribbean','Dollars','XCD','$',',','.'),(35,'Egypt','Pounds','EGP','£',',','.'),(36,'El Salvador','Colones','SVC','$',',','.'),(37,'England (United Kingdom)','Pounds','GBP','£',',','.'),(38,'Euro','Euro','EUR','€',',','.'),(39,'Falkland Islands','Pounds','FKP','£',',','.'),(40,'Fiji','Dollars','FJD','$',',','.'),(41,'France','Euro','EUR','€',',','.'),(42,'Ghana','Cedis','GHS','¢',',','.'),(43,'Gibraltar','Pounds','GIP','£',',','.'),(44,'Greece','Euro','EUR','€',',','.'),(45,'Guatemala','Quetzales','GTQ','Q',',','.'),(46,'Guernsey','Pounds','GGP','£',',','.'),(47,'Guyana','Dollars','GYD','$',',','.'),(48,'Holland (Netherlands)','Euro','EUR','€',',','.'),(49,'Honduras','Lempiras','HNL','L',',','.'),(50,'Hong Kong','Dollars','HKD','$',',','.'),(51,'Hungary','Forint','HUF','Ft',',','.'),(52,'Iceland','Kronur','ISK','kr',',','.'),(53,'India','Rupees','INR','₹',',','.'),(54,'Indonesia','Rupiahs','IDR','Rp',',','.'),(55,'Iran','Rials','IRR','﷼',',','.'),(56,'Ireland','Euro','EUR','€',',','.'),(57,'Isle of Man','Pounds','IMP','£',',','.'),(58,'Israel','New Shekels','ILS','₪',',','.'),(59,'Italy','Euro','EUR','€',',','.'),(60,'Jamaica','Dollars','JMD','J$',',','.'),(61,'Japan','Yen','JPY','¥',',','.'),(62,'Jersey','Pounds','JEP','£',',','.'),(63,'Kazakhstan','Tenge','KZT','лв',',','.'),(64,'Korea (North)','Won','KPW','₩',',','.'),(65,'Korea (South)','Won','KRW','₩',',','.'),(66,'Kyrgyzstan','Soms','KGS','лв',',','.'),(67,'Laos','Kips','LAK','₭',',','.'),(68,'Latvia','Lati','LVL','Ls',',','.'),(69,'Lebanon','Pounds','LBP','£',',','.'),(70,'Liberia','Dollars','LRD','$',',','.'),(71,'Liechtenstein','Switzerland Francs','CHF','CHF',',','.'),(72,'Lithuania','Litai','LTL','Lt',',','.'),(73,'Luxembourg','Euro','EUR','€',',','.'),(74,'Macedonia','Denars','MKD','ден',',','.'),(75,'Malaysia','Ringgits','MYR','RM',',','.'),(76,'Malta','Euro','EUR','€',',','.'),(77,'Mauritius','Rupees','MUR','₨',',','.'),(78,'Mexico','Pesos','MXN','$',',','.'),(79,'Mongolia','Tugriks','MNT','₮',',','.'),(80,'Mozambique','Meticais','MZN','MT',',','.'),(81,'Namibia','Dollars','NAD','$',',','.'),(82,'Nepal','Rupees','NPR','₨',',','.'),(83,'Netherlands Antilles','Guilders','ANG','ƒ',',','.'),(84,'Netherlands','Euro','EUR','€',',','.'),(85,'New Zealand','Dollars','NZD','$',',','.'),(86,'Nicaragua','Cordobas','NIO','C$',',','.'),(87,'Nigeria','Nairas','NGN','₦',',','.'),(88,'North Korea','Won','KPW','₩',',','.'),(89,'Norway','Krone','NOK','kr',',','.'),(90,'Oman','Rials','OMR','﷼',',','.'),(91,'Pakistan','Rupees','PKR','₨',',','.'),(92,'Panama','Balboa','PAB','B/.',',','.'),(93,'Paraguay','Guarani','PYG','Gs',',','.'),(94,'Peru','Nuevos Soles','PEN','S/.',',','.'),(95,'Philippines','Pesos','PHP','Php',',','.'),(96,'Poland','Zlotych','PLN','zł',',','.'),(97,'Qatar','Rials','QAR','﷼',',','.'),(98,'Romania','New Lei','RON','lei',',','.'),(99,'Russia','Rubles','RUB','руб',',','.'),(100,'Saint Helena','Pounds','SHP','£',',','.'),(101,'Saudi Arabia','Riyals','SAR','﷼',',','.'),(102,'Serbia','Dinars','RSD','Дин.',',','.'),(103,'Seychelles','Rupees','SCR','₨',',','.'),(104,'Singapore','Dollars','SGD','$',',','.'),(105,'Slovenia','Euro','EUR','€',',','.'),(106,'Solomon Islands','Dollars','SBD','$',',','.'),(107,'Somalia','Shillings','SOS','S',',','.'),(108,'South Africa','Rand','ZAR','R',',','.'),(109,'South Korea','Won','KRW','₩',',','.'),(110,'Spain','Euro','EUR','€',',','.'),(111,'Sri Lanka','Rupees','LKR','₨',',','.'),(112,'Sweden','Kronor','SEK','kr',',','.'),(113,'Switzerland','Francs','CHF','CHF',',','.'),(114,'Suriname','Dollars','SRD','$',',','.'),(115,'Syria','Pounds','SYP','£',',','.'),(116,'Taiwan','New Dollars','TWD','NT$',',','.'),(117,'Thailand','Baht','THB','฿',',','.'),(118,'Trinidad and Tobago','Dollars','TTD','TT$',',','.'),(119,'Turkey','Lira','TRY','TL',',','.'),(120,'Turkey','Liras','TRL','£',',','.'),(121,'Tuvalu','Dollars','TVD','$',',','.'),(122,'Ukraine','Hryvnia','UAH','₴',',','.'),(123,'United Kingdom','Pounds','GBP','£',',','.'),(124,'United States of America','Dollars','USD','$',',','.'),(125,'Uruguay','Pesos','UYU','$U',',','.'),(126,'Uzbekistan','Sums','UZS','лв',',','.'),(127,'Vatican City','Euro','EUR','€',',','.'),(128,'Venezuela','Bolivares Fuertes','VEF','Bs',',','.'),(129,'Vietnam','Dong','VND','₫',',','.'),(130,'Yemen','Rials','YER','﷼',',','.'),(131,'Zimbabwe','Zimbabwe Dollars','ZWD','Z$',',','.'),(132,'West African CFA franc','Francs','XOF','CFA',',','.');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_biling_plans`
--

DROP TABLE IF EXISTS `custom_biling_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_biling_plans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `gateway` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main_plan_price_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_plan_price_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_biling_plans`
--

LOCK TABLES `custom_biling_plans` WRITE;
/*!40000 ALTER TABLE `custom_biling_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_biling_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customsettings`
--

DROP TABLE IF EXISTS `customsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customsettings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_str` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_text` text COLLATE utf8mb4_unicode_ci,
  `value_longtext` longtext COLLATE utf8mb4_unicode_ci,
  `value_html` text COLLATE utf8mb4_unicode_ci,
  `value_int` int NOT NULL DEFAULT '0',
  `value_bigint` bigint DEFAULT NULL,
  `value_ubigint` bigint unsigned DEFAULT NULL,
  `value_double` double NOT NULL DEFAULT '0',
  `value_bool` tinyint(1) NOT NULL DEFAULT '0',
  `value_date` date DEFAULT NULL,
  `value_timestamp` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customsettings`
--

LOCK TABLES `customsettings` WRITE;
/*!40000 ALTER TABLE `customsettings` DISABLE KEYS */;
INSERT INTO `customsettings` VALUES (1,'howitworks_bottomline','Used in How it Works section bottom line. Controls visibility and HTML value of line.',NULL,NULL,NULL,'Want to see? <a class=\"text-[#FCA7FF]\" href=\"https://codecanyon.net/item/magicai-openai-content-text-image-chat-code-generator-as-saas/45408109\">Join Magic</a>',1,NULL,NULL,0,0,NULL,NULL,'2026-09-12 17:41:04','2026-09-12 17:41:04');
/*!40000 ALTER TABLE `customsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_widgets`
--

DROP TABLE IF EXISTS `dashboard_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_widgets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `order` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_widgets`
--

LOCK TABLES `dashboard_widgets` WRITE;
/*!40000 ALTER TABLE `dashboard_widgets` DISABLE KEYS */;
INSERT INTO `dashboard_widgets` VALUES (1,'premium-advantages',1,0,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(2,'what-is-new',1,1,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(3,'usage-overview',1,2,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(4,'finance',1,3,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(5,'revenue-source',1,4,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(6,'api-cost-distribution',1,5,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(7,'top-countries',1,6,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(8,'cost-management',1,7,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(9,'new-customers',1,8,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(10,'recent-transactions',1,9,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(11,'users-and-platform',1,10,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(12,'user-traffic',1,11,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(13,'popular-ai-tools',1,12,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(14,'generated-content',1,13,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(15,'users',1,14,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(16,'user-client',1,15,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(17,'recent-activity',1,16,'2026-09-12 17:22:04','2026-09-12 17:22:04'),(18,'system-status',1,17,'2026-09-12 17:22:04','2026-09-12 17:22:04');
/*!40000 ALTER TABLE `dashboard_widgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domains`
--

DROP TABLE IF EXISTS `domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `domains` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `domain` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `app_key` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chatbot_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domains_chatbot_id_domain_unique` (`chatbot_id`,`domain`),
  UNIQUE KEY `domains_uuid_unique` (`uuid`),
  KEY `domains_chatbot_id_index` (`chatbot_id`),
  CONSTRAINT `domains_chatbot_id_foreign` FOREIGN KEY (`chatbot_id`) REFERENCES `chatbot` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domains`
--

LOCK TABLES `domains` WRITE;
/*!40000 ALTER TABLE `domains` DISABLE KEYS */;
/*!40000 ALTER TABLE `domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elevenlab_voices`
--

DROP TABLE IF EXISTS `elevenlab_voices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elevenlab_voices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `voice_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elevenlab_voices`
--

LOCK TABLES `elevenlab_voices` WRITE;
/*!40000 ALTER TABLE `elevenlab_voices` DISABLE KEYS */;
/*!40000 ALTER TABLE `elevenlab_voices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_templates`
--

DROP TABLE IF EXISTS `email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_templates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `system` tinyint(1) NOT NULL DEFAULT '1',
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates`
--

LOCK TABLES `email_templates` WRITE;
/*!40000 ALTER TABLE `email_templates` DISABLE KEYS */;
INSERT INTO `email_templates` VALUES (1,1,'Successful Subscription','Successful Subscription Email','<div style=\"padding: 0 19px\">\r\n    <h1>Hello, {user_name}!</h1>\r\n    <h2>You have successfully subscribed to {site_name}!</h2>\r\n\r\n    <p>Thank you for subscribing to our {plan_name} plan. Your subscription is now active.</p>\r\n      <p>Thank you for choosing {site_name}.</p>\r\n    <p>Click <a href=\"{login_url}\">here</a> to login to your account.</p>\r\n    <p>Click <a href=\"{site_url}\">here</a> to visit our site.</p>\r\n</div>\r\n\r\n<br>\r\n\r\n<a href=\"{login_url}\" class=\"btn btn-lg btn-block btn-round\">\r\n    Login to Your Account\r\n</a>\r\n\r\n<p class=\"need-help-p\">Need help? <a href=\"{site_url}\">Contact us.</a></p>',NULL,NULL,'subscription-successful'),(2,1,'Successful Payment','Successful Payment Email','<div style=\"padding: 0 19px\">\r\n    <h1>Hello, {user_name}!</h1>\r\n    <h2>Your payment was successful!</h2>\r\n\r\n    <p>Thank you for your payment. Your payment has been successfully processed for our {plan_name} plan.</p>\r\n    <ul>\r\n    <p>Thank you for choosing {site_name}.</p>\r\n    <p>Click <a href=\"{login_url}\">here</a> to login to your account.</p>\r\n    <p>Click <a href=\"{site_url}\">here</a> to visit our site.</p>\r\n</div>\r\n\r\n<br>\r\n\r\n<a href=\"{login_url}\" class=\"btn btn-lg btn-block btn-round\">\r\n    Login to Your Account\r\n</a>\r\n\r\n<p class=\"need-help-p\">Need help? <a href=\"{site_url}\">Contact us.</a></p>',NULL,NULL,'payment-successful');
/*!40000 ALTER TABLE `email_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engines`
--

DROP TABLE IF EXISTS `engines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `engines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'enabled',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_engines_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engines`
--

LOCK TABLES `engines` WRITE;
/*!40000 ALTER TABLE `engines` DISABLE KEYS */;
INSERT INTO `engines` VALUES (1,'openai','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(2,'piapi','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(3,'deep_seek','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(4,'stable_diffusion','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(5,'anthropic','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(6,'gemini','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(7,'unsplash','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(8,'pexels','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(9,'pixabay','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(10,'elevenlabs','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(11,'google','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(12,'azure','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(13,'speechify','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(14,'serper','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(15,'perplexity','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(16,'clipdrop','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(17,'novita','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(18,'freepik','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(19,'plagiarism_check','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(20,'synthesia','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(21,'heygen','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(22,'pebblely','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(23,'fal_ai','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(24,'gamma_ai','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(25,'x_ai','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(26,'minimax','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(27,'open_router','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(28,'together','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(29,'creatify','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(30,'topview','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(31,'vizard','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(32,'klap','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47'),(33,'captions','enabled','2026-09-12 17:01:47','2026-09-12 17:01:47');
/*!40000 ALTER TABLE `engines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entities`
--

DROP TABLE IF EXISTS `entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `engine` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'openai',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `selected_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_selected` tinyint(1) NOT NULL DEFAULT '0',
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'enabled',
  `effort` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entities`
--

LOCK TABLES `entities` WRITE;
/*!40000 ALTER TABLE `entities` DISABLE KEYS */;
INSERT INTO `entities` VALUES (1,'claude-fable-5','Claude Fable 5',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Fable 5',0,'enabled',NULL),(2,'claude-sonnet-5','Claude Sonnet 5',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Sonnet 5',0,'enabled',NULL),(3,'claude-sonnet-4-5-20250929','Claude Sonnet 4.5',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Sonnet 4.5',0,'enabled',NULL),(4,'claude-sonnet-4-6','Claude Sonnet 4.6',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Sonnet 4.6',0,'enabled',NULL),(5,'claude-sonnet-4-20250514','Claude Sonnet 4',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Sonnet 4',0,'enabled',NULL),(6,'claude-3-7-sonnet-20250219','Claude 3.7 Sonnet',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude 3.7 Sonnet',0,'enabled',NULL),(7,'claude-3-5-sonnet-20241022','Claude 3.5 Sonnet V2',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude 3.5 Sonnet V2',0,'enabled',NULL),(8,'claude-3-5-sonnet-20240620','Claude 3.5 Sonnet',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude 3.5 Sonnet',0,'enabled',NULL),(9,'claude-3-sonnet-20240229','Claude 3 Sonnet',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude 3 Sonnet',0,'enabled',NULL),(10,'claude-opus-5','Claude Opus 5',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Opus 5',0,'enabled',NULL),(11,'claude-opus-4-8','Claude Opus 4.8',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Opus 4.8',0,'enabled',NULL),(12,'claude-opus-4-7','Claude Opus 4.7',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Opus 4.7',0,'enabled',NULL),(13,'claude-opus-4-6','Claude Opus 4.6',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Opus 4.6',0,'enabled',NULL),(14,'claude-opus-4-5-20251101','Claude Opus 4.5',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Opus 4.5',0,'enabled',NULL),(15,'claude-opus-4-1-20250805','Claude Opus 4.1',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Opus 4.1',0,'enabled',NULL),(16,'claude-opus-4-20250514','Claude Opus 4',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude Opus 4',0,'enabled',NULL),(17,'claude-3-opus-20240229','Claude 3 Opus',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude 3 Opus',0,'enabled',NULL),(18,'claude-3-haiku-20241022','Claude 3.5 Haiku',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude 3.5 Haiku',0,'enabled',NULL),(19,'claude-3-haiku-20240307','Claude 3 Haiku',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude 3 Haiku',0,'enabled',NULL),(20,'claude-2.1','Claude 2.1',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude 2.1',0,'enabled',NULL),(21,'claude-2.0','Claude 2',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Claude 2',0,'enabled',NULL),(22,'voyage-2','Voyage 2',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Voyage 2',0,'enabled',NULL),(23,'voyage-large-2','Voyage Large 2',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Voyage Large 2',0,'enabled',NULL),(24,'voyage-code-2','Voyage Code 2',NULL,'anthropic','2026-09-12 17:01:47','2026-09-12 17:22:03','Voyage Code 2',0,'enabled',NULL),(25,'davinci-002','Davinci 002 (Expensive &amp; Capable)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','Davinci 002 (Expensive &amp; Capable)',0,'enabled',NULL),(26,'text-davinci-003','Davinci 003 (Expensive &amp; Capable)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','Davinci 003 (Expensive &amp; Capable)',0,'enabled',NULL),(27,'gpt-3.5-turbo','GPT 3.5-turbo (Most Expensive & Fastest & Most Capable)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT 3.5-turbo (Most Expensive & Fastest & Most Capable)',0,'enabled',NULL),(28,'gpt-3.5-turbo-0125','GTP 3.5-turbo-0125 (Updated Knowleddge cutoff of Sep 2021, 16k)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GTP 3.5-turbo-0125 (Updated Knowleddge cutoff of Sep 2021, 16k)',0,'enabled',NULL),(29,'gpt-3.5-turbo-1106','GTP 3.5-turbo-1106 (Updated Knowleddge cutoff of Nov 2021, 16k)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GTP 3.5-turbo-1106 (Updated Knowleddge cutoff of Nov 2021, 16k)',0,'enabled',NULL),(30,'gpt-4','GPT-4 (Most Expensive & Fastest & Most Capable)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4 (Most Expensive & Fastest & Most Capable)',0,'enabled',NULL),(31,'gpt-4-turbo','GPT-4 Turbo (Most Expensive & Fastest & Most Capable)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4 Turbo (Most Expensive & Fastest & Most Capable)',0,'enabled',NULL),(32,'gpt-4-1106-preview','GPT-4-1106 Turbo (Updated Knowleddge cutoff of April 2023, 128k)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4-1106 Turbo (Updated Knowleddge cutoff of April 2023, 128k)',0,'enabled',NULL),(33,'gpt-4-0125-preview','GPT-4-0125 Turbo (Updated Knowleddge cutoff of Dec 2023, 128k)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4-0125 Turbo (Updated Knowleddge cutoff of Dec 2023, 128k)',0,'enabled',NULL),(34,'gpt-4o','GPT-4o Most advanced works for Vision, multimodal flagship model that’s cheaper and faster than GPT-4 Turbo.  (Updated Knowleddge cutoff of Oct 2023, 128k)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4o Most advanced works for Vision, multimodal flagship model that’s cheaper and faster than GPT-4 Turbo.  (Updated Knowleddge cutoff of Oct 2023, 128k)',0,'enabled',NULL),(35,'gpt-4o-mini','GPT-4o mini Our affordable and intelligent small model for fast, lightweight tasks. GPT-4o mini is cheaper and more capable than GPT-3.5 Turbo.',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4o mini Our affordable and intelligent small model for fast, lightweight tasks. GPT-4o mini is cheaper and more capable than GPT-3.5 Turbo.',0,'enabled',NULL),(36,'gpt-4o-search-preview','GPT-4o Search Preview',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4o Search Preview',0,'enabled',NULL),(37,'gpt-4o-mini-search-preview','GPT-4o Mini Search Preview',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4o Mini Search Preview',0,'enabled',NULL),(38,'o1-preview','GPT o1-preview (Updated Knowledge cutoff of Dec 2023, 128k)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT o1-preview (Updated Knowledge cutoff of Dec 2023, 128k)',0,'enabled',NULL),(39,'o1-mini','GPT o1-mini (Updated Knowledge cutoff of Dec 2023, 128k)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT o1-mini (Updated Knowledge cutoff of Dec 2023, 128k)',0,'enabled',NULL),(40,'o1','GPT o1 (Updated Knowledge cutoff of Dec 2023, 128k)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT o1 (Updated Knowledge cutoff of Dec 2023, 128k)',0,'enabled',NULL),(41,'o3-mini','GPT o3-mini (Updated Knowledge cutoff of October 2023, 200k)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT o3-mini (Updated Knowledge cutoff of October 2023, 200k)',0,'enabled',NULL),(42,'gpt-4o-realtime-preview-2024-12-17','GPT-4o Realtime Preview (Updated Knowledge cutoff of December 2024, 128k)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4o Realtime Preview (Updated Knowledge cutoff of December 2024, 128k)',0,'enabled',NULL),(43,'gpt-realtime','GPT Realtime (GA, 32k)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT Realtime (GA, 32k)',0,'enabled',NULL),(44,'gpt-live-1','GPT-Live 1 (Preview — API access pending)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-Live 1 (Preview — API access pending)',0,'enabled',NULL),(45,'gpt-live-1-mini','GPT-Live 1 Mini (Preview — API access pending)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-Live 1 Mini (Preview — API access pending)',0,'enabled',NULL),(46,'gpt-4.1','GPT-4.1 (Jun 01, 2024 knowledge cutoff, 32k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4.1 (Jun 01, 2024 knowledge cutoff, 32k max output tokens.)',0,'enabled',NULL),(47,'gpt-4.1-mini','GPT-4.1 Mini (Jun 01, 2024 knowledge cutoff, 32k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4.1 Mini (Jun 01, 2024 knowledge cutoff, 32k max output tokens.)',0,'enabled',NULL),(48,'gpt-4.1-nano','GPT-4.1 Nano (Jun 01, 2024 knowledge cutoff, 32k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-4.1 Nano (Jun 01, 2024 knowledge cutoff, 32k max output tokens.)',0,'enabled',NULL),(49,'o4-mini','GPT o4-mini (Jun 01, 2024 knowledge cutoff, 100k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT o4-mini (Jun 01, 2024 knowledge cutoff, 100k max output tokens.)',0,'enabled',NULL),(50,'o3','GPT o3 (Jun 01, 2024 knowledge cutoff, 100k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT o3 (Jun 01, 2024 knowledge cutoff, 100k max output tokens.)',0,'enabled',NULL),(51,'gpt-5','GPT-5 (Oct 01, 2024 knowledge cutoff, 128k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5 (Oct 01, 2024 knowledge cutoff, 128k max output tokens.)',0,'enabled',NULL),(52,'gpt-5-mini','GPT-5 Mini (May 31, 2024 knowledge cutoff, 128k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5 Mini (May 31, 2024 knowledge cutoff, 128k max output tokens.)',0,'enabled',NULL),(53,'gpt-5-nano','GPT-5 Nano (May 31, 2024 knowledge cutoff, 128k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5 Nano (May 31, 2024 knowledge cutoff, 128k max output tokens.)',0,'enabled',NULL),(54,'gpt-5-chat-latest','GPT-5 Chat (Sep 30, 2024 knowledge cutoff, 128k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5 Chat (Sep 30, 2024 knowledge cutoff, 128k max output tokens.)',0,'enabled',NULL),(55,'gpt-5-pro','GPT-5 Pro (Sep 30, 2024 knowledge cutoff, 272k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5 Pro (Sep 30, 2024 knowledge cutoff, 272k max output tokens.)',0,'enabled',NULL),(56,'gpt-5.1','GPT-5.1 (Sep 30, 2024 knowledge cutoff, 128k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.1 (Sep 30, 2024 knowledge cutoff, 128k max output tokens.)',0,'enabled',NULL),(57,'gpt-5.1-chat-latest','GPT-5.1 Chat (Sep 30, 2024 knowledge cutoff, 16k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.1 Chat (Sep 30, 2024 knowledge cutoff, 16k max output tokens.)',0,'enabled',NULL),(58,'gpt-5.2','GPT-5.2 (Aug 31, 2025 knowledge cutoff, 128k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.2 (Aug 31, 2025 knowledge cutoff, 128k max output tokens.)',0,'enabled',NULL),(59,'gpt-5.2-pro','GPT-5.2 Pro (Aug 31, 2025 knowledge cutoff, 128k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.2 Pro (Aug 31, 2025 knowledge cutoff, 128k max output tokens.)',0,'enabled',NULL),(60,'gpt-5.3-chat-latest','GPT-5.3 Instant (Aug 31, 2025 knowledge cutoff, 16k max output tokens.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.3 Instant (Aug 31, 2025 knowledge cutoff, 16k max output tokens.)',0,'enabled',NULL),(61,'gpt-5.4','GPT-5.4 (Aug 31, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.4 (Aug 31, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',0,'enabled',NULL),(62,'gpt-5.4-mini','GPT-5.4 Mini (Aug 31, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.4 Mini (Aug 31, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',0,'enabled',NULL),(63,'gpt-5.4-nano','GPT-5.4 Nano (Aug 31, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.4 Nano (Aug 31, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',0,'enabled',NULL),(64,'gpt-5.5','GPT-5.5 (Dec 01, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.5 (Dec 01, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',0,'enabled',NULL),(65,'gpt-5.6-sol','GPT-5.6 Sol (Dec 01, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.6 Sol (Dec 01, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',0,'enabled',NULL),(66,'gpt-5.6-terra','GPT-5.6 Terra (Dec 01, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.6 Terra (Dec 01, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',0,'enabled',NULL),(67,'gpt-5.6-luna','GPT-5.6 Luna (Dec 01, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-5.6 Luna (Dec 01, 2025 knowledge cutoff, 128k max output tokens, 1.05M context.)',0,'enabled',NULL),(68,'o3-deep-research','o3 Deep Research (Multi-step web research with detailed reports)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','o3 Deep Research (Multi-step web research with detailed reports)',0,'enabled',NULL),(69,'o4-mini-deep-research','o4-mini Deep Research (Fast multi-step web research with reports)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','o4-mini Deep Research (Fast multi-step web research with reports)',0,'enabled',NULL),(70,'sora-2','Sora 2 (Flagship video generation with synced audio)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','Sora 2 (Flagship video generation with synced audio)',0,'enabled',NULL),(71,'sora-2-pro','Sora 2 Pro (Most advanced synced-audio video generation)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','Sora 2 Pro (Most advanced synced-audio video generation)',0,'enabled',NULL),(72,'text-embedding-ada-002','Text Embedding Ada (Expensive &amp; Capable)',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','Text Embedding Ada (Expensive &amp; Capable)',0,'enabled',NULL),(73,'text-embedding-3-small','Text Embedding Small',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','Text Embedding Small',0,'enabled',NULL),(74,'text-embedding-3-large','Text Embedding Large',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','Text Embedding Large',0,'enabled',NULL),(75,'image-to-video','AI Video',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','AI Video',0,'enabled',NULL),(76,'stable-diffusion-xl-1024-v1-0','Stable Diffusion XL 1.0',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Stable Diffusion XL 1.0',0,'enabled',NULL),(77,'stable-diffusion-v1-6','Stable Diffusion 1.6',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Stable Diffusion 1.6',0,'enabled',NULL),(78,'sd3','Stable Diffusion 3',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Stable Diffusion 3',0,'enabled',NULL),(79,'sd3-turbo','Stable Diffusion 3 turbo',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Stable Diffusion 3 turbo',0,'enabled',NULL),(80,'sd3-medium','Stable Diffusion 3 Medium',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Stable Diffusion 3 Medium',0,'enabled',NULL),(81,'sd3-large','Stable Diffusion 3 Large',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Stable Diffusion 3 Large',0,'enabled',NULL),(82,'sd3-large-turbo','Stable Diffusion 3 Large Turbo',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Stable Diffusion 3 Large Turbo',0,'enabled',NULL),(83,'sd3.5-large','Stable Diffusion 3.5 Large',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Stable Diffusion 3.5 Large',0,'enabled',NULL),(84,'sd3.5-large-turbo','Stable Diffusion 3.5 Large Turbo',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Stable Diffusion 3.5 Large Turbo',0,'enabled',NULL),(85,'sd3.5-medium','Stable Diffusion 3.5 Medium',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Stable Diffusion 3.5 Medium',0,'enabled',NULL),(86,'core','Core',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Core',0,'enabled',NULL),(87,'ultra','Ultra',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','Ultra',0,'enabled',NULL),(88,'aws_bedrock','AWS Bedrock',NULL,'stable_diffusion','2026-09-12 17:01:47','2026-09-12 17:22:03','AWS Bedrock',0,'enabled',NULL),(89,'gemini-2.5-flash-preview-05-20','Gemini 2.5 Flash Preview 05-20 Adaptive thinking, cost efficiency',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 2.5 Flash Preview 05-20 Adaptive thinking, cost efficiency',0,'enabled',NULL),(90,'gemini-3-pro-preview','Gemini 3 Pro Preview The most intelligent model family to date, built on a foundation of state-of-the-art reasoning.',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 3 Pro Preview The most intelligent model family to date, built on a foundation of state-of-the-art reasoning.',0,'enabled',NULL),(91,'gemini-3.1-pro-preview','Gemini 3.1 Pro Preview Refined performance and reliability, thinking, multimodal, function calling, structured outputs.',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 3.1 Pro Preview Refined performance and reliability, thinking, multimodal, function calling, structured outputs.',0,'enabled',NULL),(92,'gemini-2.5-pro','Gemini 2.5 Pro Preview Enhanced thinking and reasoning, multimodal understanding, advanced coding, and more',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 2.5 Pro Preview Enhanced thinking and reasoning, multimodal understanding, advanced coding, and more',0,'enabled',NULL),(93,'gemini-deep-research','Gemini Deep Research (Multi-step web research with detailed reports)',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini Deep Research (Multi-step web research with detailed reports)',0,'enabled',NULL),(94,'gemini-2.0-flash','Gemini 2.0 Flash Next generation features, speed, thinking, realtime streaming, and multimodal generation',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 2.0 Flash Next generation features, speed, thinking, realtime streaming, and multimodal generation',0,'enabled',NULL),(95,'gemini-2.0-flash-lite','Gemini 2.0 Flash-Lite Cost efficiency and low latency',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 2.0 Flash-Lite Cost efficiency and low latency',0,'enabled',NULL),(96,'gemini-1.5-pro','Gemini 1.5 Pro Complex reasoning tasks requiring more intelligence',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 1.5 Pro Complex reasoning tasks requiring more intelligence',0,'enabled',NULL),(97,'gemini-embedding-exp','Gemini Embedding Measuring the relatedness of text strings',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini Embedding Measuring the relatedness of text strings',0,'enabled',NULL),(98,'gemini-1.5-flash','Gemini 1.5 Flash Fast and versatile performance across a diverse variety of tasks',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 1.5 Flash Fast and versatile performance across a diverse variety of tasks',0,'enabled',NULL),(99,'gemini-3-flash-preview','Gemini 3 Flash Advanced reasoning, coding, and multimodal capabilities with high speed',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 3 Flash Advanced reasoning, coding, and multimodal capabilities with high speed',0,'enabled',NULL),(100,'gemini-3.1-flash-live-preview','Gemini 3.1 Flash Live Preview Low-latency audio-to-audio model for real-time dialogue',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 3.1 Flash Live Preview Low-latency audio-to-audio model for real-time dialogue',0,'enabled',NULL),(101,'gemini-3.5-flash','Gemini 3.5 Flash Frontier intelligence at higher speed and lower cost, built for agentic deployment and multi-step workflows',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 3.5 Flash Frontier intelligence at higher speed and lower cost, built for agentic deployment and multi-step workflows',0,'enabled',NULL),(102,'gemini-3.5-flash-lite','Gemini 3.5 Flash-Lite Low-latency, cost-effective multimodal model for high-throughput subagent tasks and document parsing',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 3.5 Flash-Lite Low-latency, cost-effective multimodal model for high-throughput subagent tasks and document parsing',0,'enabled',NULL),(103,'gemini-3.6-flash','Gemini 3.6 Flash Frontier intelligence for code generation, agentic execution, and spatial reasoning',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini 3.6 Flash Frontier intelligence for code generation, agentic execution, and spatial reasoning',0,'enabled',NULL),(104,'text-embedding-004','Gemini Text Embeding 004',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini Text Embeding 004',0,'enabled',NULL),(105,'clipdrop','Clipdrop for Photo Studio',NULL,'clipdrop','2026-09-12 17:01:47','2026-09-12 17:22:03','Clipdrop for Photo Studio',0,'enabled',NULL),(106,'novita','Novita for Photo Studio',NULL,'novita','2026-09-12 17:01:47','2026-09-12 17:22:03','Novita for Photo Studio',0,'enabled',NULL),(107,'freepik','Novita for Image Editor',NULL,'freepik','2026-09-12 17:01:47','2026-09-12 17:22:03','Novita for Image Editor',0,'enabled',NULL),(108,'plagiarismcheck','Plagiarism Check',NULL,'plagiarism_check','2026-09-12 17:01:47','2026-09-12 17:22:03','Plagiarism Check',0,'enabled',NULL),(109,'synthesia','Synthesia',NULL,'synthesia','2026-09-12 17:01:47','2026-09-12 17:22:03','Synthesia',0,'enabled',NULL),(110,'heygen','Heygen',NULL,'heygen','2026-09-12 17:01:47','2026-09-12 17:22:03','Heygen',0,'enabled',NULL),(111,'video-dubbing','Video Dubbing',NULL,'heygen','2026-09-12 17:01:47','2026-09-12 17:22:03','Video Dubbing',0,'enabled',NULL),(112,'ai-captions','AI Captions',NULL,'captions','2026-09-12 17:01:47','2026-09-12 17:22:03','AI Captions',0,'enabled',NULL),(113,'pebblely','Pebblely',NULL,'pebblely','2026-09-12 17:01:47','2026-09-12 17:22:03','Pebblely',0,'enabled',NULL),(114,'deepseek-chat','Deepseek Chat',NULL,'deep_seek','2026-09-12 17:01:47','2026-09-12 17:22:03','Deepseek Chat',0,'enabled',NULL),(115,'deepseek-reasoner','Deepseek DeepSeek-R1',NULL,'deep_seek','2026-09-12 17:01:47','2026-09-12 17:22:03','Deepseek DeepSeek-R1',0,'enabled',NULL),(116,'unsplash','Unsplash for AI Article Wizard',NULL,'unsplash','2026-09-12 17:01:47','2026-09-12 17:22:03','Unsplash for AI Article Wizard',0,'enabled',NULL),(117,'pexels','Pexels for AI Article Wizard',NULL,'pexels','2026-09-12 17:01:47','2026-09-12 17:22:03','Pexels for AI Article Wizard',0,'enabled',NULL),(118,'pixabay','Pixabay for AI Article Wizard',NULL,'pixabay','2026-09-12 17:01:47','2026-09-12 17:22:03','Pixabay for AI Article Wizard',0,'enabled',NULL),(119,'elevenlabs','Elevenlabs for TTS',NULL,'elevenlabs','2026-09-12 17:01:47','2026-09-12 17:22:03','Elevenlabs for TTS',0,'enabled',NULL),(120,'eleven_v3','ElevenLabs v3 for TTS',NULL,'elevenlabs','2026-09-12 17:01:47','2026-09-12 17:22:03','ElevenLabs v3 for TTS',0,'enabled',NULL),(121,'elevenlabs-voice-chatbot','Elevenlabs Voice Chatbots',NULL,'elevenlabs','2026-09-12 17:01:47','2026-09-12 17:22:03','Elevenlabs Voice Chatbots',0,'enabled',NULL),(122,'isolator','Voice Isolator (1 word = 5 used characters of elevenlabs) X 1 token',NULL,'elevenlabs','2026-09-12 17:01:47','2026-09-12 17:22:03','Voice Isolator (1 word = 5 used characters of elevenlabs) X 1 token',0,'enabled',NULL),(123,'elevenlabs-ai-music','Elevenlabs for AI Music Pro',NULL,'elevenlabs','2026-09-12 17:01:47','2026-09-12 17:22:03','Elevenlabs for AI Music Pro',0,'enabled',NULL),(124,'lyria-3-clip','Google Lyria 3 Clip for AI Music Pro',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Google Lyria 3 Clip for AI Music Pro',0,'enabled',NULL),(125,'lyria-3-pro','Google Lyria 3 Pro for AI Music Pro',NULL,'gemini','2026-09-12 17:01:47','2026-09-12 17:22:03','Google Lyria 3 Pro for AI Music Pro',0,'enabled',NULL),(126,'google','Google for TTS',NULL,'google','2026-09-12 17:01:47','2026-09-12 17:22:03','Google for TTS',0,'enabled',NULL),(127,'azure','Azure for TTS',NULL,'azure','2026-09-12 17:01:47','2026-09-12 17:22:03','Azure for TTS',0,'enabled',NULL),(128,'azure-openai','Azure OpenAI Model',NULL,'azure','2026-09-12 17:01:47','2026-09-12 17:22:03','Azure OpenAI Model',0,'enabled',NULL),(129,'speechify','Speechify for TTS',NULL,'speechify','2026-09-12 17:01:47','2026-09-12 17:22:03','Speechify for TTS',0,'enabled',NULL),(130,'serper','Serper for Realtime Data',NULL,'serper','2026-09-12 17:01:47','2026-09-12 17:22:03','Serper for Realtime Data',0,'enabled',NULL),(131,'perplexity','Perplexity for Realtime Data',NULL,'perplexity','2026-09-12 17:01:47','2026-09-12 17:22:03','Perplexity for Realtime Data',0,'enabled',NULL),(132,'whisper-1','WHISPER 1 The latest text to speech model, optimized for speed.',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','WHISPER 1 The latest text to speech model, optimized for speed.',0,'enabled',NULL),(133,'dall-e-2','DALL-E 2 The previous DALL·E model released in Nov 2022.',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','DALL-E 2 The previous DALL·E model released in Nov 2022.',0,'enabled',NULL),(134,'dall-e-3','DALL-E 3 The latest DALL·E model released in Nov 2023.',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','DALL-E 3 The latest DALL·E model released in Nov 2023.',0,'enabled',NULL),(135,'gpt-image-1','GPT-IMAGE-1 The latest image model released in Nov 2025.',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-IMAGE-1 The latest image model released in Nov 2025.',0,'enabled',NULL),(136,'gpt-image-1.5','GPT-IMAGE-1.5 The latest image model released in Dec 2025.',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-IMAGE-1.5 The latest image model released in Dec 2025.',0,'enabled',NULL),(137,'gpt-image-2','GPT-IMAGE-2 The latest image model with flexible resolutions and high-fidelity inputs.',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','GPT-IMAGE-2 The latest image model with flexible resolutions and high-fidelity inputs.',0,'enabled',NULL),(138,'tts-1','TTS 1 The latest text to speech model, optimized for speed.',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','TTS 1 The latest text to speech model, optimized for speed.',0,'enabled',NULL),(139,'tts-1-hd','TTS 1 HD The latest text to speech model, optimized for quality.',NULL,'openai','2026-09-12 17:01:47','2026-09-12 17:22:03','TTS 1 HD The latest text to speech model, optimized for quality.',0,'enabled',NULL),(140,'grok-2-1212','Grok 2 1212',NULL,'x_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok 2 1212',0,'enabled',NULL),(141,'grok-2-vision-1212','Grok 2 Vision 1212',NULL,'x_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok 2 Vision 1212',0,'enabled',NULL),(142,'grok-3','Grok 3',NULL,'x_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok 3',0,'enabled',NULL),(143,'grok-3-mini','Grok 3 Mini',NULL,'x_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok 3 Mini',0,'enabled',NULL),(144,'grok-3-fast','Grok 3 Fast',NULL,'x_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok 3 Fast',0,'enabled',NULL),(145,'grok-3-mini-fast','Grok 3 Mini Fast',NULL,'x_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok 3 Mini Fast',0,'enabled',NULL),(146,'grok-4-0709','Grok 4',NULL,'x_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok 4',0,'enabled',NULL),(147,'grok-4-fast-reasoning','Grok 4 Fast',NULL,'x_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok 4 Fast',0,'enabled',NULL),(148,'grok-4-1-fast-reasoning','Grok 4.1 Fast Reasoning',NULL,'x_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok 4.1 Fast Reasoning',0,'enabled',NULL),(149,'grok-4-1-fast-non-reasoning','Grok 4.1 Fast Non-Reasoning',NULL,'x_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok 4.1 Fast Non-Reasoning',0,'enabled',NULL),(150,'grok-4.5','Grok 4.5',NULL,'x_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok 4.5',0,'enabled',NULL),(151,'gamma-ai','Gamma AI',NULL,'gamma_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Gamma AI',0,'enabled',NULL),(152,'veed','Veed',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Veed',0,'enabled',NULL),(153,'veed/fabric-1.0','Veed Fabric 1.0',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Veed Fabric 1.0',0,'enabled',NULL),(154,'veo2','Veo 2',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Veo 2',0,'enabled',NULL),(155,'veo3','Veo 3',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Veo 3',0,'enabled',NULL),(156,'veo3.1/text-to-video','Veo 3.1 Text To Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Veo 3.1 Text To Video',0,'enabled',NULL),(157,'veo3.1/fast/text-to-video','Fast Veo 3.1 Text To Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Fast Veo 3.1 Text To Video',0,'enabled',NULL),(158,'veo3.1/first-last-frame-to-video','Veo 3.1 First Last Frame To Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Veo 3.1 First Last Frame To Video',0,'enabled',NULL),(159,'veo3.1/fast/first-last-frame-to-video','Fast Veo 3.1 First Last Frame To Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Fast Veo 3.1 First Last Frame To Video',0,'enabled',NULL),(160,'veo3.1/image-to-video','Veo 3.1 Image To Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Veo 3.1 Image To Video',0,'enabled',NULL),(161,'veo3.1/fast/image-to-video','Fast Veo 3.1 Image To Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Fast Veo 3.1 Image To Video',0,'enabled',NULL),(162,'veo3.1/reference-to-video','Veo 3.1 Reference To Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Veo 3.1 Reference To Video',0,'enabled',NULL),(163,'veo3.1/lite','Veo 3.1 Lite Text To Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Veo 3.1 Lite Text To Video',0,'enabled',NULL),(164,'veo3.1/lite/image-to-video','Veo 3.1 Lite Image To Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Veo 3.1 Lite Image To Video',0,'enabled',NULL),(165,'veo3.1/lite/first-last-frame-to-video','Veo 3.1 Lite First Last Frame To Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Veo 3.1 Lite First Last Frame To Video',0,'enabled',NULL),(166,'veo3-fast','Fast Veo 3',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Fast Veo 3',0,'enabled',NULL),(167,'nano-banana','Nano Banana',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Nano Banana',0,'enabled',NULL),(168,'nano-banana/edit','Nano Banana Edit',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Nano Banana Edit',0,'enabled',NULL),(169,'nano-banana-pro','Nano Banana Pro',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Nano Banana Pro',0,'enabled',NULL),(170,'nano-banana-pro/edit','Nano Banana Pro Edit',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Nano Banana Pro Edit',0,'enabled',NULL),(171,'nano-banana-2','Nano Banana 2',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Nano Banana 2',0,'enabled',NULL),(172,'nano-banana-2/edit','Nano Banana 2 Edit',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Nano Banana 2 Edit',0,'enabled',NULL),(173,'xai/grok-imagine-image','Grok Imagine Image',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok Imagine Image',0,'enabled',NULL),(174,'xai/grok-imagine-image/edit','Grok Imagine Image Edit',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok Imagine Image Edit',0,'enabled',NULL),(175,'xai/grok-imagine-video/text-to-video','Grok Imagine Video Text-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok Imagine Video Text-to-Video',0,'enabled',NULL),(176,'xai/grok-imagine-video/image-to-video','Grok Imagine Video Image-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Grok Imagine Video Image-to-Video',0,'enabled',NULL),(177,'seedream/v4/text-to-image','SeeDream v4 ',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','SeeDream v4 ',0,'enabled',NULL),(178,'seedream/v4/edit','SeeDream v4 Edit',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','SeeDream v4 Edit',0,'enabled',NULL),(179,'bytedance/seedance-2.0/text-to-video','Seedance 2.0 Text-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Seedance 2.0 Text-to-Video',0,'enabled',NULL),(180,'bytedance/seedance-2.0/image-to-video','Seedance 2.0 Image-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Seedance 2.0 Image-to-Video',0,'enabled',NULL),(181,'bytedance/seedance-2.0/reference-to-video','Seedance 2.0 Reference-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Seedance 2.0 Reference-to-Video',0,'enabled',NULL),(182,'bytedance/seedance-2.0/fast/text-to-video','Seedance 2.0 Fast Text-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Seedance 2.0 Fast Text-to-Video',0,'enabled',NULL),(183,'bytedance/seedance-2.0/fast/image-to-video','Seedance 2.0 Fast Image-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Seedance 2.0 Fast Image-to-Video',0,'enabled',NULL),(184,'bytedance/seedance-2.0/fast/reference-to-video','Seedance 2.0 Fast Reference-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Seedance 2.0 Fast Reference-to-Video',0,'enabled',NULL),(185,'bytedance/seedance-2.5/text-to-video','Seedance 2.5 Text-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Seedance 2.5 Text-to-Video',0,'enabled',NULL),(186,'bytedance/seedance-2.5/image-to-video','Seedance 2.5 Image-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Seedance 2.5 Image-to-Video',0,'enabled',NULL),(187,'bytedance/seedance-2.5/reference-to-video','Seedance 2.5 Reference-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Seedance 2.5 Reference-to-Video',0,'enabled',NULL),(188,'google/gemini-omni-flash','Gemini Omni Flash Text-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini Omni Flash Text-to-Video',0,'enabled',NULL),(189,'google/gemini-omni-flash/image-to-video','Gemini Omni Flash Image-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini Omni Flash Image-to-Video',0,'enabled',NULL),(190,'google/gemini-omni-flash/reference-to-video','Gemini Omni Flash Reference-to-Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Gemini Omni Flash Reference-to-Video',0,'enabled',NULL),(191,'flux-pro','Flux Pro',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Flux Pro',0,'enabled',NULL),(192,'flux-pro/kontext/max/multi','Flux Pro Kontext Max Multi',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Flux Pro Kontext Max Multi',0,'enabled',NULL),(193,'flux-pro/kontext/text-to-image','Flux Pro Kontext Max Text to Image',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Flux Pro Kontext Max Text to Image',0,'enabled',NULL),(194,'flux-pro/kontext','Flux Pro Kontext Max',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Flux Pro Kontext Max',0,'enabled',NULL),(195,'imagen4','Google Imagen 4',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Google Imagen 4',0,'enabled',NULL),(196,'ideogram-v2','Ideogram V2',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Ideogram V2',0,'enabled',NULL),(197,'flux-pro/v1.1','Flux Pro 1.1',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Flux Pro 1.1',0,'enabled',NULL),(198,'flux-realism','Flux Realism',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Flux Realism',0,'enabled',NULL),(199,'flux/schnell','Flux Schnell',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Flux Schnell',0,'enabled',NULL),(200,'flux-2-flex','Flux 2 Flex',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Flux 2 Flex',0,'enabled',NULL),(201,'flux-2-flex/edit','Flux 2 Flex Edit',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Flux 2 Flex Edit',0,'enabled',NULL),(202,'kling','Kling 1.0',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling 1.0',0,'enabled',NULL),(203,'klingV21','Kling 2.1',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling 2.1',0,'enabled',NULL),(204,'kling-2.5-turbo/pro/text-to-video','Kling 2.5 Turbo Pro Text to Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling 2.5 Turbo Pro Text to Video',0,'enabled',NULL),(205,'kling-2.5-turbo/pro/image-to-video','Kling 2.5 Turbo Pro Image to Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling 2.5 Turbo Pro Image to Video',0,'enabled',NULL),(206,'kling-2.5-turbo/standard/image-to-video','Kling 2.5 Turbo Standard Image to Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling 2.5 Turbo Standard Image to Video',0,'enabled',NULL),(207,'kling-video/v2.6/pro/text-to-video','Kling Video v2.6 Pro Text to Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling Video v2.6 Pro Text to Video',0,'enabled',NULL),(208,'kling-video/v2.6/pro/image-to-video','Kling Video v2.6 Pro Image to Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling Video v2.6 Pro Image to Video',0,'enabled',NULL),(209,'kling-video/v2.6/pro/motion-control','Kling Video v2.6 Pro Motion Control',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling Video v2.6 Pro Motion Control',0,'enabled',NULL),(210,'kling-video/v2.6/standard/motion-control','Kling Video v2.6 Standard Motion Control',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling Video v2.6 Standard Motion Control',0,'enabled',NULL),(211,'kling-video/v3/pro/text-to-video','Kling Video v3 Pro Text to Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling Video v3 Pro Text to Video',0,'enabled',NULL),(212,'kling-video/v3/pro/image-to-video','Kling Video v3 Pro Image to Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling Video v3 Pro Image to Video',0,'enabled',NULL),(213,'kling-video/v3/standard/text-to-video','Kling Video v3 Standard Text to Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling Video v3 Standard Text to Video',0,'enabled',NULL),(214,'kling-video/v3/standard/image-to-video','Kling Video v3 Standard Image to Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling Video v3 Standard Image to Video',0,'enabled',NULL),(215,'klingImage','Kling Image to Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling Image to Video',0,'enabled',NULL),(216,'kling-video','Kling Video',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Kling Video',0,'enabled',NULL),(217,'luma-dream-machine','Luma Dream Machine',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Luma Dream Machine',0,'enabled',NULL),(218,'haiper','Haiper',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Haiper',0,'enabled',NULL),(219,'minimax','Minimax',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Minimax',0,'enabled',NULL),(220,'music-01','Music 01',NULL,'minimax','2026-09-12 17:01:47','2026-09-12 17:22:03','Music 01',0,'enabled',NULL),(221,'anthropic/claude-3-5-haiku-20241022','Anthropic: Claude 3.5 Haiku (2024-10-22)',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Anthropic: Claude 3.5 Haiku (2024-10-22)',0,'enabled',NULL),(222,'anthropic/claude-3-5-haiku-20241022:beta','Anthropic: Claude 3.5 Haiku (2024-10-22) (self-moderated)',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Anthropic: Claude 3.5 Haiku (2024-10-22) (self-moderated)',0,'enabled',NULL),(223,'anthropic/claude-3-5-haiku','Anthropic: Claude 3.5 Haiku',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Anthropic: Claude 3.5 Haiku',0,'enabled',NULL),(224,'anthropic/claude-3-5-haiku:beta','Anthropic: Claude 3.5 Haiku (self-moderated)',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Anthropic: Claude 3.5 Haiku (self-moderated)',0,'enabled',NULL),(225,'neversleep/llama-3.1-lumimaid-70b','Lumimaid v0.2 70B',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Lumimaid v0.2 70B',0,'enabled',NULL),(226,'anthracite-org/magnum-v4-72b','Magnum v4 72B',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Magnum v4 72B',0,'enabled',NULL),(227,'x-ai/grok-beta','xAI: Grok Beta',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','xAI: Grok Beta',0,'enabled',NULL),(228,'mistralai/ministral-8b','Ministral 8B',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Ministral 8B',0,'enabled',NULL),(229,'mistralai/ministral-3b','Ministral 3B',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Ministral 3B',0,'enabled',NULL),(230,'qwen/qwen-2.5-7b-instruct','Qwen2.5 7B Instruct',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Qwen2.5 7B Instruct',0,'enabled',NULL),(231,'nvidia/llama-3.1-nemotron-70b-instruct','NVIDIA: Llama 3.1 Nemotron 70B Instruct',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','NVIDIA: Llama 3.1 Nemotron 70B Instruct',0,'enabled',NULL),(232,'inflection/inflection-3-pi','Inflection: Inflection 3 Pi',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Inflection: Inflection 3 Pi',0,'enabled',NULL),(233,'inflection/inflection-3-productivity','Inflection: Inflection 3 Productivity',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Inflection: Inflection 3 Productivity',0,'enabled',NULL),(234,'liquid/lfm-40b:free','Liquid: LFM 40B MoE (free)',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Liquid: LFM 40B MoE (free)',0,'enabled',NULL),(235,'liquid/lfm-40b','Liquid: LFM 40B MoE',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Liquid: LFM 40B MoE',0,'enabled',NULL),(236,'thedrummer/rocinante-12b','Rocinante 12B',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Rocinante 12B',0,'enabled',NULL),(237,'eva-unit-01/eva-qwen-2.5-14b','EVA Qwen2.5 14B',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','EVA Qwen2.5 14B',0,'enabled',NULL),(238,'anthracite-org/magnum-v2-72b','Magnum v2 72B',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Magnum v2 72B',0,'enabled',NULL),(239,'meta-llama/llama-3.2-3b-instruct:free','Meta: Llama 3.2 3B Instruct (free)',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Meta: Llama 3.2 3B Instruct (free)',0,'enabled',NULL),(240,'meta-llama/llama-3.2-1b-instruct:free','Meta: Llama 3.2 1B Instruct (free)',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Meta: Llama 3.2 1B Instruct (free)',0,'enabled',NULL),(241,'meta-llama/llama-3.2-3b-instruct','Meta: Llama 3.2 3B Instruct',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Meta: Llama 3.2 3B Instruct',0,'enabled',NULL),(242,'meta-llama/llama-3.2-1b-instruct','Meta: Llama 3.2 1B Instruct',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Meta: Llama 3.2 1B Instruct',0,'enabled',NULL),(243,'perplexity/llama-3.1-sonar-huge-128k-online','Perplexity: Llama 3.1 Sonar 405B Online',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Perplexity: Llama 3.1 Sonar 405B Online',0,'enabled',NULL),(244,'perplexity/llama-3.1-sonar-large-128k-online','Perplexity: Llama 3.1 Sonar 70B Online',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Perplexity: Llama 3.1 Sonar 70B Online',0,'enabled',NULL),(245,'perplexity/llama-3.1-sonar-large-128k-chat','Perplexity: Llama 3.1 Sonar 70B',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Perplexity: Llama 3.1 Sonar 70B',0,'enabled',NULL),(246,'perplexity/llama-3.1-sonar-small-128k-online','Perplexity: Llama 3.1 Sonar 8B Online',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Perplexity: Llama 3.1 Sonar 8B Online',0,'enabled',NULL),(247,'perplexity/llama-3.1-sonar-small-128k-chat','Perplexity: Llama 3.1 Sonar 8B',NULL,'open_router','2026-09-12 17:01:47','2026-09-12 17:22:03','Perplexity: Llama 3.1 Sonar 8B',0,'enabled',NULL),(248,'midjourney','Midjourney',NULL,'piapi','2026-09-12 17:01:47','2026-09-12 17:22:03','Midjourney',0,'enabled',NULL),(249,'video-upscaler','Video Upscaler',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Video Upscaler',0,'enabled',NULL),(250,'cogvideox-5b/video-to-video','Cogvideox 5B',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Cogvideox 5B',0,'enabled',NULL),(251,'animatediff-v2v','Animatediff V2V',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Animatediff V2V',0,'enabled',NULL),(252,'fast-animatediff/turbo/video-to-video','Fast Animatediff Turbo',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Fast Animatediff Turbo',0,'enabled',NULL),(253,'veed/video-background-removal','Video Background Removal',NULL,'fal_ai','2026-09-12 17:01:47','2026-09-12 17:22:03','Video Background Removal',0,'enabled',NULL),(254,'black-forest-labs/FLUX.1-schnell','Black Forest Labs Flux 1 Schnell',NULL,'together','2026-09-12 17:01:47','2026-09-12 17:22:03','Black Forest Labs Flux 1 Schnell',0,'enabled',NULL),(255,'ad-marketing-video','Ad Marketing Video',NULL,'creatify','2026-09-12 17:01:47','2026-09-12 17:22:03','Ad Marketing Video',0,'enabled',NULL),(256,'ad-marketing-video-topview','Topview Ad Video',NULL,'topview','2026-09-12 17:01:47','2026-09-12 17:22:03','Topview Ad Video',0,'enabled',NULL),(257,'ai-clip-vizard','Vizard AI Clip',NULL,'vizard','2026-09-12 17:01:47','2026-09-12 17:22:03','Vizard AI Clip',0,'enabled',NULL),(258,'ai-clip-klap','Klap AI Clip',NULL,'klap','2026-09-12 17:01:47','2026-09-12 17:22:03','Klap AI Clip',0,'enabled',NULL);
/*!40000 ALTER TABLE `entities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exported_videos`
--

DROP TABLE IF EXISTS `exported_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exported_videos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `task_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'in_progress',
  `video_url` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `used_ai_tool` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'topview',
  `cover_url` text COLLATE utf8mb4_unicode_ci,
  `video_duration` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exported_videos_task_id_unique` (`task_id`),
  KEY `exported_videos_user_id_foreign` (`user_id`),
  CONSTRAINT `exported_videos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exported_videos`
--

LOCK TABLES `exported_videos` WRITE;
/*!40000 ALTER TABLE `exported_videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `exported_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_ai_agent_avatars`
--

DROP TABLE IF EXISTS `ext_ai_agent_avatars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_ai_agent_avatars` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_ai_agent_avatars_user_id_foreign` (`user_id`),
  CONSTRAINT `ext_ai_agent_avatars_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_ai_agent_avatars`
--

LOCK TABLES `ext_ai_agent_avatars` WRITE;
/*!40000 ALTER TABLE `ext_ai_agent_avatars` DISABLE KEYS */;
INSERT INTO `ext_ai_agent_avatars` VALUES (6,NULL,'vendor/ai-agent/images/avatars/avatar-1.png','2026-09-13 13:43:33','2026-09-13 13:43:33'),(7,NULL,'vendor/ai-agent/images/avatars/avatar-2.png','2026-09-13 13:43:33','2026-09-13 13:43:33'),(8,NULL,'vendor/ai-agent/images/avatars/avatar-3.png','2026-09-13 13:43:33','2026-09-13 13:43:33'),(9,NULL,'vendor/ai-agent/images/avatars/avatar-4.png','2026-09-13 13:43:33','2026-09-13 13:43:33'),(10,NULL,'vendor/ai-agent/images/avatars/avatar-5.png','2026-09-13 13:43:33','2026-09-13 13:43:33'),(11,NULL,'vendor/ai-agent/images/avatars/avatar-6.png','2026-09-13 13:43:33','2026-09-13 13:43:33'),(12,NULL,'vendor/ai-agent/images/avatars/avatar-7.png','2026-09-13 13:43:33','2026-09-13 13:43:33');
/*!40000 ALTER TABLE `ext_ai_agent_avatars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_ai_agent_channels`
--

DROP TABLE IF EXISTS `ext_ai_agent_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_ai_agent_channels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credentials` json DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `last_message_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_ai_agent_channels_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_ai_agent_channels`
--

LOCK TABLES `ext_ai_agent_channels` WRITE;
/*!40000 ALTER TABLE `ext_ai_agent_channels` DISABLE KEYS */;
INSERT INTO `ext_ai_agent_channels` VALUES (1,1,'MagicAI (Web)','magicai',NULL,1,NULL,'2026-09-13 14:09:35','2026-09-13 14:09:35');
/*!40000 ALTER TABLE `ext_ai_agent_channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_ai_agent_conversations`
--

DROP TABLE IF EXISTS `ext_ai_agent_conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_ai_agent_conversations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` bigint NOT NULL,
  `workflow_id` bigint DEFAULT NULL,
  `sender_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_message_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `pinned` int unsigned NOT NULL DEFAULT '0',
  `closed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ext_ai_agent_conversations_channel_id_sender_id_unique` (`channel_id`,`sender_id`),
  KEY `ext_ai_agent_conversations_channel_id_index` (`channel_id`),
  KEY `ext_ai_agent_conversations_pinned_index` (`pinned`),
  KEY `ext_ai_agent_conversations_workflow_id_index` (`workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_ai_agent_conversations`
--

LOCK TABLES `ext_ai_agent_conversations` WRITE;
/*!40000 ALTER TABLE `ext_ai_agent_conversations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_ai_agent_conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_ai_agent_knowledge_sources`
--

DROP TABLE IF EXISTS `ext_ai_agent_knowledge_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_ai_agent_knowledge_sources` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `file_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_ai_agent_knowledge_sources_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_ai_agent_knowledge_sources`
--

LOCK TABLES `ext_ai_agent_knowledge_sources` WRITE;
/*!40000 ALTER TABLE `ext_ai_agent_knowledge_sources` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_ai_agent_knowledge_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_ai_agent_memories`
--

DROP TABLE IF EXISTS `ext_ai_agent_memories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_ai_agent_memories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `memory` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_ai_agent_memories_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_ai_agent_memories`
--

LOCK TABLES `ext_ai_agent_memories` WRITE;
/*!40000 ALTER TABLE `ext_ai_agent_memories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_ai_agent_memories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_ai_agent_messages`
--

DROP TABLE IF EXISTS `ext_ai_agent_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_ai_agent_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` bigint DEFAULT NULL,
  `conversation_id` bigint DEFAULT NULL,
  `workflow_run_id` bigint DEFAULT NULL,
  `direction` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'outbound',
  `sender_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `raw_payload` json DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_ai_agent_messages_channel_id_index` (`channel_id`),
  KEY `ext_ai_agent_messages_workflow_run_id_index` (`workflow_run_id`),
  KEY `ext_ai_agent_messages_conversation_id_index` (`conversation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_ai_agent_messages`
--

LOCK TABLES `ext_ai_agent_messages` WRITE;
/*!40000 ALTER TABLE `ext_ai_agent_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_ai_agent_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_ai_agent_workflow_copilot_messages`
--

DROP TABLE IF EXISTS `ext_ai_agent_workflow_copilot_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_ai_agent_workflow_copilot_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `workflow_id` bigint unsigned DEFAULT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `tool_calls` json DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_ai_agent_workflow_copilot_messages_workflow_id_index` (`workflow_id`),
  CONSTRAINT `ext_ai_agent_workflow_copilot_messages_workflow_id_foreign` FOREIGN KEY (`workflow_id`) REFERENCES `ext_ai_agent_workflows` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_ai_agent_workflow_copilot_messages`
--

LOCK TABLES `ext_ai_agent_workflow_copilot_messages` WRITE;
/*!40000 ALTER TABLE `ext_ai_agent_workflow_copilot_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_ai_agent_workflow_copilot_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_ai_agent_workflow_runs`
--

DROP TABLE IF EXISTS `ext_ai_agent_workflow_runs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_ai_agent_workflow_runs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `workflow_id` bigint DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'running',
  `trigger_data` json DEFAULT NULL,
  `steps_output` json DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `started_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_ai_agent_workflow_runs_workflow_id_index` (`workflow_id`),
  KEY `ext_ai_agent_workflow_runs_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_ai_agent_workflow_runs`
--

LOCK TABLES `ext_ai_agent_workflow_runs` WRITE;
/*!40000 ALTER TABLE `ext_ai_agent_workflow_runs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_ai_agent_workflow_runs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_ai_agent_workflows`
--

DROP TABLE IF EXISTS `ext_ai_agent_workflows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_ai_agent_workflows` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_instructions` text COLLATE utf8mb4_unicode_ci,
  `copilot_model` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `trigger_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_config` json DEFAULT NULL,
  `actions` json DEFAULT NULL,
  `steps` json DEFAULT NULL,
  `last_run_at` timestamp NULL DEFAULT NULL,
  `next_run_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_ai_agent_workflows_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_ai_agent_workflows`
--

LOCK TABLES `ext_ai_agent_workflows` WRITE;
/*!40000 ALTER TABLE `ext_ai_agent_workflows` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_ai_agent_workflows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_sm_automation_actions`
--

DROP TABLE IF EXISTS `ext_sm_automation_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_sm_automation_actions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `automation_id` bigint unsigned NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` json NOT NULL,
  `order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_sm_automation_actions_automation_id_order_index` (`automation_id`,`order`),
  CONSTRAINT `ext_sm_automation_actions_automation_id_foreign` FOREIGN KEY (`automation_id`) REFERENCES `ext_sm_automations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_sm_automation_actions`
--

LOCK TABLES `ext_sm_automation_actions` WRITE;
/*!40000 ALTER TABLE `ext_sm_automation_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_sm_automation_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_sm_automation_logs`
--

DROP TABLE IF EXISTS `ext_sm_automation_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_sm_automation_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `automation_id` bigint unsigned NOT NULL,
  `platform_comment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commenter_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commenter_username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actions_executed` json DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'success',
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `automation_comment_unique` (`automation_id`,`platform_comment_id`),
  KEY `ext_sm_automation_logs_automation_id_index` (`automation_id`),
  CONSTRAINT `ext_sm_automation_logs_automation_id_foreign` FOREIGN KEY (`automation_id`) REFERENCES `ext_sm_automations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_sm_automation_logs`
--

LOCK TABLES `ext_sm_automation_logs` WRITE;
/*!40000 ALTER TABLE `ext_sm_automation_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_sm_automation_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_sm_automation_replies`
--

DROP TABLE IF EXISTS `ext_sm_automation_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_sm_automation_replies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `automation_id` bigint unsigned NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_sm_automation_replies_automation_id_foreign` (`automation_id`),
  CONSTRAINT `ext_sm_automation_replies_automation_id_foreign` FOREIGN KEY (`automation_id`) REFERENCES `ext_sm_automations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_sm_automation_replies`
--

LOCK TABLES `ext_sm_automation_replies` WRITE;
/*!40000 ALTER TABLE `ext_sm_automation_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_sm_automation_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_sm_automations`
--

DROP TABLE IF EXISTS `ext_sm_automations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_sm_automations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `social_media_platform_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `trigger_target` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all_posts',
  `trigger_post_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trigger_post_data` json DEFAULT NULL,
  `keyword_mode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'any',
  `include_keywords` json DEFAULT NULL,
  `exclude_keywords` json DEFAULT NULL,
  `enable_public_replies` tinyint(1) NOT NULL DEFAULT '0',
  `delay_seconds` int unsigned NOT NULL DEFAULT '0',
  `workflow_graph` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_sm_automations_user_id_status_index` (`user_id`,`status`),
  KEY `ext_sm_automations_social_media_platform_id_status_index` (`social_media_platform_id`,`status`),
  CONSTRAINT `ext_sm_automations_social_media_platform_id_foreign` FOREIGN KEY (`social_media_platform_id`) REFERENCES `ext_social_media_platforms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ext_sm_automations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_sm_automations`
--

LOCK TABLES `ext_sm_automations` WRITE;
/*!40000 ALTER TABLE `ext_sm_automations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_sm_automations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_sm_pending_automations`
--

DROP TABLE IF EXISTS `ext_sm_pending_automations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_sm_pending_automations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `automation_id` bigint unsigned NOT NULL,
  `comment_data` json NOT NULL,
  `execute_at` timestamp NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_sm_pending_automations_automation_id_foreign` (`automation_id`),
  KEY `ext_sm_pending_automations_status_execute_at_index` (`status`,`execute_at`),
  CONSTRAINT `ext_sm_pending_automations_automation_id_foreign` FOREIGN KEY (`automation_id`) REFERENCES `ext_sm_automations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_sm_pending_automations`
--

LOCK TABLES `ext_sm_pending_automations` WRITE;
/*!40000 ALTER TABLE `ext_sm_pending_automations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_sm_pending_automations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_social_media_agent_posts`
--

DROP TABLE IF EXISTS `ext_social_media_agent_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_social_media_agent_posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agent_id` bigint unsigned NOT NULL,
  `platform_id` bigint unsigned NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_urls` json DEFAULT NULL,
  `video_urls` json DEFAULT NULL,
  `video_request_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `image_request_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `image_model` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publishing_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'post',
  `status` enum('draft','pending_approval','approved','scheduled','published','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `scheduled_at` timestamp NULL DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `ai_metadata` json DEFAULT NULL,
  `hashtags` json DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `platform_post_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `platform_response` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_social_media_agent_posts_agent_id_status_index` (`agent_id`,`status`),
  KEY `ext_social_media_agent_posts_scheduled_at_status_index` (`scheduled_at`,`status`),
  KEY `ext_social_media_agent_posts_platform_id_index` (`platform_id`),
  CONSTRAINT `ext_social_media_agent_posts_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `ext_social_media_agents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ext_social_media_agent_posts_platform_id_foreign` FOREIGN KEY (`platform_id`) REFERENCES `ext_social_media_platforms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_social_media_agent_posts`
--

LOCK TABLES `ext_social_media_agent_posts` WRITE;
/*!40000 ALTER TABLE `ext_social_media_agent_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_social_media_agent_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_social_media_agents`
--

DROP TABLE IF EXISTS `ext_social_media_agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_social_media_agents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `platform_ids` json DEFAULT NULL,
  `site_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_description` text COLLATE utf8mb4_unicode_ci,
  `scraped_content` json DEFAULT NULL,
  `target_audience` json DEFAULT NULL,
  `post_types` json DEFAULT NULL,
  `tone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cta_templates` json DEFAULT NULL,
  `categories` json DEFAULT NULL,
  `goals` json DEFAULT NULL,
  `branding_description` text COLLATE utf8mb4_unicode_ci,
  `creativity` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hashtag_count` int NOT NULL DEFAULT '0',
  `approximate_words` int NOT NULL DEFAULT '20',
  `language` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `schedule_days` json DEFAULT NULL,
  `schedule_times` json DEFAULT NULL,
  `daily_post_count` int NOT NULL DEFAULT '1',
  `reserved_post_day` int NOT NULL DEFAULT '7',
  `start_train_post_count` int NOT NULL DEFAULT '30',
  `post_generation_status` json DEFAULT NULL,
  `average_impressions` bigint unsigned DEFAULT NULL,
  `average_engagement` decimal(10,2) DEFAULT NULL,
  `has_image` tinyint(1) NOT NULL DEFAULT '0',
  `publishing_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'post',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `settings` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_social_media_agents`
--

LOCK TABLES `ext_social_media_agents` WRITE;
/*!40000 ALTER TABLE `ext_social_media_agents` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_social_media_agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_social_media_analyses`
--

DROP TABLE IF EXISTS `ext_social_media_analyses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_social_media_analyses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `agent_id` bigint DEFAULT NULL,
  `summary` text COLLATE utf8mb4_unicode_ci,
  `report_text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ext_social_media_analyses_user_id_foreign` (`user_id`),
  CONSTRAINT `ext_social_media_analyses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_social_media_analyses`
--

LOCK TABLES `ext_social_media_analyses` WRITE;
/*!40000 ALTER TABLE `ext_social_media_analyses` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_social_media_analyses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_social_media_campaigns`
--

DROP TABLE IF EXISTS `ext_social_media_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_social_media_campaigns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_audience` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_social_media_campaigns`
--

LOCK TABLES `ext_social_media_campaigns` WRITE;
/*!40000 ALTER TABLE `ext_social_media_campaigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_social_media_campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_social_media_platforms`
--

DROP TABLE IF EXISTS `ext_social_media_platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_social_media_platforms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `platform` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credentials` json DEFAULT NULL,
  `followers_count` bigint unsigned DEFAULT NULL,
  `connected_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_social_media_platforms`
--

LOCK TABLES `ext_social_media_platforms` WRITE;
/*!40000 ALTER TABLE `ext_social_media_platforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_social_media_platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_social_media_post_daily_metrics`
--

DROP TABLE IF EXISTS `ext_social_media_post_daily_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_social_media_post_daily_metrics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `social_media_post_id` bigint unsigned NOT NULL,
  `agent_id` bigint unsigned DEFAULT NULL,
  `social_media_platform_id` bigint unsigned DEFAULT NULL,
  `platform` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_identifier` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `like_count` bigint unsigned NOT NULL DEFAULT '0',
  `comment_count` bigint unsigned NOT NULL DEFAULT '0',
  `share_count` bigint unsigned NOT NULL DEFAULT '0',
  `view_count` bigint unsigned NOT NULL DEFAULT '0',
  `last_totals` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ext_sm_post_daily_metrics_post_date_unique` (`social_media_post_id`,`date`),
  KEY `ext_sm_post_daily_metrics_platform_fk` (`social_media_platform_id`),
  KEY `ext_social_media_post_daily_metrics_agent_id_index` (`agent_id`),
  CONSTRAINT `ext_sm_post_daily_metrics_platform_fk` FOREIGN KEY (`social_media_platform_id`) REFERENCES `ext_social_media_platforms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ext_sm_post_daily_metrics_post_fk` FOREIGN KEY (`social_media_post_id`) REFERENCES `ext_social_media_posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_social_media_post_daily_metrics`
--

LOCK TABLES `ext_social_media_post_daily_metrics` WRITE;
/*!40000 ALTER TABLE `ext_social_media_post_daily_metrics` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_social_media_post_daily_metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_social_media_posts`
--

DROP TABLE IF EXISTS `ext_social_media_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_social_media_posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agent_id` bigint DEFAULT NULL,
  `social_media_agent_post_id` bigint unsigned DEFAULT NULL,
  `post_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `campaign_id` bigint DEFAULT NULL,
  `social_media_platform_id` bigint DEFAULT NULL,
  `social_media_platform` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'post',
  `is_personalized_content` tinyint(1) NOT NULL DEFAULT '0',
  `tone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `images` json DEFAULT NULL,
  `video` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_repeated` tinyint(1) NOT NULL DEFAULT '0',
  `has_replicate` tinyint(1) NOT NULL DEFAULT '0',
  `repeat_period` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repeat_start_date` date DEFAULT NULL,
  `repeat_time` time DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `scheduled_at` timestamp NULL DEFAULT NULL,
  `posted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `post_metrics` json DEFAULT NULL,
  `post_metric_at` timestamp NULL DEFAULT NULL,
  `hashtags` json DEFAULT NULL,
  `post_engagement_count` bigint DEFAULT '0',
  `post_engagement_rate` decimal(8,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_social_media_posts`
--

LOCK TABLES `ext_social_media_posts` WRITE;
/*!40000 ALTER TABLE `ext_social_media_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_social_media_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_social_media_shared_logs`
--

DROP TABLE IF EXISTS `ext_social_media_shared_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_social_media_shared_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `social_media_post_id` bigint DEFAULT NULL,
  `response` json DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_social_media_shared_logs`
--

LOCK TABLES `ext_social_media_shared_logs` WRITE;
/*!40000 ALTER TABLE `ext_social_media_shared_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_social_media_shared_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extensions`
--

DROP TABLE IF EXISTS `extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extensions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `installed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_theme` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extensions`
--

LOCK TABLES `extensions` WRITE;
/*!40000 ALTER TABLE `extensions` DISABLE KEYS */;
/*!40000 ALTER TABLE `extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq`
--

DROP TABLE IF EXISTS `faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `question` text COLLATE utf8mb4_unicode_ci,
  `answer` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq`
--

LOCK TABLES `faq` WRITE;
/*!40000 ALTER TABLE `faq` DISABLE KEYS */;
INSERT INTO `faq` VALUES (1,'How does it generate responses?','MagicAI uses the most popular AI models such as GPT, Dall-E, Ada to create text, image, code and more within seconds. The process is simple. All you have to do is provide a topic or idea, and our AI-based generator will take care of the rest.',NULL,'2023-06-02 12:14:35','2023-06-02 12:14:35'),(2,'Can I create templates or chat bots?','You can use pre-made templates and examples for various content types and industries to help you get started quickly. You can even create your own chatbot or custom prompt template for further customization.',NULL,'2023-06-02 12:15:43','2023-06-02 12:15:43'),(3,'Should I buy regular or extended license?','If you plan to charge end users for the final product or service, you should buy the extended license in compliance with Envato’s terms of service, same as other projects: https://codecanyon.net/licenses/standard',NULL,'2023-06-02 12:16:02','2023-06-02 12:16:02'),(4,'Can I translate the script into another language?','Yes! MagicAI\'s multilingual capabilities apply to both content generation and dashboard language. You can easily translate it into other languages. A built-in translation tool is coming soon!',NULL,'2023-06-02 12:16:25','2023-06-02 12:16:25'),(5,'Is there a mobile app for MagicAI?','MagicAI provides an almost native-app experience thanks to its mobile-first approach. The entire layout is responsive and works great on any device regardless of the size.',NULL,'2023-06-02 12:16:53','2023-06-02 12:16:53');
/*!40000 ALTER TABLE `faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favourite_list`
--

DROP TABLE IF EXISTS `favourite_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favourite_list` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favourite_list`
--

LOCK TABLES `favourite_list` WRITE;
/*!40000 ALTER TABLE `favourite_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `favourite_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features_marquees`
--

DROP TABLE IF EXISTS `features_marquees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features_marquees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features_marquees`
--

LOCK TABLES `features_marquees` WRITE;
/*!40000 ALTER TABLE `features_marquees` DISABLE KEYS */;
INSERT INTO `features_marquees` VALUES (1,'Designed for mobile','top',NULL,NULL),(2,'Easy to use','top',NULL,NULL),(3,'Customizable','top',NULL,NULL),(4,'No coding required','top',NULL,NULL),(5,'10 Reasons to use MagicAI','bottom',NULL,NULL),(6,'No sign up required','bottom',NULL,NULL),(7,'No watermarks','bottom',NULL,NULL),(8,'No hidden fees','bottom',NULL,NULL);
/*!40000 ALTER TABLE `features_marquees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folders`
--

DROP TABLE IF EXISTS `folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `folders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `team_id` bigint DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `folders_created_by_foreign` (`created_by`),
  CONSTRAINT `folders_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folders`
--

LOCK TABLES `folders` WRITE;
/*!40000 ALTER TABLE `folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `footer_items`
--

DROP TABLE IF EXISTS `footer_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `footer_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `item` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `footer_items`
--

LOCK TABLES `footer_items` WRITE;
/*!40000 ALTER TABLE `footer_items` DISABLE KEYS */;
INSERT INTO `footer_items` VALUES (1,'Premium Support 30-Day',NULL,NULL),(2,'Money Back Guarantee',NULL,NULL),(3,'Instant Access',NULL,NULL),(4,'Free Trial',NULL,NULL),(5,'Lifetime Updates',NULL,NULL);
/*!40000 ALTER TABLE `footer_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frontend_channel_settings`
--

DROP TABLE IF EXISTS `frontend_channel_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frontend_channel_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frontend_channel_settings`
--

LOCK TABLES `frontend_channel_settings` WRITE;
/*!40000 ALTER TABLE `frontend_channel_settings` DISABLE KEYS */;
INSERT INTO `frontend_channel_settings` VALUES (1,'Facebook','facebook','Our AI tool helps you craft compelling content that resonates with your audience Whether it\'s a status update, promotional post, or a simple interaction.','/themes/social-media-front/assets/landing-page/card-fb.jpg','assets/landing-page/logo-fb.png','2026-09-12 17:01:42','2026-09-12 17:01:42'),(2,'Twitter / X','x','Create impactful X posts with our AI tool in seconds! Whether it\'s a quick update, an engaging tweet, or a conversation starter, generate posts that drive conversations and keep your followers engaged on X.','/themes/social-media-front/assets/landing-page/card-x.jpg','assets/landing-page/logo-x.png','2026-09-12 17:01:42','2026-09-12 17:01:42'),(3,'Instagram','instagram','Design eye-catching Instagram posts in no time with our AI-powered generator. From beautiful visuals to captivating captions, create Instagram content that stands out and grabs your followers\' attention.','/themes/social-media-front/assets/landing-page/card-ig.jpg','assets/landing-page/logo-ig.png','2026-09-12 17:01:42','2026-09-12 17:01:42'),(4,'LinkedIn','linkedin','Build your professional presence with polished LinkedIn posts. Our AI helps you write insightful articles, thought-provoking updates, and attention-grabbing headlines that engage with your network.','/themes/social-media-front/assets/landing-page/card-in.jpg','assets/landing-page/logo-in.png','2026-09-12 17:01:42','2026-09-12 17:01:42');
/*!40000 ALTER TABLE `frontend_channel_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frontend_content_boxes`
--

DROP TABLE IF EXISTS `frontend_content_boxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frontend_content_boxes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `emoji` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `background` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foreground` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frontend_content_boxes`
--

LOCK TABLES `frontend_content_boxes` WRITE;
/*!40000 ALTER TABLE `frontend_content_boxes` DISABLE KEYS */;
INSERT INTO `frontend_content_boxes` VALUES (1,'😎','Partner','Invite your colleagues and collaborators to join a team and maximize the benefits of AI.','#615C5A','#fff','2026-09-12 17:01:42','2026-09-12 17:01:42'),(2,'🚀','Collaborate','Invite your colleagues and collaborators to join a team and maximize the benefits of AI.','#EB6434','#fff','2026-09-12 17:01:42','2026-09-12 17:01:42'),(3,'👥','Invite','Invite your colleagues and collaborators to join a team and maximize the benefits of AI.','#3B4F99','#fff','2026-09-12 17:01:42','2026-09-12 17:01:42');
/*!40000 ALTER TABLE `frontend_content_boxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frontend_curtains`
--

DROP TABLE IF EXISTS `frontend_curtains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frontend_curtains` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title_icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sliders` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frontend_curtains`
--

LOCK TABLES `frontend_curtains` WRITE;
/*!40000 ALTER TABLE `frontend_curtains` DISABLE KEYS */;
INSERT INTO `frontend_curtains` VALUES (1,'Sarah J.','','[{\"title\": \"Sarah J.\", \"bg_color\": \"\", \"bg_image\": \"\", \"bg_video\": \"/themes/social-media-front/assets/landing-page/demo-vid-1.webm\", \"description\": \"Translates Podcasts into different languages.\", \"title_color\": \"\", \"description_color\": \"\"}, {\"title\": \"Sarah J.\", \"bg_color\": \"\", \"bg_image\": \"\", \"bg_video\": \"/themes/social-media-front/assets/landing-page/demo-vid-1.webm\", \"description\": \"\", \"title_color\": \"\", \"description_color\": \"\"}, {\"title\": \"Sarah J.\", \"bg_color\": \"\", \"bg_image\": \"\", \"bg_video\": \"/themes/social-media-front/assets/landing-page/demo-vid-1.webm\", \"description\": \"\", \"title_color\": \"\", \"description_color\": \"\"}]','2026-09-12 17:01:42','2026-09-12 17:01:42'),(2,'Jason R.','','[{\"title\": \"Jason R.\", \"bg_color\": \"#aea397\", \"bg_image\": \"\", \"bg_video\": \"/themes/social-media-front/assets/landing-page/demo-vid-1.webm\", \"description\": \"\", \"title_color\": \"\", \"description_color\": \"\"}, {\"title\": \"Jason R.\", \"bg_color\": \"#aea397\", \"bg_image\": \"/themes/social-media-front/assets/landing-page/banner-img.jpg\", \"bg_video\": \"\", \"description\": \"\", \"title_color\": \"\", \"description_color\": \"\"}]','2026-09-12 17:01:42','2026-09-12 17:01:42'),(3,'Mary J.','','[{\"title\": \"Mary J.\", \"bg_color\": \"#496e8f\", \"bg_image\": \"\", \"bg_video\": \"/themes/social-media-front/assets/landing-page/demo-vid-1.webm\", \"description\": \"\", \"title_color\": \"\", \"description_color\": \"\"}]','2026-09-12 17:01:42','2026-09-12 17:01:42');
/*!40000 ALTER TABLE `frontend_curtains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frontend_footer_settings`
--

DROP TABLE IF EXISTS `frontend_footer_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frontend_footer_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `header_title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Limited Offer',
  `header_text` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Sign up and receive 20% bonus discount on checkout.',
  `hero_subtitle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Unleash the Power of AI',
  `hero_title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Ultimate AI',
  `hero_description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'All-in-one platform to generate AI content and start making money in minutes.',
  `hero_scroll_text` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Discover MagicAI',
  `hero_button` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Start Making Money',
  `hero_button_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hero_image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '/themes/dark/assets/landing-page/banner-img.jpg',
  `hero_button_type` int NOT NULL DEFAULT '1',
  `footer_header` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Start your free trial.',
  `footer_text_small` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pay once, own forever.',
  `footer_text` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Unlock your business potential by letting the AI work and generate money for you.',
  `footer_button_text` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Join our community',
  `footer_button_url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'https://codecanyon.net/item/magicai-openai-content-text-image-chat-code-generator-as-saas/45408109',
  `footer_copyright` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'All images are for demo purposes.',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `hero_title_text_rotator` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Generator,Chatbot,Assistant',
  `sign_in` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Sign In',
  `join_hub` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Join Hub',
  `floating_button_small_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `floating_button_bold_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `floating_button_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `floating_button_active` tinyint(1) NOT NULL DEFAULT '0',
  `footer_text_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_credit_cart_required` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT 'No credit cart required.',
  `faster_content_creation` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '<span class="font-heading text-[1.857em]/[1em] font-bold">10x</span>Faster Content Creation',
  `over_5000_businesses` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT 'over <u>5000+</u> businesses trust us to boost their social media precense',
  `join_the_ranks` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frontend_footer_settings`
--

LOCK TABLES `frontend_footer_settings` WRITE;
/*!40000 ALTER TABLE `frontend_footer_settings` DISABLE KEYS */;
INSERT INTO `frontend_footer_settings` VALUES (1,'Limited Offer','Sign up and receive 20% bonus discount on checkout.','Unleash the Power of AI','Ultimate AI','All-in-one platform to generate AI content and start making money in minutes.','Discover MagicAI','Start Making Money',NULL,'/themes/dark/assets/landing-page/banner-img.jpg',1,'Start your free trial.','Pay once, own forever.','Unlock your business potential by letting the AI work and generate money for you.','Join our community','https://codecanyon.net/item/magicai-openai-content-text-image-chat-code-generator-as-saas/45408109','All images are for demo purposes.','2026-09-12 17:01:47','2026-09-12 17:01:47','Generator,Chatbot,Assistant','Sign In','Join Hub',NULL,NULL,NULL,0,NULL,'No credit cart required.','<span class=\"font-heading text-[1.857em]/[1em] font-bold\">10x</span>Faster Content Creation','over <u>5000+</u> businesses trust us to boost their social media precense',NULL);
/*!40000 ALTER TABLE `frontend_footer_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frontend_future`
--

DROP TABLE IF EXISTS `frontend_future`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frontend_future` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frontend_future`
--

LOCK TABLES `frontend_future` WRITE;
/*!40000 ALTER TABLE `frontend_future` DISABLE KEYS */;
INSERT INTO `frontend_future` VALUES (1,'AI Generator','Generate <strong>text, image, code, chat</strong> and even more with',' <svg width=\"20\" height=\"21\" viewBox=\"0 0 20 21\" fill=\"none\" stroke=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n                                <path d=\"M2.333 14.204L14.571 1.966C15.0509 1.48609 15.7018 1.21648 16.3805 1.21648C16.7166 1.21648 17.0493 1.28267 17.3598 1.41127C17.6703 1.53988 17.9524 1.72837 18.19 1.966C18.4276 2.20363 18.6161 2.48573 18.7447 2.79621C18.8733 3.10668 18.9395 3.43944 18.9395 3.7755C18.9395 4.11156 18.8733 4.44432 18.7447 4.75479C18.6161 5.06527 18.4276 5.34737 18.19 5.585L5.952 17.823C5.6728 18.1022 5.31719 18.2926 4.93 18.37L1 19.156L1.786 15.226C1.86345 14.8388 2.05378 14.4832 2.333 14.204Z\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\n                                <path d=\"M12.5 4.656L15.5 7.656\" stroke-width=\"2\"/>\n                            </svg>','2023-06-02 15:32:56','2023-06-02 15:32:56'),(2,'Advanced Dashboard','Access to valuable user insight, analytics and activity.','  <svg width=\"16\" height=\"18\" viewBox=\"0 0 16 18\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n                                <path d=\"M3.46 13.838H5.19V3.46H3.46V13.838ZM6.92 17.298H8.65V0H6.92V17.298ZM0 10.379H1.73V6.919H0V10.379ZM10.379 13.839H12.109V3.46H10.379V13.839ZM13.839 6.92V10.38H15.569V6.92H13.839Z\"/>\n                            </svg>','2023-06-02 15:32:56','2023-06-02 15:32:56'),(3,'Payment Gateways','Securely process credit card, debit card, or other methods.',' <svg width=\"19\" height=\"19\" viewBox=\"0 0 19 19\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n                                <path d=\"M3.421 -6.80448e-08L3.267 0.643L0.231 14.636L0 15.636H4.013L3.524 17.925L3.293 18.925H9.029L9.158 18.256L10.007 14.295H12.219C13.7458 14.318 15.2324 13.8059 16.4212 12.8475C17.6099 11.8891 18.4257 10.5449 18.727 9.048C18.9117 8.34466 18.9335 7.60848 18.7909 6.89542C18.6483 6.18237 18.345 5.51122 17.904 4.933C17.2726 4.18389 16.4149 3.66026 15.46 3.441C15.303 2.67914 14.9378 1.97574 14.405 1.409C13.9537 0.955562 13.416 0.597241 12.8237 0.355227C12.2315 0.113213 11.5967 -0.00757721 10.957 -6.80448e-08H3.421ZM4.758 1.646H10.958C11.8009 1.63923 12.613 1.96222 13.221 2.546C13.563 2.92723 13.7979 3.39222 13.9019 3.89369C14.0059 4.39516 13.9752 4.91523 13.813 5.401C13.6186 6.54221 13.0154 7.57362 12.116 8.30255C11.2167 9.03148 10.0827 9.40808 8.926 9.362H5.376L5.25 10.006L4.401 13.993H2.058L4.758 1.646ZM6.841 2.855L6.687 3.498L5.839 7.3L5.608 8.3H8.515C9.23308 8.28426 9.92567 8.0308 10.4843 7.57932C11.0429 7.12783 11.436 6.50381 11.602 5.805H11.628C11.628 5.789 11.628 5.77 11.628 5.754C11.7218 5.41549 11.7405 5.06056 11.6828 4.71406C11.6252 4.36756 11.4924 4.03785 11.294 3.748C11.0809 3.46596 10.8048 3.23768 10.4878 3.0814C10.1707 2.92513 9.82147 2.8452 9.468 2.848L6.841 2.855ZM8.15 4.5H9.462C9.55438 4.48894 9.64804 4.50213 9.73378 4.53824C9.81952 4.57436 9.89438 4.63218 9.951 4.706C10.0148 4.80392 10.055 4.91532 10.0683 5.03143C10.0817 5.14753 10.0679 5.26515 10.028 5.375V5.4C9.92453 5.73467 9.72591 6.032 9.45637 6.25573C9.18682 6.47947 8.858 6.61993 8.51 6.66H7.661L8.15 4.5ZM15.506 5.22C15.9416 5.37924 16.3307 5.64457 16.638 5.992C16.9265 6.37171 17.1192 6.81536 17.1998 7.28537C17.2804 7.75537 17.2465 8.23787 17.101 8.692C16.9066 9.83321 16.3034 10.8646 15.404 11.5935C14.5047 12.3225 13.3707 12.6991 12.214 12.653H8.664L8.535 13.296L7.686 17.283H5.35L5.71 15.637H5.736L5.865 14.968L6.714 11.007H8.926C10.4528 11.03 11.9394 10.5179 13.1282 9.55954C14.3169 8.60115 15.1327 7.25692 15.434 5.76C15.472 5.575 15.488 5.4 15.51 5.221L15.506 5.22Z\"/>\n                            </svg>','2023-06-02 15:32:56','2023-06-02 15:32:56'),(4,'Multi-Lingual','Ability to understand and generate content in different languages',' <svg width=\"22\" height=\"22\" viewBox=\"0 0 22 22\" fill=\"none\" stroke=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n                                <path d=\"M10.85 20.85C16.3728 20.85 20.85 16.3728 20.85 10.85C20.85 5.32715 16.3728 0.85 10.85 0.85C5.32715 0.85 0.85 5.32715 0.85 10.85C0.85 16.3728 5.32715 20.85 10.85 20.85Z\" stroke-width=\"1.7\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\n                                <path d=\"M6.85 10.85C6.85 16.3728 8.64086 20.85 10.85 20.85C13.0591 20.85 14.85 16.3728 14.85 10.85C14.85 5.32715 13.0591 0.85 10.85 0.85C8.64086 0.85 6.85 5.32715 6.85 10.85Z\" stroke-width=\"1.7\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\n                                <path d=\"M0.85 10.85H20.85\" stroke-width=\"1.7\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\n                            </svg>','2023-06-02 15:32:56','2023-06-02 15:32:56'),(5,'Custom Templates','Add unlimited number of custom prompts for your customers.','  <svg width=\"19\" height=\"16\" viewBox=\"0 0 19 16\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n                                <path d=\"M14.84 6.509H7.29C6.571 6.509 6.509 7.091 6.509 7.809C6.509 8.527 6.571 9.109 7.29 9.109H14.84C15.559 9.109 15.621 8.527 15.621 7.809C15.621 7.091 15.558 6.509 14.84 6.509ZM17.44 13.018H7.29C6.571 13.018 6.509 13.6 6.509 14.318C6.509 15.036 6.571 15.618 7.29 15.618H17.443C18.162 15.618 18.224 15.036 18.224 14.318C18.224 13.6 18.162 13.018 17.443 13.018H17.44ZM7.29 2.6H17.443C18.162 2.6 18.224 2.018 18.224 1.3C18.224 0.582 18.162 0 17.443 0H7.29C6.571 0 6.509 0.582 6.509 1.3C6.509 2.018 6.571 2.6 7.29 2.6ZM3.124 6.509H0.781C0.0619999 6.509 0 7.091 0 7.809C0 8.527 0.0619999 9.109 0.781 9.109H3.124C3.843 9.109 3.905 8.527 3.905 7.809C3.905 7.091 3.843 6.509 3.124 6.509ZM3.124 13.018H0.781C0.0619999 13.018 0 13.6 0 14.318C0 15.036 0.0619999 15.618 0.781 15.618H3.124C3.843 15.618 3.905 15.036 3.905 14.318C3.905 13.6 3.843 13.018 3.124 13.018ZM3.124 0H0.781C0.0619999 0 0 0.582 0 1.3C0 2.018 0.0619999 2.6 0.781 2.6H3.124C3.843 2.6 3.905 2.018 3.905 1.3C3.905 0.582 3.843 0 3.124 0Z\"/>\n                            </svg>','2023-06-02 15:32:56','2023-06-02 15:32:56'),(6,'Support Platform','Access and manage your support tickets from your dashboard.','<svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n                                <path d=\"M9.217 1.068L9.635 7.968M13.818 7.968L14.236 1.068M9.217 22.191L9.635 15.291M13.818 15.291L14.236 22.191M22.287 9.121L15.387 9.539M15.387 13.722L22.287 14.14M1.164 9.121L8.064 9.539M8.064 13.722L1.164 14.14M22.85 11.85C22.85 17.9251 17.9251 22.85 11.85 22.85C5.77487 22.85 0.849998 17.9251 0.849998 11.85C0.849998 5.77487 5.77487 0.849998 11.85 0.849998C17.9251 0.849998 22.85 5.77487 22.85 11.85ZM15.85 11.85C15.85 14.0591 14.0591 15.85 11.85 15.85C9.64086 15.85 7.85 14.0591 7.85 11.85C7.85 9.64086 9.64086 7.85 11.85 7.85C14.0591 7.85 15.85 9.64086 15.85 11.85Z\" stroke-width=\"1.7\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\n                            </svg>','2023-06-02 15:32:56','2023-06-02 15:32:56');
/*!40000 ALTER TABLE `frontend_future` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frontend_generators`
--

DROP TABLE IF EXISTS `frontend_generators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frontend_generators` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle_one` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle_two` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_subtitle` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `icon` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frontend_generators`
--

LOCK TABLES `frontend_generators` WRITE;
/*!40000 ALTER TABLE `frontend_generators` DISABLE KEYS */;
INSERT INTO `frontend_generators` VALUES (1,'AI Text Generator','Say goodbye to writer\'s block','AI','Intelligent Writing Assistant','Writer is designed to help you <strong>generate high-quality texts instantly</strong>, without breaking a sweat. With our intuitive interface and powerful features, you can easily edit, export, or publish your AI-generated result.','assets/img/site/text-generator.jpg','Generate, edit, export.','Powered by OpenAI.','#EADDF9','2023-06-02 15:33:09','2023-06-02 15:33:09',NULL),(2,'AI Image Generator','Unleash your creativity','AI','Create eye-catching images and graphics.','Generate high-quality images for a wide range of applications.','assets/img/site/image-generator.jpg','Imagine, Generate, Publish.','Powered by Dall-E.','#DFE5EB','2023-06-02 15:33:09','2023-06-02 15:33:09',NULL),(3,'AI Code Generator','The future of development','AI','Generate high-quality code in no time.','MagicAI is designed to make coding faster, easier, and more efficient than ever before. Whether you’re a seasoned developer or a coding newbie, our tool will help you streamline your coding process and get your projects up and running in no time.','assets/img/site/code-generator.jpg','Fix. Improve. Generate.','Powered by OpenAI.','#DDE6FF','2023-06-02 15:33:09','2023-06-02 15:33:09',NULL),(4,'AI Chat Bot','Intuitive / Humanlike Chatbot','AI','Meet your next virtual assistant.','Get instant answers to your questions, no matter the topic. Whether you’re looking to book a reservation, get product recommendations, or just chat about the weather, MagicAI is always ready and willing to help.','assets/img/site/ai-chat.jpg','Chat, Solve, Repeat.','Powered by OpenAI.','#F9DDDF','2023-06-02 15:33:09','2023-06-02 15:33:09',NULL),(5,'AI Speech To Text','Say goodbye to writer\'s block','AI','Transcribe your speech into text.','Accurately transcribe your recordings in just minutes. With our user-friendly interface, you can upload your files and have them transcribed in a matter of clicks.','assets/img/site/ai-speech.jpg','Upload, Analyze, Generate.','Powered by OpenAI.','#FFF8EB','2023-06-02 15:33:09','2023-06-02 15:33:09',NULL),(6,'Empower Your Message with AI','Say goodbye to writer\'s block','AI','Transcribe your speech into text.','From captivating commercials to engaging narrations, our AI voice will bring your words to life. With its seamless delivery, natural intonation, and unrivaled versatility, our AI VoiceOver is the perfect choice for any project. Effortlessly choose from a variety of voices and languages while adjusting the pace to your preference.','assets/img/site/voiceover.jpg','Upload, Analyze, Generate.','Powered by OpenAI.','#FFF8EB','2023-06-02 15:33:09','2023-06-02 15:33:09',NULL);
/*!40000 ALTER TABLE `frontend_generators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frontend_sections_statuses_titles`
--

DROP TABLE IF EXISTS `frontend_sections_statuses_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frontend_sections_statuses_titles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `features_active` tinyint(1) NOT NULL DEFAULT '1',
  `features_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'The future of AI.',
  `features_subtitle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Unleash the Power of AI',
  `features_description` text COLLATE utf8mb4_unicode_ci,
  `generators_active` tinyint(1) NOT NULL DEFAULT '1',
  `who_is_for_active` tinyint(1) NOT NULL DEFAULT '1',
  `custom_templates_active` tinyint(1) NOT NULL DEFAULT '1',
  `custom_templates_subtitle_one` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Custom',
  `custom_templates_subtitle_two` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Prompts',
  `custom_templates_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Custom Templates.',
  `custom_templates_learn_more_link_url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#templates',
  `custom_templates_learn_more_link` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Discover MagicAI',
  `custom_templates_description` text COLLATE utf8mb4_unicode_ci,
  `tools_active` tinyint(1) NOT NULL DEFAULT '1',
  `tools_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Magic Tools.',
  `tools_subtitle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Unleash the Power of AI',
  `tools_description` text COLLATE utf8mb4_unicode_ci,
  `how_it_works_active` tinyint(1) NOT NULL DEFAULT '1',
  `how_it_works_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'So, how does it work?',
  `how_it_works_link_label` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Learn More',
  `how_it_works_link` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#',
  `how_it_works_description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'To create content quickly and effectively, <strong>here are the steps you can follow:</strong>',
  `how_it_works_subtitle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Unleash the Power of AI',
  `testimonials_active` tinyint(1) NOT NULL DEFAULT '1',
  `testimonials_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Trusted by millions.',
  `testimonials_description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Content and <strong>kickstart your earnings</strong> in minutes  kickstart your earnings in minutes',
  `testimonials_subtitle_one` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Testimonials',
  `testimonials_subtitle_two` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Trustpilot',
  `pricing_active` tinyint(1) NOT NULL DEFAULT '1',
  `pricing_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Flexible Pricing.',
  `pricing_subtitle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Unleash the Power of AI',
  `pricing_description` text COLLATE utf8mb4_unicode_ci,
  `pricing_save_percent` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Save 30%',
  `faq_active` tinyint(1) NOT NULL DEFAULT '1',
  `faq_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Have a question?',
  `faq_subtitle` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Our support team will get assistance from AI-powered suggestions, making it quicker than ever to handle support requests.',
  `faq_text_one` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'FAQ',
  `faq_text_two` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Help Center',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `preheader_active` tinyint(1) NOT NULL DEFAULT '1',
  `blog_active` tinyint(1) NOT NULL DEFAULT '0',
  `blog_title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Latest News',
  `blog_subtitle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Stay up-to-date',
  `blog_posts_per_page` int NOT NULL DEFAULT '3',
  `blog_button_text` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Show more',
  `blog_a_title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Blog Posts',
  `blog_a_subtitle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Latest News',
  `blog_a_description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Welcome to our cozy corner of the internet, where you will find a delightful collection of our heartfelt and thought-provoking blog posts.',
  `blog_a_posts_per_page` int NOT NULL DEFAULT '6',
  `marquee_items` text COLLATE utf8mb4_unicode_ci,
  `generators_subtitle` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generators_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generators_description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plan_footer_text` text COLLATE utf8mb4_unicode_ci,
  `advanced_features_section_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `advanced_features_section_description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frontend_sections_statuses_titles`
--

LOCK TABLES `frontend_sections_statuses_titles` WRITE;
/*!40000 ALTER TABLE `frontend_sections_statuses_titles` DISABLE KEYS */;
INSERT INTO `frontend_sections_statuses_titles` VALUES (1,1,'The future of AI.','Unleash the Power of AI',NULL,1,1,1,'Custom','Prompts','Custom Templates.','#templates','Discover MagicAI',NULL,1,'Magic Tools.','Unleash the Power of AI',NULL,1,'So, how does it work?','Learn More','#','To create content quickly and effectively, <strong>here are the steps you can follow:</strong>','Unleash the Power of AI',1,'Trusted by millions.','Content and <strong>kickstart your earnings</strong> in minutes  kickstart your earnings in minutes','Testimonials','Trustpilot',1,'Flexible Pricing.','Unleash the Power of AI',NULL,'Save 30%',1,'Have a question?','Our support team will get assistance from AI-powered suggestions, making it quicker than ever to handle support requests.','FAQ','Help Center','2026-09-12 17:04:31','2026-09-13 15:19:09',1,0,'Latest News','Stay up-to-date',3,'Show more','Blog Posts','Latest News','Welcome to our cozy corner of the internet, where you will find a delightful collection of our heartfelt and thought-provoking blog posts.',6,'Cold Email,Newsletter,Summarize,Product Description,Testimonial,Pick an outfit,Study Vocabulary, Create a workout plan,Transcribe my class notes,Create a pros and cons list,Morning Productivity Plan,Experience Tokyo like a local,Translate',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `frontend_sections_statuses_titles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frontend_tools`
--

DROP TABLE IF EXISTS `frontend_tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frontend_tools` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `buy_link` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Start Making Money',
  `buy_link_url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'https://codecanyon.net/item/magicai-openai-content-text-image-chat-code-generator-as-saas/45408109',
  `learn_more_link` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Discover MagicAI',
  `learn_more_link_url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#templates',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frontend_tools`
--

LOCK TABLES `frontend_tools` WRITE;
/*!40000 ALTER TABLE `frontend_tools` DISABLE KEYS */;
INSERT INTO `frontend_tools` VALUES (1,'Advanced Dashboard','Track a wide range of data points, including user traffic and sales.','upload/images/frontent/tools/v6sP-test.png','2023-05-29 14:18:13','2023-05-29 14:18:31','Start Making Money','https://codecanyon.net/item/magicai-openai-content-text-image-chat-code-generator-as-saas/45408109','Discover MagicAI','#templates'),(2,'Payment Gateways','Securely process credit card or other electronic payment methods.','upload/images/frontent/tools/Payments100.jpg','2023-05-29 14:19:49','2023-05-29 14:19:49','Start Making Money','https://codecanyon.net/item/magicai-openai-content-text-image-chat-code-generator-as-saas/45408109','Discover MagicAI','#templates'),(3,'Multilingual','Ability to understand and generate content in different languages.','upload/images/frontent/tools/NZBW-multilingual.png','2023-05-29 14:20:18','2023-05-29 14:20:18','Start Making Money','https://codecanyon.net/item/magicai-openai-content-text-image-chat-code-generator-as-saas/45408109','Discover MagicAI','#templates'),(4,'Affiliate System','Ability to invite friends, and earn commission from their first purchase.','upload/images/frontent/tools/RAhq-affiliate-system.png','2023-05-29 14:20:49','2023-05-29 14:20:49','Start Making Money','https://codecanyon.net/item/magicai-openai-content-text-image-chat-code-generator-as-saas/45408109','Discover MagicAI','#templates'),(5,'Easy Export','Export generated content as plain text, PDF, Word or HTML easily.','upload/images/frontent/tools/mPWB-easy-export.png','2023-05-29 14:21:05','2023-05-29 14:21:05','Start Making Money','https://codecanyon.net/item/magicai-openai-content-text-image-chat-code-generator-as-saas/45408109','Discover MagicAI','#templates'),(6,'Support Platform','Access and mage support tickets from your dashboard.','upload/images/frontent/tools/rIwa-support-platform.png','2023-05-29 14:21:21','2023-05-29 14:21:21','Start Making Money','https://codecanyon.net/item/magicai-openai-content-text-image-chat-code-generator-as-saas/45408109','Discover MagicAI','#templates');
/*!40000 ALTER TABLE `frontend_tools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frontend_who_is_for`
--

DROP TABLE IF EXISTS `frontend_who_is_for`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frontend_who_is_for` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frontend_who_is_for`
--

LOCK TABLES `frontend_who_is_for` WRITE;
/*!40000 ALTER TABLE `frontend_who_is_for` DISABLE KEYS */;
INSERT INTO `frontend_who_is_for` VALUES (1,'Digital Agencies','orange','2023-06-02 13:16:34','2023-06-02 10:38:34'),(2,'Product Designers','purple','2023-06-02 13:16:34','2023-06-02 13:16:34'),(3,'Enterpreneurs','teal','2023-06-02 13:16:34','2023-06-02 13:16:34'),(4,'Copywriters','blue','2023-06-02 13:16:34','2023-06-02 13:16:34'),(5,'Digital Marketers','green','2023-06-02 13:16:34','2023-06-02 13:16:34'),(6,'Developers','red','2023-06-02 13:16:34','2023-06-02 13:16:34');
/*!40000 ALTER TABLE `frontend_who_is_for` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gateway_taxes`
--

DROP TABLE IF EXISTS `gateway_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gateway_taxes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `gateway_id` int DEFAULT NULL,
  `country_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gateway_taxes`
--

LOCK TABLES `gateway_taxes` WRITE;
/*!40000 ALTER TABLE `gateway_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `gateway_taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gatewayproducts`
--

DROP TABLE IF EXISTS `gatewayproducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gatewayproducts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `plan_id` int NOT NULL DEFAULT '0',
  `plan_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gatewayproducts`
--

LOCK TABLES `gatewayproducts` WRITE;
/*!40000 ALTER TABLE `gatewayproducts` DISABLE KEYS */;
/*!40000 ALTER TABLE `gatewayproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gateways`
--

DROP TABLE IF EXISTS `gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gateways` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` int NOT NULL DEFAULT '0',
  `mode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sandbox_client_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sandbox_client_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sandbox_app_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_client_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_client_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_app_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_action` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_locale` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notify_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sandbox_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validate_ssl` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `webhook_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logger` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `webhook_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `automate_tax` tinyint(1) NOT NULL DEFAULT '0',
  `bank_account_details` text COLLATE utf8mb4_unicode_ci,
  `bank_account_other` text COLLATE utf8mb4_unicode_ci,
  `country_tax_enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gateways`
--

LOCK TABLES `gateways` WRITE;
/*!40000 ALTER TABLE `gateways` DISABLE KEYS */;
INSERT INTO `gateways` VALUES (1,'banktransfer','Bank Transfer',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'130',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-13 14:12:59','2026-09-13 15:08:01',NULL,'0',0,'Bank Name:sdf\r\nAccount Name:sadfsd\r\nIBAN:52132sd\r\nBIC/Swift:\r\nRouting Number:','To facilitate the processing of your transaction, kindly remit your payment directly to our designated bank account. Please ensure to include your Order ID Number as the payment reference to expedite the allocation of funds to your account. Note that services will not be credited until the payment has successfully been received in our bank account. We appreciate your cooperation and thank you for choosing our services.',0);
/*!40000 ALTER TABLE `gateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `health_check_result_history_items`
--

DROP TABLE IF EXISTS `health_check_result_history_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `health_check_result_history_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `check_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `check_label` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notification_message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_summary` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta` json NOT NULL,
  `ended_at` timestamp NOT NULL,
  `batch` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `health_check_result_history_items_created_at_index` (`created_at`),
  KEY `health_check_result_history_items_batch_index` (`batch`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `health_check_result_history_items`
--

LOCK TABLES `health_check_result_history_items` WRITE;
/*!40000 ALTER TABLE `health_check_result_history_items` DISABLE KEYS */;
INSERT INTO `health_check_result_history_items` VALUES (1,'DebugMode','Debug Mode','ok','','false','{\"actual\": false, \"expected\": false}','2026-09-13 14:20:25','4b0cfe61-76a3-4f8e-96e2-b903d56c31a6','2026-09-13 14:20:25','2026-09-13 14:20:25'),(2,'Environment','Environment','ok','','production','{\"actual\": \"production\", \"expected\": \"production\"}','2026-09-13 14:20:25','4b0cfe61-76a3-4f8e-96e2-b903d56c31a6','2026-09-13 14:20:25','2026-09-13 14:20:25'),(3,'Database','Database','ok','','Ok','{\"connection_name\": \"mysql\"}','2026-09-13 14:20:25','4b0cfe61-76a3-4f8e-96e2-b903d56c31a6','2026-09-13 14:20:25','2026-09-13 14:20:25'),(4,'MemoryLimit','Memory Limit','ok','512M','Ok','[]','2026-09-13 14:20:25','4b0cfe61-76a3-4f8e-96e2-b903d56c31a6','2026-09-13 14:20:25','2026-09-13 14:20:25');
/*!40000 ALTER TABLE `health_check_result_history_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `howitworks`
--

DROP TABLE IF EXISTS `howitworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `howitworks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order` int NOT NULL DEFAULT '0',
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bg_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bg_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `howitworks`
--

LOCK TABLES `howitworks` WRITE;
/*!40000 ALTER TABLE `howitworks` DISABLE KEYS */;
INSERT INTO `howitworks` VALUES (1,1,'Simply explain what your content is about and adjust settings according to your needs.','2023-06-02 08:41:26','2023-06-02 08:41:26',NULL,NULL,NULL,NULL,NULL),(2,2,'Simply input some basic information or keywords about your brand or product, and let our AI algorithms do the rest.','2023-06-02 08:41:34','2023-06-02 08:41:34',NULL,NULL,NULL,NULL,NULL),(3,3,'View, edit or export your result with a few clicks. And you’re done!','2023-06-02 08:41:41','2023-06-02 08:41:41',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `howitworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrations`
--

DROP TABLE IF EXISTS `integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integrations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `app` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrations`
--

LOCK TABLES `integrations` WRITE;
/*!40000 ALTER TABLE `integrations` DISABLE KEYS */;
INSERT INTO `integrations` VALUES (1,'Wordpress','Wordpress integration','images/integrations/wordpress.png','wordpress',0,'2024-03-08 23:28:43','2024-03-08 23:28:44');
/*!40000 ALTER TABLE `integrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `introductions`
--

DROP TABLE IF EXISTS `introductions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `introductions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `intro` text COLLATE utf8mb4_unicode_ci,
  `order` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `title` text COLLATE utf8mb4_unicode_ci,
  `file_path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `introductions`
--

LOCK TABLES `introductions` WRITE;
/*!40000 ALTER TABLE `introductions` DISABLE KEYS */;
INSERT INTO `introductions` VALUES (1,'initialize','Welcome to MagicAI. Let\'s take a quick tour',1,'2026-09-12 17:15:56','2026-09-12 17:15:56',1,NULL,NULL,NULL,NULL,NULL),(2,'ai_writer','A great tool for using the Text Generator & AI Copywriting Assistant.',2,'2026-09-12 17:15:56','2026-09-12 17:15:56',1,NULL,NULL,NULL,NULL,NULL),(3,'ai_image','Create stunning images with just a few words.',3,'2026-09-12 17:15:56','2026-09-12 17:15:56',1,NULL,NULL,NULL,NULL,NULL),(4,'ai_pdf','Simply upload a PDF, find specific information. extract key insights or summarize the entire document.',4,'2026-09-12 17:15:56','2026-09-12 17:15:56',1,NULL,NULL,NULL,NULL,NULL),(5,'ai_code','Generate high quality code in seconds.',5,'2026-09-12 17:15:56','2026-09-12 17:15:56',1,NULL,NULL,NULL,NULL,NULL),(6,'select_plan','Choose the plan that suits you and start creating right away.',6,'2026-09-12 17:15:56','2026-09-12 17:15:56',1,NULL,NULL,NULL,NULL,NULL),(7,'affiliate_send','Invite your friends and start earning commissions.',7,'2026-09-12 17:15:56','2026-09-12 17:15:56',1,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `introductions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `linkedin_tokens`
--

DROP TABLE IF EXISTS `linkedin_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkedin_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `access_token` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linkedin_tokens`
--

LOCK TABLES `linkedin_tokens` WRITE;
/*!40000 ALTER TABLE `linkedin_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `linkedin_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int unsigned DEFAULT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `route` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route_slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `svg` text COLLATE utf8mb4_unicode_ci,
  `order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `params` longtext COLLATE utf8mb4_unicode_ci,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `badge` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bolt_menu` tinyint(1) DEFAULT '0',
  `bolt_background` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bolt_foreground` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_icon` tinyint(1) DEFAULT '0',
  `letter_icon_bg` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `custom_menu` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_key_unique` (`key`),
  KEY `idx_menus_parent_id` (`parent_id`),
  KEY `idx_menus_parent_id_order` (`parent_id`,`order`),
  KEY `idx_menus_is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,NULL,'user_label',NULL,NULL,'User',NULL,NULL,1,1,'[]','label',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(2,NULL,'dashboard','dashboard.user.index',NULL,'Dashboard','tabler-layout-2',NULL,2,1,'[]','item',NULL,NULL,1,'#9A6FFD','#fff',NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:22:03',0),(3,NULL,'creative_suite','dashboard.user.creative-suite.index',NULL,'Creative Suite','tabler-image-in-picture',NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(4,NULL,'ext_crm_dropdown','dashboard.user.crm.index',NULL,'CRM','tabler-briefcase',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(5,4,'crm_dashboard','dashboard.user.crm.index',NULL,'Dashboard','tabler-layout-dashboard',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(6,4,'crm_assistant','dashboard.user.crm.ai.index',NULL,'CRM Assistant','tabler-message-chatbot',NULL,2,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(7,4,'crm_contacts','dashboard.user.crm.contacts.index',NULL,'Contacts','tabler-address-book',NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(8,4,'crm_companies','dashboard.user.crm.companies.index',NULL,'Companies','tabler-building',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(9,4,'crm_deals','dashboard.user.crm.deals.index',NULL,'Deals','tabler-coin',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(10,4,'crm_projects','dashboard.user.crm.projects.index',NULL,'Projects','tabler-briefcase',NULL,6,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(11,4,'crm_tasks','dashboard.user.crm.tasks.index',NULL,'Tasks','tabler-checklist',NULL,7,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(12,4,'crm_calendar','dashboard.user.crm.calendar.index',NULL,'Calendar','tabler-calendar',NULL,8,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(13,4,'crm_presentations','dashboard.user.crm.presentations.index',NULL,'Presentations','tabler-presentation',NULL,9,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(14,4,'crm_reports','dashboard.user.crm.reports.index',NULL,'Reports','tabler-chart-bar',NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(15,NULL,'ext_sales_dropdown','dashboard.user.sales.invoices.index',NULL,'Sales','tabler-receipt',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(16,15,'crm_sales_invoices','dashboard.user.sales.invoices.index',NULL,'Invoices','tabler-file-invoice',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(17,15,'crm_sales_payments','dashboard.user.sales.payments.index',NULL,'Payments','tabler-cash',NULL,2,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(18,15,'crm_sales_proposals','dashboard.user.sales.proposals.index',NULL,'Proposals','tabler-file-text',NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(19,15,'crm_sales_estimates','dashboard.user.sales.estimates.index',NULL,'Estimates','tabler-calculator',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(20,NULL,'ext_chat_bot','dashboard.chatbot.index',NULL,'AI Chat Bots','tabler-message-chatbot',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(21,NULL,'ext_chatbot_analytics','dashboard.chatbot.analytics.index',NULL,'AI Bot Analytics','tabler-chart-bar',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(22,NULL,'ext_chatbot_knowledge_base_article','dashboard.chatbot.knowledge-base-article.index',NULL,'AI Bot Knowledge Base','tabler-library',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(23,NULL,'ext_chatbot_canned_response','dashboard.chatbot.canned-response.index',NULL,'AI Bot Canned Responses','tabler-message-reply',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(24,NULL,'ext_chatbot_chatbot_customer_article','dashboard.chatbot.chatbot-customer.index',NULL,'AI Bot Contacts','tabler-library',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(25,NULL,'ext_voice_chatbot','dashboard.chatbot-voice.index',NULL,'AI Voice Bots','tabler-message-chatbot',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(26,NULL,'ext_phone_call_agent','dashboard.phone-call-agent.index',NULL,'Phone Call Agent','tabler-phone-call',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(27,26,'ext_phone_call_agent_dashboard','dashboard.phone-call-agent.index',NULL,'Dashboard','tabler-layout-dashboard',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(28,26,'ext_phone_call_agent_history','dashboard.phone-call-agent.history',NULL,'Call History','tabler-history',NULL,2,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(29,26,'ext_phone_call_agent_outbound','dashboard.phone-call-agent.outbound.index',NULL,'Outbound Calls','tabler-phone-outgoing',NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(30,26,'ext_phone_call_agent_new','dashboard.phone-call-agent.new',NULL,'Create Agent','tabler-plus',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(31,NULL,'marketing_bot_dashboard','dashboard.user.marketing-bot.dashboard',NULL,'Marketing Bot','tabler-dashboard',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(32,NULL,'marketing_bot_settings','dashboard.user.marketing-bot.settings.index',NULL,'Marketing Bot Settings','tabler-settings-code',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(33,NULL,'marketing_bot',NULL,NULL,'Marketing bot',NULL,NULL,4,1,'[]','label',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(34,NULL,'marketing_bot_inbox','dashboard.user.marketing-bot.inbox.index',NULL,'Inbox','tabler-inbox',NULL,4,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(35,NULL,'marketing_bot_campaigns','dashboard.user.marketing-bot.whatsapp-campaign.index',NULL,'Campaigns','tabler-flag-share',NULL,4,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(36,35,'marketing_bot_campaigns_whatsapp','dashboard.user.marketing-bot.whatsapp-campaign.index',NULL,'Whatsapp',NULL,NULL,4,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(37,35,'marketing_bot_campaigns_telegram','dashboard.user.marketing-bot.telegram-campaign.index',NULL,'Telegram',NULL,NULL,4,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(38,NULL,'marketing_bot_telegram','dashboard.user.marketing-bot.telegram-group.index',NULL,'Telegram','tabler-brand-telegram',NULL,4,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(39,38,'marketing_bot_telegram_group','dashboard.user.marketing-bot.telegram-group.index',NULL,'Telegram Groups',NULL,NULL,4,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(40,38,'marketing_bot_telegram_subscribers','dashboard.user.marketing-bot.telegram-subscriber.index',NULL,'Telegram Subscribers',NULL,NULL,4,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(41,NULL,'marketing_bot_whatsapp','dashboard.user.marketing-bot.contact.index',NULL,'Whatsapp','tabler-brand-whatsapp',NULL,4,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(42,41,'marketing_bot_whatsapp_contact','dashboard.user.marketing-bot.contact.index',NULL,'Contact Lists',NULL,NULL,4,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(43,41,'marketing_bot_whatsapp_segment','dashboard.user.marketing-bot.segment.index',NULL,'Segments',NULL,NULL,4,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(44,41,'marketing_bot_whatsapp_contact_list','dashboard.user.marketing-bot.contact-list.index',NULL,'Contacts',NULL,NULL,4,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(45,NULL,'ai_agent','dashboard.user.ai-agent.dashboard',NULL,'AI Agent','tabler-robot',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(46,45,'ai_agent_dashboard','dashboard.user.ai-agent.dashboard',NULL,'Dashboard','tabler-layout-dashboard',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(47,45,'ai_agent_workflows','dashboard.user.ai-agent.workflows.index',NULL,'Agents','tabler-git-branch',NULL,2,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(48,45,'ai_agent_messages','dashboard.user.ai-agent.messages.index',NULL,'Channel Messages','tabler-messages',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(49,NULL,'ext_chat_bot_agent','dashboard.chatbot-agent.index',NULL,'Human Agent','tabler-message',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-13 15:19:08',0),(50,NULL,'ext_ai_photo_studio_dropdown','dashboard.user.ai-photoshoot.index',NULL,'AI Photoshoot','tabler-camera',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(51,50,'ext_ai_photo_studio','dashboard.user.ai-photoshoot.index',NULL,'Dashboard','tabler-layout-dashboard',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(52,50,'ext_ai_photo_studio_custom','dashboard.user.ai-photoshoot.custom.index',NULL,'Custom Photoshoot','tabler-wand',NULL,2,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(53,50,'ext_ai_photo_studio_templates','dashboard.user.ai-photoshoot.templates.index',NULL,'Template Photoshoot','tabler-template',NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(54,50,'ext_ai_photo_studio_replace_background','dashboard.user.ai-photoshoot.replace-background.index',NULL,'Replace Background','tabler-replace',NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(55,50,'ext_ai_photo_studio_edit_image','dashboard.user.ai-photoshoot.edit_image.index',NULL,'Edit Image','tabler-pencil',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(56,50,'ext_ai_photo_studio_my_photoshoots','dashboard.user.ai-photoshoot.photo_shoots.my',NULL,'My Photoshoots','tabler-photo',NULL,6,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(57,NULL,'ext_fashion_studio_dropdown','dashboard.user.fashion-studio.index',NULL,'AI Fashion Studio','tabler-tie',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(58,57,'ext_fashion_studio','dashboard.user.fashion-studio.index',NULL,'Dashboard','tabler-layout-dashboard',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(59,57,'ext_fashion_studio_photo_shoot','dashboard.user.fashion-studio.photo_shoots.index',NULL,'PhotoShoot','tabler-camera',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(60,57,'ext_fashion_studio_virtual_try_on','dashboard.user.fashion-studio.virtual_try_on.index',NULL,'Virtual Try-on','tabler-shirt',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(61,57,'ext_fashion_studio_change_model','dashboard.user.fashion-studio.change_model.index',NULL,'Change Model','tabler-user-square-rounded',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(62,57,'ext_fashion_studio_edit_image','dashboard.user.fashion-studio.edit_image.index',NULL,'Edit Image','tabler-pencil',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(63,57,'ext_fashion_studio_create_video','dashboard.user.fashion-studio.create_video.index',NULL,'Create Video','tabler-video',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(64,57,'ext_fashion_studio_photo_shoots','dashboard.user.fashion-studio.photo_shoots.my',NULL,'My Photo Shoots','tabler-copy',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(65,57,'ext_fashion_studio_wardrobe','dashboard.user.fashion-studio.wardrobe.index',NULL,'My Wardrobe','tabler-hanger-2',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(66,57,'ext_fashion_studio_user_settings','dashboard.user.fashion-studio.user_settings.index',NULL,'Settings','tabler-settings',NULL,99,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(67,NULL,'ext_ugc_dropdown','dashboard.user.ugc-studio.index',NULL,'UGC','tabler-video',NULL,6,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(68,67,'ext_ugc_studio','dashboard.user.ugc-studio.index',NULL,'Studio','tabler-layout-dashboard',NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(69,67,'ext_ugc_factory','dashboard.user.ugc-factory.index',NULL,'Factory','tabler-wand',NULL,2,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(70,67,'ext_ugc_creator','dashboard.user.ugc-creator.index',NULL,'Creator','tabler-movie',NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(71,NULL,'ext_chatbot_customer_tag','dashboard.chatbot-customer-tags.index',NULL,'Customer Tags','tabler-tags',NULL,6,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-13 15:19:09',0),(72,NULL,'ext_social_media_dropdown','dashboard.user.social-media.index',NULL,'AI Social Media','tabler-thumb-up',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(73,72,'ext_social_media','dashboard.user.social-media.index',NULL,'Dashboard',NULL,NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(74,72,'ext_social_media_campaign','dashboard.user.social-media.campaign.index',NULL,'Campaigns',NULL,NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(75,72,'ext_social_media_platform','dashboard.user.social-media.platforms',NULL,'Platforms',NULL,NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(76,72,'ext_social_media_post','dashboard.user.social-media.post.index',NULL,'Social Media Posts',NULL,NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(77,72,'ext_social_media_calendar','dashboard.user.social-media.calendar',NULL,'Calendar',NULL,NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(78,72,'ext_social_media_automation','dashboard.user.social-media.automation.index',NULL,'Automation',NULL,NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(79,NULL,'ext_social_media_agent_dropdown','dashboard.user.social-media.agent.index',NULL,'AI Social Media Agent','tabler-thumb-up',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(80,79,'ext_social_media_agent_dashboard','dashboard.user.social-media.agent.index',NULL,'Dashboard',NULL,NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(81,79,'ext_social_media_agent_agents','dashboard.user.social-media.agent.agents',NULL,'Agents',NULL,NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(82,79,'ext_social_media_agent_agents_archived_posts','dashboard.user.social-media.agent.posts',NULL,'Archived Posts',NULL,NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(83,79,'ext_social_media_agent_calendar','dashboard.user.social-media.agent.calendar',NULL,'Calendar',NULL,NULL,2,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(84,79,'ext_social_media_agent_analytics','dashboard.user.social-media.agent.analytics',NULL,'Analytics',NULL,NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:52','2026-09-12 17:01:52',0),(85,79,'ext_social_media_agent_accounts','dashboard.user.social-media.agent.accounts',NULL,'Accounts',NULL,NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(86,79,'ext_social_media_agent_chat','dashboard.user.social-media.agent.chat.index',NULL,'Chat',NULL,NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(87,NULL,'ext_blogpilot_dropdown','dashboard.user.blogpilot.agent.index',NULL,'AI BlogPilot','tabler-file-text-ai',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(88,87,'ext_blogpilot_dashboard','dashboard.user.blogpilot.agent.index',NULL,'Dashboard',NULL,NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(89,87,'ext_blogpilot_agents','dashboard.user.blogpilot.agent.agents',NULL,'Agents',NULL,NULL,2,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(90,87,'ext_blogpilot_agents_archived_posts','dashboard.user.blogpilot.agent.posts',NULL,'Posts',NULL,NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(91,87,'ext_blogpilot_calendar','dashboard.user.blogpilot.agent.calendar',NULL,'Calendar',NULL,NULL,4,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(92,87,'ext_blogpilot_analytics','dashboard.user.blogpilot.agent.analytics',NULL,'Analytics',NULL,NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(93,NULL,'ai_influencer','dashboard.user.ai-influencer.index',NULL,'AI Influencer','tabler-star',NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-13 15:19:08',0),(94,NULL,'url_to_video','dashboard.user.url-to-video.index',NULL,'Url To Video','tabler-photo-video',NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(95,NULL,'viral_clips','dashboard.user.viral-clips.index',NULL,'AI Viral Clips','tabler-movie',NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(96,NULL,'influencer_avatar','dashboard.user.influencer-avatar.index',NULL,'Influencer Avatar','tabler-device-mobile-star',NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(97,NULL,'documents','dashboard.user.openai.documents.all',NULL,'Documents','tabler-archive',NULL,3,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(98,NULL,'ai_editor','dashboard.user.generator.index',NULL,'AI Editor','tabler-notebook',NULL,4,1,'[]','item',NULL,NULL,1,'#E29CB6','#fff',NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:22:03',0),(99,NULL,'ai_writer','dashboard.user.openai.list',NULL,'AI Writer','tabler-notes',NULL,5,1,'[]','item',NULL,NULL,1,'#468EA6','#fff',NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:22:03',0),(100,NULL,'ai_video','dashboard.user.openai.generator','ai_video','AI Video','tabler-video',NULL,6,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(101,NULL,'ai_video_to_video','dashboard.user.openai.generator','ai_video_to_video','AI Video To Video','tabler-video',NULL,7,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(102,NULL,'ai_image_generator','dashboard.user.openai.generator','ai_image_generator','AI Image','tabler-photo',NULL,7,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(103,NULL,'ai_article_wizard','dashboard.user.openai.articlewizard.new','ai_article_wizard','AI Article Wizard','tabler-ad-2',NULL,8,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(104,NULL,'ai_pdf','dashboard.user.openai.generator.workbook','ai_pdf','AI File Chat','tabler-file-pencil',NULL,9,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(105,NULL,'ai_vision','dashboard.user.openai.generator.workbook','ai_vision','AI Vision','tabler-scan-eye',NULL,10,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(106,NULL,'ai_realtime_voice_chat','dashboard.user.openai.chat.chat','ai_realtime_voice_chat','AI Realtime Voice Chat','tabler-wave-sine',NULL,10,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(107,NULL,'ai_realtime_image','dashboard.user.ai-realtime-image.index','ai_realtime_image','AI Realtime Image','tabler-image-in-picture',NULL,10,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(108,NULL,'ai_rewriter','dashboard.user.openai.rewriter','ai_rewriter','AI ReWriter','tabler-ballpen',NULL,11,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(109,NULL,'ai_chat_image','dashboard.user.openai.generator.workbook','ai_chat_image','AI Chat Image','tabler-photo',NULL,12,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(110,NULL,'ai_chat_all','dashboard.user.openai.chat.chat',NULL,'AI Chat','tabler-message-dots',NULL,13,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(111,NULL,'ai_chat_pro','dashboard.user.openai.chat.pro.index',NULL,'AI Chat Pro','tabler-message-plus',NULL,13,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(112,NULL,'ai_chat_pro_image_chat','ai-chat-image.index',NULL,'Image Assistant','tabler-photo-up',NULL,13,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(113,NULL,'ai_image_pro','dashboard.user.ai-image-pro.index',NULL,'AI Image Pro','tabler-photo-up',NULL,13,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(114,NULL,'ai_image_pro_bookmark','dashboard.user.ai-image-pro.index','slug=bookmarks','Bookmark','tabler-bookmark',NULL,13,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(115,NULL,'ai_image_pro_real_time','dashboard.user.ai-image-pro.realtime',NULL,'Realtime Image','tabler-aperture',NULL,13,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-13 15:19:09',0),(116,NULL,'ai_image_pro_edit','dashboard.user.ai-image-pro.edit',NULL,'Smart Edit','tabler-vector-bezier',NULL,13,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(117,NULL,'ai_image_pro_get_inspired','dashboard.user.ai-image-pro.index','slug=inspired','Get Inspired','tabler-wand',NULL,13,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(118,NULL,'ai_image_pro_media_library','ai-image-pro.media-library',NULL,'Media Library','tabler-inbox',NULL,13,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(119,NULL,'ai_code_generator','dashboard.user.openai.generator.workbook','ai_code_generator','AI Code','tabler-terminal-2',NULL,14,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(120,NULL,'ai_presentation','dashboard.user.ai-presentation.index',NULL,'AI Presentation','tabler-presentation',NULL,14,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(121,NULL,'ai_youtube','dashboard.user.openai.generator.workbook','ai_youtube','AI YouTube','tabler-brand-youtube',NULL,15,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(122,NULL,'ai_rss','dashboard.user.openai.generator.workbook','ai_rss','AI RSS','tabler-rss',NULL,15,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(123,NULL,'ai_speech_to_text','dashboard.user.openai.generator','ai_speech_to_text','AI Speech to Text','tabler-microphone',NULL,16,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(124,NULL,'ai_voiceover','dashboard.user.openai.generator','ai_voiceover','AI Voiceover','tabler-volume',NULL,17,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(125,NULL,'ai_voice_isolator','dashboard.user.openai.generator','ai_voice_isolator','AI Voice Isolator','tabler-ear-scan',NULL,18,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(126,NULL,'ai_voiceover_clone','dashboard.user.voice.index',NULL,'AI Voice Clone','tabler-microphone-2',NULL,18,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(127,NULL,'team_menu','dashboard.user.team.index',NULL,'Team','tabler-user-plus',NULL,19,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(128,NULL,'brand_voice','dashboard.user.brand.index',NULL,'Brand Voice','tabler-brand-trello',NULL,20,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(129,NULL,'advanced_image','dashboard.user.advanced-image.index',NULL,'AI Image Editor','tabler-photo-edit',NULL,20,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(130,NULL,'ai_avatar','dashboard.user.ai-avatar.index',NULL,'AI Avatar','tabler-slideshow',NULL,20,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(131,NULL,'ai_persona','dashboard.user.ai-persona.index',NULL,'AI Persona','tabler-camera-star',NULL,20,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(132,NULL,'video_studio','dashboard.user.video-studio.index',NULL,'Video Studio','tabler-layout-dashboard',NULL,19,1,'[]','item',NULL,'0',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(133,NULL,'ai_video_pro','dashboard.user.ai-video-pro.index',NULL,'AI Video Pro','tabler-video',NULL,20,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(134,NULL,'video_dubbing','dashboard.user.video-dubbing.index',NULL,'Video Dubbing','tabler-language',NULL,20,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(135,NULL,'ai_captions','dashboard.user.ai-captions.index',NULL,'AI Captions','tabler-quote',NULL,20,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(136,NULL,'ai_music','dashboard.user.ai-music.index',NULL,'AI Music','tabler-slideshow',NULL,20,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(137,NULL,'ext_ai_music_pro','dashboard.user.ai-music-pro.index',NULL,'AI Music Pro','tabler-music',NULL,20,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(138,NULL,'ai_product_shot','dashboard.user.ai-product-shot.index',NULL,'AI Product Photography','tabler-photo-star',NULL,20,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(139,NULL,'api_keys','dashboard.user.apikeys.index',NULL,'API Keys','tabler-key',NULL,21,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(140,NULL,'affiliates','dashboard.user.affiliates.index',NULL,'Affiliates','tabler-currency-dollar',NULL,22,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(141,NULL,'support','dashboard.support.list',NULL,'Support','tabler-lifebuoy',NULL,23,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(142,NULL,'integration','dashboard.user.integration.index',NULL,'Integration','tabler-webhook',NULL,24,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(143,NULL,'divider_one',NULL,NULL,NULL,NULL,NULL,25,1,'[]','divider',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(144,NULL,'links',NULL,NULL,'Links',NULL,NULL,26,1,'[]','label',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(145,NULL,'favorites','dashboard.user.openai.list','filter=favorite','Favorites',NULL,NULL,27,1,'[]','item',NULL,NULL,0,NULL,NULL,1,'bg-[#7A8193] text-white','2026-09-12 17:01:53','2026-09-12 17:01:53',0),(146,NULL,'workbook','dashboard.user.openai.documents.all','?filter=favorites','Workbook',NULL,NULL,28,1,'[]','item',NULL,NULL,0,NULL,NULL,1,'bg-[#658C8E] text-white','2026-09-12 17:01:53','2026-09-12 17:01:53',0),(147,NULL,'divider_two',NULL,NULL,NULL,NULL,NULL,29,1,'[]','divider',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(148,NULL,'admin_label',NULL,NULL,'Admin',NULL,NULL,30,1,'[]','label',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(149,NULL,'admin_dashboard','dashboard.admin.index',NULL,'Dashboard','tabler-layout-2',NULL,31,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(150,NULL,'marketplace','dashboard.admin.marketplace.index',NULL,'Marketplace','tabler-building-store',NULL,32,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(151,NULL,'themes','dashboard.admin.themes.index',NULL,'Themes','tabler-palette',NULL,33,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(152,NULL,'ext_migration','migration::welcome',NULL,'Migration','tabler-transfer-in',NULL,33,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(153,NULL,'user_management','dashboard.admin.users.index',NULL,'User Management','tabler-users',NULL,34,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(154,153,'user_list','dashboard.admin.users.index',NULL,'Users List',NULL,NULL,34,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(155,153,'user_activity','dashboard.admin.users.activity',NULL,'Users Activities',NULL,NULL,34,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(156,153,'user_dashboard','dashboard.admin.users.dashboard',NULL,'Users Dashboard',NULL,NULL,34,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(157,153,'user_deletion','dashboard.admin.users.deletion.reqs',NULL,'User Deletion Requests',NULL,NULL,34,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(158,153,'user_permission','dashboard.admin.users.permissions',NULL,'User Permissions',NULL,NULL,34,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(159,NULL,'announcements','dashboard.admin.announcements.index',NULL,'Announcements','tabler-speakerphone',NULL,35,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(160,NULL,'discount-manager','dashboard.admin.discount-manager.index',NULL,'Discount & Offer Manager','tabler-shopping-bag-discount',NULL,37,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(161,NULL,'site_promo','dashboard.admin.ads.index',NULL,'Google adsense','tabler-ad-circle',NULL,35,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(162,NULL,'support_requests','dashboard.support.list',NULL,'Support Requests','tabler-lifebuoy',NULL,36,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(163,NULL,'templates','dashboard.admin.openai.list',NULL,'Templates','tabler-list-details',NULL,37,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(164,163,'built_in_templates','dashboard.admin.openai.list',NULL,'Built-in Templates',NULL,NULL,38,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(165,163,'custom_templates','dashboard.admin.openai.custom.list',NULL,'Custom Templates',NULL,NULL,39,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(166,163,'ai_writer_categories','dashboard.admin.openai.categories.list',NULL,'AI Writer Categories',NULL,NULL,40,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(167,NULL,'chat_settings','dashboard.admin.openai.chat.category',NULL,'Chat Settings','tabler-message-circle',NULL,41,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(168,167,'chat_categories','dashboard.admin.openai.chat.category',NULL,'Chat Categories',NULL,NULL,42,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(169,167,'chat_templates','dashboard.admin.openai.chat.list',NULL,'Chat Templates',NULL,NULL,43,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(170,167,'chatbot_training','dashboard.admin.chatbot.index',NULL,'Chatbot Training',NULL,NULL,44,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(171,167,'voice_chatbot_training','dashboard.admin.voice-chatbot.index',NULL,'Voice Chatbot Training',NULL,NULL,44,1,'[]','item',NULL,'0',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(172,167,'ai_assistant','dashboard.admin.ai-assistant.index',NULL,'Assistant Training',NULL,NULL,44,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(173,244,'ai_chat_models','dashboard.admin.ai-chat-model.index',NULL,'AI Models',NULL,NULL,3,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-13 15:19:09',0),(174,167,'ai_engines','dashboard.admin.ai-chat-model.models.index',NULL,'AI Engines',NULL,NULL,45,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(175,167,'floating_chat_settings','dashboard.admin.chatbot.setting',NULL,'Floating Chat Settings',NULL,NULL,45,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(176,167,'social_media_agent_chat_settings','dashboard.admin.social-media.agent.chat.settings',NULL,'Social Media Agent Chat',NULL,NULL,46,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(177,167,'external_chat_settings','dashboard.admin.chatbot.external_settings',NULL,'External Chat Settings',NULL,NULL,47,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(178,NULL,'frontend','dashboard.admin.frontend.settings',NULL,'Frontend','tabler-device-laptop',NULL,47,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(179,178,'frontend_settings','dashboard.admin.frontend.settings',NULL,'Frontend Settings',NULL,NULL,48,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(180,178,'frontend_section_settings','dashboard.admin.frontend.sectionsettings',NULL,'Frontend Section Settings',NULL,NULL,49,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(181,178,'frontend_menu','dashboard.admin.frontend.menusettings',NULL,'Menu',NULL,NULL,50,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(182,178,'social_media_accounts','dashboard.admin.frontend.socialmedia',NULL,'Social Media Accounts',NULL,NULL,50,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(183,178,'auth_settings','dashboard.admin.frontend.authsettings',NULL,'Auth Settings',NULL,NULL,52,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(184,178,'f_a_q','dashboard.admin.frontend.faq.index',NULL,'F.A.Q',NULL,NULL,53,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(185,178,'tools_section','dashboard.admin.frontend.tools.index',NULL,'Tools Section',NULL,NULL,54,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(186,178,'channels_section','dashboard.admin.frontend.channel-setting.index',NULL,'Channels Section',NULL,NULL,54,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(187,178,'content_box','dashboard.admin.frontend.content-box.index',NULL,'Content Box Section',NULL,NULL,54,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(188,178,'curtain_section','dashboard.admin.frontend.curtain.index',NULL,'Curtain Section',NULL,NULL,54,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(189,178,'features_section','dashboard.admin.frontend.future.index',NULL,'Features Section','tabler-list-details',NULL,55,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(190,178,'testimonials_section','dashboard.admin.testimonials.index',NULL,'Testimonials Section',NULL,NULL,56,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(191,178,'clients_section','dashboard.admin.clients.index',NULL,'Clients Section',NULL,NULL,57,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(192,178,'how_it_works_section','dashboard.admin.howitWorks.index',NULL,'How it Works Section',NULL,NULL,58,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(193,178,'who_can_use_section','dashboard.admin.frontend.whois.index',NULL,'Who Can Use Section',NULL,NULL,59,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(194,178,'generators_list_section','dashboard.admin.frontend.generatorlist.index',NULL,'Generators List Section',NULL,NULL,60,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(195,NULL,'finance','dashboard.admin.finance.plans.index',NULL,'Finance','tabler-wallet',NULL,61,1,'[]','item',NULL,NULL,1,'#3569F5','#fff',NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:22:03',0),(196,195,'bank_transactions','dashboard.admin.bank.transactions.list',NULL,'Bank Transactions',NULL,NULL,62,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(197,195,'membership_plans','dashboard.admin.finance.plans.index',NULL,'Membership Plans (old version)',NULL,NULL,63,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-13 15:19:09',0),(198,195,'admin_finance_plan','dashboard.admin.finance.plan.index',NULL,'Pricing Plans',NULL,NULL,63,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-13 15:19:09',0),(199,195,'payment_gateways','dashboard.admin.finance.paymentGateways.index',NULL,'Payment Gateways',NULL,NULL,64,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(200,195,'trial_features','dashboard.admin.finance.free.feature',NULL,'Trial Features',NULL,NULL,60,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(201,195,'mobile_payment','dashboard.admin.finance.mobile.index',NULL,'Mobile Payment',NULL,NULL,60,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(202,195,'shared_credit_costs','dashboard.admin.finance.shared-credit-costs.index',NULL,'Shared Credit Costs',NULL,NULL,65,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(203,195,'shared_credit_migration','dashboard.admin.finance.credit-migration.index',NULL,'Credit Migration',NULL,NULL,66,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(204,NULL,'pages','dashboard.page.list',NULL,'Pages','tabler-file-description',NULL,61,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(205,NULL,'blog','dashboard.blog.list',NULL,'Blog','tabler-pencil',NULL,62,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(206,NULL,'ai-image-pro-publish-reqs','dashboard.admin.ai-image-pro.community-images.index',NULL,'AI Image Pro Publish Requests','tabler-notification',NULL,63,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(207,NULL,'affiliates_admin','dashboard.admin.affiliates.index',NULL,'Affiliates','tabler-currency-dollar',NULL,63,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(208,NULL,'coupons_admin','dashboard.admin.coupons.index',NULL,'Coupons','tabler-ticket',NULL,64,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(209,NULL,'email_templates','dashboard.email-templates.index',NULL,'Email Templates','tabler-mail',NULL,65,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(210,NULL,'onboarding_pro_extension','dashboard.admin.onboarding-pro.index',NULL,'Onboarding Pro','tabler-message-circle',NULL,65,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(211,NULL,'onboarding','dashboard.admin.onboarding.index',NULL,'Onboarding','tabler-directions',NULL,65,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(212,NULL,'mailchimp_newsletter','dashboard.admin.mailchimp-newsletter.index',NULL,'Mailchimp Newsletter','tabler-mailbox',NULL,65,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(213,NULL,'hubspot','dashboard.admin.hubspot.index',NULL,'Hubspot','tabler-affiliate',NULL,65,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(214,NULL,'api_integration','default',NULL,'API Integration','tabler-api',NULL,66,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-13 15:19:09',0),(215,214,'api_integration_azure_openai','dashboard.admin.settings.azure-openai.index',NULL,'Azure OpenAI',NULL,NULL,67,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(216,214,'api_integration_openrouter','dashboard.admin.settings.open-router.show',NULL,'Open Router',NULL,NULL,74,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(217,214,'api_integration_ably','dashboard.admin.settings.ably',NULL,'Ably Setting',NULL,NULL,74,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(218,214,'api_integration_llama','dashboard.admin.settings.llama',NULL,'Llama',NULL,NULL,74,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(219,214,'api_integration_searchapi','dashboard.admin.settings.searchapi',NULL,'Search Api',NULL,NULL,74,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(220,214,'api_integration_openai','dashboard.admin.settings.openai',NULL,'OpenAI',NULL,NULL,67,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(221,214,'api_integration_gemini','dashboard.admin.settings.gemini',NULL,'Gemini',NULL,NULL,67,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(222,214,'api_integration_anthropic','dashboard.admin.settings.anthropic',NULL,'Anthropic',NULL,NULL,68,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(223,214,'api_integration_deepseek','dashboard.admin.settings.deepseek',NULL,'Deepseek',NULL,NULL,68,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(224,214,'api_integration_fal_ai','dashboard.admin.settings.fal-ai',NULL,'Fal AI',NULL,NULL,68,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-13 15:19:09',0),(225,214,'api_integration_gamma_ai','dashboard.admin.settings.gamma-ai',NULL,'Gamma AI',NULL,NULL,68,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(226,214,'api_integration_creatify','dashboard.admin.settings.creatify',NULL,'Creatify',NULL,NULL,68,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(227,214,'api_integration_topview','dashboard.admin.settings.topview',NULL,'Topview',NULL,NULL,68,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(228,214,'api_integration_vizard','dashboard.admin.settings.vizard',NULL,'Vizard',NULL,NULL,68,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(229,214,'api_integration_klap','dashboard.admin.settings.klap',NULL,'Klap',NULL,NULL,68,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(230,214,'api_integration_piapi_ai','dashboard.admin.settings.piapi-ai',NULL,'PiAPI',NULL,NULL,69,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(231,214,'api_integration_stablediffusion','dashboard.admin.settings.stablediffusion',NULL,'StableDiffusion',NULL,NULL,69,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(232,214,'api_integration_unsplashapi','dashboard.admin.settings.unsplashapi',NULL,'Unsplash',NULL,NULL,70,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(233,214,'api_integration_pexelsapi','dashboard.admin.settings.pexelsapi',NULL,'Pexels',NULL,NULL,71,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(234,214,'api_integration_pixabayapi','dashboard.admin.settings.pixabayapi',NULL,'Pixabay',NULL,NULL,72,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(235,214,'api_integration_serperapi','dashboard.admin.settings.serperapi',NULL,'Serper',NULL,NULL,73,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(236,214,'api_integration_perplexity','dashboard.admin.settings.perplexity',NULL,'Perplexity',NULL,NULL,73,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(237,214,'api_integration_tts','dashboard.admin.settings.tts',NULL,'TTS',NULL,NULL,74,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(238,214,'api_integration_synthesia','dashboard.admin.settings.synthesia',NULL,'Synthesia',NULL,NULL,74,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(239,214,'api_integration_together','dashboard.admin.settings.together',NULL,'Together',NULL,NULL,74,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(240,214,'api_integration_heygen','dashboard.admin.settings.heygen',NULL,'Heygen',NULL,NULL,74,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(241,214,'api_integration_aimlapi','dashboard.admin.settings.aimlapi',NULL,'Aimlapi',NULL,NULL,74,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(242,214,'api_integration_pebblely','dashboard.admin.settings.pebblely',NULL,'Pebblely',NULL,NULL,74,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(243,214,'plagiarism_extension','dashboard.admin.settings.plagiarism',NULL,'Plagiarism API',NULL,NULL,77,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(244,NULL,'settings','dashboard.admin.settings.general',NULL,'Settings','tabler-device-laptop',NULL,75,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(245,244,'config','dashboard.admin.config.index',NULL,'General Settings',NULL,NULL,0,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-13 15:19:08',0),(246,NULL,'live_customizer','dashboard.admin.live-customizer.setting',NULL,'Live Customizer ','tabler-brush',NULL,69,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(247,244,'thumbnail_system','dashboard.admin.settings.thumbnail',NULL,'Thumbnail System',NULL,NULL,79,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(248,244,'premium_advantages','dashboard.admin.config.premium-advantages.index',NULL,'Premium Advantages',NULL,NULL,79,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(249,244,'advanced_image_setting','dashboard.admin.settings.advanced-image.index',NULL,'AI Image Editor Setting',NULL,NULL,70,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(250,244,'privacy','dashboard.admin.settings.privacy',NULL,'Privacy Policy and Terms',NULL,NULL,82,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(251,NULL,'site_health','dashboard.admin.health.index',NULL,'Site Health','tabler-activity-heartbeat',NULL,85,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(252,NULL,'license','dashboard.admin.license.index',NULL,'License','tabler-checklist',NULL,86,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(253,NULL,'update','dashboard.admin.update.index',NULL,'Update','tabler-refresh',NULL,87,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(254,NULL,'menu_setting','dashboard.admin.menu.index',NULL,'Menu','tabler-menu',NULL,88,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(255,NULL,'footer_menu_setting','dashboard.admin.footer-menu.index',NULL,'Footer Menu','tabler-menu',NULL,89,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(256,NULL,'mega_menu_setting','dashboard.admin.mega-menu.index',NULL,'Mega Menu','tabler-menu-2',NULL,88,1,'[]','item',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(257,NULL,'openai_generator_extension','default',NULL,'Ai Template','tabler-list-details',NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(258,257,'custom_templates_extension','dashboard.user.ai-template.openai-generator.index',NULL,'Custom Templates',NULL,NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(259,257,'ai_writer_categories_extension','dashboard.user.ai-template.openai-generator-filter.index',NULL,'AI Writer Categories',NULL,NULL,5,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(260,NULL,'ai_plagiarism_extension','dashboard.user.openai.plagiarism.index',NULL,'AI Plagiarism','tabler-progress-check',NULL,6,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(261,NULL,'ai_detector_extension','dashboard.user.openai.detectaicontent.index',NULL,'AI Detector','tabler-text-scan-2',NULL,6,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(262,NULL,'ai_social_media_extension','dashboard.user.automation.index',NULL,'AI Social Media','tabler-share',NULL,6,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(263,NULL,'scheduled_posts_extension','dashboard.user.automation.list',NULL,'Social Media Posts','tabler-report',NULL,6,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(264,244,'ai_social_media_settings_extension','dashboard.admin.automation.settings',NULL,'AI Social Media Settings',NULL,NULL,77,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(265,244,'ai_chat_pro_settings_extension','dashboard.admin.openai.chat.pro.settings',NULL,'AI Chat Pro Settings',NULL,NULL,77,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(266,244,'video_dubbing_settings_extension','dashboard.admin.video-dubbing.settings',NULL,'Video Dubbing Settings',NULL,NULL,78,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(267,214,'ai_captions_settings_extension','dashboard.admin.ai-captions.settings',NULL,'AI Captions',NULL,NULL,78,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(268,244,'ai_music_pro_settings_extension','dashboard.admin.ai-music-pro.settings',NULL,'AI Music Pro Settings',NULL,NULL,79,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(269,244,'ai_chat_pro_image_chat_settings_extension','dashboard.admin.ai-chat-pro-image-chat.settings',NULL,'AI Chat Pro Image Chat Settings',NULL,NULL,78,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(270,244,'ai_image_pro_settings_extension','dashboard.admin.ai-image-pro.settings',NULL,'AI Image Pro Settings',NULL,NULL,78,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(271,244,'social_media_agent_chat_settings_extension','dashboard.admin.social-media.agent.chat.settings',NULL,'Social Media Agent Chat Settings',NULL,NULL,78,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(272,244,'content_manager_extension','content-manager::settings',NULL,'Content Manager Settings',NULL,NULL,77,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(273,244,'social_media_settings_extension','dashboard.admin.social-media.setting.index',NULL,'Social Media Platform Settings',NULL,NULL,78,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(274,244,'chatbot_instagram_settings_extension','dashboard.admin.chatbot-instagram.settings.index',NULL,'Instagram Chatbot Settings',NULL,NULL,78,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(275,244,'chatbot_voice_call_settings_extension','dashboard.admin.settings.voice-call',NULL,'Voice Call Settings',NULL,NULL,79,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(276,244,'phone_call_agent_settings_extension','dashboard.phone-call-agent.admin.settings',NULL,'Phone Call Agent Settings',NULL,NULL,80,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(277,NULL,'chat_settings_extension','default',NULL,'Chat Settings','tabler-message-circle',NULL,7,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(278,277,'chat_categories_extension','dashboard.user.chat-setting.chat-category.index',NULL,'Chat Categories',NULL,NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(279,277,'chat_template_extension','dashboard.user.chat-setting.chat-template.index',NULL,'Chat Templates',NULL,NULL,2,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(280,277,'chat_training_extension','dashboard.user.chat-setting.chatbot.index',NULL,'Chatbot Training','tabler-tags',NULL,3,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-13 15:19:09',0),(281,244,'cloudflare_r2_extension','dashboard.admin.settings.cloudflare-r2',NULL,'Cloudflare R2',NULL,NULL,1,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-13 15:19:08',0),(282,NULL,'photo_studio_extension','dashboard.user.photo-studio.index',NULL,'AI Photoshoot','tabler-device-laptop',NULL,8,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(283,NULL,'seo_tool_extension','dashboard.user.seo.index',NULL,'SEO Tool','tabler-seo',NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(284,NULL,'ai_web_chat_extension','dashboard.user.openai.webchat.workbook',NULL,'AI Web Chat','tabler-world-www',NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(285,214,'clipdrop_extension','dashboard.admin.settings.clipdrop',NULL,'Clipdrop',NULL,NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(286,244,'creative_suite_settings','dashboard.admin.creative-suite.settings',NULL,'Creative Suite Settings',NULL,NULL,70,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(287,214,'novita_extension','dashboard.admin.settings.novita',NULL,'Novita',NULL,NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(288,214,'freepik_extension','dashboard.admin.settings.freepik',NULL,'Freepik',NULL,NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(289,214,'x_ai','dashboard.admin.settings.x-ai',NULL,'X AI',NULL,NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(290,214,'xero_extension','dashboard.admin.settings.xero',NULL,'Xero API',NULL,NULL,10,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(291,244,'maintenance_setting','dashboard.admin.settings.maintenance.index',NULL,'Maintenance',NULL,NULL,2,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-13 15:19:08',0),(292,244,'checkout_registration_extension','dashboard.admin.checkout.registration.settings.index',NULL,'Checkout Registration',NULL,NULL,9,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(293,244,'ext_ai_photo_studio_settings','dashboard.admin.ai-photoshoot.settings',NULL,'AI Photoshoot Settings',NULL,NULL,78,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(294,244,'ext_fashion_studio_settings','dashboard.admin.fashion-studio.settings',NULL,'AI Fashion Studio Settings',NULL,NULL,79,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(295,244,'ext_ugc_factory_settings','dashboard.admin.ugc-factory.settings',NULL,'UGC Factory Settings',NULL,NULL,80,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(296,244,'ext_ugc_creator_settings','dashboard.admin.ugc-creator.settings',NULL,'UGC Creator Settings',NULL,NULL,81,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(297,244,'crm_admin_settings','dashboard.admin.crm.settings',NULL,'CRM Settings',NULL,NULL,79,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(298,244,'marketing_bot_admin_settings','dashboard.admin.marketing-bot.settings.index',NULL,'Marketing Bot Settings',NULL,NULL,79,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(299,244,'ext_ai_agent_settings','dashboard.admin.ai-agent.settings',NULL,'AI Agent Settings',NULL,NULL,80,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(300,244,'ext_ai_agent_gmail_settings','dashboard.admin.ai-agent.gmail.settings',NULL,'AI Agent - Gmail Settings',NULL,NULL,81,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0),(301,244,'ext_ai_agent_outlook_settings','dashboard.admin.ai-agent.outlook.settings',NULL,'AI Agent - Outlook Settings',NULL,NULL,82,1,'[]','item',NULL,'1',0,NULL,NULL,NULL,NULL,'2026-09-12 17:01:53','2026-09-12 17:01:53',0);
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=475 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_01_01_000001_convert_db_tables_engines_from_myisam_to_innodb',1),(2,'2014_10_12_000000_create_users_table',1),(3,'2014_10_12_100000_create_password_reset_tokens_table',1),(4,'2017_08_24_000000_create_app_settings_table',1),(5,'2018_08_08_100000_create_telescope_entries_table',1),(6,'2019_05_02_122941_create_plans_table',1),(7,'2019_05_03_000001_create_customer_columns',1),(8,'2019_05_03_000002_create_subscriptions_table',1),(9,'2019_05_03_000003_create_subscription_items_table',1),(10,'2019_08_19_000000_create_failed_jobs_table',1),(11,'2019_12_14_000001_create_personal_access_tokens_table',1),(12,'2023_03_01_113559_create_jobs_table',1),(13,'2023_03_01_113611_create_settings_table',1),(14,'2023_03_01_134013_create_user_orders_table',1),(15,'2023_03_01_134144_create_user_support_table',1),(16,'2023_03_01_134254_create_user_support_messages_table',1),(17,'2023_03_10_100433_create_openai_table',1),(18,'2023_03_14_073839_create_user_openai_table',1),(19,'2023_03_20_115202_add_user_id_to_user_orders_table',1),(20,'2023_03_20_134019_add_type_to_user_orders_table',1),(21,'2023_03_21_123416_add_additional_fields_to_user_support_table',1),(22,'2023_03_22_101116_add_paths_to_settings_table',1),(23,'2023_03_22_104952_add_openai_settings_to_settings_table',1),(24,'2023_03_30_000547_add_workbook_items_to_user_openai_table',1),(25,'2023_04_01_235507_add_custom_template_fields_to_openai_table',1),(26,'2023_04_12_223330_add_affiliate_to_users_table',1),(27,'2023_04_13_175439_create_user_affiliates_table',1),(28,'2023_04_13_175939_add_affiliate_to_settings_table',1),(29,'2023_04_13_180614_add_affiliate_to_user_orders_table',1),(30,'2023_04_24_115420_create_cache_table',1),(31,'2023_04_24_144953_create_activity_table',1),(32,'2023_04_28_110404_create_currencies_table',1),(33,'2023_05_01_205543_add_frontend_fields_to_settings_table',1),(34,'2023_05_03_103134_add_color_to_openai_table',1),(35,'2023_05_03_103903_add_additional_fields_to_activity_table',1),(36,'2023_05_03_105011_create_user_favorites_table',1),(37,'2023_05_04_190611_add_version_to_settings_table',1),(38,'2023_05_10_120704_create_openai_filters_table',1),(39,'2023_05_10_120716_add_filters_to_openai_table',1),(40,'2023_05_15_133018_create_openai_chat_category_table',1),(41,'2023_05_15_140015_create_user_openai_chat_table',1),(42,'2023_05_15_145853_create_user_openai_chat_messages_table',1),(43,'2023_05_24_134923_add_collapsed_logo_path_to_settings_table',1),(44,'2023_05_25_182410_add_email_confirmation_to_users_table',1),(45,'2023_05_26_134701_add_stripe_status_for_now_to_settings_table',1),(46,'2023_05_29_122817_create_faq_table',1),(47,'2023_05_29_130259_create_testimonials_table',1),(48,'2023_05_29_165555_create_frontend_tools_table',1),(49,'2023_05_30_110811_create_howitworks_table',1),(50,'2023_05_31_090418_create_customsettings_table',1),(51,'2023_05_31_151447_create_clients_table',1),(52,'2023_05_31_153647_add_new_logo_type_options',1),(53,'2023_06_01_124212_create_frontend_footer_settings_table',1),(54,'2023_06_01_140509_create_frontend_future_table',1),(55,'2023_06_01_145426_create_gateways_table',1),(56,'2023_06_02_124117_create_frontend_sections_statuses_titles_table',1),(57,'2023_06_02_124736_create_frontend_who_is_for_table',1),(58,'2023_06_02_124908_create_frontend_generators_table',1),(59,'2023_06_05_131107_add_settings_columns_to_settings_table',1),(60,'2023_06_06_094535_add_new_logo_options',1),(61,'2023_06_06_100350_add_paid_with_to_subscriptions',1),(62,'2023_06_06_133614_add_new_field_for_chat',1),(63,'2023_06_07_124125_create_gatewayproducts_table',1),(64,'2023_06_08_122900_add_hero_title_text_rotator_to_frontend_footer_settings_table',1),(65,'2023_06_09_091144_add_keywords_columns_to_settings_table',1),(66,'2023_06_09_102154_create_pages_table',1),(67,'2023_06_12_091546_add_gdpr_option_to_settings_table',1),(68,'2023_06_12_135232_add_menu_option_to_settings_table',1),(69,'2023_06_14_104251_add_token_field_to_users_table',1),(70,'2023_06_14_113746_add_google_refresh_token_to_users_table',1),(71,'2023_06_14_114054_add_trial_days_field_to_plans_table',1),(72,'2023_06_15_104503_create_oldgatewayproducts_table',1),(73,'2023_06_15_110436_add_privacy_and_terms_column_to_settings_table',1),(74,'2023_06_19_140133_add_login_without_confirmation_to_settings_table',1),(75,'2023_06_20_084825_add_old_product_id_to_oldgatewayproducts',1),(76,'2023_06_20_125836_add_header_buttons_to_frontend_footer_settings_table',1),(77,'2023_06_21_135415_add_additional_option_to_settings_table',1),(78,'2023_06_22_115805_add_customcode_to_settings_table',1),(79,'2023_06_22_124915_add_free_plan_to_settings_table',1),(80,'2023_06_22_133908_add_webhooks_to_gateways',1),(81,'2023_06_23_091003_create_email_templates_table',1),(82,'2023_06_23_141415_create_webhookhistory_table',1),(83,'2023_06_26_140101_create_bad_words_table',1),(84,'2023_07_01_080909_create_advertis_table',1),(85,'2023_07_03_082326_add_column_to_frontend_sections_statuses_titles_table',1),(86,'2023_07_07_103442_create_blogs_table',1),(87,'2023_07_08_205833_create_settings_two_table',1),(88,'2023_07_11_200235_add_license_type_to_settings_two',1),(89,'2023_07_11_200310_add_liquid_license_domain_key_to_settings_two',1),(90,'2023_07_13_133729_add_stream_server_option_to_settings_two_table',1),(91,'2023_07_13_143413_add_blog_options_to_frontend_sections_statuses_titles',1),(92,'2023_07_18_222043_add_image_storage_field_to_settings_two_table',1),(93,'2023_07_19_105519_add_package_column_to_openai_table',1),(94,'2023_07_21_121324_options_to_settingstwo_table',1),(95,'2023_07_24_103747_create_subscriptions_yokassa_table',1),(96,'2023_08_11_125732_create_paystack_payment_infos_table',1),(97,'2023_08_14_073857_add_storage_to_user_openai_table',1),(98,'2023_08_22_143604_add_iyzico_id_column_to_users',1),(99,'2023_08_30_162502_create_ads_table',1),(100,'2023_08_31_135312_change_facebook_token_type',1),(101,'2023_09_11_130128_change_github_and_google_token_type',1),(102,'2023_09_13_075321_add_stablediffusion_default_model_to_settings_two_table',1),(103,'2023_09_19_064148_create_article_wizard_table',1),(104,'2023_09_19_151726_create_coupons_table',1),(105,'2023_09_20_140329_add_feature_ai_article_wizard_to_settings_table',1),(106,'2023_09_20_174744_create_coupon_users_table',1),(107,'2023_09_26_134837_create_privacy_terms_table',1),(108,'2023_09_28_173820_add_hero_button_type_column_to_frontend_footer_settings',1),(109,'2023_09_29_075552_add_floating_button_to_frontend_footer_settings',1),(110,'2023_10_03_080002_add_unsplash_api_key_to_settings_two',1),(111,'2023_11_17_051523_add_dalle_setting_to_settings_two',1),(112,'2023_11_17_155039_create_folders_table',1),(113,'2023_11_17_155940_add_folder_id_to_user_openai',1),(114,'2023_11_27_052529_create_prompt_library_table',1),(115,'2023_11_28_130925_add_favorite_plan_to_openai_chat_category_table',1),(116,'2023_11_28_141010_create_chat_category_table',1),(117,'2023_11_28_160244_add_category_to_openai_chat_category_table',1),(118,'2023_11_29_060800_create_favourite_list_table',1),(119,'2023_11_29_122715_create_rate_limits_table',1),(120,'2023_11_30_084646_add_user_id_to_prompt_library',1),(121,'2023_12_07_093902_add_display_to_plans',1),(122,'2023_12_12_063333_add_feature_ai_vision_to_settings_table',1),(123,'2023_12_13_071818_add_allowed_images_count_to_settings_two',1),(124,'2023_12_13_124801_add_image_field_to_chat_messages',1),(125,'2023_12_14_075424_change_content_column_in_pages_table',1),(126,'2023_12_14_093837_create_pdf_data_table',1),(127,'2023_12_15_003956_update_users_change_avatar_length',1),(128,'2023_12_18_142047_add_pdf_info_to_chat_messages',1),(129,'2023_12_18_145013_add_ai_pdf_to_chat_to_settings_table',1),(130,'2023_12_19_085351_add_tax_to_gateways_table',1),(131,'2023_12_21_080109_add_type_column_to_rate_limits_table',1),(132,'2023_12_21_080333_add_allowed_voice_count_to_settings_two',1),(133,'2023_12_22_085010_add_bot_output_image',1),(134,'2023_12_25_212630_add_bank_details_to_gateways_table',1),(135,'2023_12_28_021338_add_new_fields_to_subscriptions_table',1),(136,'2023_12_28_040900_add_new_fields_to_user_orders_table',1),(137,'2023_12_28_143354_add_ai_chat_image_field_to_settings_table',1),(138,'2024_01_02_071044_add_auto_renewal_colmn_to_plans_table',1),(139,'2024_01_04_073526_add_mobile_payment_active_column_to_settings_table',1),(140,'2024_01_06_123827_add_revenuecat_id_column_to_users',1),(141,'2024_01_11_091958_create_table_revenuecatproducts',1),(142,'2024_01_15_152651_add_serperapi_colmn_to_settings_two_table',1),(143,'2024_01_16_053948_add_tts_settings_to_settings_two_table',1),(144,'2024_01_16_063552_add_realtime_colmn_to_user_openai_chat_messages_table',1),(145,'2024_01_17_072456_create_extensions_table',1),(146,'2024_01_17_075234_add_image_url_to_extensions',1),(147,'2024_01_18_001456_add_detail_to_extensions',1),(148,'2024_01_18_001457_add_licensed_to_extensions',1),(149,'2024_01_22_074920_add_prize_to_table',1),(150,'2024_01_22_134905_add_columns_to_subscriptions_yokassa_table',1),(151,'2024_01_23_052857_add_ai_rewriter_to_table',1),(152,'2024_01_23_143224_feature_ai_youtube_option',1),(153,'2024_01_24_105005_feature_ai_rss_option',1),(154,'2024_01_25_113135_fine_tune_list_data',1),(155,'2024_01_25_120049_update_helps_with_column_in_openai_chat_category_table',1),(156,'2024_01_26_110443_add_chatbot_table',1),(157,'2024_01_29_081000_chatbot_settings',1),(158,'2024_01_29_110158_add_apple_columns_to_user_table',1),(159,'2024_01_29_143656_create_teams_table',1),(160,'2024_01_29_143721_create_team_members_table',1),(161,'2024_01_29_150757_chatbot_message_data',1),(162,'2024_01_30_063632_add_team_id_to_users_table',1),(163,'2024_01_30_064148_add_is_team_plan_and_plan_allow_seat_to_plans_table',1),(164,'2024_01_30_081601_chatbot_chat_data',1),(165,'2024_01_30_084904_chatbot_history',1),(166,'2024_01_30_130737_add_team_function_add_settings_to_table',1),(167,'2024_01_30_134710_add_team_id_to_user_openai_table',1),(168,'2024_01_30_134807_add_team_id_to_user_openai_chat_table',1),(169,'2024_01_30_135358_add_team_id_to_user_folders_table',1),(170,'2024_02_01_130945_add_user_count_to_settings_table',1),(171,'2024_02_06_095920_create_payment_proofs_table',1),(172,'2024_02_06_172558_add_system_to_email_templates_table',1),(173,'2024_02_08_192853_create_custom_biling_plans_table',1),(174,'2024_02_09_064724_add_ai_advanced_editor_to_settings_table',1),(175,'2024_02_14_085457_add_razorpay_id_column_to_users_table',1),(176,'2024_02_14_124404_add_titlebar_status_to_pages_table',1),(177,'2024_02_15_085457_add_url_to_user_openai_chat',1),(178,'2024_02_15_100430_add_payload_to_gatewayproducts_table',1),(179,'2024_02_15_111859_add_coingate_subscriber_id_to_users_table',1),(180,'2024_02_15_132142_add_payload_to_user_orders_table',1),(181,'2024_02_16_163955_create_elevenlab_voices_table',1),(182,'2024_02_19_074856_add_payload_to_table_user_openai',1),(183,'2024_02_19_172005_add_voice_clone_settings_table',1),(184,'2024_02_19_175115_add_user_id_to_elevenlab_voices_table',1),(185,'2024_02_20_101928_add_open_ai_items_to_plans_table',1),(186,'2024_02_21_051626_add_free_open_ai_items_to_settings_table',1),(187,'2024_02_21_064451_update_apple_token_column_from_user_table',1),(188,'2024_02_21_100405_add_theme_column_to_settings_table',1),(189,'2024_02_21_163100_add_chatbot_interests_to_chatbot_table',1),(190,'2024_02_21_180426_add_status_to_chatbot_table',1),(191,'2024_02_22_065844_create_chatbot_data_table',1),(192,'2024_02_22_120600_create_chatbot_data_vectors_table',1),(193,'2024_02_22_150925_add_chatbot_id_to_openai_chat_category_table',1),(194,'2024_02_23_061429_add_chatbot_id_to_user_openai_chat_table',1),(195,'2024_02_23_111745_add_user_api_option_to_settings_table',1),(196,'2024_02_23_111834_add_api_keys_to_users_table',1),(197,'2024_02_26_013354_add_ai_video_to_settings_two',1),(198,'2024_02_26_184945_create_companies_table',1),(199,'2024_02_26_185155_create_products_table',1),(200,'2024_02_27_080913_add_reference_url_to_user_openai_chat',1),(201,'2024_02_27_120732_add_is_custom_column_to_pages_table',1),(202,'2024_02_27_134353_add_tone_of_voice_to_companies_table',1),(203,'2024_02_28_084232_add_target_audience_column_to_companies_table',1),(204,'2024_02_28_130323_add_user_id_to_chatbot_table',1),(205,'2024_02_29_074747_chatbot_timestamp',1),(206,'2024_03_04_070314_create_usage_table',1),(207,'2024_03_05_085748_add_version_to_extensions_table',1),(208,'2024_03_07_152339_create_intagrations_table',1),(209,'2024_03_08_082441_create_user_integrations_table',1),(210,'2024_03_08_112315_add_face_price_to_extensions_table',1),(211,'2024_03_12_143138_add_auth_view_options_column_to_settings_table',1),(212,'2024_03_14_061720_add_user_id_to_openai_filters_table',1),(213,'2024_03_14_062605_add_user_id_to_openai_table',1),(214,'2024_03_19_142411_add_instructions_to_openai_chat_category_table',1),(215,'2024_03_19_151400_add_first_message_to_openai_chat_category_table',1),(216,'2024_03_25_085453_add_theme_columns_to_extension_table',1),(217,'2024_03_28_002018_create_user_docs_favorite_table',1),(218,'2024_03_28_134851_add_to_token_to_users_table',1),(219,'2024_03_29_212039_delete_column_from_extensions_table',1),(220,'2024_04_02_063345_add_anthropic_api_keys_to_users_table',1),(221,'2024_04_06_014025_change_columns_in_privacy_terms_table',1),(222,'2024_04_09_191525_add_affiliate_status_to_users_table',1),(223,'2024_04_18_121537_add_defi_setting_to_users_table',1),(224,'2024_05_01_082729_add_gemini_api_keys_colmn_to_users_table',1),(225,'2024_05_01_111455_add_google2fa_secret_to_users_table',1),(226,'2024_05_03_094207_add_show_page_on_footer_to_pages_table',1),(227,'2024_05_08_163635_create_photo_studios_table',1),(228,'2024_05_15_100541_create_users_activity_table',1),(229,'2024_05_16_092520_create_menus_table',1),(230,'2024_05_21_091041_create_ai_models_table',1),(231,'2024_05_21_091043_create_tokens_table',1),(232,'2024_05_22_154814_change_integer_to_float_in_team_members',1),(233,'2024_05_22_154827_change_integer_to_float_in_users',1),(234,'2024_06_03_145735_create_gateway_taxes_table',1),(235,'2024_06_04_032206_add_country_tax_enabled_to_gateways_table',1),(236,'2024_06_07_064433_add_state_and_city_columns_to_users_table',1),(237,'2024_06_13_132553_create_social_media_accounts_table',1),(238,'2024_06_13_162318_add_hero_image_column_to_frontend_settings_table',1),(239,'2024_06_14_124938_add_plan_description_column_to_plans_table',1),(240,'2024_06_14_145824_create_account_deletion_reqs_table',1),(241,'2024_06_18_062706_add_tool_subtitle_to_frontend_sections_statuses_titles_table',1),(242,'2024_06_18_080246_add_some_fields_to_frontend_tools_table',1),(243,'2024_06_18_082526_add_some_fields_to_howitworks_table',1),(244,'2024_06_18_090439_add_icon_column_to_frontend_generators_table',1),(245,'2024_06_24_074201_add_footer_text_color_to_frontend_footer_settings_table',1),(246,'2024_06_24_141627_create_introductions_table',1),(247,'2024_06_25_112300_create_notifications_table',1),(248,'2024_06_25_131414_add_tour_seen_to_users_table',1),(249,'2024_06_26_074715_add_custom_menu_to_menus_table',1),(250,'2024_06_26_123911_add_tour_seen_to_settings_table',1),(251,'2024_06_27_135525_add_recaptcha_to_settings_table',1),(252,'2024_07_01_103008_add_otp_to_users_table',1),(253,'2024_07_01_103139_add_otp_to_settings_table',1),(254,'2024_07_04_120705_create_domains_table',1),(255,'2024_07_05_112203_add_synthesia_secret_key_to_settings_table',1),(256,'2024_07_05_122831_add_is_selected_to_ai_models_table',1),(257,'2024_07_09_045618_create_ai_chat_model_plans_table',1),(258,'2024_07_09_150801_add_dash_notify_seen_to_users_table',1),(259,'2024_07_18_121143_add_stablediffusion_bedrock_model_to_settings_two_table',1),(260,'2024_07_19_184746_add_cols_to_frontend_sections_statuses_titles_table',1),(261,'2024_07_19_212020_create_advanced_features_sectoion_table',1),(262,'2024_07_23_231136_create_comparison_section_items_table',1),(263,'2024_07_24_111812_create_features_marquees_table',1),(264,'2024_07_24_115747_create_footer_items_table',1),(265,'2024_07_25_081052_create_banner_bottom_texts_table',1),(266,'2024_07_25_084337_add_generator_text_to_frontend_sections_statuses_titles_table',1),(267,'2024_07_25_100909_add_plan_footer_text_to_frontend_sections_statuses_titles',1),(268,'2024_07_25_114952_add_advanced_features_title_to_frontend_sections_statuses_titles_table',1),(269,'2024_07_25_120715_add_description_to_howitworks_table',1),(270,'2024_07_25_131428_add_pebblely_key_to_settings_table',1),(271,'2024_07_29_121039_create_pebblely_table',1),(272,'2024_07_31_051243_add_plan_columns_to_plans_table',1),(273,'2024_08_06_050052_add_default_ai_model_to_plans_table',1),(274,'2024_08_06_115604_update_admin_to_super_admin_in_users_table',1),(275,'2024_08_09_103631_add_ai_models_to_plans_table',1),(276,'2024_08_12_050354_create_user_credits_table',1),(277,'2024_08_12_141902_add_assistant_to_openai_chat_category_table',1),(278,'2024_08_12_225618_add_thread_id_to_user_openai_chat_table',1),(279,'2024_08_13_095658_remove_is_free_column_in_plans_table',1),(280,'2024_08_14_050339_add_request_id_to_user_openai_table',1),(281,'2024_08_16_105255_rollback_permission_table',1),(282,'2024_09_02_120410_create_share_links_table',1),(283,'2024_09_12_185443_add_default_mrrobot_words_to_settings',1),(284,'2024_09_19_070942_add_bolt_menu_to_menus_table',1),(285,'2024_09_19_110114_create_engines_table',1),(286,'2024_09_19_211829_make_sure_to_remove_deprecated_entities_before_migration',1),(287,'2024_09_19_245426_add_entity_credits_to_users_table',1),(288,'2024_09_24_095546_update_ai_models_table',1),(289,'2024_09_24_213419_rename_ai_models_to_entities_table',1),(290,'2024_09_24_213999_remove_deprecated_stable_diff_models_from_db',1),(291,'2024_09_24_214000_update_plan_credits_temporary_migration',1),(292,'2024_09_24_220949_rename_ai_engine_column_in_entities_table',1),(293,'2024_09_24_221029_rename_ai_model_id_column_in_ai_chat_model_plans_table',1),(294,'2024_09_24_221030_make_ai_chat_model_plans_entity_id_foreign_key',1),(295,'2024_09_25_125009_update_sd_values_in_app_settings_table',1),(296,'2024_09_30_113752_rename_ai_model_id_column_in_token_table',1),(297,'2024_10_14_082619_add_aimlapi_key_to_settings_table',1),(298,'2024_10_17_124512_remove_free_plan_column_from_settings_table',1),(299,'2024_10_22_154324_remove_plan_total_words_and_images_columns',1),(300,'2024_10_25_095152_add_logo_to_settings_table',1),(301,'2024_11_04_100122_create_permission_tables',1),(302,'2024_11_04_101015_update_permission_table',1),(303,'2024_11_18_102726_change_amount_col_in_user_affiliates_table',1),(304,'2024_11_25_101434_create_health_check_result_history_items_table',1),(305,'2024_11_26_094758_add_heygen_secret_key_to_settings_table',1),(306,'2024_11_28_061918_add_automate_tax_to_gateways_table',1),(307,'2024_12_03_145649_add_status_to_introductions_table',1),(308,'2024_12_10_071444_add_user_api_to_plans_table',1),(309,'2024_12_10_080148_delete_menu_icon_one_time_migration',1),(310,'2024_12_16_074143_add_column_to_scheduled_posts_table',1),(311,'2024_12_16_080709_add_hidden_to_plans_table',1),(312,'2024_12_17_081626_add_index_to_user_openai',1),(313,'2024_12_17_113420_remove_deprecated_runway_models_from_db',1),(314,'2024_12_19_180117_change_prompt_column_to_user_fall_table',1),(315,'2024_12_20_104536_add_status_to_photo_studios_table',1),(316,'2025_01_02_123507_add_file_to_introductions_table',1),(317,'2025_01_08_132515_add_parent_id_to_introduction_table',1),(318,'2025_01_24_145331_add_reset_credits_on_renewal_column_to_plans_table',1),(319,'2025_02_26_082114_add_xai_api_keys_to_users_table',1),(320,'2025_03_04_215021_add_show_for_all_column_to_prompt_library_table',1),(321,'2025_03_10_221327_remove_cost_per_token_column_from_tokens_table',1),(322,'2025_03_13_140538_add_slug_column_to_email_templates_table',1),(323,'2025_03_13_140539_add_payment_mail_templates_to_email_templates_table',1),(324,'2025_03_17_111036_add_social_theme_frontend_setting_migration',1),(325,'2025_03_18_050755_create_channel_settings_table',1),(326,'2025_03_18_053123_create_content_boxes_table',1),(327,'2025_03_18_053809_create_curtains_table',1),(328,'2025_03_24_112325_add_is_pinned_to_user_openai_chat_table',1),(329,'2025_04_08_100750_create_user_usage_credits_table',1),(330,'2025_04_08_110336_add_openai_vector_and_file_id_columns_to_user_openai_chat',1),(331,'2025_04_10_113919_create_referers_table',1),(332,'2025_04_23_164215_create_dashboard_widgets_table',1),(333,'2025_04_25_094959_add_last_activity_at_to_users_table',1),(334,'2025_05_02_115019_fix_typo_in_dashboard_widgets',1),(335,'2025_05_02_120212_change_name_in_dashboard_widgets',1),(337,'2025_05_06_102938_2remove_gemini_deprected_models',1),(338,'2025_05_21_151911_add_engine_and_model_columns_to_user_openai_table',1),(339,'2025_05_21_154920_add_price_tax_included_colum_to_plans_table',1),(340,'2025_06_08_102625_create_exported_videos_table',1),(341,'2025_06_16_135944_add_plan_entity_credits_to_teams_table',1),(342,'2025_06_20_214812_add_2checkout_customer_reference_colmn_to_users_table',1),(343,'2025_06_25_062502_create_recent_search_keys_table',1),(344,'2025_06_26_050421_add_is_demo_to_user_openai_table',1),(345,'2025_07_10_110144_add_user_id_to_exported_videos',1),(346,'2025_07_11_082144_change_testimonials_words_colmn_type_to_text',1),(347,'2025_07_23_140424_add_specific_instructions_column_to_companies_table',1),(348,'2025_07_29_102938_remove_gemini_deprected_models2',1),(349,'2025_08_05_151726_add_is_offer_column_to_coupons_table',1),(350,'2025_08_13_102938_remove_openai_deprected_models',1),(351,'2025_08_13_160030_add_effort_col_to_entities_table',1),(352,'2025_08_18_125426_add_duration_column_to_coupons_table',1),(353,'2025_08_22_090439_add_access_type_column_to_openai_table',1),(354,'2025_08_27_094648_add_is_empty_colmn_to_user_openai_chat_table',1),(355,'2025_09_09_085800_add_support_multi_model_selection_colum_to_plans_table',1),(356,'2025_09_25_141701_add_index_to_user_openai_table',1),(357,'2025_09_26_131447_add_indexes_to_menus_table',1),(358,'2025_09_26_131720_add_indexes_to_teams_table',1),(359,'2025_09_26_132442_add_indexes_to_users_table',1),(360,'2025_10_02_000001_add_voice_call_seconds_limit_to_plans',1),(361,'2025_10_02_215339_make_name_and_surname_nullable_in_users_table',1),(362,'2025_10_06_113800_add_active_title_index_to_openai_table',1),(363,'2025_10_06_114224_add_user_status_index_to_subscriptions',1),(364,'2025_10_06_114954_add_user_team_index_to_user_openai_table',1),(365,'2025_10_06_141500_add_key_index_to_entities_table',1),(366,'2025_10_06_142343_add_key_index_to_engines_table',1),(367,'2025_10_13_212019_add_affiliate_status_column_to_plans_table',1),(368,'2025_10_28_144500_add_offer_id_to_coupons_table',1),(369,'2025_11_03_105055_move_frontend_additional_url_to_app_settings_table',1),(370,'2025_11_20_055013_add_chatbot_limit_to_plans_table',1),(371,'2025_12_16_085213_add_social_media_agent_limits_to_plans_table',1),(372,'2026_01_15_142724_add_chat_type_to_user_openai_chat_table',1),(373,'2026_01_15_145408_add_indexes_to_search_tables',1),(374,'2026_02_23_093522_add_badge_to_menus_table',1),(375,'2026_02_24_000003_add_model_council_support_to_plans_table',1),(376,'2026_02_24_104644_add_blogpilot_limits_to_plans_table',1),(377,'2026_02_27_053831_add_social_media_automation_limits_to_plans_table',1),(378,'2026_03_04_090723_add_image_to_entities_table',1),(379,'2026_03_11_110001_add_deep_research_request_limit_to_plans_table',1),(380,'2026_03_17_000003_add_video_dubbing_seconds_limit_to_plans',1),(381,'2026_03_26_005526_add_used_skills_to_user_openai_chat_messages_table',1),(382,'2026_03_30_130008_add_marketing_bot_limits_to_plans_table',1),(383,'2026_04_01_000001_add_shared_credit_columns',1),(384,'2026_04_01_000002_create_shared_credit_transactions_table',1),(385,'2026_04_01_000003_create_shared_credit_costs_table',1),(386,'2026_04_01_123529_add_daily_shared_credit_limit_to_team_members_table',1),(387,'2026_04_10_072705_drop_shared_credits_expires_at_from_users',1),(388,'2026_04_28_131234_add_ai_agent_limits_to_plans_table',1),(389,'2026_04_28_133202_add_ai_agent_memory_limit_to_plans_table',1),(390,'2026_05_08_100003_add_ugc_videos_limit_to_plans_table',1),(391,'2026_05_18_000002_add_ai_captions_columns_to_plans_table',1),(392,'2026_05_19_000005_add_phone_call_agent_seconds_limit_to_plans',1),(393,'2026_05_19_084654_add_language_to_elevenlab_voices_table',1),(394,'2026_05_19_100003_add_ugc_creator_videos_limit_to_plans_table',1),(395,'2026_05_22_113556_add_twilio_credentials_to_settings_two',1),(396,'2026_06_05_105707_backfill_image_for_new_claude_opus_entities',1),(397,'2026_06_11_000000_backfill_image_for_claude_fable_5_entity',1),(398,'2026_06_12_153306_drop_ip_column_from_users_activity_table',1),(399,'2026_06_25_115509_add_ai_chat_pro_connectors_to_plans',1),(400,'2026_07_10_000004_add_follow_up_enabled_to_plans_table',1),(401,'2026_07_10_000005_add_outbound_enabled_to_plans_table',1),(402,'2026_07_21_101216_add_is_human_agent_to_team_members_table',1),(403,'2026_07_28_000000_normalize_total_spend_setting',1),(404,'2026_07_29_000000_backfill_image_for_claude_opus_5_entity',1),(405,'2026_08_11_000000_backfill_image_for_new_gemini_and_grok_entities',1),(406,'2025_05_05_102938_remove_gemini_deprected_models',2),(407,'2025_01_23_053903_create_social_media_platforms_table',3),(408,'2025_01_23_081425_create_social_media_campaigns_table',3),(409,'2025_01_23_081426_create_social_media_posts_table',3),(410,'2025_02_20_000001_add_followers_count_to_ext_social_media_platforms_table',3),(411,'2025_02_26_103434_add_has_replicate_ext_social_media_posts_table',3),(412,'2025_02_26_103434_add_platform_ext_social_media_posts_table',3),(413,'2025_02_26_103434_add_post_id_to_ext_social_media_posts_table',3),(414,'2025_02_26_103434_add_status_to_ext_social_media_shared_logs_table',3),(415,'2025_02_26_103434_change_repeat_period_to_ext_social_media_posts_table',3),(416,'2025_06_17_073817_add_post_metrics_to_ext_social_media_posts_table',3),(417,'2025_11_04_055202_create_ext_social_media_agents_table',3),(418,'2025_11_04_055217_create_ext_social_media_agent_posts_table',3),(419,'2025_11_04_072035_add_image_request_id_to_agent_posts',3),(420,'2025_11_04_074928_add_post_metrics_to_ext_social_media_posts_table',3),(421,'2025_11_05_053609_add_post_generation_status_to_social_media_agents_table',3),(422,'2025_11_11_110129_create_ext_social_media_daily_metrics_table',3),(423,'2025_11_12_000001_create_ext_social_media_analyses_table',3),(424,'2025_11_12_000002_add_summary_to_ext_social_media_analyses_table',3),(425,'2025_11_20_000001_add_average_metrics_to_social_media_agents_table',3),(426,'2025_11_20_000002_add_agent_id_to_ext_social_media_post_daily_metrics_table',3),(427,'2025_11_25_000011_add_social_media_agent_post_id_to_ext_social_media_posts_table',3),(428,'2025_11_25_000011_add_social_media_analysis_id_to_user_openai_chat_table',3),(429,'2026_01_28_000001_add_video_fields_to_agent_posts',3),(430,'2026_02_05_072846_add_image_model_to_social_media_agent_posts',3),(431,'2026_02_09_000001_add_post_type_to_ext_social_media_posts_table',3),(432,'2026_02_10_000001_add_publishing_type_to_ext_social_media_agent_posts_table',3),(433,'2026_02_10_000002_add_publishing_type_to_ext_social_media_agents_table',3),(434,'2026_02_18_055740_add_images_to_ext_social_media_posts_table',3),(435,'2026_02_20_000001_create_ext_sm_automations_table',3),(436,'2026_02_20_000002_create_ext_sm_automation_actions_table',3),(437,'2026_02_20_000003_create_ext_sm_automation_replies_table',3),(438,'2026_02_20_000004_create_ext_sm_automation_logs_table',3),(439,'2026_03_23_000001_add_unique_index_to_ext_sm_automation_logs_table',3),(440,'2026_03_25_000001_create_ext_sm_pending_automations_table',3),(441,'2026_04_09_123205_add_workflow_graph_to_ext_sm_automations_table',3),(442,'2024_11_04_101015_automation_campaigns_table',4),(443,'2024_11_04_101015_automations_table',4),(444,'2024_11_04_101015_linkedin_tokens_table',4),(445,'2024_11_04_101015_scheduled_posts_table',4),(446,'2024_11_04_101015_twitter_settings_table',4),(447,'2024_11_04_101016_add_command_running_scheduled_posts_table',4),(448,'2024_11_04_101016_add_index_scheduled_posts_table',4),(449,'2024_12_10_101229_create_automation_platforms_table',4),(450,'2024_12_10_103351_platform_migration',4),(451,'2024_12_11_070409_add_automation_platform_id_to_scheduled_posts_table',4),(452,'2025_03_21_080755_add_new_ai_social_media_templates',5),(453,'2025_03_21_080756_add_auto_generate_to_scheduled_posts_table',6),(454,'2025_03_21_080756_change_content_to_scheduled_posts_table',6),(455,'2026_03_27_000001_create_ext_ai_agent_workflows_table',7),(456,'2026_03_27_000002_create_ext_ai_agent_workflow_runs_table',7),(457,'2026_03_27_000003_create_ext_ai_agent_channels_table',7),(458,'2026_03_27_000004_create_ext_ai_agent_memories_table',7),(459,'2026_03_27_000005_create_ext_ai_agent_messages_table',7),(460,'2026_04_09_000000_simplify_ext_ai_agent_memories_table',7),(461,'2026_04_16_000001_add_steps_to_ext_ai_agent_workflows',7),(462,'2026_04_16_000002_create_ext_ai_agent_workflow_copilot_messages',7),(463,'2026_04_17_000001_create_ext_ai_agent_knowledge_sources_table',7),(464,'2026_04_24_000001_create_ext_ai_agent_conversations_table',7),(465,'2026_04_24_000002_add_conversation_id_to_ext_ai_agent_messages',7),(466,'2026_04_28_070713_add_created_at_index_to_ext_ai_agent_workflow_runs_table',7),(467,'2026_05_11_125019_add_config_fields_to_ext_ai_agent_workflows',7),(468,'2026_05_11_140226_create_ext_ai_agent_avatars_table',7),(469,'2026_05_12_141714_add_copilot_model_to_ext_ai_agent_workflows_table',7),(470,'2026_05_20_000001_add_metadata_to_ext_ai_agent_workflow_copilot_messages',7),(471,'2026_05_26_000001_add_pinned_and_closed_at_to_ext_ai_agent_conversations',7),(472,'2026_06_04_084631_reset_ext_ai_agent_avatar_presets',7),(473,'2026_06_08_075837_add_workflow_id_to_ext_ai_agent_conversations',7),(474,'2026_06_19_000000_add_avatar_6_and_7_presets',7);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oldgatewayproducts`
--

DROP TABLE IF EXISTS `oldgatewayproducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oldgatewayproducts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `plan_id` int NOT NULL DEFAULT '0',
  `plan_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_price_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_price_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `old_product_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oldgatewayproducts`
--

LOCK TABLES `oldgatewayproducts` WRITE;
/*!40000 ALTER TABLE `oldgatewayproducts` DISABLE KEYS */;
/*!40000 ALTER TABLE `oldgatewayproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `openai`
--

DROP TABLE IF EXISTS `openai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `openai` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `questions` text COLLATE utf8mb4_unicode_ci,
  `image` text COLLATE utf8mb4_unicode_ci,
  `premium` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `prompt` text COLLATE utf8mb4_unicode_ci,
  `custom_template` tinyint(1) NOT NULL DEFAULT '0',
  `tone_of_voice` tinyint(1) NOT NULL DEFAULT '0',
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filters` text COLLATE utf8mb4_unicode_ci,
  `package` text COLLATE utf8mb4_unicode_ci,
  `access_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'regular',
  PRIMARY KEY (`id`),
  KEY `openai_access_type_index` (`access_type`),
  KEY `idx_openai_active_title` (`active`,`title`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `openai`
--

LOCK TABLES `openai` WRITE;
/*!40000 ALTER TABLE `openai` DISABLE KEYS */;
INSERT INTO `openai` VALUES (1,NULL,'Post Title Generator','Get captivating post titles instantly with our title generator. Boost engagement and save time.','post_title_generator',1,'[{\"name\":\"your_description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M430 896V356H200V256h560v100H530v540H430Z\"/></svg>',0,'text','2023-03-11 08:26:49','2023-03-11 08:26:49',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(2,NULL,'Summarize Text','Effortlessly condense large text into shorter summaries. Save time and increase productivity.','summarize_text',1,'[{\"name\":\"text_to_summary\",\"type\":\"textarea\",\"question\":\"Text to summary\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M120 816v-60h480v60H120Zm0-210v-60h720v60H120Zm0-210v-60h720v60H120Z\"/></svg>',0,'text','2023-03-11 10:25:43','2023-03-11 10:25:43',NULL,0,0,'#CCD9B8','blog',NULL,'regular'),(3,NULL,'Product Description','Easily create compelling product descriptions that sell. Increase conversions and boost sales.','product_description',1,'[{\"name\":\"product_name\",\"type\":\"text\",\"question\":\"Product Name\",\"select\":\"\"},{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Short Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M319 806h322v-60H319v60Zm0-170h322v-60H319v60Zm-99 340q-24 0-42-18t-18-42V236q0-24 18-42t42-18h361l219 219v521q0 24-18 42t-42 18H220Zm331-554h189L551 236v186Z\"/></svg>',0,'text','2023-03-11 10:30:40','2023-03-11 10:30:40',NULL,0,0,'#C2DEDD','ecommerce',NULL,'regular'),(4,NULL,'Article Generator','Instantly create unique articles on any topic. Boost engagement, improve SEO, and save time.','article_generator',1,'[{\"name\":\"article_title\",\"type\":\"text\",\"question\":\"Article Title\",\"select\":\"\"},{\"name\":\"focus_keywords\",\"type\":\"text\",\"question\":\"Focus Keywords (Seperate with Comma)\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M140 936q-24.75 0-42.375-17.625T80 876V216l67 67 66-67 67 67 67-67 66 67 67-67 67 67 66-67 67 67 67-67 66 67 67-67v660q0 24.75-17.625 42.375T820 936H140Zm0-60h310V596H140v280Zm370 0h310V766H510v110Zm0-170h310V596H510v110ZM140 536h680V416H140v120Z\"/></svg>',0,'text','2023-03-11 10:36:10','2023-03-11 10:36:10',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(5,NULL,'Product Name Generator','Create catchy product names with ease. Attract customers and boost sales effortlessly.','product_name',1,'[{\"name\":\"seed_words\",\"type\":\"text\",\"question\":\"Seed Words (Seperate With Comma)\",\"select\":\"\"},{\"name\":\"product_description\",\"type\":\"textarea\",\"question\":\"Product Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M290 896V356H80V256h520v100H390v540H290Zm360 0V556H520V456h360v100H750v340H650Z\"/></svg>',0,'text','2023-03-11 10:37:56','2023-03-11 10:37:56',NULL,0,0,'#C2DEDD','ecommerce',NULL,'regular'),(6,NULL,'Testimonial Review','Instantly generate authentic testimonials. Build trust and credibility with genuine reviews.','testimonial_review',1,'[{\"name\":\"subject\",\"type\":\"textarea\",\"question\":\"Subject\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"40\" viewBox=\"0 96 960 960\" width=\"40\"><path d=\"m233 976 65-281L80 506l288-25 112-265 112 265 288 25-218 189 65 281-247-149-247 149Z\"/></svg>',0,'text','2023-03-11 10:39:00','2023-03-11 10:39:00',NULL,0,0,'#A3A7D6','ecommerce',NULL,'regular'),(7,NULL,'Problem Agitate Solution','Identify and solve problems efficiently. Streamline solutions and increase productivity.','problem_agitate_solution',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"m772 421-43-100-104-46 104-45 43-95 43 95 104 45-104 46-43 100Zm0 595-43-96-104-45 104-45 43-101 43 101 104 45-104 45-43 96ZM333 862l-92-197-201-90 201-90 92-196 93 196 200 90-200 90-93 197Zm0-148 48-96 98-43-98-43-48-96-47 96-99 43 99 43 47 96Zm0-139Z\"/></svg>',0,'text','2023-03-11 10:39:56','2023-03-11 10:39:56',NULL,0,0,'#E0BFC9','development',NULL,'regular'),(8,NULL,'Blog Section','Effortlessly create blog sections with AI. Get unique, engaging content and save time.','blog_section',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M180 936q-24.75 0-42.375-17.625T120 876V276q0-24.75 17.625-42.375T180 216h600q24.75 0 42.375 17.625T840 276v600q0 24.75-17.625 42.375T780 936H180Zm0-60h600V356H180v520Zm100-310v-60h390v60H280Zm0 160v-60h230v60H280Z\"/></svg>',0,'text','2023-03-11 10:40:50','2023-03-11 10:40:50',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(9,NULL,'Blog Post Ideas','Unlock your creativity with unique blog post ideas. Generate endless inspiration and take your content to the next level.','blog_post_ideas',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M360 896q-134 0-227-93T40 576q0-134 93-227t227-93q134 0 227 93t93 227q0 134-93 227t-227 93Zm-.235-60Q468 836 544 760.235q76-75.764 76-184Q620 468 544.235 392q-75.764-76-184-76Q252 316 176 391.765q-76 75.764-76 184Q100 684 175.765 760q75.764 76 184 76ZM330 706h60V506h80v-40H250v40h80v200Zm454-298-42-94-94-42 94-42 42-94 42 94 94 42-94 42-42 94Zm0 608-42-94-94-42 94-42 42-94 42 94 94 42-94 42-42 94ZM360 576Z\"/></svg>',0,'text','2023-03-11 10:41:31','2023-03-11 10:41:31',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(10,NULL,'Blog Intros','Set the tone for your blog post with captivating intros. Grab readers\' attention and keep them engaged.','blog_intros',1,'[{\"name\":\"title\",\"type\":\"text\",\"question\":\"Title of blog text\",\"select\":\"\"},{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description of your need\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M80 976v-60h800v60H80Zm210-450V426h380v100H290Zm0 240V666h380v100H290Z\"/></svg>',0,'text','2023-03-14 11:43:57','2023-03-14 11:43:57',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(11,NULL,'Blog Conclusion','End your blog posts on a high note. Craft memorable conclusions that leave a lasting impact.','blog_conclusion',1,'[{\"name\":\"title\",\"type\":\"text\",\"question\":\"Title of the blog text\",\"select\":\"\"},{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M80 236v-60h800v60H80Zm210 250V386h380v100H290Zm0 240V626h380v100H290Z\"/></svg>',0,'text','2023-03-14 11:44:49','2023-03-14 11:44:49',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(12,NULL,'Facebook Ads','Create high-converting Facebook ads that grab attention. Drive sales and grow your business.','facebook_ads',1,'[{\"name\":\"title\",\"type\":\"text\",\"question\":\"Title\",\"select\":\"\"},{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg width=\"9\" height=\"16\" viewBox=\"0 0 9 16\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\n<path d=\"M5.66016 15.2383H2.88281V8.41797H0.5625V5.74609H2.88281V3.77734C2.88281 2.65234 3.19922 1.78516 3.83203 1.17578C4.46484 0.566406 5.30859 0.261719 6.36328 0.261719C7.20703 0.261719 7.89844 0.296875 8.4375 0.367188V2.72266L6.99609 2.75781C6.48047 2.75781 6.12891 2.86328 5.94141 3.07422C5.75391 3.28516 5.66016 3.60156 5.66016 4.02344V5.74609H8.33203L7.98047 8.41797H5.66016V15.2383Z\" fill=\"#23344D\"/>\n</svg>',0,'text','2023-03-14 11:46:23','2023-03-14 11:46:23',NULL,0,0,'#E8CEC3','advertisement',NULL,'regular'),(13,NULL,'Youtube Video Description','Elevate your YouTube content with compelling video descriptions. Generate engaging descriptions effortlessly and increase views.','youtube_video_description',1,'[{\"name\":\"title\",\"type\":\"text\",\"question\":\"Title\",\"select\":\"\"}]','<svg width=\"17\" height=\"11\" viewBox=\"0 0 17 11\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\n<path d=\"M15.8301 2.76172C15.9473 3.58203 16.0059 4.39062 16.0059 5.1875V6.3125L15.8301 8.73828C15.7363 9.41797 15.5371 9.91016 15.2324 10.2148C14.9043 10.543 14.4121 10.7539 13.7559 10.8477C13.123 10.8945 12.3613 10.9297 11.4707 10.9531C10.6035 10.9766 9.88867 10.9883 9.32617 10.9883H8.48242C5.88086 10.9648 4.18164 10.918 3.38477 10.8477C3.38477 10.8477 3.29102 10.8359 3.10352 10.8125C2.91602 10.7891 2.76367 10.7656 2.64648 10.7422C2.5293 10.7188 2.37695 10.6602 2.18945 10.5664C2.02539 10.4727 1.87305 10.3555 1.73242 10.2148C1.61523 10.0742 1.49805 9.88672 1.38086 9.65234C1.28711 9.39453 1.22852 9.17188 1.20508 8.98438L1.13477 8.73828C1.04102 7.91797 0.994141 7.10938 0.994141 6.3125V5.1875L1.13477 2.76172C1.22852 2.08203 1.42773 1.58984 1.73242 1.28516C2.06055 0.933594 2.56445 0.722656 3.24414 0.652344C3.87695 0.605469 4.62695 0.570313 5.49414 0.546875C6.36133 0.523437 7.07617 0.511719 7.63867 0.511719H8.48242C10.5918 0.511719 12.3496 0.558594 13.7559 0.652344C14.4121 0.722656 14.9043 0.933594 15.2324 1.28516C15.3262 1.37891 15.4082 1.49609 15.4785 1.63672C15.5488 1.75391 15.6074 1.88281 15.6543 2.02344C15.7012 2.14062 15.7363 2.25781 15.7598 2.375C15.7832 2.49219 15.8066 2.58594 15.8301 2.65625V2.76172ZM10.5215 5.85547L11.0137 5.60938L6.9707 3.5V7.71875L10.5215 5.85547Z\" fill=\"#23344D\"/>\n</svg>',0,'text','2023-03-14 11:47:17','2023-03-14 11:47:17',NULL,0,0,'#E4CD9F','social media',NULL,'regular'),(14,NULL,'Youtube Video Title','Get more views with attention-grabbing video titles. Create unique, catchy titles that entice viewers.','youtube_video_title',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg width=\"17\" height=\"11\" viewBox=\"0 0 17 11\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\n<path d=\"M15.8301 2.76172C15.9473 3.58203 16.0059 4.39062 16.0059 5.1875V6.3125L15.8301 8.73828C15.7363 9.41797 15.5371 9.91016 15.2324 10.2148C14.9043 10.543 14.4121 10.7539 13.7559 10.8477C13.123 10.8945 12.3613 10.9297 11.4707 10.9531C10.6035 10.9766 9.88867 10.9883 9.32617 10.9883H8.48242C5.88086 10.9648 4.18164 10.918 3.38477 10.8477C3.38477 10.8477 3.29102 10.8359 3.10352 10.8125C2.91602 10.7891 2.76367 10.7656 2.64648 10.7422C2.5293 10.7188 2.37695 10.6602 2.18945 10.5664C2.02539 10.4727 1.87305 10.3555 1.73242 10.2148C1.61523 10.0742 1.49805 9.88672 1.38086 9.65234C1.28711 9.39453 1.22852 9.17188 1.20508 8.98438L1.13477 8.73828C1.04102 7.91797 0.994141 7.10938 0.994141 6.3125V5.1875L1.13477 2.76172C1.22852 2.08203 1.42773 1.58984 1.73242 1.28516C2.06055 0.933594 2.56445 0.722656 3.24414 0.652344C3.87695 0.605469 4.62695 0.570313 5.49414 0.546875C6.36133 0.523437 7.07617 0.511719 7.63867 0.511719H8.48242C10.5918 0.511719 12.3496 0.558594 13.7559 0.652344C14.4121 0.722656 14.9043 0.933594 15.2324 1.28516C15.3262 1.37891 15.4082 1.49609 15.4785 1.63672C15.5488 1.75391 15.6074 1.88281 15.6543 2.02344C15.7012 2.14062 15.7363 2.25781 15.7598 2.375C15.7832 2.49219 15.8066 2.58594 15.8301 2.65625V2.76172ZM10.5215 5.85547L11.0137 5.60938L6.9707 3.5V7.71875L10.5215 5.85547Z\" fill=\"#23344D\"/>\n</svg>',0,'text','2023-03-14 11:49:10','2023-03-14 11:49:10',NULL,0,0,'#E4CD9F','social media',NULL,'regular'),(15,NULL,'Youtube Video Tag','Improve your YouTube video\'s discoverability with relevant video tags. Boost views and engagement.','youtube_video_tag',1,'[{\"name\":\"title\",\"type\":\"textarea\",\"question\":\"Title\",\"select\":\"\"}]','<svg width=\"17\" height=\"11\" viewBox=\"0 0 17 11\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\n<path d=\"M15.8301 2.76172C15.9473 3.58203 16.0059 4.39062 16.0059 5.1875V6.3125L15.8301 8.73828C15.7363 9.41797 15.5371 9.91016 15.2324 10.2148C14.9043 10.543 14.4121 10.7539 13.7559 10.8477C13.123 10.8945 12.3613 10.9297 11.4707 10.9531C10.6035 10.9766 9.88867 10.9883 9.32617 10.9883H8.48242C5.88086 10.9648 4.18164 10.918 3.38477 10.8477C3.38477 10.8477 3.29102 10.8359 3.10352 10.8125C2.91602 10.7891 2.76367 10.7656 2.64648 10.7422C2.5293 10.7188 2.37695 10.6602 2.18945 10.5664C2.02539 10.4727 1.87305 10.3555 1.73242 10.2148C1.61523 10.0742 1.49805 9.88672 1.38086 9.65234C1.28711 9.39453 1.22852 9.17188 1.20508 8.98438L1.13477 8.73828C1.04102 7.91797 0.994141 7.10938 0.994141 6.3125V5.1875L1.13477 2.76172C1.22852 2.08203 1.42773 1.58984 1.73242 1.28516C2.06055 0.933594 2.56445 0.722656 3.24414 0.652344C3.87695 0.605469 4.62695 0.570313 5.49414 0.546875C6.36133 0.523437 7.07617 0.511719 7.63867 0.511719H8.48242C10.5918 0.511719 12.3496 0.558594 13.7559 0.652344C14.4121 0.722656 14.9043 0.933594 15.2324 1.28516C15.3262 1.37891 15.4082 1.49609 15.4785 1.63672C15.5488 1.75391 15.6074 1.88281 15.6543 2.02344C15.7012 2.14062 15.7363 2.25781 15.7598 2.375C15.7832 2.49219 15.8066 2.58594 15.8301 2.65625V2.76172ZM10.5215 5.85547L11.0137 5.60938L6.9707 3.5V7.71875L10.5215 5.85547Z\" fill=\"#23344D\"/>\n</svg>',0,'text','2023-03-14 11:50:15','2023-03-14 11:50:15',NULL,0,0,'#E4CD9F','social media',NULL,'regular'),(16,NULL,'Instagram Captions','Elevate your Instagram game with captivating captions. Generate unique captions that engage followers and increase your reach.','instagram_captions',1,'[{\"name\":\"title\",\"type\":\"textarea\",\"question\":\"Title\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" data-name=\"Layer 1\" viewBox=\"0 0 24 24\" id=\"instagram\"><path d=\"M17.34,5.46h0a1.2,1.2,0,1,0,1.2,1.2A1.2,1.2,0,0,0,17.34,5.46Zm4.6,2.42a7.59,7.59,0,0,0-.46-2.43,4.94,4.94,0,0,0-1.16-1.77,4.7,4.7,0,0,0-1.77-1.15,7.3,7.3,0,0,0-2.43-.47C15.06,2,14.72,2,12,2s-3.06,0-4.12.06a7.3,7.3,0,0,0-2.43.47A4.78,4.78,0,0,0,3.68,3.68,4.7,4.7,0,0,0,2.53,5.45a7.3,7.3,0,0,0-.47,2.43C2,8.94,2,9.28,2,12s0,3.06.06,4.12a7.3,7.3,0,0,0,.47,2.43,4.7,4.7,0,0,0,1.15,1.77,4.78,4.78,0,0,0,1.77,1.15,7.3,7.3,0,0,0,2.43.47C8.94,22,9.28,22,12,22s3.06,0,4.12-.06a7.3,7.3,0,0,0,2.43-.47,4.7,4.7,0,0,0,1.77-1.15,4.85,4.85,0,0,0,1.16-1.77,7.59,7.59,0,0,0,.46-2.43c0-1.06.06-1.4.06-4.12S22,8.94,21.94,7.88ZM20.14,16a5.61,5.61,0,0,1-.34,1.86,3.06,3.06,0,0,1-.75,1.15,3.19,3.19,0,0,1-1.15.75,5.61,5.61,0,0,1-1.86.34c-1,.05-1.37.06-4,.06s-3,0-4-.06A5.73,5.73,0,0,1,6.1,19.8,3.27,3.27,0,0,1,5,19.05a3,3,0,0,1-.74-1.15A5.54,5.54,0,0,1,3.86,16c0-1-.06-1.37-.06-4s0-3,.06-4A5.54,5.54,0,0,1,4.21,6.1,3,3,0,0,1,5,5,3.14,3.14,0,0,1,6.1,4.2,5.73,5.73,0,0,1,8,3.86c1,0,1.37-.06,4-.06s3,0,4,.06a5.61,5.61,0,0,1,1.86.34A3.06,3.06,0,0,1,19.05,5,3.06,3.06,0,0,1,19.8,6.1,5.61,5.61,0,0,1,20.14,8c.05,1,.06,1.37.06,4S20.19,15,20.14,16ZM12,6.87A5.13,5.13,0,1,0,17.14,12,5.12,5.12,0,0,0,12,6.87Zm0,8.46A3.33,3.33,0,1,1,15.33,12,3.33,3.33,0,0,1,12,15.33Z\"></path></svg>',0,'text','2023-03-14 11:50:52','2023-03-14 11:50:52',NULL,0,0,'#E49FE1','social media',NULL,'regular'),(17,NULL,'Instagram Hashtags','Boost your Instagram reach with relevant hashtags. Generate optimal, trending hashtags and increase your visibility.','instagram_hashtag',1,'[{\"name\":\"keywords\",\"type\":\"textarea\",\"question\":\"Keywords (Separate with comma.)\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" data-name=\"Layer 1\" viewBox=\"0 0 24 24\" id=\"instagram\"><path d=\"M17.34,5.46h0a1.2,1.2,0,1,0,1.2,1.2A1.2,1.2,0,0,0,17.34,5.46Zm4.6,2.42a7.59,7.59,0,0,0-.46-2.43,4.94,4.94,0,0,0-1.16-1.77,4.7,4.7,0,0,0-1.77-1.15,7.3,7.3,0,0,0-2.43-.47C15.06,2,14.72,2,12,2s-3.06,0-4.12.06a7.3,7.3,0,0,0-2.43.47A4.78,4.78,0,0,0,3.68,3.68,4.7,4.7,0,0,0,2.53,5.45a7.3,7.3,0,0,0-.47,2.43C2,8.94,2,9.28,2,12s0,3.06.06,4.12a7.3,7.3,0,0,0,.47,2.43,4.7,4.7,0,0,0,1.15,1.77,4.78,4.78,0,0,0,1.77,1.15,7.3,7.3,0,0,0,2.43.47C8.94,22,9.28,22,12,22s3.06,0,4.12-.06a7.3,7.3,0,0,0,2.43-.47,4.7,4.7,0,0,0,1.77-1.15,4.85,4.85,0,0,0,1.16-1.77,7.59,7.59,0,0,0,.46-2.43c0-1.06.06-1.4.06-4.12S22,8.94,21.94,7.88ZM20.14,16a5.61,5.61,0,0,1-.34,1.86,3.06,3.06,0,0,1-.75,1.15,3.19,3.19,0,0,1-1.15.75,5.61,5.61,0,0,1-1.86.34c-1,.05-1.37.06-4,.06s-3,0-4-.06A5.73,5.73,0,0,1,6.1,19.8,3.27,3.27,0,0,1,5,19.05a3,3,0,0,1-.74-1.15A5.54,5.54,0,0,1,3.86,16c0-1-.06-1.37-.06-4s0-3,.06-4A5.54,5.54,0,0,1,4.21,6.1,3,3,0,0,1,5,5,3.14,3.14,0,0,1,6.1,4.2,5.73,5.73,0,0,1,8,3.86c1,0,1.37-.06,4-.06s3,0,4,.06a5.61,5.61,0,0,1,1.86.34A3.06,3.06,0,0,1,19.05,5,3.06,3.06,0,0,1,19.8,6.1,5.61,5.61,0,0,1,20.14,8c.05,1,.06,1.37.06,4S20.19,15,20.14,16ZM12,6.87A5.13,5.13,0,1,0,17.14,12,5.12,5.12,0,0,0,12,6.87Zm0,8.46A3.33,3.33,0,1,1,15.33,12,3.33,3.33,0,0,1,12,15.33Z\"></path></svg>',0,'text','2023-03-14 11:52:48','2023-03-14 11:52:48',NULL,0,0,'#E49FE1','social media',NULL,'regular'),(18,NULL,'Social Media Post Tweet','Make an impact with every tweet. Generate attention-grabbing social media posts and increase engagement.','social_media_post_tweet',1,'[{\"name\":\"title\",\"type\":\"textarea\",\"question\":\"Title\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" data-name=\"Layer 1\" viewBox=\"0 0 24 24\" id=\"twitter\"><path d=\"M22,5.8a8.49,8.49,0,0,1-2.36.64,4.13,4.13,0,0,0,1.81-2.27,8.21,8.21,0,0,1-2.61,1,4.1,4.1,0,0,0-7,3.74A11.64,11.64,0,0,1,3.39,4.62a4.16,4.16,0,0,0-.55,2.07A4.09,4.09,0,0,0,4.66,10.1,4.05,4.05,0,0,1,2.8,9.59v.05a4.1,4.1,0,0,0,3.3,4A3.93,3.93,0,0,1,5,13.81a4.9,4.9,0,0,1-.77-.07,4.11,4.11,0,0,0,3.83,2.84A8.22,8.22,0,0,1,3,18.34a7.93,7.93,0,0,1-1-.06,11.57,11.57,0,0,0,6.29,1.85A11.59,11.59,0,0,0,20,8.45c0-.17,0-.35,0-.53A8.43,8.43,0,0,0,22,5.8Z\"></path></svg>',0,'text','2023-03-14 11:55:37','2023-03-14 11:55:37',NULL,0,0,'#C2DEDE','social media',NULL,'regular'),(19,NULL,'Social Media Post Business','Generate a text for your business social media networks. Maximize your social media presence with impactful business posts.','social_media_post_business',1,'[{\"name\":\"company_name\",\"type\":\"text\",\"question\":\"Company Name\",\"select\":\"\"},{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Company Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M180 936q-24 0-42-18t-18-42V276q0-24 18-42t42-18h600q24 0 42 18t18 42v600q0 24-18 42t-42 18H180Zm100-160h200v-80H280v80Zm40-171 160-80 160 80V276H320v329Z\"/></svg>',0,'text','2023-03-14 12:04:56','2023-03-14 12:04:56',NULL,0,0,'#E3E49F','social media',NULL,'regular'),(20,NULL,'Facebook Headlines','Get noticed with attention-grabbing Facebook headlines. Generate unique, clickable headlines that increase engagement and drive traffic.','facebook_headlines',1,'[{\"name\":\"title\",\"type\":\"text\",\"question\":\"Title\",\"select\":\"\"},{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg width=\"9\" height=\"16\" viewBox=\"0 0 9 16\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\n<path d=\"M5.66016 15.2383H2.88281V8.41797H0.5625V5.74609H2.88281V3.77734C2.88281 2.65234 3.19922 1.78516 3.83203 1.17578C4.46484 0.566406 5.30859 0.261719 6.36328 0.261719C7.20703 0.261719 7.89844 0.296875 8.4375 0.367188V2.72266L6.99609 2.75781C6.48047 2.75781 6.12891 2.86328 5.94141 3.07422C5.75391 3.28516 5.66016 3.60156 5.66016 4.02344V5.74609H8.33203L7.98047 8.41797H5.66016V15.2383Z\" fill=\"#23344D\"/>\n</svg>',0,'text','2023-03-14 12:06:05','2023-03-14 12:06:05',NULL,0,0,'#E8CEC3','social media',NULL,'regular'),(21,NULL,'Google Ads Headlines','Create high-converting Google ads with captivating headlines. Generate unique, clickable ads that drive traffic and boost sales.','google_ads_headlines',1,'[{\"name\":\"product_name\",\"type\":\"text\",\"question\":\"Product Name\",\"select\":\"\"},{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"},{\"name\":\"audience\",\"type\":\"select\",\"question\":\"Audience\",\"select\":\"\\n        <option value=\'everyone\'> Everyone </option>\\n        <option value=\'man\'> Man </option>\\n        <option value=\'woman\'> Woman </option>\\n        <option value=\'children\'> Children </option>\\n        <option value=\'teenager\'> Teenager </option>\\n        \"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"32\" height=\"32\" enable-background=\"new 0 0 32 32\" viewBox=\"0 0 32 32\" id=\"adwords\"><path fill=\"#263238\" d=\"M2.066 23.314c-.082 0-.166-.021-.242-.063-.242-.135-.329-.438-.194-.681L9.278 8.803c.134-.24.439-.326.68-.194.242.135.329.438.194.681L2.503 23.058C2.412 23.222 2.242 23.314 2.066 23.314zM9.933 27.686c-.082 0-.166-.021-.242-.063-.242-.135-.329-.438-.194-.681l4.796-8.634c.133-.24.438-.326.68-.194.242.135.329.438.194.681l-4.796 8.634C10.279 27.593 10.109 27.686 9.933 27.686z\"></path><path fill=\"#263238\" d=\"M15.709,15.761L9.497,26.942c-0.705,1.27-2.046,2.059-3.5,2.059c-0.674,0-1.345-0.175-1.939-0.505 c-1.928-1.07-2.625-3.511-1.554-5.438l7.578-13.639c0.134-0.241,0.047-0.546-0.194-0.681c-0.24-0.133-0.545-0.046-0.68,0.194 L1.629,22.571c-1.339,2.41-0.468,5.46,1.942,6.8c0.742,0.412,1.58,0.63,2.424,0.63c1.817,0,3.493-0.985,4.375-2.572 l5.921-10.658L15.709,15.761z\"></path><path fill=\"#263238\" d=\"M6 30c-2.757 0-5-2.243-5-5s2.243-5 5-5 5 2.243 5 5S8.757 30 6 30zM6 21c-2.206 0-4 1.794-4 4s1.794 4 4 4 4-1.794 4-4S8.206 21 6 21zM26.004 30.001c-1.817 0-3.493-.985-4.375-2.572l-10-18c-1.339-2.41-.468-5.46 1.942-6.8.742-.412 1.581-.631 2.425-.631 1.816 0 3.492.986 4.374 2.573l10 18c1.339 2.41.468 5.46-1.942 6.8C27.687 29.783 26.848 30.001 26.004 30.001zM15.997 2.998c-.675 0-1.345.175-1.94.506-1.928 1.07-2.625 3.511-1.554 5.438l10 18c.705 1.27 2.046 2.059 3.5 2.059.674 0 1.345-.175 1.939-.505 1.928-1.07 2.625-3.511 1.554-5.438l-10-18C18.792 3.787 17.451 2.998 15.997 2.998z\"></path></svg>',0,'text','2023-03-14 12:10:42','2023-03-14 12:10:42',NULL,0,0,'#D6C0A3','advertisement',NULL,'regular'),(22,NULL,'Google Ads Description','Step up your Google ad game, Craft high-converting ad copy that grabs attention and drives sales.','google_ads_description',1,'[{\"name\":\"product_name\",\"type\":\"text\",\"question\":\"Product Name\",\"select\":\"\"},{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"},{\"name\":\"audience\",\"type\":\"select\",\"question\":\"Audience\",\"select\":\"\\n        <option value=\'everyone\'> Everyone </option>\\n        <option value=\'man\'> Man </option>\\n        <option value=\'woman\'> Woman </option>\\n        <option value=\'children\'> Children </option>\\n        <option value=\'teenager\'> Teenager </option>\\n        \"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"32\" height=\"32\" enable-background=\"new 0 0 32 32\" viewBox=\"0 0 32 32\" id=\"adwords\"><path fill=\"#263238\" d=\"M2.066 23.314c-.082 0-.166-.021-.242-.063-.242-.135-.329-.438-.194-.681L9.278 8.803c.134-.24.439-.326.68-.194.242.135.329.438.194.681L2.503 23.058C2.412 23.222 2.242 23.314 2.066 23.314zM9.933 27.686c-.082 0-.166-.021-.242-.063-.242-.135-.329-.438-.194-.681l4.796-8.634c.133-.24.438-.326.68-.194.242.135.329.438.194.681l-4.796 8.634C10.279 27.593 10.109 27.686 9.933 27.686z\"></path><path fill=\"#263238\" d=\"M15.709,15.761L9.497,26.942c-0.705,1.27-2.046,2.059-3.5,2.059c-0.674,0-1.345-0.175-1.939-0.505 c-1.928-1.07-2.625-3.511-1.554-5.438l7.578-13.639c0.134-0.241,0.047-0.546-0.194-0.681c-0.24-0.133-0.545-0.046-0.68,0.194 L1.629,22.571c-1.339,2.41-0.468,5.46,1.942,6.8c0.742,0.412,1.58,0.63,2.424,0.63c1.817,0,3.493-0.985,4.375-2.572 l5.921-10.658L15.709,15.761z\"></path><path fill=\"#263238\" d=\"M6 30c-2.757 0-5-2.243-5-5s2.243-5 5-5 5 2.243 5 5S8.757 30 6 30zM6 21c-2.206 0-4 1.794-4 4s1.794 4 4 4 4-1.794 4-4S8.206 21 6 21zM26.004 30.001c-1.817 0-3.493-.985-4.375-2.572l-10-18c-1.339-2.41-.468-5.46 1.942-6.8.742-.412 1.581-.631 2.425-.631 1.816 0 3.492.986 4.374 2.573l10 18c1.339 2.41.468 5.46-1.942 6.8C27.687 29.783 26.848 30.001 26.004 30.001zM15.997 2.998c-.675 0-1.345.175-1.94.506-1.928 1.07-2.625 3.511-1.554 5.438l10 18c.705 1.27 2.046 2.059 3.5 2.059.674 0 1.345-.175 1.939-.505 1.928-1.07 2.625-3.511 1.554-5.438l-10-18C18.792 3.787 17.451 2.998 15.997 2.998z\"></path></svg>',0,'text','2023-03-14 12:11:58','2023-03-14 12:11:58',NULL,0,0,'#D6C0A3','advertisement',NULL,'regular'),(23,NULL,'Paragraph Generator','Generate a paragraph with keywords and description. Never struggle with writer\'s block again. Generate flawless paragraphs that captivate readers.','paragraph_generator',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"},{\"name\":\"keywords\",\"type\":\"textarea\",\"question\":\"Keywords (Separate with comma.)\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M160 684v-60h640v60H160Zm0 160v-60h640v60H160Zm0-316v-60h640v60H160Zm0-160v-60h640v60H160Z\"/></svg>',0,'text','2023-03-14 12:17:21','2023-03-14 12:17:21',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(24,NULL,'Pros & Cons','Make informed decisions with ease. Generate unbiased pros and cons lists that help you weigh options and make better choices.','pros_cons',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"},{\"name\":\"title\",\"type\":\"text\",\"question\":\"Title\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M443 936q-17 0-32-6.5T385 912L203 719l32-33q11-11 25-13.5t29 .5l114 25V276q0-26 17-43t43-17q26 0 43 17t17 43v240h36q11 0 19 1.5t17 6.5l163 82q24 12 36 35t8 49l-26 180q-5 29-28 47.5T696 936H443Zm-26-60h281l43-249-183-91h-55V316q0-18-11-29t-29-11q-18 0-29 11t-11 29v399l-154-33-23 23 171 171Zm0 0L246 705l23-23 154 33V316q0-18 11-29t29-11q18 0 29 11t11 29v220h55l183 91-43 249H417Z\"/></svg>',0,'text','2023-03-14 12:21:00','2023-03-14 12:21:00',NULL,0,0,'#E0BFC9','development',NULL,'regular'),(25,NULL,'Meta Description','Get more clicks with compelling meta descriptions. Generate unique, SEO-friendly meta descriptions that attract customers and boost traffic.','meta_description',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"},{\"name\":\"title\",\"type\":\"text\",\"question\":\"Title\",\"select\":\"\"},{\"name\":\"keywords\",\"type\":\"text\",\"question\":\"Keywords (Separate with comma)\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M319 806h322v-60H319v60Zm0-170h322v-60H319v60Zm-99 340q-24 0-42-18t-18-42V236q0-24 18-42t42-18h361l219 219v521q0 24-18 42t-42 18H220Zm331-554V236H220v680h520V422H551ZM220 236v186-186 680-680Z\"/></svg>',0,'text','2023-03-14 13:17:43','2023-03-14 13:17:43',NULL,0,0,'#A3D6C2','development',NULL,'regular'),(26,NULL,'FAQ Generator (All Datas)','Quickly create helpful FAQs. Our AI-powered generator provides custom responses to common questions in seconds.','faq_generator',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"},{\"name\":\"title\",\"type\":\"text\",\"question\":\"Title (Faq Question)\",\"select\":\"\"}]','<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\n<path d=\"M8.62695 5.87109C8.04102 6.45703 7.32617 6.75 6.48242 6.75C5.66211 6.75 4.95898 6.45703 4.37305 5.87109C3.78711 5.28516 3.49414 4.58203 3.49414 3.76172C3.49414 2.91797 3.78711 2.20313 4.37305 1.61719C4.95898 1.03125 5.66211 0.738281 6.48242 0.738281C7.32617 0.738281 8.04102 1.03125 8.62695 1.61719C9.21289 2.20313 9.50586 2.91797 9.50586 3.76172C9.50586 4.58203 9.21289 5.28516 8.62695 5.87109ZM4.05664 8.57812C4.94727 8.36719 5.75586 8.26172 6.48242 8.26172C7.23242 8.26172 8.05273 8.36719 8.94336 8.57812C9.83398 8.78906 10.6426 9.14062 11.3691 9.63281C12.1191 10.1016 12.4941 10.6406 12.4941 11.25V12.7617H0.505859V11.25C0.505859 10.6406 0.869141 10.1016 1.5957 9.63281C2.3457 9.14062 3.16602 8.78906 4.05664 8.57812Z\" fill=\"#23344D\"/>\n</svg>',0,'text','2023-03-14 13:19:40','2023-03-14 13:19:40',NULL,0,0,'#D6D2A3','development',NULL,'regular'),(27,NULL,'Email Generator','Generate an email with your subject and description. Streamline your inbox and save time.','email_generator',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"},{\"name\":\"subject\",\"type\":\"text\",\"question\":\"Subject of Email\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M140 896q-24 0-42-18t-18-42V316q0-24 18-42t42-18h680q24 0 42 18t18 42v520q0 24-18 42t-42 18H140Zm340-302 340-223v-55L480 534 140 316v55l340 223Z\"/></svg>',0,'text','2023-03-14 13:22:21','2023-03-14 13:22:21',NULL,0,0,'#D1C5DE','email',NULL,'regular'),(28,NULL,'Email Answer Generator','Effortlessly tackle your overflowing inbox with custom, accurate responses to common queries, freeing you up to focus on what matters most.','email_answer_generator',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description (Receieved Email)\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M140 896q-24 0-42-18t-18-42V316q0-24 18-42t42-18h680q24 0 42 18t18 42v520q0 24-18 42t-42 18H140Zm340-302 340-223v-55L480 534 140 316v55l340 223Z\"/></svg>',0,'text','2023-03-14 13:24:20','2023-03-14 13:24:20',NULL,0,0,'#D1C5DE','email',NULL,'regular'),(29,NULL,'Newsletter Generator','Generate engaging newsletters easily with personalized content that resonates with your audience, driving growth and engagement.','newsletter_generator',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"},{\"name\":\"title\",\"type\":\"text\",\"question\":\"Title\",\"select\":\"\"},{\"name\":\"subject\",\"type\":\"text\",\"question\":\"Subject\",\"select\":\"\"}]','<svg width=\"17\" height=\"14\" viewBox=\"0 0 17 14\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\n<path d=\"M0.625 13.5V8.26172L11.875 6.75L0.625 5.23828V0L16.375 6.75L0.625 13.5Z\" fill=\"#23344D\"/>\n</svg>',0,'text','2023-03-14 13:26:49','2023-03-14 13:26:49',NULL,0,0,'#E1D5F4','email',NULL,'regular'),(30,NULL,'Grammar Correction','Eliminate grammar errors and enhance your writing with ease. Our tool offers seamless grammar correction for flawless content.','grammar_correction',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg width=\"17\" height=\"18\" viewBox=\"0 0 17 18\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\n<path d=\"M4.75586 8.01172V9.48828H0.255859V8.01172H4.75586ZM6.37305 5.58594L5.31836 6.64062L3.73633 5.02344L4.79102 3.96875L6.37305 5.58594ZM9.25586 0.488281V4.98828H7.74414V0.488281H9.25586ZM13.2637 5.02344L11.6816 6.64062L10.627 5.58594L12.209 3.96875L13.2637 5.02344ZM12.2441 8.01172H16.7441V9.48828H12.2441V8.01172ZM6.90039 7.16797C7.3457 6.72266 7.87305 6.5 8.48242 6.5C9.11523 6.5 9.6543 6.72266 10.0996 7.16797C10.5449 7.58984 10.7676 8.11719 10.7676 8.75C10.7676 9.38281 10.5449 9.92188 10.0996 10.3672C9.6543 10.7891 9.11523 11 8.48242 11C7.87305 11 7.3457 10.7891 6.90039 10.3672C6.47852 9.92188 6.26758 9.38281 6.26758 8.75C6.26758 8.11719 6.47852 7.58984 6.90039 7.16797ZM10.627 11.9141L11.6816 10.8594L13.2637 12.4766L12.209 13.5312L10.627 11.9141ZM3.73633 12.4766L5.31836 10.8594L6.37305 11.9141L4.79102 13.5312L3.73633 12.4766ZM7.74414 17.0117V12.5117H9.25586V17.0117H7.74414Z\" fill=\"#23344D\"/>\n</svg>',0,'text','2023-03-14 13:29:15','2023-03-14 13:29:15',NULL,0,0,'#D6C0A3','blog',NULL,'regular'),(31,NULL,'TL;DR Summarization','Automatically summarize long texts into bite-sized summaries with this TL;DR generator.','tldr_summarization',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M160 666v-60h389v60H160Zm0-120v-60h640v60H160Z\"/></svg>',0,'text','2023-03-14 13:30:44','2023-03-14 13:30:44',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(32,NULL,'AI Image Generator','Create stunning images in seconds.','ai_image_generator',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Describe the Image\",\"select\":\"\"},{\"name\":\"size\",\"type\":\"select\",\"question\":\"Image Resolution\",\"select\":\"<option value=\'256x256\'>256x256</option><option value=\'512x512\'>512x512</option><option value=\'1024x1024\'>1024x1024</option>\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M180 936q-24 0-42-18t-18-42V276q0-24 18-42t42-18h600q24 0 42 18t18 42v600q0 24-18 42t-42 18H180Zm56-157h489L578 583 446 754l-93-127-117 152Z\"/></svg>',0,'image','2023-03-20 13:22:02','2023-03-20 13:22:02',NULL,0,0,'#D1C5DE','development',NULL,'regular'),(33,NULL,'Custom Generation','Create your own custom generator with AI! Our app allows you to quickly and easily generate unique content in any language.','custom-generation-eQao5n',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Description\",\"description\":\"Description for prompt\"},{\"name\":\"description-second\",\"type\":\"textarea\",\"question\":\"Description Second\",\"description\":\"Description Second for prompt\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"40\" viewBox=\"0 96 960 960\" width=\"40\"><path d=\"M424 962.333V705h93.666v83H860v93.666H517.666v80.667H424ZM99.667 881.666V788H372v93.666H99.667Zm178.667-178.333V622H99.667v-92.666h178.667v-82H372v255.999h-93.666ZM424 622v-92.666h436V622H424Zm163.667-175.667V189h93.666v81.334H860V364H681.333v82.333h-93.666ZM99.667 364v-93.666h436V364h-436Z\"/></svg>',0,'text','2023-04-04 21:49:28','2023-05-12 14:49:22','write a text about   **description**  and  **description-second**',1,0,'#F4E8A4','Custom',NULL,'regular'),(34,NULL,'AI Speech to Text','The AI app that turns audio speech into text with ease.','ai_speech_to_text',1,'[{\"name\":\"file\",\"type\":\"file\",\"question\":\"Upload an Audio File (mp3, mp4, mpeg, mpga, m4a, wav, and webm)(Max: 25Mb)\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M140 976q-24.75 0-42.375-17.625T80 916V236q0-24.75 17.625-42.375T140 176h380l-60 60H140v680h480V776h60v140q0 24.75-17.625 42.375T620 976H140Zm100-170v-60h280v60H240Zm0-120v-60h200v60H240Zm380 10L460 536H320V336h140l160-160v520Zm60-92V258q56 21 88 74t32 104q0 51-35 101t-85 67Zm0 142v-62q70-25 125-90t55-158q0-93-55-158t-125-90v-62q102 27 171 112.5T920 436q0 112-69 197.5T680 746Z\"/></svg>',0,'audio','2023-04-08 19:30:04','2023-05-09 15:38:40',NULL,0,0,'#DEFF81','blog',NULL,'regular'),(35,NULL,'AI Code Generator','Create custom code in seconds! Leverage our state-of-the-art AI technology to quickly and easily generate code in any language.','ai_code_generator',1,'[{\"name\":\"description\",\"type\":\"textarea\",\"question\":\"Describe What Kind of Code You Need\",\"select\":\"\"},{\"name\":\"code_language\",\"type\":\"text\",\"question\":\"Coding Language (Java, PHP etc.)\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"40\" viewBox=\"0 96 960 960\" width=\"40\"><path d=\"M196.666 965.333q-43.824 0-74.912-31.087-31.087-31.088-31.087-74.912V701.667h105.999v157.667h157.667v105.999H196.666Zm409.001 0V859.334h157.667V701.667H870v157.667q0 43.824-31.284 74.912-31.283 31.087-75.382 31.087H605.667ZM344 739.333 180.667 576 344 412.667 418.333 489l-86 87 86 87L344 739.333Zm272 0L541.667 663l86-87-86-87L616 412.667 779.333 576 616 739.333Zm-525.333-289V292.666q0-44.099 31.087-75.382Q152.842 186 196.666 186h157.667v106.666H196.666v157.667H90.667Zm672.667 0V292.666H605.667V186h157.667q44.099 0 75.382 31.284Q870 248.567 870 292.666v157.667H763.334Z\"/></svg>',0,'code','2023-04-12 19:58:19','2023-05-06 21:43:02',NULL,0,0,'#81FFC2','development',NULL,'regular'),(36,NULL,'AI Article Wizard Generator','Create custom article instantly with our article wizard generator. Boost engagement and save time.','ai_article_wizard_generator',1,'[{\"name\":\"your_description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M430 896V356H200V256h560v100H530v540H430Z\"/></svg>',0,'text','2023-09-20 08:26:49','2023-09-20 08:26:49',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(37,NULL,'AI Vision','Elevate your visual analytics with our AI Vision platform. Harness the power of machine learning for real-time image recognition and data insights. Enhance efficiency and decision-making.','ai_vision',1,'[{\"name\":\"your_description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" \n width=\"48\" height=\"48\" stroke-width=\"2\" stroke=\"black\" fill=\"none\" viewBox=\"0 0 24 24\"><path stroke=\"none\" d=\"M0 0h24v24H0z\" fill=\"none\"/><path d=\"M6 4l6 16l6 -16\" /></svg>',0,'text','2023-09-20 08:26:49','2023-09-20 08:26:49',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(38,NULL,'File Analyzer','Simply upload a file (PDF, CSV, .doc or .docx) and extract key insights or summarize the entire document.','ai_pdf',1,'[{\"name\":\"your_description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" \n width=\"48\" height=\"48\" stroke-width=\"2\" stroke=\"black\" fill=\"none\" viewBox=\"0 0 24 24\"><path stroke=\"none\" d=\"M0 0h24v24H0z\" fill=\"none\"/><path d=\"M6 4l6 16l6 -16\" /></svg>',0,'text','2023-09-20 08:26:49','2023-09-20 08:26:49',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(39,NULL,'Chat Image','Generate Image by user input','ai_chat_image',1,'[{\"name\":\"your_description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" \n width=\"48\" height=\"48\" stroke-width=\"2\" stroke=\"black\" fill=\"none\" viewBox=\"0 0 24 24\"><path stroke=\"none\" d=\"M0 0h24v24H0z\" fill=\"none\"/><path d=\"M6 4l6 16l6 -16\" /></svg>',0,'text','2023-09-20 08:26:49','2023-09-20 08:26:49',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(40,NULL,'AI ReWriter','Rewrite more professional and detailed content instantly with our ai rewriter. Boost engagement and save time.','ai_rewriter',1,'[{\"name\":\"your_description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M430 896V356H200V256h560v100H530v540H430Z\"/></svg>',0,'text','2023-09-20 08:26:49','2023-09-20 08:26:49',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(41,NULL,'AI Web Chat','Analyze web page content with url','ai_webchat',1,'[{\"name\":\"your_description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" \n width=\"48\" height=\"48\" stroke-width=\"2\" stroke=\"black\" fill=\"none\" viewBox=\"0 0 24 24\"><path stroke=\"none\" d=\"M0 0h24v24H0z\" fill=\"none\"/><path d=\"M6 4l6 16l6 -16\" /></svg>',0,'text','2023-09-20 08:26:49','2023-09-20 08:26:49',NULL,0,0,'#A3D6C2','blog',NULL,'regular'),(42,NULL,'AI Video','Bring your static images to life and create visually compelling videos effortlessly.','ai_video',1,'[{\"name\":\"your_description\",\"type\":\"textarea\",\"question\":\"Description\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" \n width=\"48\" height=\"48\" stroke-width=\"2\" stroke=\"black\" fill=\"none\" viewBox=\"0 0 24 24\"><path stroke=\"none\" d=\"M0 0h24v24H0z\" fill=\"none\"/><path d=\"M6 4l6 16l6 -16\" /></svg>',0,'video','2023-09-20 08:26:49','2023-09-20 08:26:49',NULL,0,0,'#A3D6C2','video',NULL,'regular'),(43,NULL,'AI Voiceover','The AI app that turns text into audio speech with ease. Get ready to generate custom audios from texts quickly and accurately.','ai_voiceover',1,'[{\"name\":\"file\",\"type\":\"file\",\"question\":\"Upload an Audio File (mp3, mp4, mpeg, mpga, m4a, wav, and webm)(Max: 25Mb)\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M140 976q-24.75 0-42.375-17.625T80 916V236q0-24.75 17.625-42.375T140 176h380l-60 60H140v680h480V776h60v140q0 24.75-17.625 42.375T620 976H140Zm100-170v-60h280v60H240Zm0-120v-60h200v60H240Zm380 10L460 536H320V336h140l160-160v520Zm60-92V258q56 21 88 74t32 104q0 51-35 101t-85 67Zm0 142v-62q70-25 125-90t55-158q0-93-55-158t-125-90v-62q102 27 171 112.5T920 436q0 112-69 197.5T680 746Z\"/></svg>',0,'voiceover','2024-03-01 11:35:52','2024-03-01 11:35:52','',0,0,'#DEFF81','voiceover',NULL,'regular'),(44,NULL,'AI YouTube','Simply turn your Youtube videos into Blog post.','ai_youtube',1,'[{\"name\":\"url\",\"type\":\"url\",\"question\":\"YouTube Video URL\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"44\" height=\"44\" viewBox=\"0 0 24 24\" stroke-width=\"1.5\" stroke=\"#2c3e50\" fill=\"none\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path stroke=\"none\" d=\"M0 0h24v24H0z\" fill=\"none\"/><path d=\"M2 8a4 4 0 0 1 4 -4h12a4 4 0 0 1 4 4v8a4 4 0 0 1 -4 4h-12a4 4 0 0 1 -4 -4v-8z\" /><path d=\"M10 9l5 3l-5 3z\" /></svg>',0,'youtube','2024-03-01 11:59:52','2024-03-01 11:59:52','',0,0,'#FFB0B0','youtube',NULL,'regular'),(45,NULL,'AI RSS','Generate unique content with RSS Feed.','ai_rss',1,'[{\"name\":\"rss_feed\",\"type\":\"rss_feed\",\"question\":\"URL\",\"select\":\"\"},{\"name\":\"title\",\"type\":\"select\",\"question\":\"Fetched Post Title\",\"select\":\"<option value=\\\"\\\">Enter the Feed URL, please!</option>\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"44\" height=\"44\" viewBox=\"0 0 24 24\" stroke-width=\"1.5\" stroke=\"#2c3e50\" fill=\"none\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path stroke=\"none\" d=\"M0 0h24v24H0z\" fill=\"none\"/><path d=\"M5 19m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0\" /><path d=\"M4 4a16 16 0 0 1 16 16\" /><path d=\"M4 11a9 9 0 0 1 9 9\" /></svg>',0,'rss','2024-02-22 19:43:17','2024-04-01 11:17:54',NULL,0,0,'#FF9E4D','rss',NULL,'regular'),(46,NULL,'AI Voice Isolator','Separate voices from background noise in audio recordings.','ai_voice_isolator',1,'[{\"name\":\"file\",\"type\":\"file\",\"question\":\"Upload an Audio File (mp3, mp4, mpeg, mpga, m4a, wav, and webm)(Max: 500Mb)\",\"select\":\"\"}]','<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"48\" viewBox=\"0 96 960 960\" width=\"48\"><path d=\"M140 976q-24.75 0-42.375-17.625T80 916V236q0-24.75 17.625-42.375T140 176h380l-60 60H140v680h480V776h60v140q0 24.75-17.625 42.375T620 976H140Zm100-170v-60h280v60H240Zm0-120v-60h200v60H240Zm380 10L460 536H320V336h140l160-160v520Zm60-92V258q56 21 88 74t32 104q0 51-35 101t-85 67Zm0 142v-62q70-25 125-90t55-158q0-93-55-158t-125-90v-62q102 27 171 112.5T920 436q0 112-69 197.5T680 746Z\"/></svg>',0,'isolator','2026-09-12 17:22:03','2026-09-12 17:22:03','',0,0,'#DEFF81','voice',NULL,'regular');
/*!40000 ALTER TABLE `openai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `openai_chat_category`
--

DROP TABLE IF EXISTS `openai_chat_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `openai_chat_category` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `chatbot_id` bigint DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `instructions` text COLLATE utf8mb4_unicode_ci,
  `first_message` text COLLATE utf8mb4_unicode_ci,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `human_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `helps_with` text COLLATE utf8mb4_unicode_ci,
  `prompt_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `chat_completions` text COLLATE utf8mb4_unicode_ci,
  `plan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assistant` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `openai_chat_category`
--

LOCK TABLES `openai_chat_category` WRITE;
/*!40000 ALTER TABLE `openai_chat_category` DISABLE KEYS */;
INSERT INTO `openai_chat_category` VALUES (1,NULL,NULL,'Default AI Chat Bot','ACB','ai-chat-bot','Default',NULL,NULL,'default','','','','','#A3D6C2','2023-05-16 03:34:57','2023-05-16 03:39:11',NULL,NULL,NULL,NULL),(2,NULL,NULL,'Finance Expert','FE','finance-expert','Personal Finance Expert',NULL,NULL,'Finance Expert','Allison Burgers','I can help you with managing your finance','As a personal finance expert,',NULL,'#DBD5F5','2023-05-16 03:34:57','2023-05-16 03:39:11',NULL,NULL,NULL,NULL),(3,NULL,NULL,'Nutritionist','N','nutritionist','Personal Nutritionist',NULL,NULL,'Nutritionist','Employes Mustwashhands','I can assist you with nutrition-related information or questions','As a nutritionist,',NULL,'#EDBBBE','2023-05-16 03:34:57','2023-05-16 03:39:11',NULL,NULL,NULL,NULL),(4,NULL,NULL,'Career Counselor','CC','career-counselor','Personal Career Counselor',NULL,NULL,'Career Counselor','Neil Feetstrong','I can assist you with your career-related inquiries or concerns','As a career counselor,',NULL,'#D4D4E2','2023-05-16 03:34:57','2023-05-16 03:39:11',NULL,NULL,NULL,NULL),(5,NULL,NULL,'Time Management Consultant','TMC','time-management-consultant','Personal Time Management Consultant',NULL,NULL,'Time Management Consultant','Sarman Yellow','I can assist you with improving your time management skills or addressing any time management challenges you may be facing','As a time management consultant,',NULL,'#D6CBA3','2023-05-16 03:34:57','2023-05-16 03:39:11',NULL,NULL,NULL,NULL),(6,NULL,NULL,'Language Tutor','LT','language-tutor','Personal Language Tutor',NULL,NULL,'Language Tutor','Sherlock Jonas','I can assist you with your language learning goals or provide guidance on language-related topics','As a language tutor,',NULL,'#EACCEB','2023-05-16 03:34:57','2023-05-16 03:39:11',NULL,NULL,NULL,NULL),(7,NULL,NULL,'Cybersecurity Expert','CE','cybersecurity-expert','Cybersecurity Expert',NULL,NULL,'Cybersecurity Expert','Mr. Robot','I can assist you with your cybersecurity concerns or provide information and guidance related to cybersecurity','As a cybersecurity expert, ',NULL,'#BDE3E3','2023-05-16 03:34:57','2023-05-16 03:39:11',NULL,NULL,NULL,NULL),(8,NULL,NULL,'Interior Designer','ID','interior-designer','Personal Interior Designer',NULL,NULL,'Interior Designer','Olivia Sinclair','I can assist you with your interior design needs or provide guidance on creating beautiful and functional spaces','As an interior designer, ',NULL,'#F0D1CD','2023-05-16 03:34:57','2023-05-16 03:39:11',NULL,NULL,NULL,NULL),(9,NULL,NULL,'Parenting Coach','PC','parenting-coach','Personal Parenting Coach',NULL,NULL,'Parenting Coach','Alexandra Stevens','I can assist you with your parenting questions or provide guidance and support in raising children','As a parenting coach, ',NULL,'#A3D6C2','2023-05-16 03:34:57','2023-05-16 03:39:11',NULL,NULL,NULL,NULL),(10,NULL,NULL,'Fitness Trainer','FT','fitness-trainer','Personal Fitness Trainer',NULL,NULL,'Fitness Trainer','Mert Karapinar','I can assist you with your fitness goals or provide guidance and advice on exercise, nutrition, and overall wellness','As a fitness trainer, ',NULL,'#D2D6DF','2023-05-16 03:34:57','2023-05-16 03:39:11',NULL,NULL,NULL,NULL),(11,NULL,NULL,'Travel Advisor','TA','travel-advisor','Personal Travel Advisor',NULL,NULL,'Travel Advisor','Bilbo Harries','I can assist you with your travel plans, provide destination recommendations, or offer guidance on travel-related inquiries','As a travel advisor,',NULL,'#BFE3EB','2023-05-16 03:34:57','2023-05-16 03:34:57',NULL,NULL,NULL,NULL),(12,NULL,NULL,'Sustainability Expert','SE','sustainability-expert','Sustainability Expert',NULL,NULL,'Sustainability Expert','Viabil Ity','I can assist you with your sustainability goals, provide information on sustainable practices, or offer guidance on living a more environmentally friendly lifestyle','As a sustainability expert',NULL,'#ECDBC1','2023-05-16 03:34:57','2023-05-16 03:34:57',NULL,NULL,NULL,NULL),(13,NULL,NULL,'Event Planner','EP','event planner','Event Planner',NULL,NULL,'Event Planner','Jack Groomer','I can assist you with planning and organizing your upcoming event, providing advice on event management, or offering guidance on creating memorable and successful events','As an event planner,',NULL,'#E3E3BD','2023-05-16 03:34:57','2023-05-16 03:34:57',NULL,NULL,NULL,NULL),(14,NULL,NULL,'VisionAI','VI','ai_vision','Image PDF Expert',NULL,NULL,'Image Expert','VisionAI','I can assist you with PDF or Images-related information or questions','As a VisionAI,','assets/img/vision.png','#EDBBBE','2023-05-16 03:34:57','2023-05-16 03:39:11','[{\"role\": \"system\", \"content\": \"You are a Vision AI assistant.\"}, {\"role\": \"user\", \"content\": \"What objects are present in this image?\"}, {\"role\": \"assistant\", \"content\": \"The image contains various objects, including a person, a car, and a building.\"}, {\"role\": \"user\", \"content\": \"Can you describe the color of the car?\"}, {\"role\": \"assistant\", \"content\": \"The car in the image appears to be red.\"}]',NULL,NULL,NULL),(15,NULL,NULL,'File Analyzer','FA','ai_pdf','I can assist you with PDF, DOC, DOCX or CSX, XLS, XLSX information or questions',NULL,NULL,'File Analyzer','File Analyzer','I can assist you with PDF, DOC, DOCX or CSX, XLS, XLSX information or questions','As a File Analyzer','assets/img/vision.png','#EDBBBE','2023-05-16 03:34:57','2026-09-12 17:22:03','[{\"role\": \"system\", \"content\": \"You are a PDF AI assistant.\"}]',NULL,NULL,NULL),(16,NULL,NULL,'Chat Image','CI','ai_chat_image','Image Generator',NULL,NULL,'Image Generator','Image Generator','I can assist to generate image by user input','As a Pdf AI,','assets/img/vision.png','#EDBBBE','2023-05-16 03:34:57','2023-05-16 03:39:11','[{\"role\": \"system\", \"content\": \"You are a Chat Image assistant.\"}]','','',NULL),(17,NULL,NULL,'WebChat','WC','ai_webchat','AI Web Chat',NULL,NULL,'Web Analyzer','AI Web Chat','I can assist you with web page content analyzation','As a WebPage analyzer,','assets/img/vision.png','#EDBBBE','2023-05-16 03:34:57','2023-05-16 03:39:11','[{\"role\": \"system\", \"content\": \"You are a Web Page Analyzer assistant.\"}]','','',NULL);
/*!40000 ALTER TABLE `openai_chat_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `openai_filters`
--

DROP TABLE IF EXISTS `openai_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `openai_filters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `openai_filters`
--

LOCK TABLES `openai_filters` WRITE;
/*!40000 ALTER TABLE `openai_filters` DISABLE KEYS */;
INSERT INTO `openai_filters` VALUES (1,NULL,'blog'),(2,NULL,'ecommerce'),(3,NULL,'development'),(4,NULL,'advertisement'),(5,NULL,'Custom'),(6,NULL,'social media'),(7,NULL,'voiceover'),(8,NULL,'youtube'),(9,NULL,'rss');
/*!40000 ALTER TABLE `openai_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `titlebar_status` tinyint NOT NULL DEFAULT '1',
  `is_custom` tinyint(1) NOT NULL DEFAULT '0',
  `show_on_footer` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'About','<p><img style=\"display: block; border-radius: 25px; margin-left: auto; margin-right: auto;\" src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/img-1.jpg\" alt=\"\" width=\"1450\" height=\"761\"></p>\r\n<p style=\"text-align: center;\"><span class=\"highlight\">About Us</span></p>\r\n<h1 style=\"text-align: center;\">Shaping the future 🏔️</h1>\r\n<p class=\"leading\" style=\"max-width: 80%; margin-left: auto; margin-right: auto; text-align: center;\">Whether&nbsp;you&rsquo;re&nbsp;a&nbsp;content&nbsp;creator,&nbsp;business&nbsp;owner,&nbsp;or&nbsp;student, <span style=\"color: rgb(89, 89, 89);\">our&nbsp;text&nbsp;generator&nbsp;is&nbsp;an&nbsp;essential&nbsp;tool&nbsp;for&nbsp;boosting&nbsp;your&nbsp;productivity.</span></p>\r\n<hr>\r\n<p>&nbsp;</p>\r\n<p><span class=\"highlight\">Who Are We<br></span></p>\r\n<p class=\"leading\">At MagicAI, we are passionate about harnessing the power of artificial intelligence to unlock limitless creativity and efficiency.<span style=\"color: rgb(89, 89, 89);\"> Our cutting-edge AI Generators are designed to revolutionize the way you create, streamline your workflows, and supercharge your productivity.</span></p>\r\n<p>Our mission is to empower individuals and businesses to unleash their creative potential and achieve extraordinary results.</p>\r\n<p>We believe that AI has the ability to augment human capabilities, enhance decision-making processes, and accelerate innovation.</p>\r\n<p>By developing state-of-the-art AI Generators, we aim to democratize access to advanced AI technologies, enabling users from all backgrounds to excel in their creative endeavors.</p>\r\n<p>&nbsp;</p>\r\n<hr>\r\n<p>&nbsp;</p>\r\n<p><span class=\"highlight\">Invite a Friend</span></p>\r\n<h3>Our Mission</h3>\r\n<p class=\"leading\">We pride ourselves on offering AI Generators that are unmatched in their quality, <span style=\"color: rgb(89, 89, 89);\">versatility, and ease of use. Here&rsquo;s what sets us apart from the competition:</span></p>\r\n<p>With our AI Generators, the possibilities are endless. From generating compelling marketing copy and designing stunning visuals to automating data analysis and creating personalized user experiences, our tools will transform the way you work and help you achieve remarkable outcomes.</p>\r\n<p>Join our community of innovators, creators, and forward-thinkers who are leveraging the power of AI to revolutionize their industries. Start your journey with MagicAI today and unlock the full potential of AI Generators.</p>\r\n<p>Ready to experience the future of creativity? Sign up now and embark on an exciting adventure of limitless possibilities.</p>\r\n<p>&nbsp;</p>\r\n<p style=\"text-align: center;\"><span class=\"info-box\">Still have a question? <span style=\"color: rgb(8, 53, 248);\"><a style=\"color: rgb(8, 53, 248);\" href=\"#\">Browse documentation</a></span> or <span style=\"color: rgb(8, 53, 248);\"><a style=\"color: rgb(8, 53, 248);\" href=\"#\">submit a ticket</a></span>.</span></p>\r\n<p>&nbsp;</p>\r\n<hr>\r\n<p>&nbsp;</p>\r\n<table style=\"border-collapse: collapse; width: 100%; border-width: 0px; border-style: none;\" border=\"1\"><colgroup><col style=\"width: 20%;\"><col style=\"width: 20%;\"><col style=\"width: 20%;\"><col style=\"width: 20%;\"><col style=\"width: 20%;\"></colgroup>\r\n<tbody>\r\n<tr style=\"text-align: center;\">\r\n<td style=\"border-width: 0px; text-align: center;\"><img src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/Path-143406.svg\" alt=\"\" width=\"79\" height=\"28\"></td>\r\n<td style=\"border-width: 0px; text-align: center;\"><img src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/Path-159906.svg\" alt=\"\" width=\"48\" height=\"48\"></td>\r\n<td style=\"border-width: 0px; text-align: center;\"><img src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/Path-159907.svg\" alt=\"\" width=\"55\" height=\"34\"></td>\r\n<td style=\"border-width: 0px; text-align: center;\"><img src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/Path-159908.svg\" alt=\"\" width=\"47\" height=\"48\"></td>\r\n<td style=\"border-width: 0px; text-align: center;\"><img src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/Path-159909.svg\" alt=\"\" width=\"80\" height=\"20\"></td>\r\n</tr>\r\n</tbody>\r\n</table>','custom-about',0,'2024-02-13 03:46:38','2024-02-14 14:11:26',0,1,0),(2,'Privacy and Policy','<p style=\"text-align: center;\"><span class=\"highlight\">Privacy Policy</span></p>\r\n<h1 style=\"text-align: center;\">Privacy and Policy</h1>\r\n<p class=\"leading\" style=\"max-width: 80%; margin-left: auto; margin-right: auto; text-align: center;\">With our tool, you can generate text in seconds, freeing up your <span style=\"color: rgb(89, 89, 89);\">time to focus on other important tasks that matter the most.</span></p>\r\n<p><img style=\"display: block; border-radius: 25px; margin-left: auto; margin-right: auto;\" src=\"https://gcdnb.pbrd.co/images/D92RJsyqJdHy.png?o=1\" alt=\"\" width=\"1450\" height=\"761\"></p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><span class=\"highlight\">Privacy Policy</span></p>\r\n<p class=\"leading\">Our newest theme update brings modern and clean design templates to Hub Collection which is already one of the biggest template collections ever built. <span style=\"color: rgb(89, 89, 89);\">These layouts are designed in a simple and unique style that can improve your daily workflow and save you an enormous amount of time.</span></p>\r\n<p>Test built the Liquid app as a Commercial app. This Service is provided by Test and is intended for use as is.</p>\r\n<p>If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.</p>\r\n<p>The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Liquid unless otherwise defined in this Privacy Policy.</p>\r\n<p>&nbsp;</p>\r\n<hr>\r\n<h5>&nbsp;</h5>\r\n<h5>Fair Use</h5>\r\n<p>For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to Test. The information that we request will be retained by us and used as described in this privacy policy.</p>\r\n<p>The app does use third-party services that may collect information used to identify you.</p>\r\n<p>Link to the privacy policy of third-party service providers used by the app</p>\r\n<p>We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (&ldquo;IP&rdquo;) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.</p>\r\n<p>&nbsp;</p>\r\n<h5 class=\"lqd-text-el m-0 p-0\"><span class=\"lqd-text-item relative elementor-repeater-item-c3d0556\">Cookies</span></h5>\r\n<p>Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device&rsquo;s internal memory.</p>\r\n<p>This Service does not use these &ldquo;cookies&rdquo; explicitly. However, the app may use third-party code and libraries that use &ldquo;cookies&rdquo; to collect information and improve their services. You have the option to either accept or refuse</p>\r\n<p>&nbsp;</p>\r\n<p style=\"text-align: center;\"><span class=\"info-box\">Still have a question? <span style=\"color: rgb(8, 53, 248);\"><a style=\"color: rgb(8, 53, 248);\" href=\"#\">Browse documentation</a></span> or <span style=\"color: rgb(8, 53, 248);\"><a style=\"color: rgb(8, 53, 248);\" href=\"#\">submit a ticket</a>.</span></span></p>','custom-privacy-and-policy',0,'2024-02-13 03:48:09','2024-02-14 14:15:29',0,1,0),(3,'How It Works','<p style=\"text-align: center;\">Trusted by these amazing companies</p>\r\n<table style=\"border-collapse: collapse; width: 100.068%; border-width: 0px;\" border=\"1\"><colgroup><col style=\"width: 25.0342%;\"><col style=\"width: 25.0342%;\"><col style=\"width: 25.0342%;\"><col style=\"width: 25.0342%;\"></colgroup>\r\n<tbody>\r\n<tr>\r\n<td style=\"border-width: 0px;\"><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/nike.svg\" alt=\"\" width=\"88\" height=\"32\"></td>\r\n<td style=\"border-width: 0px;\"><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/Path-133531.svg\" alt=\"\" width=\"86\" height=\"37\"></td>\r\n<td style=\"border-width: 0px;\"><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/Path-46878.svg\" alt=\"\" width=\"49\" height=\"35\"></td>\r\n<td style=\"border-width: 0px;\"><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/volkswagen-1.svg\" alt=\"\" width=\"53\" height=\"53\"></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p class=\"leading\" style=\"text-align: center;\">&nbsp;</p>\r\n<p class=\"leading\" style=\"text-align: center;\">At MagicAI, we are passionate about harnessing the power of artificial intelligence to unlock limitless creativity and efficiency.&nbsp;<span style=\"color: rgb(89, 89, 89);\">Our cutting-edge AI Generators are designed to revolutionize the way you create, streamline your workflows, and supercharge your productivity.</span></p>\r\n<p class=\"leading\" style=\"text-align: center;\">&nbsp;</p>\r\n<p><span class=\"num-block\">1</span></p>\r\n<h4>Select a Template</h4>\r\n<p>Our mission is to empower individuals and businesses to unleash their creative potential and achieve extraordinary results. We believe that AI has the ability to augment human capabilities, enhance decision-making processes, and accelerate innovation.</p>\r\n<p>&nbsp;</p>\r\n<p><span class=\"num-block\">2</span></p>\r\n<h4>Explain your idea</h4>\r\n<p>AI generators are sophisticated systems trained on vast amounts of data to learn patterns, understand context, and generate original content. They are designed to mimic human creativity by analyzing existing examples.</p>\r\n<p>&nbsp;</p>\r\n<p><span class=\"num-block\">3</span></p>\r\n<h4>Done!</h4>\r\n<p>By developing state-of-the-art AI Generators, we aim to democratize access to advanced AI technologies, enabling users from all backgrounds to excel in their creative endeavors.</p>\r\n<p>&nbsp;</p>\r\n<p style=\"text-align: center;\"><span class=\"info-box\">Still have a question? <span style=\"color: rgb(8, 53, 248);\"><a style=\"color: rgb(8, 53, 248);\" href=\"#\">Browse documentation</a></span> or <span style=\"color: rgb(8, 53, 248);\"><a style=\"color: rgb(8, 53, 248);\" href=\"#\">submit a ticket</a>.</span></span></p>\r\n<p>&nbsp;</p>\r\n<p><img style=\"border-radius: 25px;\" src=\"https://gcdnb.pbrd.co/images/OZmBXkQ5MQyH.png?o=1\" alt=\"How it works\" width=\"1620\" height=\"870\"></p>\r\n<p>&nbsp;</p>\r\n<p><span class=\"highlight\">Invite a Friend</span></p>\r\n<h4>Affiliate System.</h4>\r\n<p class=\"leading\">We pride ourselves on offering AI Generators that are unmatched in their quality, <span style=\"color: rgb(89, 89, 89);\">versatility, and ease of use. Here&rsquo;s what sets us apart from the competition:</span></p>\r\n<h5>Done!</h5>\r\n<p>Join our community of innovators, creators, and forward-thinkers who are leveraging the power of AI to revolutionize their industries. Start your journey with MagicAI today and unlock the full potential of AI Generators.</p>\r\n<p>&nbsp;</p>\r\n<p><img src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/icon-2.jpg\" alt=\"\" width=\"48\" height=\"48\"></p>\r\n<h5>Invite your Friend</h5>\r\n<p>With our AI Generators, the possibilities are endless. From generating compelling marketing copy and designing stunning visuals to automating data analysis and creating personalized user experiences.</p>\r\n<p>&nbsp;</p>\r\n<p><img src=\"https://aidefault.liquid-themes.com/wp-content/uploads/2023/08/icon-3.jpg\" alt=\"\" width=\"48\" height=\"48\"></p>\r\n<h5>Make Money</h5>\r\n<p>Ready to experience the future of creativity? Sign up now and embark on an exciting adventure of limitless possibilities.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p style=\"text-align: center;\"><span class=\"info-box\">Still have a question? <span style=\"color: rgb(8, 53, 248);\"><a style=\"color: rgb(8, 53, 248);\" href=\"#\">Browse documentation</a></span> or <span style=\"color: rgb(8, 53, 248);\"><a style=\"color: rgb(8, 53, 248);\" href=\"#\">submit a ticket</a>.</span></span></p>','custom-how-it-works',0,'2024-02-13 03:49:08','2024-02-14 13:37:35',1,1,0),(4,'Features','<p><img style=\"border-radius: 25px;\" src=\"https://gcdnb.pbrd.co/images/iTA0Xv7SHrVp.png?o=1\" alt=\"About us\" width=\"1526 &times;\" height=\"866\"></p>\r\n<p>&nbsp;</p>\r\n<p><span class=\"highlight\">Introducing</span></p>\r\n<h3 class=\"lqd-text-el m-0 p-0\"><span class=\"lqd-text-item relative elementor-repeater-item-eaff06a\">Custom Chatbots.</span></h3>\r\n<p class=\"leading\">We pride ourselves on offering AI Generators that are unmatched in their quality, <span style=\"color: rgb(89, 89, 89);\">versatility, and ease of use. Here&rsquo;s what sets us apart from the competition:</span></p>\r\n<p>With our AI Generators, the possibilities are endless. From generating compelling marketing copy and designing stunning visuals to automating data analysis and creating personalized user experiences, our tools will transform the way you work and help you achieve remarkable outcomes.</p>\r\n<p>Join our community of innovators, creators, and forward-thinkers who are leveraging the power of AI to revolutionize their industries. Start your journey with MagicAI today and unlock the full potential of AI Generators.</p>\r\n<p>Ready to experience the future of creativity? Sign up now and embark on an exciting adventure of limitless possibilities.</p>\r\n<ul style=\"list-style: disc; list-style-position: inside;\">\r\n<li><strong>New &mdash;</strong>&nbsp;AI Voiceover in 30 Languages</li>\r\n<li><strong>New &mdash;</strong>&nbsp;Custom Avatar for Chatbot</li>\r\n<li><strong>Improved &mdash;</strong>&nbsp;Auto Translate</li>\r\n</ul>','custom-features',0,'2024-02-14 12:27:38','2024-02-14 13:25:50',1,1,0);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_proofs`
--

DROP TABLE IF EXISTS `payment_proofs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_proofs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `order_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plan_id` bigint unsigned NOT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `proof_image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_proofs_user_id_foreign` (`user_id`),
  KEY `payment_proofs_plan_id_foreign` (`plan_id`),
  CONSTRAINT `payment_proofs_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payment_proofs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_proofs`
--

LOCK TABLES `payment_proofs` WRITE;
/*!40000 ALTER TABLE `payment_proofs` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_proofs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paystack_payment_infos`
--

DROP TABLE IF EXISTS `paystack_payment_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paystack_payment_infos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trans` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trxref` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plan_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `other` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `paystack_payment_infos_user_id_foreign` (`user_id`),
  CONSTRAINT `paystack_payment_infos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paystack_payment_infos`
--

LOCK TABLES `paystack_payment_infos` WRITE;
/*!40000 ALTER TABLE `paystack_payment_infos` DISABLE KEYS */;
/*!40000 ALTER TABLE `paystack_payment_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pdf_data`
--

DROP TABLE IF EXISTS `pdf_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pdf_data` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` int NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `vector` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pdf_data`
--

LOCK TABLES `pdf_data` WRITE;
/*!40000 ALTER TABLE `pdf_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `pdf_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pebblely`
--

DROP TABLE IF EXISTS `pebblely`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pebblely` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pebblely`
--

LOCK TABLES `pebblely` WRITE;
/*!40000 ALTER TABLE `pebblely` DISABLE KEYS */;
/*!40000 ALTER TABLE `pebblely` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'marketplace','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(2,'themes','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(3,'user_management','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(4,'announcements','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(5,'google_adsense','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(6,'support_requests','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(7,'templates','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(8,'chat_settings','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(9,'frontend','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(10,'finance','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(11,'pages','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(12,'blog','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(13,'affiliates_admin','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(14,'coupons_admin','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(15,'email_templates','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(16,'introductions','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(17,'mailchimp_newsletter','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(18,'hubspot','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(19,'api_integration','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(20,'settings','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(21,'site_health','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(22,'license','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(23,'update','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(24,'menu_setting','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(25,'VIP_CHAT_WIDGET','web','2026-09-12 17:22:03','2026-09-12 17:22:03');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_studios`
--

DROP TABLE IF EXISTS `photo_studios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo_studios` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `photo` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci,
  `credits` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_studios`
--

LOCK TABLES `photo_studios` WRITE;
/*!40000 ALTER TABLE `photo_studios` DISABLE KEYS */;
/*!40000 ALTER TABLE `photo_studios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double NOT NULL DEFAULT '0',
  `price_tax_included` tinyint(1) DEFAULT '0',
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `frequency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'monthly',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `stripe_product_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ai_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_tokens` bigint DEFAULT NULL,
  `can_create_ai_images` tinyint(1) DEFAULT NULL,
  `plan_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all',
  `features` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'subscription',
  `credit_system_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'separated',
  `shared_credits_amount` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `shared_credit_model_overrides` json DEFAULT NULL,
  `shared_credit_feature_limits` json DEFAULT NULL,
  `is_team_plan` tinyint(1) NOT NULL DEFAULT '0',
  `plan_allow_seat` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `trial_days` int NOT NULL DEFAULT '0',
  `open_ai_items` json DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `plan_ai_tools` json NOT NULL,
  `plan_features` json NOT NULL,
  `social_media_agent_limits` json DEFAULT NULL,
  `social_media_automation_limits` json DEFAULT NULL,
  `blogpilot_limits` json DEFAULT NULL,
  `marketing_bot_limits` json DEFAULT NULL,
  `default_ai_model` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'gpt-3.5-turbo',
  `ai_models` json DEFAULT NULL,
  `user_api` tinyint(1) NOT NULL DEFAULT '0',
  `hidden_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `max_subscribe` int DEFAULT NULL,
  `chatbot_limit` int DEFAULT NULL,
  `chatbot_channels` json DEFAULT NULL,
  `chatbot_human_agent` tinyint(1) NOT NULL DEFAULT '1',
  `last_date` date DEFAULT NULL,
  `reset_credits_on_renewal` tinyint(1) NOT NULL DEFAULT '0',
  `multi_model_support` tinyint(1) DEFAULT '0',
  `voice_call_seconds_limit` int NOT NULL DEFAULT '-1',
  `phone_call_agent_seconds_limit` int NOT NULL DEFAULT '-1',
  `phone_call_agent_outbound_seconds_limit` int NOT NULL DEFAULT '-1',
  `ai_chat_pro_connectors` json DEFAULT NULL,
  `affiliate_status` tinyint(1) NOT NULL DEFAULT '1',
  `model_council_support` tinyint(1) DEFAULT '0',
  `deep_research_request_limit` int NOT NULL DEFAULT '5',
  `ai_agent_workflow_limit` int DEFAULT NULL,
  `ai_agent_channel_limit` int DEFAULT NULL,
  `ai_agent_message_limit` int DEFAULT NULL,
  `ai_agent_memory_limit` int DEFAULT NULL,
  `video_dubbing_seconds_limit` int NOT NULL DEFAULT '20',
  `ugc_videos_limit` int NOT NULL DEFAULT '-1',
  `ai_captions_access` tinyint(1) NOT NULL DEFAULT '1',
  `ai_captions_minutes` int NOT NULL DEFAULT '30',
  `ugc_creator_videos_limit` int NOT NULL DEFAULT '-1',
  `phone_call_agent_follow_up_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `phone_call_agent_outbound_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `phone_call_agent_outbound_calls_per_day` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privacy_terms`
--

DROP TABLE IF EXISTS `privacy_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `privacy_terms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privacy_terms`
--

LOCK TABLES `privacy_terms` WRITE;
/*!40000 ALTER TABLE `privacy_terms` DISABLE KEYS */;
/*!40000 ALTER TABLE `privacy_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` int DEFAULT NULL,
  `key_features` text COLLATE utf8mb4_unicode_ci,
  `user_id` bigint unsigned DEFAULT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_user_id_foreign` (`user_id`),
  KEY `products_company_id_foreign` (`company_id`),
  CONSTRAINT `products_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE SET NULL,
  CONSTRAINT `products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prompt_library`
--

DROP TABLE IF EXISTS `prompt_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prompt_library` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prompt` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int NOT NULL,
  `show_for_all` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prompt_library`
--

LOCK TABLES `prompt_library` WRITE;
/*!40000 ALTER TABLE `prompt_library` DISABLE KEYS */;
/*!40000 ALTER TABLE `prompt_library` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rate_limits`
--

DROP TABLE IF EXISTS `rate_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate_limits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` int NOT NULL DEFAULT '0',
  `last_attempt_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'image',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate_limits`
--

LOCK TABLES `rate_limits` WRITE;
/*!40000 ALTER TABLE `rate_limits` DISABLE KEYS */;
/*!40000 ALTER TABLE `rate_limits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recent_search_keys`
--

DROP TABLE IF EXISTS `recent_search_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recent_search_keys` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recent_search_keys_keyword_index` (`keyword`),
  KEY `recent_search_keys_user_keyword_index` (`user_id`,`keyword`),
  KEY `recent_search_keys_user_created_index` (`user_id`,`created_at`),
  CONSTRAINT `recent_search_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recent_search_keys`
--

LOCK TABLES `recent_search_keys` WRITE;
/*!40000 ALTER TABLE `recent_search_keys` DISABLE KEYS */;
INSERT INTO `recent_search_keys` VALUES (1,'AI Agent',1,'2026-09-13 12:42:04','2026-09-13 12:42:04'),(3,'AI Bot Replies',1,'2026-09-13 14:35:20','2026-09-13 14:35:20'),(4,'Replies',1,'2026-09-13 14:35:23','2026-09-13 14:35:23');
/*!40000 ALTER TABLE `recent_search_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referers`
--

DROP TABLE IF EXISTS `referers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `referer` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `domain` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `referers_domain_index` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referers`
--

LOCK TABLES `referers` WRITE;
/*!40000 ALTER TABLE `referers` DISABLE KEYS */;
INSERT INTO `referers` VALUES (1,'v65bqgizHxytmTui9JCvAQ9soWRKlH55ge97gk8l','http://magicai.nammoai.com','magicai.nammoai.com','2026-09-12 17:02:09'),(2,'C4zL5AZPFWcR6260So3EziEYLpZlehDDlwYnvTYN','https://magicai.nammoai.com/','magicai.nammoai.com','2026-09-12 17:02:09'),(3,'WgUu03QjoX9pJUmTbpTW90proLwGzL5O0tMA7q5U','http://magicai.nammoai.com','magicai.nammoai.com','2026-09-12 17:02:09'),(4,'OiaQ6vwIszyenqGSQABhKD680W9JBSefnWDyFno1','https://magicai.nammoai.com/','magicai.nammoai.com','2026-09-12 17:02:09'),(5,'DPR2dBIOgumYDwQUfC9zdVQTC48CbUy7cpN5Kdxw','http://magicai.nammoai.com','magicai.nammoai.com','2026-09-12 20:00:15'),(6,'Vw4gjdU7Om2M0ZGoMrHZp2UbLpdm0Yvr0StDiFHx','http://magicai.nammoai.com','magicai.nammoai.com','2026-09-12 20:00:15'),(7,'HfnxST5h73vE8JCcUq0tPOVaE2kj3rrSligTmRVG','http://magicai.nammoai.com','magicai.nammoai.com','2026-09-13 12:36:36'),(8,'HTF9girLAoNR3yuNv5xU7FlC07yCVfPKb7Wytrws','http://magicai.nammoai.com','magicai.nammoai.com','2026-09-13 13:58:39');
/*!40000 ALTER TABLE `referers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revenuecat_products`
--

DROP TABLE IF EXISTS `revenuecat_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revenuecat_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `plan_id` bigint unsigned DEFAULT NULL,
  `gatewayproduct_id` bigint unsigned DEFAULT NULL,
  `entitlement_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apple_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amazon_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `revenuecat_products_plan_id_foreign` (`plan_id`),
  KEY `revenuecat_products_gatewayproduct_id_foreign` (`gatewayproduct_id`),
  CONSTRAINT `revenuecat_products_gatewayproduct_id_foreign` FOREIGN KEY (`gatewayproduct_id`) REFERENCES `gatewayproducts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `revenuecat_products_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revenuecat_products`
--

LOCK TABLES `revenuecat_products` WRITE;
/*!40000 ALTER TABLE `revenuecat_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `revenuecat_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES (1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(10,2),(11,2),(12,2),(13,2),(14,2),(15,2),(16,2),(17,2),(18,2),(19,2),(20,2),(21,2),(22,2),(23,2),(24,2),(25,2);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'user','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(2,'admin','web','2026-09-12 17:22:03','2026-09-12 17:22:03'),(3,'super_admin','web','2026-09-12 17:22:03','2026-09-12 17:22:03');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_posts`
--

DROP TABLE IF EXISTS `scheduled_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduled_posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `automation_platform_id` bigint DEFAULT NULL,
  `command_running` tinyint(1) NOT NULL DEFAULT '0',
  `last_run_date` date DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `platform` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `products` text COLLATE utf8mb4_unicode_ci,
  `campaign_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_target` longtext COLLATE utf8mb4_unicode_ci,
  `topics` longtext COLLATE utf8mb4_unicode_ci,
  `is_seo` tinyint(1) NOT NULL DEFAULT '0',
  `tone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `length` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_email` tinyint(1) NOT NULL DEFAULT '0',
  `is_repeated` tinyint(1) NOT NULL DEFAULT '0',
  `repeat_period` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repeat_start_date` date DEFAULT NULL,
  `repeat_time` time DEFAULT NULL,
  `visual_format` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visual_ratio` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posted_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prompt` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `auto_generate` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `command_running_last_run_date_index` (`command_running`,`last_run_date`,`repeat_period`,`repeat_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_posts`
--

LOCK TABLES `scheduled_posts` WRITE;
/*!40000 ALTER TABLE `scheduled_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduled_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_postal` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_vat` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_currency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2',
  `tax_rate` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_active` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `stripe_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_base_url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'https://api.stripe.com',
  `bank_transfer_active` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `bank_transfer_instructions` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_transfer_informations` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MagicAI',
  `site_url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'https://liquid-themes.com',
  `site_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_analytics_active` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `google_analytics_code` text COLLATE utf8mb4_unicode_ci,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'magicAI-logo.svg',
  `favicon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` text COLLATE utf8mb4_unicode_ci,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `facebook_active` tinyint(1) NOT NULL DEFAULT '0',
  `facebook_api_key` text COLLATE utf8mb4_unicode_ci,
  `facebook_api_secret` text COLLATE utf8mb4_unicode_ci,
  `facebook_redirect_url` text COLLATE utf8mb4_unicode_ci,
  `github_active` tinyint(1) NOT NULL DEFAULT '0',
  `github_api_key` text COLLATE utf8mb4_unicode_ci,
  `github_api_secret` text COLLATE utf8mb4_unicode_ci,
  `github_redirect_url` text COLLATE utf8mb4_unicode_ci,
  `google_active` tinyint(1) NOT NULL DEFAULT '0',
  `google_api_key` text COLLATE utf8mb4_unicode_ci,
  `google_api_secret` text COLLATE utf8mb4_unicode_ci,
  `google_redirect_url` text COLLATE utf8mb4_unicode_ci,
  `twitter_active` tinyint(1) NOT NULL DEFAULT '0',
  `twitter_api_key` text COLLATE utf8mb4_unicode_ci,
  `twitter_api_secret` text COLLATE utf8mb4_unicode_ci,
  `twitter_redirect_url` text COLLATE utf8mb4_unicode_ci,
  `register_active` tinyint(1) NOT NULL DEFAULT '1',
  `default_country` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'United States',
  `smtp_host` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_port` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_sender_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_encryption` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'TLS',
  `openai_api_secret` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `logo_path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'assets/img/logo/magicAI-logo.svg',
  `favicon_path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `openai_default_model` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'gpt-3.5-turbo',
  `openai_default_language` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en-US',
  `openai_default_tone_of_voice` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'professional',
  `openai_default_creativity` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0.75',
  `openai_max_input_length` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '300',
  `openai_max_output_length` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '200',
  `affiliate_minimum_withdrawal` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '10',
  `affiliate_commission_percentage` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '10',
  `frontend_pricing_section` tinyint(1) NOT NULL DEFAULT '1',
  `frontend_custom_templates_section` tinyint(1) NOT NULL DEFAULT '1',
  `frontend_business_partners_section` tinyint(1) NOT NULL DEFAULT '1',
  `frontend_additional_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frontend_custom_js` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frontend_custom_css` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frontend_footer_facebook` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frontend_footer_twitter` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frontend_footer_instagram` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `script_version` double NOT NULL DEFAULT '10',
  `logo_collapsed` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'magicAI-logo-Collapsed.png',
  `logo_collapsed_path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'assets/img/logo/magicAI-logo-Collapsed.png',
  `stripe_status_for_now` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'disabled',
  `logo_dark` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'magicAI-logo-dark.svg',
  `logo_dashboard` text COLLATE utf8mb4_unicode_ci,
  `logo_dashboard_dark` text COLLATE utf8mb4_unicode_ci,
  `logo_collapsed_dark` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'magicAI-logo-collapsed-dark.svg',
  `logo_2x` text COLLATE utf8mb4_unicode_ci,
  `logo_dark_2x` text COLLATE utf8mb4_unicode_ci,
  `logo_dashboard_2x` text COLLATE utf8mb4_unicode_ci,
  `logo_dashboard_dark_2x` text COLLATE utf8mb4_unicode_ci,
  `logo_collapsed_2x` text COLLATE utf8mb4_unicode_ci,
  `logo_collapsed_dark_2x` text COLLATE utf8mb4_unicode_ci,
  `logo_dark_path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'assets/img/logo/magicAI-logo-dark.svg',
  `logo_dashboard_path` text COLLATE utf8mb4_unicode_ci,
  `logo_dashboard_dark_path` text COLLATE utf8mb4_unicode_ci,
  `logo_collapsed_dark_path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'assets/img/logo/magicAI-logo-collapsed-dark.svg',
  `logo_2x_path` text COLLATE utf8mb4_unicode_ci,
  `logo_dark_2x_path` text COLLATE utf8mb4_unicode_ci,
  `logo_dashboard_2x_path` text COLLATE utf8mb4_unicode_ci,
  `logo_dashboard_dark_2x_path` text COLLATE utf8mb4_unicode_ci,
  `logo_collapsed_2x_path` text COLLATE utf8mb4_unicode_ci,
  `logo_collapsed_dark_2x_path` text COLLATE utf8mb4_unicode_ci,
  `feature_ai_writer` tinyint(1) NOT NULL DEFAULT '1',
  `feature_ai_image` tinyint(1) NOT NULL DEFAULT '1',
  `feature_ai_chat` tinyint(1) NOT NULL DEFAULT '1',
  `feature_ai_code` tinyint(1) NOT NULL DEFAULT '1',
  `feature_ai_voice_clone` tinyint(1) NOT NULL DEFAULT '0',
  `feature_ai_speech_to_text` tinyint(1) NOT NULL DEFAULT '1',
  `feature_affilates` tinyint(1) NOT NULL DEFAULT '1',
  `logo_sticky` text COLLATE utf8mb4_unicode_ci,
  `logo_sticky_path` text COLLATE utf8mb4_unicode_ci,
  `logo_sticky_2x` text COLLATE utf8mb4_unicode_ci,
  `logo_sticky_2x_path` text COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci,
  `gdpr_status` tinyint(1) NOT NULL DEFAULT '0',
  `gdpr_button` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Accept',
  `gdpr_content` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'This website uses cookies to improve your web experience.',
  `menu_options` text COLLATE utf8mb4_unicode_ci,
  `privacy_enable` tinyint(1) NOT NULL DEFAULT '0',
  `privacy_enable_login` tinyint(1) NOT NULL DEFAULT '0',
  `privacy_content` text COLLATE utf8mb4_unicode_ci,
  `terms_content` text COLLATE utf8mb4_unicode_ci,
  `login_without_confirmation` tinyint(1) NOT NULL DEFAULT '1',
  `feature_ai_voiceover` tinyint(1) DEFAULT '1',
  `gcs_file` text COLLATE utf8mb4_unicode_ci,
  `gcs_name` text COLLATE utf8mb4_unicode_ci,
  `frontend_code_before_head` text COLLATE utf8mb4_unicode_ci,
  `frontend_code_before_body` text COLLATE utf8mb4_unicode_ci,
  `dashboard_code_before_head` text COLLATE utf8mb4_unicode_ci,
  `dashboard_code_before_body` text COLLATE utf8mb4_unicode_ci,
  `feature_ai_article_wizard` tinyint NOT NULL DEFAULT '1',
  `feature_ai_vision` tinyint NOT NULL DEFAULT '1',
  `feature_ai_pdf` tinyint NOT NULL DEFAULT '1',
  `feature_ai_chat_image` tinyint NOT NULL DEFAULT '1',
  `mobile_payment_active` tinyint(1) NOT NULL DEFAULT '0',
  `feature_ai_rewriter` tinyint NOT NULL DEFAULT '1',
  `feature_ai_youtube` tinyint NOT NULL DEFAULT '1',
  `feature_ai_rss` tinyint NOT NULL DEFAULT '1',
  `team_functionality` tinyint(1) NOT NULL DEFAULT '0',
  `feature_ai_advanced_editor` tinyint(1) NOT NULL DEFAULT '1',
  `user_count` int NOT NULL DEFAULT '0',
  `free_open_ai_items` json DEFAULT NULL,
  `user_api_option` tinyint NOT NULL DEFAULT '0',
  `auth_view_options` text COLLATE utf8mb4_unicode_ci,
  `tour_seen` tinyint(1) NOT NULL DEFAULT '1',
  `recaptcha_login` tinyint(1) NOT NULL DEFAULT '0',
  `recaptcha_register` tinyint(1) NOT NULL DEFAULT '0',
  `recaptcha_sitekey` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recaptcha_secretkey` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_with_otp` tinyint(1) NOT NULL DEFAULT '0',
  `synthesia_secret_key` text COLLATE utf8mb4_unicode_ci,
  `pebblely_key` text COLLATE utf8mb4_unicode_ci,
  `mrrobot_name` text COLLATE utf8mb4_unicode_ci,
  `mrrobot_search_words` text COLLATE utf8mb4_unicode_ci,
  `aimlapi_key` text COLLATE utf8mb4_unicode_ci,
  `ai_music_model` text COLLATE utf8mb4_unicode_ci,
  `x_logo` text COLLATE utf8mb4_unicode_ci,
  `xx_logo` text COLLATE utf8mb4_unicode_ci,
  `heygen_secret_key` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2',NULL,'0',NULL,NULL,'https://api.stripe.com','0',NULL,NULL,'nammoai','https://magicai.nammoai.com/',NULL,'0',NULL,'magicAI-logo.svg',NULL,NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,NULL,1,'United States','smtp.hostinger.com','587','info@nammoai.com','4A^tSdS92Sa','info@nammoai.com','Nammo AI','TLS',',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',NULL,'2026-09-13 14:46:25','assets/img/logo/magicAI-logo.svg',NULL,'gpt-4o-mini','ar-AE','Professional','0.75','300','200','10','10',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,10,'magicAI-logo-Collapsed.png','assets/img/logo/magicAI-logo-Collapsed.png','disabled','magicAI-logo-dark.svg',NULL,NULL,'magicAI-logo-collapsed-dark.svg',NULL,NULL,NULL,NULL,NULL,NULL,'assets/img/logo/magicAI-logo-dark.svg',NULL,NULL,'assets/img/logo/magicAI-logo-collapsed-dark.svg',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,1,1,1,1,NULL,NULL,NULL,NULL,NULL,0,'Accept','This website uses cookies to improve your web experience.',NULL,0,0,NULL,NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,1,0,1,1,1,1,1,0,'[\"post_title_generator\", \"summarize_text\", \"product_description\", \"article_generator\", \"product_name\", \"testimonial_review\", \"problem_agitate_solution\", \"blog_section\", \"blog_post_ideas\", \"blog_intros\", \"blog_conclusion\", \"facebook_ads\", \"youtube_video_description\", \"youtube_video_title\", \"youtube_video_tag\", \"instagram_captions\", \"instagram_hashtag\", \"social_media_post_tweet\", \"social_media_post_business\", \"facebook_headlines\", \"google_ads_headlines\", \"google_ads_description\", \"paragraph_generator\", \"pros_cons\", \"meta_description\", \"faq_generator\", \"email_generator\", \"email_answer_generator\", \"newsletter_generator\", \"grammar_correction\", \"tldr_summarization\", \"ai_image_generator\", \"custom-generation-eQao5n\", \"ai_speech_to_text\", \"ai_code_generator\", \"ai_article_wizard_generator\", \"ai_vision\", \"ai_pdf\", \"ai_chat_image\", \"ai_rewriter\", \"ai_webchat\", \"ai_video\", \"ai_voiceover\", \"ai_youtube\", \"ai_rss\", \"ai_voice_isolator\"]',0,NULL,1,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_two`
--

DROP TABLE IF EXISTS `settings_two`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings_two` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `theme` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `stable_diffusion_api_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stable_diffusion_default_model` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_recaptcha_status` tinyint(1) NOT NULL DEFAULT '0',
  `google_recaptcha_site_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_recaptcha_secret_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `languages` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  `languages_default` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `liquid_license_type` text COLLATE utf8mb4_unicode_ci,
  `liquid_license_domain_key` text COLLATE utf8mb4_unicode_ci,
  `openai_default_stream_server` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'backend',
  `ai_image_storage` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  `stablediffusion_default_language` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en-US',
  `stablediffusion_default_model` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'stable-diffusion-xl-1024-v1-0',
  `unsplash_api_key` text COLLATE utf8mb4_unicode_ci,
  `dalle` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'dall-e-3',
  `daily_limit_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `allowed_images_count` int NOT NULL DEFAULT '2',
  `daily_voice_limit_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `allowed_voice_count` int NOT NULL DEFAULT '1',
  `serper_api_key` text COLLATE utf8mb4_unicode_ci,
  `elevenlabs_api_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twilio_account_sid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twilio_auth_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_tts_google` tinyint(1) NOT NULL DEFAULT '0',
  `feature_tts_openai` tinyint(1) NOT NULL DEFAULT '1',
  `feature_tts_elevenlabs` tinyint(1) NOT NULL DEFAULT '0',
  `fine_tune_list` json DEFAULT NULL,
  `chatbot_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'disabled',
  `chatbot_template` int DEFAULT NULL,
  `chatbot_position` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'bottom-left',
  `chatbot_login_require` tinyint NOT NULL DEFAULT '1',
  `chatbot_rate_limit` int DEFAULT '10',
  `feature_ai_video` tinyint(1) NOT NULL DEFAULT '1',
  `chatbot_show_timestamp` tinyint(1) NOT NULL DEFAULT '0',
  `stablediffusion_bedrock_model` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'stability.stable-diffusion-xl-v1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_two`
--

LOCK TABLES `settings_two` WRITE;
/*!40000 ALTER TABLE `settings_two` DISABLE KEYS */;
INSERT INTO `settings_two` VALUES (1,'default',NULL,NULL,0,NULL,NULL,'en,ar','en','Extended License','322c8678-96fd-4319-b5af-04c9179561fe','backend','public','en-US','stable-diffusion-xl-1024-v1-0',NULL,'dall-e-3',0,2,0,1,NULL,NULL,NULL,NULL,0,1,0,NULL,'both',1,'bottom-left',1,10,1,1,'stability.stable-diffusion-xl-v1');
/*!40000 ALTER TABLE `settings_two` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `share_links`
--

DROP TABLE IF EXISTS `share_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `share_links` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chat` int NOT NULL,
  `message` int NOT NULL,
  `time` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `share_links`
--

LOCK TABLES `share_links` WRITE;
/*!40000 ALTER TABLE `share_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `share_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shared_credit_costs`
--

DROP TABLE IF EXISTS `shared_credit_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shared_credit_costs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `entity_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `engine_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_cost` decimal(10,4) NOT NULL,
  `quality_high_multiplier` decimal(6,2) NOT NULL DEFAULT '1.00',
  `quality_low_multiplier` decimal(6,2) NOT NULL DEFAULT '1.00',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shared_credit_costs_entity_key_unique` (`entity_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shared_credit_costs`
--

LOCK TABLES `shared_credit_costs` WRITE;
/*!40000 ALTER TABLE `shared_credit_costs` DISABLE KEYS */;
/*!40000 ALTER TABLE `shared_credit_costs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shared_credit_transactions`
--

DROP TABLE IF EXISTS `shared_credit_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shared_credit_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `entity_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `engine_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,4) NOT NULL,
  `balance_after` decimal(12,4) NOT NULL,
  `unit_cost` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `quantity` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `quality` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shared_credit_transactions_user_id_created_at_index` (`user_id`,`created_at`),
  KEY `shared_credit_transactions_user_id_action_type_index` (`user_id`,`action_type`),
  CONSTRAINT `shared_credit_transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shared_credit_transactions`
--

LOCK TABLES `shared_credit_transactions` WRITE;
/*!40000 ALTER TABLE `shared_credit_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `shared_credit_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_media_accounts`
--

DROP TABLE IF EXISTS `social_media_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_media_accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` longtext COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_media_accounts_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_media_accounts`
--

LOCK TABLES `social_media_accounts` WRITE;
/*!40000 ALTER TABLE `social_media_accounts` DISABLE KEYS */;
INSERT INTO `social_media_accounts` VALUES (1,'Linkedin','Developments in the sector','linkedin','#','<svg width=\"50\" height=\"52\" viewBox=\"0 0 50 52\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M42.4358 43.9153H35.1192V32.1428C35.1192 29.3353 35.0705 25.7228 31.3137 25.7228C27.5033 25.7228 26.9193 28.7803 26.9193 31.9403V43.9153H19.6051V19.7053H26.6297V23.0128H26.7271C28.1602 20.4978 30.8221 18.9953 33.6568 19.1028C41.0732 19.1028 42.4383 24.1153 42.4383 30.6328L42.4358 43.9153ZM11.3492 16.3953C9.00359 16.3953 7.10326 14.4428 7.10326 12.0328C7.10326 9.62284 9.00359 7.67034 11.3492 7.67034C13.6948 7.67034 15.5951 9.62284 15.5951 12.0328C15.5951 14.4428 13.6948 16.3953 11.3492 16.3953ZM15.0063 43.9153H7.68236V19.7053H15.0063V43.9153ZM46.0832 0.690341H4.00579C2.01786 0.667841 0.387613 2.30534 0.363281 4.34784V47.7578C0.387613 49.8028 2.01786 51.4403 4.00579 51.4178H46.0832C48.076 51.4428 49.7136 49.8053 49.7403 47.7578V4.34534C49.7111 2.29784 48.0736 0.660341 46.0832 0.687841\" /> </svg>',1,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(2,'Telegram','Fast instant communication','telegram','#','<svg width=\"54\" height=\"44\" viewBox=\"0 0 54 44\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M1.90766 21.6842L13.9835 25.7855L42.6529 8.25838C43.0684 8.0042 43.4942 8.56864 43.1358 8.89856L21.431 28.8769L20.6238 40.0616C20.5623 40.9125 21.5873 41.3862 22.1955 40.7881L28.8784 34.2166L41.0954 43.4649C42.4122 44.4619 44.319 43.7592 44.6743 42.1462L53.181 3.52121C53.6662 1.31777 51.5072 -0.541559 49.4001 0.265366L1.84622 18.475C0.35447 19.0463 0.395102 21.1706 1.90766 21.6842Z\" /> </svg>',1,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(3,'Behance','A wide visibility','behance','#','<svg width=\"54\" height=\"34\" viewBox=\"0 0 54 34\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M27.5018 23.0206V20.9609C27.5018 17.6598 24.8344 15.019 21.5598 15.019L22.8538 14.121C24.9665 12.695 26.234 10.2918 26.234 7.75669C26.234 5.69675 25.4155 3.84808 24.0686 2.52765C22.7481 1.18091 20.8996 0.362305 18.8397 0.362305H0.75V32.8446H17.6778C23.0914 32.8447 27.5018 28.4343 27.5018 23.0206ZM7.64256 5.74963H16.014C18.074 5.74963 19.7377 7.41337 19.7377 9.47308C19.7377 11.533 18.074 13.1968 16.014 13.1968H7.64256V5.74963ZM7.64256 27.6422V18.3201H16.3574C18.9454 18.3201 21.0317 20.4062 21.0317 22.968C21.0317 25.5559 18.9454 27.6422 16.3574 27.6422H7.64256Z\" /> <path d=\"M41.2872 8.5752C34.6851 8.5752 29.3242 14.1738 29.3242 21.0928C29.3242 28.0117 34.6851 33.6369 41.2872 33.6369C46.4368 33.6369 50.847 30.2038 52.5107 25.3973H46.7273C45.3278 28.8833 41.2872 28.3023 41.2872 28.3023C35.6886 27.8798 35.8999 22.5188 35.8999 22.5188H53.171C53.2238 22.0434 53.2503 21.5681 53.2503 21.0927C53.2503 14.1738 47.8893 8.5752 41.2872 8.5752ZM36.4017 18.3199C36.4017 15.4942 38.6992 13.1967 41.5249 13.1967C44.3769 13.1967 46.6746 15.4942 46.6746 18.3199H36.4017Z\" /> <path d=\"M34.7812 2.5625H48.2213V5.74625H34.7812V2.5625Z\" /> </svg>',1,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(4,'X','Latest news and updates','twitter','#','<svg id=\"Capa_1\" enable-background=\"new 0 0 1226.37 1226.37\" viewBox=\"0 0 1226.37 1226.37\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"m727.348 519.284 446.727-519.284h-105.86l-387.893 450.887-309.809-450.887h-357.328l468.492 681.821-468.492 544.549h105.866l409.625-476.152 327.181 476.152h357.328l-485.863-707.086zm-144.998 168.544-47.468-67.894-377.686-540.24h162.604l304.797 435.991 47.468 67.894 396.2 566.721h-162.604l-323.311-462.446z\"/><g/><g/><g/><g/><g/><g/><g/><g/><g/><g/><g/><g/><g/><g/><g/></svg>',1,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(5,'Instagram','Share your photos','instagram','#','<svg height=\"511pt\" viewBox=\"0 0 511 511.9\" width=\"511pt\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"m510.949219 150.5c-1.199219-27.199219-5.597657-45.898438-11.898438-62.101562-6.5-17.199219-16.5-32.597657-29.601562-45.398438-12.800781-13-28.300781-23.101562-45.300781-29.5-16.296876-6.300781-34.898438-10.699219-62.097657-11.898438-27.402343-1.300781-36.101562-1.601562-105.601562-1.601562s-78.199219.300781-105.5 1.5c-27.199219 1.199219-45.898438 5.601562-62.097657 11.898438-17.203124 6.5-32.601562 16.5-45.402343 29.601562-13 12.800781-23.097657 28.300781-29.5 45.300781-6.300781 16.300781-10.699219 34.898438-11.898438 62.097657-1.300781 27.402343-1.601562 36.101562-1.601562 105.601562s.300781 78.199219 1.5 105.5c1.199219 27.199219 5.601562 45.898438 11.902343 62.101562 6.5 17.199219 16.597657 32.597657 29.597657 45.398438 12.800781 13 28.300781 23.101562 45.300781 29.5 16.300781 6.300781 34.898438 10.699219 62.101562 11.898438 27.296876 1.203124 36 1.5 105.5 1.5s78.199219-.296876 105.5-1.5c27.199219-1.199219 45.898438-5.597657 62.097657-11.898438 34.402343-13.300781 61.601562-40.5 74.902343-74.898438 6.296876-16.300781 10.699219-34.902343 11.898438-62.101562 1.199219-27.300781 1.5-36 1.5-105.5s-.101562-78.199219-1.300781-105.5zm-46.097657 209c-1.101562 25-5.300781 38.5-8.800781 47.5-8.601562 22.300781-26.300781 40-48.601562 48.601562-9 3.5-22.597657 7.699219-47.5 8.796876-27 1.203124-35.097657 1.5-103.398438 1.5s-76.5-.296876-103.402343-1.5c-25-1.097657-38.5-5.296876-47.5-8.796876-11.097657-4.101562-21.199219-10.601562-29.398438-19.101562-8.5-8.300781-15-18.300781-19.101562-29.398438-3.5-9-7.699219-22.601562-8.796876-47.5-1.203124-27-1.5-35.101562-1.5-103.402343s.296876-76.5 1.5-103.398438c1.097657-25 5.296876-38.5 8.796876-47.5 4.101562-11.101562 10.601562-21.199219 19.203124-29.402343 8.296876-8.5 18.296876-15 29.398438-19.097657 9-3.5 22.601562-7.699219 47.5-8.800781 27-1.199219 35.101562-1.5 103.398438-1.5 68.402343 0 76.5.300781 103.402343 1.5 25 1.101562 38.5 5.300781 47.5 8.800781 11.097657 4.097657 21.199219 10.597657 29.398438 19.097657 8.5 8.300781 15 18.300781 19.101562 29.402343 3.5 9 7.699219 22.597657 8.800781 47.5 1.199219 27 1.5 35.097657 1.5 103.398438s-.300781 76.300781-1.5 103.300781zm0 0\"/><path d=\"m256.449219 124.5c-72.597657 0-131.5 58.898438-131.5 131.5s58.902343 131.5 131.5 131.5c72.601562 0 131.5-58.898438 131.5-131.5s-58.898438-131.5-131.5-131.5zm0 216.800781c-47.097657 0-85.300781-38.199219-85.300781-85.300781s38.203124-85.300781 85.300781-85.300781c47.101562 0 85.300781 38.199219 85.300781 85.300781s-38.199219 85.300781-85.300781 85.300781zm0 0\"/><path d=\"m423.851562 119.300781c0 16.953125-13.746093 30.699219-30.703124 30.699219-16.953126 0-30.699219-13.746094-30.699219-30.699219 0-16.957031 13.746093-30.699219 30.699219-30.699219 16.957031 0 30.703124 13.742188 30.703124 30.699219zm0 0\"/></svg>',1,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(6,'Facebook','The most popular social media','facebook','#','<svg width=\"54\" height=\"54\" viewBox=\"0 0 54 54\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M27 0C12.087 0 0 12.087 0 27C0 40.5 10.5 51 24 54V35.1H17.1V27H24V21.6C24 16.2 27.9 13.5 32.4 13.5C34.2 13.5 36 13.8 36 13.8V20.7H33.3C30.6 20.7 30 22.5 30 24V27H36L35.1 35.1H30V54C43.5 51 54 40.5 54 27C54 12.087 41.913 0 27 0Z\" /> </svg>',1,'2026-09-12 17:01:54','2026-09-12 17:01:54');
/*!40000 ALTER TABLE `social_media_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strings`
--

DROP TABLE IF EXISTS `strings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `strings` (
  `code` int unsigned NOT NULL AUTO_INCREMENT,
  `en` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `ar` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `da` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `de` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `el` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `es` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `fr` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `id` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `it` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `nl` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `pt_BR` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `sv` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `th` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `edit` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2560 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strings`
--

LOCK TABLES `strings` WRITE;
/*!40000 ALTER TABLE `strings` DISABLE KEYS */;
INSERT INTO `strings` VALUES (1,'(Cheapest &amp; Fastest)',NULL,NULL,'(Billigste und schnellste)','(Το φθηνότερο και το πιο γρήγορο)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(2,'(Default Language)',NULL,NULL,'(Standardsprache)','(Προεπιλεγμένη γλώσσα)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(3,'(Most Expensive &amp; Most Capable)',NULL,NULL,'(Teuerster und fähigster)','(Το πιο ακριβό και το πιο ικανό)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(4,'(New)',NULL,NULL,'(Neu)','(Νέος)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(5,'(Only jpg, png, webp will be accepted)',NULL,NULL,'(Nur JPG, PNG, WebP wird akzeptiert)','(Μόνο jpg, png, webp θα γίνονται δεκτά)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(6,'*You can use HTML in Step Title and Bottom Line.',NULL,NULL,'*Sie können HTML im Schritttitel und Endergebnis verwenden.','*Μπορείτε να χρησιμοποιήσετε HTML σε Step Title και Bottom Line.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(7,', and I\'m',NULL,NULL,'und ich bin',', και είμαι',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(8,', and I\'m here to answer all your questions',NULL,NULL,'und ich bin hier, um alle Ihre Fragen zu beantworten',', και είμαι εδώ για να απαντήσω σε όλες τις ερωτήσεις σας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(9,'2-Factor Auth.',NULL,NULL,'2-Faktor-Auth.','2-Factor Auth.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(10,'2023 MagicAI. All images are for demo purposes.',NULL,NULL,'2023 Magicai. ','2023 MagicAI.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(11,'23 Languages',NULL,NULL,'23 Sprachen','23 Γλώσσες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(12,'30+ Languages',NULL,NULL,'30+ Sprachen','30+ Γλώσσες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(13,'30+ Templates',NULL,NULL,'30+ Vorlagen','30+ πρότυπα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(14,'3D Model',NULL,NULL,'3D -Modell','3D μοντέλο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(15,'3D Render',NULL,NULL,'3D -Renderung','3D Render',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(16,'404 Not Found',NULL,NULL,'404 nicht gefunden','404 Δεν βρέθηκε',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(17,'419 Token Missmatch',NULL,NULL,'419 Token -Mismatch','419 Αναντιστοιχία διακριτικών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(18,'500 Critical Server Error',NULL,NULL,'500 Kritischer Serverfehler','500 Κρίσιμο σφάλμα διακομιστή',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(19,'500 Server Error',NULL,NULL,'500 Serverfehler','500 Σφάλμα διακομιστή',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(20,'503 Maintenance',NULL,NULL,'503 Wartung','503 Συντήρηση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(21,'<span class=\'text-white\'>Simply explain</span> what your content is about and adjust settings according to your needs.',NULL,NULL,'<span class = \'text-White\'> Erklären Sie einfach </span>, worum es in Ihrem Inhalt Einstellungen entsprechend Ihren Anforderungen geht.','<span class=\'text-white\'>Απλώς εξηγήστε</span> τι είναι το περιεχόμενό σας και προσαρμόστε τις ρυθμίσεις ανάλογα με τις ανάγκες σας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(22,'<span class=\'text-white\'>Simply input some basic information</span> or keywords about your brand or product, and let our AI algorithms do the rest.',NULL,NULL,'<span class = \'text-White\'> Geben Sie einfach einige grundlegende Informationen </span> oder Schlüsselwörter über Ihre Marke oder Ihr Produkt ein und lassen Sie unsere AI-Algorithmen den Rest erledigen.','<span class=\'text-white\'>Απλώς εισαγάγετε ορισμένες βασικές πληροφορίες</span> ή λέξεις-κλειδιά σχετικά με την επωνυμία ή το προϊόν σας και αφήστε τους αλγόριθμους τεχνητής νοημοσύνης να κάνουν τα υπόλοιπα.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(23,'<span class=\'text-white\'>View, edit or export</span> your result with a few clicks. And you’re done!',NULL,NULL,'<span class = \'text-White\'> Ansicht, Bearbeiten oder Exportieren </span> Ihr Ergebnis mit einigen Klicks. ','<span class=\'text-white\'>Προβολή, επεξεργασία ή εξαγωγή</span> του αποτελέσματός σας με μερικά κλικ.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(24,'<strong>Safe Payment:</strong> Use Stripe or Credit Card.',NULL,NULL,'<strong> Sichere Zahlung: </strong> Stripe oder Kreditkarte verwenden.','<strong>Ασφαλής πληρωμή:</strong> Χρησιμοποιήστε Stripe ή πιστωτική κάρτα.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(25,'<strong>Safe Payment:</strong> Use Stripe, ApplePay, AmazonPay, PayPal or Credit Card.',NULL,NULL,'<strong> Sichere Zahlung: </strong> Stripe, Apple Pay, Amazon Pay, PayPal oder Kreditkarte verwenden.','<strong>Ασφαλής πληρωμή:</strong> Χρησιμοποιήστε Stripe, Apple Pay, Amazon Pay, PayPal ή πιστωτική κάρτα.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(26,'<strong>They subscribe</strong> to a paid plan by using your referral link',NULL,NULL,'<strong> sie abonnieren </strong> einen kostenpflichtigen Plan, indem sie Ihren Empfehlungslink verwenden.','<strong>Γίνονται συνδρομητές</strong> σε ένα πρόγραμμα επί πληρωμή χρησιμοποιώντας τον σύνδεσμο παραπομπής σας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(27,'<strong>They subscribe</strong> to a paid plan by using your referral link.',NULL,NULL,'<strong> sie abonnieren </strong> einen kostenpflichtigen Plan, indem sie Ihren Empfehlungslink verwenden.','<strong>Γίνονται συνδρομητές</strong> σε ένα πρόγραμμα επί πληρωμή χρησιμοποιώντας τον σύνδεσμο παραπομπής σας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(28,'A description for the input',NULL,NULL,'Eine Beschreibung für die Eingabe','Περιγραφή για την εισαγωγή',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(29,'A description for the input.',NULL,NULL,'Eine Beschreibung für die Eingabe.','Περιγραφή για την εισαγωγή.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(30,'A newer version of',NULL,NULL,'Eine neuere Version von','Μια νεότερη έκδοση του',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(31,'A role for the chatbot that can define what it can help with. For example Finance Expert.',NULL,NULL,'Eine Rolle für den Chatbot, der definieren kann, was es helfen kann. ','Ένας ρόλος για το chatbot που μπορεί να καθορίσει σε τι μπορεί να βοηθήσει.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(32,'A short description about what this template do.',NULL,NULL,'Eine kurze Beschreibung darüber, was diese Vorlage tut.','Μια σύντομη περιγραφή για το τι κάνει αυτό το πρότυπο.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(33,'A short description of what this chat template can help with for SEO',NULL,NULL,'Eine kurze Beschreibung dessen, was diese Chat -Vorlage für SEO helfen kann','Μια σύντομη περιγραφή του τι μπορεί να βοηθήσει αυτό το πρότυπο συνομιλίας για το SEO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(34,'A short description of what this chat template can help with.',NULL,NULL,'Eine kurze Beschreibung dessen, worauf diese Chat -Vorlage helfen kann.','Μια σύντομη περιγραφή του σε τι μπορεί να βοηθήσει αυτό το πρότυπο συνομιλίας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(35,'A title for the template that will show in templates list and in search results',NULL,NULL,'Ein Titel für die Vorlage, die in Vorlagenliste und in Suchergebnissen angezeigt wird','Ένας τίτλος για το πρότυπο που θα εμφανίζεται στη λίστα προτύπων και στα αποτελέσματα αναζήτησης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(36,'AI',NULL,NULL,'Ai','Όλα συμπεριλαμβάνονται',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(37,'AI Article Wizard',NULL,NULL,'AI -Artikel Assistent','AI Article Wizard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(38,'AI Chat',NULL,NULL,'KI -Chat','AI Chat',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(39,'AI Chat Bot',NULL,NULL,'Ai Chat Bot','AI Chat Bot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(40,'AI Chat Template',NULL,NULL,'AI -Chat -Vorlage','Πρότυπο συνομιλίας AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(41,'AI Code',NULL,NULL,'KI -Code','Κώδικας AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(42,'AI Code Generator',NULL,NULL,'AI -Codegenerator','Γεννήτρια κώδικα AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(43,'AI Generator',NULL,NULL,'AI -Generator','Γεννήτρια AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(44,'AI Hub works great with your favorite platforms. Contact us if you can’t see your platform here. ',NULL,NULL,'AI Hub funktioniert hervorragend mit Ihren Lieblingsplattformen. ','Το AI Hub λειτουργεί εξαιρετικά με τις αγαπημένες σας πλατφόρμες.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:14','2026-09-12 20:18:14',NULL),(45,'AI Image',NULL,NULL,'KI -Bild','Εικόνα AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(46,'AI Image Generator',NULL,NULL,'AI -Bildgenerator','Γεννήτρια εικόνας AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(47,'AI Name',NULL,NULL,'KI -Name','Όνομα AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(48,'AI PDF',NULL,NULL,'AI PDF','AI PDF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(49,'AI Powered',NULL,NULL,'KI angetrieben','AI Powered',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(50,'AI Speech To Text',NULL,NULL,'KI -Rede zum Text','AI Ομιλία σε κείμενο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(51,'AI Speech to Text',NULL,NULL,'KI -Rede zum Text','AI Ομιλία σε κείμενο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(52,'AI Text Generator',NULL,NULL,'AI -Textgenerator','Γεννήτρια κειμένου AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(53,'AI Vision',NULL,NULL,'AI Vision','AI Vision',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(54,'AI Voiceover',NULL,NULL,'AI Voice -Over','AI Voiceover',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(55,'AI Writer',NULL,NULL,'KI -Schriftsteller','Συγγραφέας AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(56,'AI Writer Categories',NULL,NULL,'KI -Schriftstellerkategorien','Κατηγορίες συγγραφέων AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(57,'AI-Powered Generator',NULL,NULL,'AI-betriebener Generator','AI-Powered Generator',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(58,'APP_DEBUG',NULL,NULL,'App_debug','APP_DEBUG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(59,'APP_ENV',NULL,NULL,'App_env','APP_ENV',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(60,'APP_LOG_LEVEL',NULL,NULL,'App_log_level','APP_LOG_LEVEL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(61,'APP_STATUS',NULL,NULL,'App_status','APP_STATUS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(62,'AWS S3',NULL,NULL,'AWS S3','AWS S3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(63,'Ability to invite friends, and earn commission from their first purchase.',NULL,NULL,'Fähigkeit, Freunde einzuladen und Provision vom ersten Kauf zu verdienen.','Δυνατότητα πρόσκλησης φίλων και λήψης προμήθειας από την πρώτη τους αγορά.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(64,'Ability to understand and generate content in different languages',NULL,NULL,'Fähigkeit, Inhalte in verschiedenen Sprachen zu verstehen und zu generieren','Ικανότητα κατανόησης και δημιουργίας περιεχομένου σε διαφορετικές γλώσσες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(65,'Ability to understand and generate content in different languages.',NULL,NULL,'Fähigkeit, Inhalte in verschiedenen Sprachen zu verstehen und zu generieren.','Ικανότητα κατανόησης και δημιουργίας περιεχομένου σε διαφορετικές γλώσσες.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(66,'Accept button text',NULL,NULL,'Akzeptieren Sie den Schaltflächentext','Αποδοχή κειμένου κουμπιού',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(67,'Access',NULL,NULL,'Zugang','Πρόσβαση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(68,'Access and mage support tickets from your dashboard.',NULL,NULL,'Zugriff und Magier -Support -Tickets aus Ihrem Dashboard.','Αποκτήστε πρόσβαση και μεταφέρετε εισιτήρια υποστήριξης από τον πίνακα ελέγχου σας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(69,'Access and manage your support tickets from your dashboard.',NULL,NULL,'Greifen Sie auf Ihre Support -Tickets in Ihrem Dashboard zu und verwalten Sie ihn.','Πρόσβαση και διαχείριση των εισιτηρίων υποστήριξής σας από τον πίνακα ελέγχου σας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(70,'Access to Support Tickets from your dashboard.',NULL,NULL,'Zugriff auf Support -Tickets aus Ihrem Dashboard.','Πρόσβαση στα Εισιτήρια Υποστήριξης από τον πίνακα ελέγχου σας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(71,'Access to valuable user insight, analytics and activity.',NULL,NULL,'Zugriff auf wertvolle Benutzereinsicht, Analyse und Aktivität.','Πρόσβαση σε πολύτιμες πληροφορίες χρήστη, αναλυτικά στοιχεία και δραστηριότητα.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(72,'Accurately transcribe your recordings in just minutes. With our user-friendly interface, you can upload your files and have them transcribed in a matter of clicks.',NULL,NULL,'Überschreiben Sie Ihre Aufnahmen genau in nur wenigen Minuten. ','Μεταγράψτε με ακρίβεια τις ηχογραφήσεις σας μέσα σε λίγα λεπτά.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(73,'Action',NULL,NULL,'Aktion','Δράση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(74,'Actions',NULL,NULL,'Aktionen','Δράσεις',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(75,'Activate',NULL,NULL,'Aktivieren','Δραστηριοποιώ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(76,'Activate MagicAI',NULL,NULL,'Aktivieren Sie Magicai','Ενεργοποιήστε το MagicAI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(77,'Activate header section to view ads',NULL,NULL,'Aktivieren Sie den Header -Abschnitt, um Anzeigen anzuzeigen','Ενεργοποιήστε την ενότητα κεφαλίδας για προβολή διαφημίσεων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(78,'Activate you license',NULL,NULL,'Aktivieren Sie Ihre Lizenz','Ενεργοποιήστε την άδεια σας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(79,'Activate your license',NULL,NULL,'Aktivieren Sie Ihre Lizenz','Ενεργοποιήστε την άδειά σας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(80,'Active',NULL,NULL,'Aktiv','Ενεργός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(81,'Activity',NULL,NULL,'Aktivität','Δραστηριότητα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(82,'Ada (Cheapest &amp; Fastest)',NULL,NULL,'ADA (billigste und schnellste)','Ada (Το φθηνότερο και το πιο γρήγορο)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(83,'Add',NULL,NULL,'Hinzufügen','Προσθέτω',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(84,'Add +',NULL,NULL,'Fügen Sie +','Προσθήκη +',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(85,'Add Category',NULL,NULL,'Kategorie hinzufügen','Προσθήκη κατηγορίας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(86,'Add Image',NULL,NULL,'Bild hinzufügen','Προσθήκη εικόνας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(87,'Add Keyword',NULL,NULL,'Keyword hinzufügen','Προσθήκη λέξης-κλειδιού',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(88,'Add Menu',NULL,NULL,'Menü hinzufügen','Προσθήκη μενού',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(89,'Add More',NULL,NULL,'Fügen Sie mehr hinzu','Προσθήκη περισσότερων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(90,'Add More User Input',NULL,NULL,'Weitere Benutzereingaben hinzufügen','Προσθήκη περισσότερων στοιχείων χρήστη',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(91,'Add New',NULL,NULL,'Neu hinzuzufügen','Προσθήκη νέου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(92,'Add New Coupon',NULL,NULL,'Fügen Sie einen neuen Gutschein hinzu','Προσθήκη νέου κουπονιού',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(93,'Add New Template',NULL,NULL,'Neue Vorlage hinzufügen','Προσθήκη νέου προτύπου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(94,'Add Outline',NULL,NULL,'Gliederung hinzufügen','Προσθήκη περίγραμμα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(95,'Add Page',NULL,NULL,'Seite hinzufügen','Προσθήκη σελίδας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(96,'Add Post',NULL,NULL,'Beitrag hinzufügen','Προσθήκη ανάρτησης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(97,'Add Slug for SEO. Example: my-post',NULL,NULL,'Slug für SEO hinzufügen. ','Προσθήκη Slug για SEO.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(98,'Add Slug for SEO. Example: privaciy-policy',NULL,NULL,'Slug für SEO hinzufügen. ','Προσθήκη Slug για SEO.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(99,'Add Template',NULL,NULL,'Vorlage hinzufügen','Προσθήκη προτύπου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(100,'Add Title',NULL,NULL,'Titel hinzufügen','Προσθήκη τίτλου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(101,'Add a page title. Example: Privacy Policy.',NULL,NULL,'Fügen Sie einen Seitentitel hinzu. ','Προσθήκη τίτλου σελίδας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(102,'Add a post title.',NULL,NULL,'Fügen Sie einen Post -Titel hinzu.','Προσθέστε έναν τίτλο ανάρτησης.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(103,'Add custom prompt',NULL,NULL,'Fügen Sie benutzerdefinierte Eingabeaufforderung hinzu','Προσθήκη προσαρμοσμένης προτροπής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(104,'Add new language ↓',NULL,NULL,'Neue Sprache hinzufügen ↓','Προσθήκη νέας γλώσσας ↓',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(105,'Add new string. Ex. Hello',NULL,NULL,'Neue Zeichenfolge hinzufügen. ','Προσθήκη νέας συμβολοσειράς.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(106,'Add or Edit Category',NULL,NULL,'Kategorie hinzufügen oder bearbeiten','Προσθήκη ή επεξεργασία κατηγορίας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(107,'Add or Edit Chat Template',NULL,NULL,'Chatvorlage hinzufügen oder bearbeiten','Προσθήκη ή επεξεργασία προτύπου συνομιλίας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(108,'Add or Edit Custom Template',NULL,NULL,'Benutzerdefinierte Vorlage hinzufügen oder bearbeiten','Προσθήκη ή επεξεργασία προσαρμοσμένου προτύπου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(109,'Add or Edit Email Templates',NULL,NULL,'E -Mail -Vorlagen hinzufügen oder bearbeiten','Προσθήκη ή επεξεργασία προτύπων email',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(110,'Add or Edit Page',NULL,NULL,'Seite hinzufügen oder bearbeiten','Προσθήκη ή Επεξεργασία σελίδας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(111,'Add or Edit Post',NULL,NULL,'Beitrag hinzufügen oder bearbeiten','Προσθήκη ή επεξεργασία ανάρτησης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(112,'Add or Edit Template',NULL,NULL,'Vorlage hinzufügen oder bearbeiten','Προσθήκη ή επεξεργασία προτύπου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(113,'Add unlimited number of custom prompts for your customers.',NULL,NULL,'Fügen Sie unbegrenzte Anzahl von benutzerdefinierten Eingabeaufforderungen für Ihre Kunden hinzu.','Προσθέστε απεριόριστο αριθμό προσαρμοσμένων προτροπών για τους πελάτες σας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(114,'Additional Landing Page URL',NULL,NULL,'Zusätzliche Zielseiten -URL','Πρόσθετη διεύθυνση URL σελίδας προορισμού',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(115,'Address',NULL,NULL,'Adresse','Διεύθυνση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(116,'Admin',NULL,NULL,'Administrator','Διαχειρ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(117,'Admin Panel',NULL,NULL,'Admin -Panel','Πίνακας Διαχειριστή',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(118,'Administrator',NULL,NULL,'Administrator','Διαχειριστής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(119,'Adsense Code',NULL,NULL,'Adsense -Code','Κώδικας Adsense',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(120,'Adsense Status',NULL,NULL,'Adsense -Status','Κατάσταση Adsense',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(121,'Adsense Type',NULL,NULL,'Adsense -Typ','Τύπος Adsense',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(122,'Advanced Dashboard',NULL,NULL,'Fortgeschrittenes Dashboard','Προηγμένος πίνακας ελέγχου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(123,'Advanced Options',NULL,NULL,'Erweiterte Optionen','Προηγμένες Επιλογές',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(124,'Advanced Settings',NULL,NULL,'Erweiterte Einstellungen','Προηγμένες ρυθμίσεις',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(125,'Advertis',NULL,NULL,'Werbung','Διαφήμιση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(126,'Advertis Edit',NULL,NULL,'Werbung bearbeiten','Επεξεργασία διαφήμισης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(127,'Affilates',NULL,NULL,'Affiliates','Συνεργάτες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(128,'Affiliate',NULL,NULL,'Partner','Εισδέχομαι μέλη',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(129,'Affiliate Commission Percentage',NULL,NULL,'Anteil der Affiliate -Kommission',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(130,'Affiliate Link',NULL,NULL,'Affiliate -Link','Σύνδεσμος συνεργατών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(131,'Affiliate Minimum Withdrawal',NULL,NULL,'Affiliate Mindestentzug','Ελάχιστη Ανάληψη Συνεργατών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(132,'Affiliate Requests',NULL,NULL,'Affiliate -Anfragen','Αιτήματα συνεργατών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(133,'Affiliate Settings',NULL,NULL,'Affiliate -Einstellungen','Ρυθμίσεις συνεργατών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(134,'Affiliate System',NULL,NULL,'Affiliate -System','Σύστημα Συνεργατών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(135,'Affiliates',NULL,NULL,'Affiliates','Συνεργάτες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(136,'Affiliation',NULL,NULL,'Zugehörigkeit','Δεσμός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(137,'Afghanistan',NULL,NULL,'Afghanistan','Αφγανιστάν',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(138,'Afrikaans (South Africa)',NULL,NULL,'Afrikaans (Südafrika)','Αφρικάανς (Νότια Αφρική)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(139,'After Saving Setting, Click Here to Test Your Api Keys',NULL,NULL,'Klicken Sie nach dem Speichern der Einstellung hier, um Ihre API -Schlüssel zu testen','Μετά την αποθήκευση της ρύθμισης, κάντε κλικ εδώ για να δοκιμάσετε τα κλειδιά Api σας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(140,'After Saving Setting, Click Here to Test Your api key',NULL,NULL,'Klicken Sie nach dem Speichern der Einstellung hier, um Ihre API -Taste zu testen','Μετά την αποθήκευση της ρύθμισης, κάντε κλικ εδώ για να δοκιμάσετε το κλειδί api σας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(141,'Aggressive',NULL,NULL,'Aggressiv','Επιθετικός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(142,'Albania',NULL,NULL,'Albanien','Αλβανία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(143,'Algeria',NULL,NULL,'Algerien','Αλγερία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(144,'All',NULL,NULL,'Alle','Ολοι',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(145,'All Locations',NULL,NULL,'Alle Standorte','Όλες οι Τοποθεσίες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(146,'All Purchases',NULL,NULL,'Alle Einkäufe','Όλες οι αγορές',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(147,'All rights reserved.',NULL,NULL,'Alle Rechte vorbehalten.','Με την επιφύλαξη παντός δικαιώματος.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(148,'All-in-one platform to generate AI content and start making money in minutes.',NULL,NULL,'All-in-One-Plattform, um KI-Inhalte zu generieren und in wenigen Minuten Geld zu verdienen.','Πλατφόρμα όλα σε ένα για να δημιουργήσετε περιεχόμενο AI και να αρχίσετε να κερδίζετε χρήματα σε λίγα λεπτά.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(149,'Alloy',NULL,NULL,'Legierung','Κράμα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(150,'Already Subscribed',NULL,NULL,'Bereits abonniert','Ήδη εγγεγραμμένος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(151,'Also please note that Chat models works with ChatGPT and GPT-4 models. So if you choose below it will automatically use ChatGPT.',NULL,NULL,'Bitte beachten Sie auch, dass Chat-Modelle mit ChatGPT- und GPT-4-Modellen arbeiten. ','Σημειώστε επίσης ότι τα μοντέλα Chat λειτουργούν με μοντέλα ChatGPT και GPT-4.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(152,'Also, please do not set both identifiers identical. For instance, you can use _ent and _pac at the end of ids.',NULL,NULL,'Bitte legen Sie auch nicht beide Kennungen identisch. ','Επίσης, μην ορίζετε και τα δύο αναγνωριστικά πανομοιότυπα.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(153,'Alt',NULL,NULL,'Alt (IMG -Tag)','Alt (ετικέτα img)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(154,'Amazon Pay',NULL,NULL,'Amazon Bezahlung','Amazon Pay',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(155,'Ambient',NULL,NULL,'Ambient','Περιβάλλων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(156,'American Samoa',NULL,NULL,'Amerikaner Samoa','Αμερικανική Σαμόα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(157,'Amount',NULL,NULL,'Menge','Ποσό',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(158,'An environment name is required.',NULL,NULL,'Ein Umgebungsname ist erforderlich.','Απαιτείται όνομα περιβάλλοντος.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(159,'An error occurred while clearing the cache.',NULL,NULL,'Ein Fehler beim Löschen des Cache.','Παρουσιάστηκε σφάλμα κατά την εκκαθάριση της προσωρινής μνήμης.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(160,'An error occurred while clearing the log.',NULL,NULL,'Ein Fehler beim Löschen des Protokolls.','Παρουσιάστηκε σφάλμα κατά την εκκαθάριση του αρχείου καταγραφής.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(161,'Analog Film',NULL,NULL,'Analogfilm','Αναλογική ταινία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(162,'Analytics',NULL,NULL,'Analyse','Analytics',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(163,'Andorra',NULL,NULL,'Andorra','Ανδόρα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(164,'Android 12',NULL,NULL,'Android 12','Android 12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(165,'Angola',NULL,NULL,'Angola','Αγκόλα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(166,'Angry',NULL,NULL,'Wütend','Θυμωμένος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(167,'Anguilla',NULL,NULL,'Anguilla','Ανγκουίλα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(168,'Angular JS',NULL,NULL,'Angular JS','Angular JS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(169,'Anime',NULL,NULL,'Anime','Anime',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(170,'Annual',NULL,NULL,'Jährlich','Ετήσιος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(171,'Annual Billing',NULL,NULL,'Jährliche Abrechnung','Ετήσια χρέωση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(172,'Answer',NULL,NULL,'Antwort','Απάντηση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(173,'Antarctica',NULL,NULL,'Antarktis','Ανταρκτική',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(174,'Antigua and Barbuda',NULL,NULL,'Antigua und Barbuda','Αντίγκουα και Μπαρμπούντα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(175,'Api Key / Client Id',NULL,NULL,'API -Schlüssel / Client -ID','Κλειδί Api / Αναγνωριστικό πελάτη',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(176,'Api Secret / Secret Key',NULL,NULL,'API Secret / Secret Key','Api Secret / Secret Key',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(177,'App Debug',NULL,NULL,'App -Debugg','Εντοπισμός σφαλμάτων εφαρμογής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(178,'App Environment',NULL,NULL,'App -Umgebung','Περιβάλλον εφαρμογής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(179,'App ID / App Name',NULL,NULL,'App -ID / App -Name','Αναγνωριστικό εφαρμογής / Όνομα εφαρμογής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(180,'App Log Level',NULL,NULL,'App -Protokollebene','Επίπεδο αρχείου καταγραφής εφαρμογής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(181,'App Name',NULL,NULL,'App -Name','Όνομα εφαρμογής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(182,'App URL',NULL,NULL,'App URL','URL εφαρμογής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(183,'Application',NULL,NULL,'Anwendung','Εφαρμογή',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(184,'Application Console Output:',NULL,NULL,'Anwendungskonsolenausgabe:','Έξοδος κονσόλας εφαρμογής:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(185,'Application has been successfully installed.',NULL,NULL,'Die Anwendung wurde erfolgreich installiert.','Η εφαρμογή εγκαταστάθηκε με επιτυχία.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(186,'Application\'s database has been successfully updated.',NULL,NULL,'Die Datenbank der Anwendung wurde erfolgreich aktualisiert.','Η βάση δεδομένων της εφαρμογής ενημερώθηκε με επιτυχία.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(187,'Apply',NULL,NULL,'Anwenden','Εφαρμόζω',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(188,'Apply daily limit on image generation',NULL,NULL,'Wenden Sie die tägliche Grenze zur Bilderzeugung an','Εφαρμόστε ημερήσιο όριο στη δημιουργία εικόνων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(189,'Apply daily limit on voice generation',NULL,NULL,'Wenden Sie die tägliche Begrenzung der Sprachgenerierung an','Εφαρμόστε ημερήσιο όριο για τη δημιουργία φωνής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(190,'Arabic',NULL,NULL,'Arabisch','αραβικός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(191,'Archived Plan',NULL,NULL,'Archiviertes Plan','Αρχειοθετημένο σχέδιο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(192,'Are you sure you want to change default language?',NULL,NULL,'Sind Sie sicher, dass Sie die Standardsprache ändern möchten?','Είστε βέβαιοι ότι θέλετε να αλλάξετε την προεπιλεγμένη γλώσσα;',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(193,'Are you sure you want to clear the cache?',NULL,NULL,'Sind Sie sicher, dass Sie den Cache löschen möchten?','Είστε βέβαιοι ότι θέλετε να διαγράψετε την προσωρινή μνήμη;',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(194,'Are you sure you want to clear the log?',NULL,NULL,'Sind Sie sicher, dass Sie das Protokoll löschen möchten?','Είστε βέβαιοι ότι θέλετε να διαγράψετε το αρχείο καταγραφής;',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(195,'Are you sure you want to create a new language?',NULL,NULL,'Sind Sie sicher, dass Sie eine neue Sprache erstellen möchten?','Είστε βέβαιοι ότι θέλετε να δημιουργήσετε μια νέα γλώσσα;',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(196,'Are you sure? This is permanent and will delete all documents related to user.',NULL,NULL,'Bist du sicher? ','Είσαι σίγουρος;',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(197,'Are you sure? This is permanent.',NULL,NULL,'Bist du sicher? ','Είσαι σίγουρος;',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(198,'Argentina',NULL,NULL,'Argentinien','Αργεντίνη',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(199,'Armenia',NULL,NULL,'Armenien','Αρμενία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(200,'Art Style',NULL,NULL,'Kunststil','Στυλ Τέχνης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(201,'Article Wizard',NULL,NULL,'Artikel -Assistent','Οδηγός άρθρου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(202,'Aruba',NULL,NULL,'Aruba','Αρούμπα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(203,'Assign the role to the AI. You are a Finance Expert.',NULL,NULL,'Weisen Sie der KI die Rolle zu. ','Αναθέστε το ρόλο στο AI.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(204,'Australia',NULL,NULL,'Australien','Αυστραλία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(205,'Austria',NULL,NULL,'Österreich','Αυστρία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(206,'Author',NULL,NULL,'Autor','Συγγραφέας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(207,'Auto Generate',NULL,NULL,'Automatisch erzeugen','Αυτόματη δημιουργία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(208,'Automated Text',NULL,NULL,'Automatisierter Text','Αυτοματοποιημένο κείμενο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(209,'Available Languages',NULL,NULL,'Verfügbare Sprachen','Διαθέσιμες γλώσσες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(210,'Avatar',NULL,NULL,'Avatar','Avatar',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(211,'Avatar will shown in chat page.',NULL,NULL,'Avatar wird auf der Chat -Seite angezeigt.','Το Avatar θα εμφανίζεται στη σελίδα συνομιλίας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(212,'Average',NULL,NULL,'Durchschnitt','Μέσος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(213,'Azerbaijan',NULL,NULL,'Aserbaidschan','Αζερμπαϊτζάν',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(214,'Azerbaijani (Azerbaijan)',NULL,NULL,'Aserbaidschani (Aserbaidschan)','Αζερμπαϊτζάν (Αζερμπαϊτζάν)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(215,'Babbage',NULL,NULL,'Babbage','Μπαμπάτζ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(216,'Back',NULL,NULL,'Zurück','Πίσω',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(217,'Back to All Templates',NULL,NULL,'Zurück zu allen Vorlagen','Επιστροφή σε όλα τα πρότυπα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(218,'Back to Clients',NULL,NULL,'Zurück zu Kunden','Επιστροφή στους πελάτες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(219,'Back to Home',NULL,NULL,'Zurück zu Hause','Επιστροφή στο σπίτι',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(220,'Back to How it Works',NULL,NULL,'Zurück zu der Funktionsweise','Επιστροφή στο Πώς λειτουργεί',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(221,'Back to Manage Plans',NULL,NULL,'Zurück, um Pläne zu verwalten','Επιστροφή στη Διαχείριση σχεδίων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(222,'Back to Payment Gateways',NULL,NULL,'Zurück zu den Zahlungsgateways','Επιστροφή στις Πύλες πληρωμών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(223,'Back to Testimonials',NULL,NULL,'Zurück zu Testimonials','Επιστροφή στις Μαρτυρίες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(224,'Back to User Management',NULL,NULL,'Zurück zur Benutzerverwaltung','Επιστροφή στη Διαχείριση χρηστών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(225,'Back to dashboard',NULL,NULL,'Zurück zum Dashboard','Επιστροφή στον πίνακα ελέγχου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(226,'Back to site health',NULL,NULL,'Zurück zur Gesundheit der Website','Επιστροφή στην υγεία του ιστότοπου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(227,'Backend',NULL,NULL,'Backend','Backend',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(228,'Backlight',NULL,NULL,'Hintergrundbeleuchtung','Οπίσθιος φωτισμός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(229,'Bahamas',NULL,NULL,'Bahamas','Μπαχάμες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(230,'Bahrain',NULL,NULL,'Bahrain','Μπαχρέιν',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(231,'Balance',NULL,NULL,'Gleichgewicht','Ισορροπία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(232,'Ballpoint Pen Drawing',NULL,NULL,'Kugelschreiberzeichnung','Σχέδιο με στυλό',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(233,'Bangladesh',NULL,NULL,'Bangladesch','Μπαγκλαντές',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(234,'Bank Information',NULL,NULL,'Bankinformationen','Τραπεζικές Πληροφορίες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(235,'Bank of America - 2382372329 3843749 2372379',NULL,NULL,'Bank of America - 2382372329 3843749 2372379','Bank of America - 2382372329 3843749 2372379',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(236,'Barbados',NULL,NULL,'Barbados','Μπαρμπάντος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(237,'Base URL',NULL,NULL,'Basis -URL','Βασική διεύθυνση URL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(238,'Basque',NULL,NULL,'baskisch','Βάσκος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(239,'Basque (Spain)',NULL,NULL,'Baske (Spanien)','Βάσκα (Ισπανία)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(240,'Bauhaus',NULL,NULL,'Bauhaus','Μπάουχαους',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(241,'Belarus',NULL,NULL,'Weißrussland','Λευκορωσία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(242,'Belgium',NULL,NULL,'Belgien','Βέλγιο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(243,'Belize',NULL,NULL,'Belize','Μπελίζ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(244,'Benin',NULL,NULL,'Benin','Μπενίν',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(245,'Bermuda',NULL,NULL,'Bermuda','Βερμούδα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(246,'Beware of that order is important. First set mode then save gateway settings.',NULL,NULL,'Achten Sie darauf, dass diese Reihenfolge wichtig ist. ','Προσέξτε ότι η σειρά είναι σημαντική.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(247,'Bhutan',NULL,NULL,'Bhutan','Μπουτάν',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(248,'Billing Settings',NULL,NULL,'Abrechnungseinstellungen','Ρυθμίσεις χρέωσης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(249,'Blog',NULL,NULL,'Blog','Ιστολόγιο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(250,'Blog Active',NULL,NULL,'Blog aktiv','Ενεργό ιστολόγιο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(251,'Blog Archive Options',NULL,NULL,'Blog -Archivoptionen','Επιλογές αρχείου ιστολογίου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(252,'Blog Button Text',NULL,NULL,'Blog -Schaltfläche Text','Κείμενο κουμπιού ιστολογίου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(253,'Blog Description',NULL,NULL,'Blogbeschreibung','Περιγραφή ιστολογίου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(254,'Blog Post',NULL,NULL,'Blog -Beitrag','Ανάρτηση ιστολογίου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(255,'Blog Post Length',NULL,NULL,'Blog -Postlänge','Μήκος ανάρτησης ιστολογίου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(256,'Blog Posts',NULL,NULL,'Blog -Beiträge','Αναρτήσεις ιστολογίου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(257,'Blog Posts Per Page',NULL,NULL,'Blog -Beiträge pro Seite','Αναρτήσεις ιστολογίου ανά σελίδα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(258,'Blog Section',NULL,NULL,'Blog -Abschnitt','Ενότητα ιστολογίου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(259,'Blog Subtitle',NULL,NULL,'Blog -Untertitel','Υπότιτλος ιστολογίου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(260,'Blog Title',NULL,NULL,'Blog -Titel','Τίτλος ιστολογίου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(261,'Blue Hour',NULL,NULL,'Blaue Stunde','Μπλε Ώρα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(262,'Bold',NULL,NULL,'Deutlich','Τολμηρός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(263,'Bolivia',NULL,NULL,'Bolivien','Βολιβία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(264,'Boring',NULL,NULL,'Langweilig','Ανιαρός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(265,'Bosnia and Herzegovina',NULL,NULL,'Bosnien und Herzegowina','Βοσνία-Ερζεγοβίνη',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(266,'Botswana',NULL,NULL,'Botswana','Μποτσουάνα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(267,'Bottom Line Settings',NULL,NULL,'Faziteinstellungen','Ρυθμίσεις κατώτατης γραμμής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(268,'Bouvet Island',NULL,NULL,'Bouvet Island','Νησί Μπουβέ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(269,'Brazil',NULL,NULL,'Brasilien','Βραζιλία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(270,'Bright',NULL,NULL,'Hell','Ευφυής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(271,'British Indian Ocean Territory',NULL,NULL,'Gebiet des britischen Indischen Ozeans','Βρετανική επικράτεια Ινδικού Ωκεανού',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(272,'Broadcast Driver',NULL,NULL,'Rundfunkfahrer','Πρόγραμμα οδήγησης εκπομπής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(273,'Broadcasting, Caching, Session, &amp; Queue',NULL,NULL,'Rundfunk, Caching, Sitzung und Warteschlange','Μετάδοση, προσωρινή αποθήκευση, περίοδος λειτουργίας και ουρά',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(274,'Browse all features or ',NULL,NULL,'Alle Funktionen durchsuchen oder','Περιηγηθείτε σε όλες τις δυνατότητες ή',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(275,'Browse all features or visit the product page.',NULL,NULL,'Durchsuchen Sie alle Funktionen oder besuchen Sie die Produktseite.','Περιηγηθείτε σε όλες τις λειτουργίες ή επισκεφτείτε τη σελίδα του προϊόντος.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(276,'Browse prompt library',NULL,NULL,'Durchsuchen Sie die Umlaufbibliothek','Περιήγηση στη βιβλιοθήκη προτροπής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(277,'Brunei Darussalam',NULL,NULL,'Brunei Darussalam','Μπρουνέι Νταρουσαλάμ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(278,'Built-in Templates',NULL,NULL,'Eingebaute Vorlagen','Ενσωματωμένα Πρότυπα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(279,'Bulgaria',NULL,NULL,'Bulgarien','Βουλγαρία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(280,'Bulgarian',NULL,NULL,'bulgarisch','Βούλγαρος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(281,'Bulgarian (Bulgaria)',NULL,NULL,'Bulgarisch (Bulgarien)','Βουλγαρικά (Βουλγαρία)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(282,'Burkina Faso',NULL,NULL,'Burkina Faso','Μπουρκίνα Φάσο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(283,'Burundi',NULL,NULL,'Burundi','Μπουρούντι',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(284,'Button',NULL,NULL,'Taste','Κουμπί',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(285,'Buy',NULL,NULL,'Kaufen','Αγορά',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(286,'Buy on Envato',NULL,NULL,'Kaufen Sie auf Envato','Αγορά στο Envato',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(287,'By proceeding, you acknowledge and accept our',NULL,NULL,'Durch Verfahren bestätigen und akzeptieren Sie unsere','Προχωρώντας, αναγνωρίζετε και αποδέχεστε τη δική μας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(288,'By purchase you confirm our',NULL,NULL,'Durch den Kauf bestätigen Sie unsere','Με την αγορά μας επιβεβαιώνετε',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(289,'By purchasing you confirm our',NULL,NULL,'Durch den Kauf bestätigen Sie unsere',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(290,'COMPANY',NULL,NULL,'UNTERNEHMEN','ΕΤΑΙΡΕΙΑ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(291,'Cache Driver',NULL,NULL,'Cache -Treiber','Πρόγραμμα οδήγησης προσωρινής μνήμης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(292,'Calm',NULL,NULL,'Ruhig','Ηρεμία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(293,'Cambodia',NULL,NULL,'Kambodscha','Καμπότζη',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(294,'Cameroon',NULL,NULL,'Kamerun','Καμερούν',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(295,'Can AI copywriting be customized to my brand and audience?',NULL,NULL,'Kann AI Copywriting an meine Marke und mein Publikum angepasst werden?','Μπορεί το copywriting AI να προσαρμοστεί στην επωνυμία και το κοινό μου;',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(296,'Can Create AI Images',NULL,NULL,'Kann KI -Bilder erstellen','Μπορεί να δημιουργήσει εικόνες AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(297,'Canada',NULL,NULL,'Kanada','Καναδάς',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(298,'Cancel',NULL,NULL,'Stornieren','Ματαίωση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(299,'Cancel My Plan',NULL,NULL,'Meinen Plan stornieren','Ακύρωση του σχεδίου μου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(300,'Cancel Subscription',NULL,NULL,'Abonnement abbrechen','Ακύρωση συνδρομής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(301,'Cancel all old subscriptions. Acquired amounts do not reset.',NULL,NULL,'Absögen Sie alle alten Abonnements. ','Ακυρώστε όλες τις παλιές συνδρομές.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(302,'Cannot access premium plan',NULL,NULL,'Kann keinen Zugriff auf einen Premium -Plan haben','Δεν είναι δυνατή η πρόσβαση στο πρόγραμμα premium',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(303,'Can’t see your favorite platform? Let us know by submitting a ticket.',NULL,NULL,'Sie können Ihre Lieblingsplattform nicht sehen? ','Δεν μπορείτε να δείτε την αγαπημένη σας πλατφόρμα;',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(304,'Cape Verde',NULL,NULL,'Kap Verde','Πράσινο Ακρωτήριο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(305,'Card Holder Name',NULL,NULL,'Name des Karteninhabers','Όνομα κατόχου κάρτας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(306,'Card Information',NULL,NULL,'Karteninformationen','Πληροφορίες κάρτας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(307,'Cartoon',NULL,NULL,'Karikatur','Κινούμενα σχέδια',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(308,'Casual',NULL,NULL,'Lässig','Ανέμελος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(309,'Catalan',NULL,NULL,'katalanisch','καταλανικά',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(310,'Catalan (Spain) ',NULL,NULL,'Katalanisch (Spanien)','Καταλανικά (Ισπανία)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(311,'Categories of the post. Useful for filtering in the blog posts.',NULL,NULL,'Kategorien des Beitrags. ','Κατηγορίες ανάρτησης.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(312,'Categories of the template. Useful for filtering in the templates list.',NULL,NULL,'Kategorien der Vorlage. ','Κατηγορίες του προτύπου.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(313,'Category',NULL,NULL,'Kategorie','Κατηγορία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(314,'Category Name',NULL,NULL,'Kategorienname','Όνομα κατηγορίας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(315,'Category name for Custom AI Writers',NULL,NULL,'Kategorie Name für benutzerdefinierte KI -Autoren','Όνομα κατηγορίας για προσαρμοσμένα AI Writers',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(316,'Cayman Islands',NULL,NULL,'Cayman -Inseln','Νησιά Κέιμαν',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(317,'Central African Republic',NULL,NULL,'Zentralafrikanische Republik','Κεντροαφρικανική Δημοκρατία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(318,'Chad',NULL,NULL,'Tschad','Τσαντ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(319,'Change Password',NULL,NULL,'Kennwort ändern','Αλλαγή κωδικού πρόσβασης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(320,'Change Plan',NULL,NULL,'Planungsplan','Αλλαγή σχεδίου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(321,'Change-log',NULL,NULL,'Wechseln','Αλλαγή-ημερολόγιο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(322,'Changelog',NULL,NULL,'Changelog','Καταγραφή αλλαγών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(323,'Chat',NULL,NULL,'Chat','Κουβέντα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(324,'Chat Categories',NULL,NULL,'Chat -Kategorien','Κατηγορίες συνομιλιών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(325,'Chat Image',NULL,NULL,'Chat -Bild','Εικόνα συνομιλίας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(326,'Chat PDF',NULL,NULL,'Chat PDF','Συνομιλία PDF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(327,'Chat Templates',NULL,NULL,'Chat -Vorlagen','Πρότυπα συνομιλίας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(328,'Chat models take a list of messages as input and return a model-generated message as output. Although the chat format is designed to make multi-turn conversations easy, it’s just as useful for single-turn tasks without any conversation. Add your custom JSON data.',NULL,NULL,'Chat-Modelle nehmen eine Liste von Nachrichten als Eingabe auf und geben eine von Modell generierte Nachricht als Ausgabe zurück. ','Τα μοντέλα συνομιλίας λαμβάνουν μια λίστα μηνυμάτων ως είσοδο και επιστρέφουν ένα μήνυμα που δημιουργείται από το μοντέλο ως έξοδο.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(329,'Chat, Solve, Repeat.',NULL,NULL,'Chat, lösen, wiederholen.','Συνομιλία, Λύση, Επανάληψη.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(330,'ChatGPT (Most Expensive & Fastest & Most Capable)',NULL,NULL,'CHATGPT (teuerster und schnellster und fähigster)','ChatGPT (Το πιο ακριβό, το πιο γρήγορο και το πιο ικανό)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(331,'ChatGPT, AI Writer, AI Image Generator, AI Chat',NULL,NULL,'Chatgpt, KI -Schriftsteller, KI -Bildgenerator, AI -Chat','ChatGPT, AI Writer, AI Image Generator, AI Chat',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(332,'ChatGPT-4 (Most Expensive & Fastest & Most Capable)',NULL,NULL,'CHATGPT-4 (teuer und am schnellsten und am fähigsten)','ChatGPT-4 (Το πιο ακριβό, το πιο γρήγορο και το πιο ικανό)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(333,'ChatGTP (3.5-turbo-16k)',NULL,NULL,'CHATGTP (3,5-Turbo-16K)','ChatGTP (3,5-turbo-16k)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(334,'Chatbot Training',NULL,NULL,'Chatbot -Training','Εκπαίδευση Chatbot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(335,'Check Permissions',NULL,NULL,'Berechtigungen überprüfen','Ελέγξτε τα δικαιώματα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(336,'Check Requirements',NULL,NULL,'Anforderungen überprüfen','Ελέγξτε τις απαιτήσεις',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(337,'Check all membership plans for this gateway.',NULL,NULL,'Überprüfen Sie alle Mitgliedschaftspläne für dieses Tor.','Ελέγξτε όλα τα σχέδια συνδρομής για αυτήν την πύλη.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(338,'Check all subscriptions for this plan.',NULL,NULL,'Überprüfen Sie alle Abonnements für diesen Plan.','Ελέγξτε όλες τις συνδρομές για αυτό το πρόγραμμα.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(339,'Check documentations',NULL,NULL,'Überprüfen Sie die Dokumentationen','Ελέγξτε τα έγγραφα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(340,'Check our documentation.',NULL,NULL,'Überprüfen Sie unsere Dokumentation.','Ελέγξτε την τεκμηρίωσή μας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(341,'Check the documentation.',NULL,NULL,'Überprüfen Sie die Dokumentation.','Ελέγξτε την τεκμηρίωση.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(342,'Cheerful',NULL,NULL,'Heiter','Χαρούμενος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(343,'Chile',NULL,NULL,'Chile','χιλή',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(344,'Chilling',NULL,NULL,'Chillen','Ψυχρός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(345,'China',NULL,NULL,'China','Κίνα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(346,'Chinese (Hong Kong)',NULL,NULL,'Chinesisch (Hongkong)','Κινέζικα (Χονγκ Κονγκ)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(347,'Chinese (Mandarin)',NULL,NULL,'Chinesisch (Mandarin)','κινέζικα (μανταρίνια)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(348,'Chinese (Simplified)',NULL,NULL,'Chinesisch (vereinfacht)','Κινεζικά (Απλοποιημένα)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(349,'Chinese (Traditional)',NULL,NULL,'Chinesisch (traditionell)','Κινέζικα (Παραδοσιακά)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(350,'Choose a Title',NULL,NULL,'Wählen Sie einen Titel','Επιλέξτε έναν τίτλο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(351,'Choose a pre-defined prompt or create your own template.',NULL,NULL,'Wählen Sie eine vordefinierte Eingabeaufforderung oder erstellen Sie Ihre eigene Vorlage.','Επιλέξτε μια προκαθορισμένη προτροπή ή δημιουργήστε το δικό σας πρότυπο.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(352,'Choose pack',NULL,NULL,'Wählen Sie Pack','Επιλέξτε πακέτο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(353,'Choose package type for which plans accessible.',NULL,NULL,'Wählen Sie Paketyp, für die Pläne zugänglich sind.','Επιλέξτε τον τύπο πακέτου για τα προγράμματα που είναι προσβάσιμα.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(354,'Choose plan',NULL,NULL,'Wählen Sie Plan','Επιλέξτε σχέδιο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(355,'Choose your enviroment:',NULL,NULL,'Wählen Sie Ihre Umgebung:','Επιλέξτε το περιβάλλον σας:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(356,'Christmas Island',NULL,NULL,'Weihnachtsinsel','Νησί των Χριστουγέννων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(357,'Cinematic',NULL,NULL,'Film','Κινηματικός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(358,'City',NULL,NULL,'Stadt','Πόλη',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(359,'Cityscape at sunset in retro vector illustration',NULL,NULL,'Stadtbild bei Sonnenuntergang in Retro -Vektor -Illustration','Αστικό τοπίο στο ηλιοβασίλεμα σε ρετρό διανυσματικά εικονογράφηση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(360,'Classic Environment Editor',NULL,NULL,'Klassischer Umwelt Editor','Κλασικός επεξεργαστής περιβάλλοντος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(361,'Classic Text Editor',NULL,NULL,'Klassischer Texteditor','Κλασικός επεξεργαστής κειμένου',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(362,'Clay',NULL,NULL,'Ton','Πηλός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(363,'Clean Up Cache',NULL,NULL,'Cache aufräumen','Εκκαθάριση προσωρινής μνήμης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(364,'Clear Log File',NULL,NULL,'Protokolldatei löschen','Εκκαθάριση αρχείου καταγραφής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(365,'Click here to exit',NULL,NULL,'Klicken Sie hier, um zu beenden','Κάντε κλικ εδώ για έξοδο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(366,'Click on each item to get the dynamic data from users input.',NULL,NULL,'Klicken Sie auf jedes Element, um die dynamischen Daten von den Eingaben der Benutzer abzurufen.','Κάντε κλικ σε κάθε στοιχείο για να λάβετε τα δυναμικά δεδομένα από την εισαγωγή των χρηστών.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(367,'Client',NULL,NULL,'Kunde','Πελάτης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(368,'Clients',NULL,NULL,'Kunden','Πελάτες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(369,'Clients Section',NULL,NULL,'Kundenabschnitt','Τμήμα Πελατών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(370,'Clip Guidance Preset',NULL,NULL,'Clip Guidance Preset','Προεπιλογή καθοδήγησης κλιπ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(371,'Close',NULL,NULL,'Schließen','Κοντά',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(372,'Cocos (Keeling) Islands',NULL,NULL,'Cocos (Keeling) Inseln','Νησιά Cocos (Keeling).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(373,'Code',NULL,NULL,'Code','Κώδικας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(374,'Code before </body>',NULL,NULL,'Code vor </body>','Κωδικός πριν από </body>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(375,'Code before </body> (Dashboard)',NULL,NULL,'Code vor </body> (Dashboard)','Κωδικός πριν από </body> (Πίνακας ελέγχου)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(376,'Code before </head>',NULL,NULL,'Code vor </head>','Κωδικός πριν από </head>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(377,'Code before </head> (Dashboard)',NULL,NULL,'Code vor </head> (Dashboard)','Κωδικός πριν από </head> (Πίνακας ελέγχου)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(378,'Coding',NULL,NULL,'Codierung','Κωδικοποίηση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(379,'Cold',NULL,NULL,'Kalt','Κρύο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(380,'Colombia',NULL,NULL,'Kolumbien','Κολομβία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(381,'Color',NULL,NULL,'Farbe','Χρώμα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(382,'Color Code (Please enter like code. For example: #FFFFFF)',NULL,NULL,'Farbcode (bitte wie Code eingeben. Zum Beispiel: #ffffff)','Κωδικός χρώματος (Παρακαλώ εισάγετε τον ίδιο κωδικό. Για παράδειγμα: #FFFFFF)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(383,'Color Name',NULL,NULL,'Farbname','Όνομα χρώματος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(384,'Colorful',NULL,NULL,'Bunt','Γραφικός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(385,'Comic Book',NULL,NULL,'Comic','Κόμικ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(386,'Coming soon',NULL,NULL,'Bald kommen','Προσεχώς',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(387,'Commission Rate',NULL,NULL,'Provisionssatz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(388,'Comoros',NULL,NULL,'Komoros','Κομόρες',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(389,'Configure Environment',NULL,NULL,'Umgebung konfigurieren','Διαμόρφωση περιβάλλοντος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(390,'Confirm Your New Password',NULL,NULL,'Bestätigen Sie Ihr neues Passwort','Επιβεβαιώστε τον νέο σας κωδικό πρόσβασης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(391,'Confirm Your Password',NULL,NULL,'Bestätigen Sie Ihr Passwort','Επιβεβαιώστε τον κωδικό πρόσβασής σας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(392,'Confirmation',NULL,NULL,'Bestätigung','Επιβεβαίωση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(393,'Congo',NULL,NULL,'Kongo','Κογκό',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(394,'Congo, The Democratic Republic of The',NULL,NULL,'Kongo, die demokratische Republik der','Κονγκό, Λαϊκή Δημοκρατία του The',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(395,'Connect to Liquid Portal',NULL,NULL,'An flüssiges Portal anschließen','Συνδεθείτε στο Liquid Portal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(396,'Contact Us',NULL,NULL,'Kontaktieren Sie uns','Επικοινωνήστε μαζί μας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(397,'Contemporary',NULL,NULL,'Zeitgenössisch','Σύγχρονος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(398,'Content',NULL,NULL,'Inhalt','Περιεχόμενο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(399,'Content copied to clipboard.',NULL,NULL,'Inhalt in Zwischenablage kopiert.','Το περιεχόμενο αντιγράφηκε στο πρόχειρο.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(400,'Continue to Payment',NULL,NULL,'Fahren weiter zur Zahlung','Συνέχεια στην Πληρωμή',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(401,'Continue with',NULL,NULL,'Weiter mit','Συνεχίστε με',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(402,'Cook Islands',NULL,NULL,'Kochinseln','Νησιά Κουκ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(403,'Copied',NULL,NULL,'Kopiert','Αντιγράφηκε',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(404,'Copy',NULL,NULL,'Kopie','Αντίγραφο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(405,'Copy to clipboard',NULL,NULL,'Kopieren Sie in die Zwischenablage','Αντιγραφή στο πρόχειρο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(406,'Copyright',NULL,NULL,'Copyright','Πνευματική ιδιοκτησία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(407,'Copywriters',NULL,NULL,'Texter','Copywriters',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(408,'Cost',NULL,NULL,'Kosten','Κόστος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(409,'Cost-effective solution to generate text in seconds and increasing your conversion rate.',NULL,NULL,'Kosteneffektive Lösung, um Text in Sekunden zu generieren und Ihre Conversion-Rate zu erhöhen.','Οικονομική λύση για τη δημιουργία κειμένου σε δευτερόλεπτα και την αύξηση του ποσοστού μετατροπής.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(410,'Costa Rica',NULL,NULL,'Costa Rica','Κόστα Ρίκα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(411,'Cote D\'ivoire',NULL,NULL,'Cote d\'Ivoire','Ακτή του Ελεφαντοστού',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(412,'Could not connect to the database.',NULL,NULL,'Konnten keine Verbindung zur Datenbank herstellen.','Δεν ήταν δυνατή η σύνδεση στη βάση δεδομένων.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(413,'Country',NULL,NULL,'Land','Χώρα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(414,'Coupon Code',NULL,NULL,'Gutscheincode','Κωδικός κουπονιού',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(415,'Coupon Users',NULL,NULL,'Gutscheinbenutzer','Χρήστες κουπονιών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(416,'Coupons',NULL,NULL,'Gutscheine','Κουπόνια',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(417,'Create',NULL,NULL,'Erstellen','Δημιουργώ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(418,'Create New Client',NULL,NULL,'Neuen Kunden erstellen','Δημιουργία νέου πελάτη',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(419,'Create New Step',NULL,NULL,'Neuen Schritt erstellen','Δημιουργία νέου βήματος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(420,'Create New Subscription',NULL,NULL,'Neues Abonnement erstellen','Δημιουργία Νέας Συνδρομής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(421,'Create New Support Request',NULL,NULL,'Erstellen Sie eine neue Support -Anfrage','Δημιουργία νέου αιτήματος υποστήριξης',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(422,'Create New Testimonial',NULL,NULL,'Erstellen Sie ein neues Zeugnis','Δημιουργία νέας μαρτυρίας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(423,'Create New Token Pack',NULL,NULL,'Erstellen Sie ein neues Token -Paket','Δημιουργία νέου πακέτου διακριτικών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(424,'Create New User',NULL,NULL,'Neuen Benutzer erstellen','Δημιουργία νέου χρήστη',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(425,'Create Workbook',NULL,NULL,'Arbeitsmappe erstellen','Δημιουργία βιβλίου εργασίας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(426,'Create example input',NULL,NULL,'Beispieleingabe erstellen','Δημιουργία εισόδου παραδείγματος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(427,'Create eye-catching images and graphics.',NULL,NULL,'Erstellen Sie auffällige Bilder und Grafiken.','Δημιουργήστε εντυπωσιακές εικόνες και γραφικά.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(428,'Create high-quality newsletters that resonate with your audience.',NULL,NULL,'Erstellen Sie qualitativ hochwertige Newsletter, die mit Ihrem Publikum in Resonanz stehen.','Δημιουργήστε ενημερωτικά δελτία υψηλής ποιότητας που έχουν απήχηση στο κοινό σας.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(429,'Create your own template or use pre-made templates and examples for various content types and industries to help you get started quickly.',NULL,NULL,'Erstellen Sie Ihre eigene Vorlage oder verwenden Sie vorgefertigte Vorlagen und Beispiele für verschiedene Inhaltstypen und Branchen, um Ihnen schnell loszulegen.','Δημιουργήστε το δικό σας πρότυπο ή χρησιμοποιήστε προκατασκευασμένα πρότυπα και παραδείγματα για διάφορους τύπους περιεχομένου και βιομηχανίες για να σας βοηθήσουν να ξεκινήσετε γρήγορα.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(430,'Created At',NULL,NULL,'Erstellt at','Δημιουργήθηκε στο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(431,'Created By',NULL,NULL,'Erstellt von','Δημιουργήθηκε από',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(432,'Created Inputs',NULL,NULL,'Eingänge erstellt','Δημιουργήθηκαν είσοδοι',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(433,'Creativity',NULL,NULL,'Kreativität','Δημιουργικότητα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(434,'Credit',NULL,NULL,'Kredit','Πίστωση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(435,'Credits',NULL,NULL,'Credits','Πιστώσεις',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(436,'Critical',NULL,NULL,'Kritisch','Κρίσιμος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(437,'Croatia',NULL,NULL,'Kroatien','την Κροατία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(438,'Croatian',NULL,NULL,'kroatisch','Κροατία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(439,'Croatian (Croatia)',NULL,NULL,'Kroatisch (Kroatien)','Κροατικά (Κροατία)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(440,'Crop',NULL,NULL,'Ernte','Καλλιέργεια',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(441,'Cuba',NULL,NULL,'Kuba','Κούβα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(442,'Cubism',NULL,NULL,'Kubismus','Κυβισμός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(443,'Curie',NULL,NULL,'Curie','Μονάδα ραδιοενέργειας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(444,'Currency Locale',NULL,NULL,'Währungsgebiet','Τοπικό νόμισμα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(445,'Current plan',NULL,NULL,'Aktueller Plan','Τρέχον σχέδιο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(446,'Custom',NULL,NULL,'Brauch','Εθιμο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(447,'Custom CSS URL',NULL,NULL,'Benutzerdefinierte CSS -URL','Προσαρμοσμένη διεύθυνση URL CSS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(448,'Custom JS URL',NULL,NULL,'Custom JS URL','Προσαρμοσμένη διεύθυνση URL JS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(449,'Custom Landing Page URL',NULL,NULL,'Benutzerdefinierte Zielseite URL','URL προσαρμοσμένης σελίδας προορισμού',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(450,'Custom Prompt',NULL,NULL,'Benutzerdefinierte Eingabeaufforderung','Προσαρμοσμένη προτροπή',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(451,'Custom Templates',NULL,NULL,'Benutzerdefinierte Vorlagen','Προσαρμοσμένα πρότυπα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(452,'Custom Templates Active',NULL,NULL,'Benutzerdefinierte Vorlagen aktiv','Προσαρμοσμένα πρότυπα ενεργά',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(453,'Custom Templates Description',NULL,NULL,'Beschreibung der benutzerdefinierten Vorlagen','Περιγραφή προσαρμοσμένων προτύπων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(454,'Custom Templates Section',NULL,NULL,'Benutzerdefinierte Vorlagen','Ενότητα προσαρμοσμένων προτύπων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(455,'Custom Templates Subtitle One',NULL,NULL,'Benutzerdefinierte Vorlagen Untertitel eins','Προσαρμοσμένα Πρότυπα Υπότιτλος Ένα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(456,'Custom Templates Subtitle Two',NULL,NULL,'Benutzerdefinierte Vorlagen Untertitel zwei','Προσαρμοσμένα Πρότυπα Υπότιτλος Δύο',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(457,'Custom Templates Title',NULL,NULL,'Titel für benutzerdefinierte Vorlagen','Τίτλος προσαρμοσμένων προτύπων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(458,'Custom Templates.',NULL,NULL,'Benutzerdefinierte Vorlagen.','Προσαρμοσμένα πρότυπα.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(459,'Customer could not set',NULL,NULL,'Der Kunde konnte nicht einstellen','Ο πελάτης δεν μπόρεσε να ορίσει',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(460,'Cyberpunk',NULL,NULL,'Cyberpunk','Cyberpunk',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(461,'Cyprus',NULL,NULL,'Zypern','Κύπρος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(462,'Czech',NULL,NULL,'tschechisch','Τσέχος',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(463,'Czech (Czech Republic)',NULL,NULL,'Tschechisch (Tschechische Republik)','Τσεχία (Τσεχία)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(464,'Czech Republic',NULL,NULL,'Tschechische Republik','Τσεχική Δημοκρατία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(465,'DALL-E-2',NULL,NULL,'Dall-e-2','DALL-E-2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(466,'DALL-E-3',NULL,NULL,'Dall-e-3','DALL-E-3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(467,'DDIM',NULL,NULL,'Ddim','DDIM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(468,'DDPM',NULL,NULL,'Ddpm','DDPM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(469,'Daily Image Limit Count',NULL,NULL,'Tägliche Bildgrenzezahl','Καταμέτρηση ορίου ημερήσιων εικόνων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(470,'Daily Voice Limit Count',NULL,NULL,'Tägliche Zählgrenze für Sprachgrenze','Καταμέτρηση ορίων ημερήσιας φωνής',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(471,'Dall-E-2',NULL,NULL,'Dall-e-2','Νταλ-Ε-2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(472,'Dall-E-3',NULL,NULL,'Dall-e-3','Dall-E-3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(473,'Danish',NULL,NULL,'dänisch','δανικός',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(474,'Danish (Denmark)',NULL,NULL,'Dänisch (Dänemark)','Δανικά (Δανία)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(475,'Dark',NULL,NULL,'Dunkel','Σκοτάδι',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(476,'Dashboard',NULL,NULL,'Armaturenbrett','Ταμπλό',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(477,'Dashboard Logo',NULL,NULL,'Dashboard -Logo','Λογότυπο ταμπλό',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(478,'Dashboard Logo (Dark)',NULL,NULL,'Dashboard -Logo (dunkel)','Λογότυπο πίνακα ελέγχου (Σκούρο)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(479,'Dashboard Logo Collapsed',NULL,NULL,'Das Dashboard -Logo brach zusammen','Το λογότυπο του πίνακα ελέγχου συμπτύχθηκε',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(480,'Dashboard Logo Collapsed (Dark)',NULL,NULL,'Das Dashboard -Logo brach zusammen (dunkel)','Το λογότυπο του πίνακα ελέγχου συμπτύχθηκε (Σκοτεινό)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(481,'Database',NULL,NULL,'Datenbank','Βάση δεδομένων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(482,'Database Connection',NULL,NULL,'Datenbankverbindung','Σύνδεση βάσης δεδομένων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(483,'Database Host',NULL,NULL,'Datenbankhost','Κεντρικός υπολογιστής βάσης δεδομένων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(484,'Database Name',NULL,NULL,'Datenbankname','Όνομα βάσης δεδομένων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(485,'Database Password',NULL,NULL,'Datenbankkennwort','Κωδικός Βάσης Δεδομένων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(486,'Database Port',NULL,NULL,'Datenbankport','Λιμάνι βάσης δεδομένων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(487,'Database Setup',NULL,NULL,'Datenbank -Setup','Ρύθμιση βάσης δεδομένων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(488,'Database User Name',NULL,NULL,'Datenbank Benutzername','Όνομα χρήστη βάσης δεδομένων',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(489,'Date',NULL,NULL,'Datum','Ημερομηνία',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(490,'Davinci (Expensive &amp; Capable)',NULL,NULL,'Davinci (teuer und fähig)','Davinci (Ακριβό και ικανό)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(491,'Davinci (Most Expensive &amp; Most Capable)',NULL,NULL,'Davinci (am teuersten und am fähigsten)','Ντα Βίντσι (Πιο ακριβό και πιο ικανό)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(492,'Days Left',NULL,NULL,'Tage übrig','Μέρες που έμειναν',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(493,'Days of free trial.',NULL,NULL,'Tage freier Testversion.','Μέρες δωρεάν δοκιμής.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(494,'Days.',NULL,NULL,'Tage.','Μέρες.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(495,'Deactivate',NULL,NULL,'Deaktivieren','Απενεργοποίηση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(496,'Debug mode is enabled. If this is your production site, it is recommended to disable it.',NULL,NULL,'Der Debug -Modus ist aktiviert. ','Η λειτουργία εντοπισμού σφαλμάτων είναι ενεργοποιημένη.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(497,'Default',NULL,NULL,'Standard','Αθέτηση',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(498,'Default Country',NULL,NULL,'Standardland','Προεπιλεγμένη χώρα',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(499,'Default Creativity',NULL,NULL,'Standardkreativität',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(500,'Default Currency',NULL,NULL,'Standardwährung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(501,'Default Dall-E Model',NULL,NULL,'Standard-Dall-e-Modell',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(502,'Default Logos',NULL,NULL,'Standardlogos',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(503,'Default Openai Language',NULL,NULL,'Standard -OpenAI -Sprache',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(504,'Default Openai Model',NULL,NULL,'Standard -OpenAI -Modell',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(505,'Default Storage',NULL,NULL,'Standardspeicher',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(506,'Default Stream Server',NULL,NULL,'Standard -Stream -Server',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(507,'Default Tone of Voice',NULL,NULL,'Standardtonfall',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(508,'Default stablediffusion Language',NULL,NULL,'Standard -STIFFLE -Sprache',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(509,'Define a human name for the chatbot to give it more personality.',NULL,NULL,'Definieren Sie einen menschlichen Namen für den Chatbot, um ihm mehr Persönlichkeit zu geben.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(510,'Delete',NULL,NULL,'Löschen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(511,'Delete all files',NULL,NULL,'Alle Dateien löschen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(512,'Delicious pizza with all the toppings.',NULL,NULL,'Köstliche Pizza mit allen Belägen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(513,'Denmark',NULL,NULL,'Dänemark',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(514,'Deprecated inputs are editable now.',NULL,NULL,'Veraltete Inputs sind jetzt bearbeitbar.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(515,'Describe what this chatbot can help with. It shows when starting a conversation and the chatbot introducing itself.',NULL,NULL,'Beschreiben Sie, was dieser Chatbot helfen kann. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(516,'Description',NULL,NULL,'Beschreibung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(517,'Designer',NULL,NULL,'Designer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(518,'Designers',NULL,NULL,'Designer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(519,'Developers',NULL,NULL,'Entwickler',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(520,'Development',NULL,NULL,'Entwicklung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(521,'Digital Agencies',NULL,NULL,'Digitale Agenturen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(522,'Digital Art',NULL,NULL,'Digitale Kunst',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(523,'Digital Marketers',NULL,NULL,'Digitale Vermarkter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(524,'Disable Login Without Confirmation',NULL,NULL,'Deaktivieren Sie die Anmeldung ohne Bestätigung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(525,'Discount',NULL,NULL,'Rabatt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(526,'Discount (%)',NULL,NULL,'Rabatt (%)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(527,'Discover',NULL,NULL,'Entdecken',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(528,'Discover MagicAI',NULL,NULL,'Entdecken Sie Magicai',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(529,'Display Bottom Line',NULL,NULL,'Fazit anzeigen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(530,'Djibouti',NULL,NULL,'Dschibuti',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(531,'Do you want to delete all files inside the folder?',NULL,NULL,'Möchten Sie alle Dateien im Ordner löschen?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(532,'Do you want to delete this client? This is irreversible.',NULL,NULL,'Möchten Sie diesen Kunden löschen? ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(533,'Do you want to delete this step? This is irreversible.',NULL,NULL,'Möchten Sie diesen Schritt löschen? ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(534,'Do you want to delete this testimonial? This is irreversible.',NULL,NULL,'Möchten Sie dieses Zeugnis löschen? ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(535,'Document',NULL,NULL,'Dokumentieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(536,'Documents',NULL,NULL,'Unterlagen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(537,'Dominica',NULL,NULL,'Dominica',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(538,'Dominican Republic',NULL,NULL,'Dominikanische Republik',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(539,'Don\'t have account yet?',NULL,NULL,'Haben Sie noch kein Konto?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(540,'Done',NULL,NULL,'Erledigt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(541,'Download',NULL,NULL,'Herunterladen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(542,'Download for iOS Devices',NULL,NULL,'Laden Sie für iOS -Geräte herunter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(543,'Download html code',NULL,NULL,'Laden Sie den HTML -Code herunter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(544,'Draft',NULL,NULL,'Entwurf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(545,'Dramatic',NULL,NULL,'Dramatisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(546,'Drop your image here or browse',NULL,NULL,'Lassen Sie Ihr Bild hier fallen oder stöbern Sie',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(547,'Dutch',NULL,NULL,'Niederländisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(548,'Dutch (Belgium)',NULL,NULL,'Niederländisch (Belgien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(549,'Dutch (Netherlands)',NULL,NULL,'Niederländisch (Niederlande)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(550,'ENVIRONMENT',NULL,NULL,'UMFELD',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(551,'Earnings',NULL,NULL,'Einkommen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(552,'Easy Export',NULL,NULL,'Einfacher Export',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(553,'Easy Installation and Setup Wizard.',NULL,NULL,'Einfache Installations- und Setup -Assistenten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(554,'Easy Integration.',NULL,NULL,'Einfache Integration.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(555,'Easy to <span>use.</span>',NULL,NULL,'Einfach zu <spanning> Verwendung. </Span>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(556,'Echo',NULL,NULL,'Echo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(557,'Economic',NULL,NULL,'Wirtschaftlich',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(558,'Ecuador',NULL,NULL,'Ecuador',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(559,'Edit',NULL,NULL,'Bearbeiten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(560,'Edit Client',NULL,NULL,'Client bearbeiten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(561,'Edit Coupon',NULL,NULL,'Gutschein bearbeiten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(562,'Edit Google Adsense Code',NULL,NULL,'Bearbeiten Sie den Google Adsense -Code',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(563,'Edit Step',NULL,NULL,'Schritt bearbeiten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(564,'Edit Strings',NULL,NULL,'Saiten bearbeiten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(565,'Edit Testimonial',NULL,NULL,'Zeugnis bearbeiten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(566,'Edit default strings',NULL,NULL,'Standardketten bearbeiten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(567,'Edit your generations.',NULL,NULL,'Bearbeiten Sie Ihre Generationen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(568,'Editing Language',NULL,NULL,'Bearbeitungssprache',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(569,'Editing Main Strings',NULL,NULL,'Hauptschnüre bearbeiten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(570,'Egypt',NULL,NULL,'Ägypten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(571,'El Salvador',NULL,NULL,'El Salvador',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(572,'ElevenLabs API Key',NULL,NULL,'Elflabs api Schlüssel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(573,'Elevenlabs TTS',NULL,NULL,'ElfLabs tts',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(574,'Email',NULL,NULL,'E-Mail',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(575,'Email Address',NULL,NULL,'E-Mail-Adresse',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(576,'Email Subject',NULL,NULL,'E -Mail -Betreff',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(577,'Email Templates',NULL,NULL,'E -Mail -Vorlagen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(578,'Email address',NULL,NULL,'E-Mail-Adresse',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(579,'Enable GDPR Alert Box',NULL,NULL,'Aktivieren Sie die DSGVO -Warnungsbox',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(580,'Enable Gateway',NULL,NULL,'Gateway aktivieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(581,'Enable Privacy Policy and Terms',NULL,NULL,'Aktivieren Sie Datenschutzrichtlinien und -bedingungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(582,'Enable Stripe for payment',NULL,NULL,'Bezahlungsstreifen aktivieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(583,'Enable dark mode',NULL,NULL,'Dunkle Modus aktivieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(584,'Enable light mode',NULL,NULL,'Lichtmodus aktivieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(585,'Engaging and shareable social media posts, including captions and hashtags.',NULL,NULL,'Anpassende und gemeinsam genutzbare Social -Media -Beiträge, einschließlich Bildunterschriften und Hashtags.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(586,'English',NULL,NULL,'Englisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(587,'English (Australia)',NULL,NULL,'Englisch (Australien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(588,'English (India)',NULL,NULL,'Englisch (Indien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(589,'English (UK)',NULL,NULL,'Englisch (Großbritannien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(590,'English (US)',NULL,NULL,'Englisch (uns)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(591,'English (USA)',NULL,NULL,'Englisch (USA)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(592,'Enhance',NULL,NULL,'Erweitern',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(593,'Enter -1 for unlimited usage.',NULL,NULL,'Geben Sie -1 für unbegrenzte Verwendung ein.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(594,'Enter Description Here',NULL,NULL,'Geben Sie hier eine Beschreibung ein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(595,'Enter Name Here',NULL,NULL,'Geben Sie hier den Namen ein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(596,'Enter your email address',NULL,NULL,'Geben Sie Ihre E -Mail -Adresse ein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(597,'Enter your environment...',NULL,NULL,'Geben Sie Ihre Umgebung ein ...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(598,'Enterpreneurs',NULL,NULL,'Unternehmer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(599,'Enterprise',NULL,NULL,'Unternehmen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(600,'Entrepreneurs',NULL,NULL,'Unternehmer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(601,'Environment',NULL,NULL,'Umfeld',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(602,'Environment Settings',NULL,NULL,'Umgebungseinstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(603,'Equatorial Guinea',NULL,NULL,'Äquatorialguinea',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(604,'Eritrea',NULL,NULL,'Eritrea',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(605,'Error Code',NULL,NULL,'Fehlercode',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(606,'Error deleting folder:',NULL,NULL,'Fehler löschen Ordner:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(607,'Error updating folder name:',NULL,NULL,'Fehleraktualisierungsordner Name:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(608,'Estonia',NULL,NULL,'Estland',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(609,'Estonian',NULL,NULL,'estnisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(610,'Estonian (Estonia)',NULL,NULL,'Estnisch (Estland)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(611,'Ethiopia',NULL,NULL,'Äthiopien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(612,'Excited',NULL,NULL,'Aufgeregt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(613,'Explain Your Image(Optional)',NULL,NULL,'Erklären Sie Ihr Bild (optional)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(614,'Explain an Image',NULL,NULL,'Erklären Sie ein Bild',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(615,'Explain your idea',NULL,NULL,'Erklären Sie Ihre Idee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(616,'Explore MagicAI',NULL,NULL,'Erforschen Sie Magicai',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(617,'Export generated content as plain text, PDF, Word or HTML easily.',NULL,NULL,'Exportierte Inhalte generierte Inhalte leicht als einfacher Text, PDF, Word oder HTML.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(618,'Export generated copy as plain  text, PDF, Word, CSV or HTML.',NULL,NULL,'Export generierte Kopie als einfacher Text, PDF, Wort, CSV oder HTML.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(619,'Extensions',NULL,NULL,'Erweiterungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(620,'F.A.Q',NULL,NULL,'F.A.Q',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(621,'FAQ',NULL,NULL,'FAQ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(622,'FAQ Active',NULL,NULL,'FAQ aktiv',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(623,'FAQ Section',NULL,NULL,'FAQ -Abschnitt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(624,'FAQ Subtitle',NULL,NULL,'FAQ -Untertitel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(625,'FAQ Text One',NULL,NULL,'FAQ -Text eins',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(626,'FAQ Text Two',NULL,NULL,'FAQ -Text zwei',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(627,'FAQ Title',NULL,NULL,'FAQ -Titel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(628,'FAST BLUE',NULL,NULL,'Schnell blau',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(629,'FAST GREEN',NULL,NULL,'Schnell grün',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(630,'FREE UPDATE',NULL,NULL,'Kostenloses Update',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(631,'Fable',NULL,NULL,'Fabel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(632,'Facebook',NULL,NULL,'Facebook',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(633,'Failed to calculate. Your server configuration is preventing this feature from being calculated.',NULL,NULL,'Nicht berechnet. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(634,'Falkland Islands (Malvinas',NULL,NULL,'Falklandinseln (Malvinas)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(635,'Falkland Islands (Malvinas)',NULL,NULL,'Falklandinseln (Malvinas)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(636,'False',NULL,NULL,'FALSCH',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(637,'Fantasy Art',NULL,NULL,'Fantasy -Kunst',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(638,'Faroe Islands',NULL,NULL,'Färöer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(639,'Fast',NULL,NULL,'Schnell',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(640,'Favorite Generator List',NULL,NULL,'Lieblings -Generatorliste',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(641,'Favorite Templates',NULL,NULL,'Lieblingsvorlagen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(642,'Favorites',NULL,NULL,'Favoriten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(643,'Favourites',NULL,NULL,'Favoriten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(644,'Featured Plan',NULL,NULL,'Vorgestellter Plan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(645,'Features',NULL,NULL,'Merkmale',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(646,'Features (Comma Seperated)',NULL,NULL,'Merkmale (Komma getrennt)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(647,'Features Description',NULL,NULL,'Funktionen Beschreibung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(648,'Features Section',NULL,NULL,'Features Abschnitt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(649,'Features Section Active',NULL,NULL,'Features Abschnitt aktiv',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(650,'Features Title',NULL,NULL,'Features Titel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(651,'Feedback',NULL,NULL,'Rückmeldung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(652,'Female',NULL,NULL,'Weiblich',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(653,'Feminine',NULL,NULL,'Feminin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(654,'Fiji',NULL,NULL,'Fidschi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(655,'File',NULL,NULL,'Datei',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(656,'Filipino (Philippines)',NULL,NULL,'Filipino (Philippinen)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(657,'Fill an example',NULL,NULL,'Füllen Sie ein Beispiel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(658,'Filter strings...',NULL,NULL,'Filterketten ...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(659,'Final .env File:',NULL,NULL,'Finale .Env -Datei:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(660,'Finance',NULL,NULL,'Finanzen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(661,'Finished',NULL,NULL,'Fertig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(662,'Finland',NULL,NULL,'Finnland',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(663,'Finnish',NULL,NULL,'finnisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(664,'Finnish (Finland)',NULL,NULL,'Finnisch (Finnland)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(665,'Firefox',NULL,NULL,'Firefox',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(666,'Fix. Improve. Generate.',NULL,NULL,'Fix. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(667,'Flexible Pricing.',NULL,NULL,'Flexible Preisgestaltung.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(668,'Flexible and affording plans tailored to your needs. Save up to %20 for a limited time.',NULL,NULL,'Flexible und lieferende Pläne, die auf Ihre Bedürfnisse zugeschnitten sind. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(669,'Floating Button',NULL,NULL,'Schwimmender Knopf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(670,'Floating Button Bold Text',NULL,NULL,'Floatierende Schaltfläche Fettdrucker Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(671,'Floating Button Small Text',NULL,NULL,'Schwebende Schaltfläche kleiner Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(672,'Floating Button URL',NULL,NULL,'Schwebende Knopf -URL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(673,'Foggy',NULL,NULL,'Nebelig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(674,'Follow Us on Twitter',NULL,NULL,'Folgen Sie uns auf Twitter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(675,'Footer Button Text',NULL,NULL,'Fußzeile Schaltfläche Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(676,'Footer Button URL (Please enter full url)',NULL,NULL,'URL der Fußzeile Taste (Bitte geben Sie die vollständige URL ein)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(677,'Footer Copyright',NULL,NULL,'Fußzeile Urheberrecht',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(678,'Footer Header',NULL,NULL,'Fußzeile Header',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(679,'Footer Header Small Text',NULL,NULL,'Fußzeile Header kleiner Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(680,'Footer Social Media Settings',NULL,NULL,'Social Media -Einstellungen für Fußzeile',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(681,'Footer Text',NULL,NULL,'Fußzeile Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(682,'For Who Section',NULL,NULL,'Für WHO -Abschnitt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(683,'For Who Section Active',NULL,NULL,'Denn der Abschnitt aktiv',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(684,'Forgot Password',NULL,NULL,'Passwort vergessen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(685,'Forgot Password?',NULL,NULL,'Passwort vergessen?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(686,'Form Wizard Setup',NULL,NULL,'Formular Assistent Setup',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(687,'France',NULL,NULL,'Frankreich',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(688,'Free Usage Upon Registration (words,images)',NULL,NULL,'Kostenlose Verwendung bei der Registrierung (Wörter, Bilder)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(689,'Free support, Free updates, Free plugins.',NULL,NULL,'Kostenlose Unterstützung, kostenlose Updates, kostenlose Plugins.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(690,'French',NULL,NULL,'Französisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(691,'French (Canada)',NULL,NULL,'Französisch (Kanada)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(692,'French (France)',NULL,NULL,'Französisch (Frankreich)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(693,'French Guiana',NULL,NULL,'Französische Guayana',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(694,'French Polynesia',NULL,NULL,'Französisch -Polynesien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(695,'French Southern Territories',NULL,NULL,'Französische südliche Gebiete',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(696,'From industry news and trends to product reviews and how-to guides.',NULL,NULL,'Von Branchennachrichten und Trends über Produktbewertungen und Anleitungen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(697,'From simple conversations and dialogue to more complex movie scripts.',NULL,NULL,'Von einfachen Gesprächen und Dialog bis hin zu komplexeren Drehbüchern.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(698,'From their first purchase, you will begin <strong>earning recurring commissions</strong>.',NULL,NULL,'Ab ihrem ersten Kauf beginnen Sie <strong> wiederkehrende Provisionen </strong>.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(699,'Frontend',NULL,NULL,'Frontend',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(700,'Frontend Section Settings',NULL,NULL,'Frontend -Abschnittseinstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(701,'Frontend Settings',NULL,NULL,'Frontend -Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(702,'Full API Integration',NULL,NULL,'Vollständige API -Integration',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(703,'Full Name',NULL,NULL,'Vollständiger Name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(704,'Funny',NULL,NULL,'Lustig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(705,'Future of AI Section',NULL,NULL,'Zukunft des KI -Abschnitts',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(706,'GCS File (JSON) path',NULL,NULL,'GCS -Datei (JSON) Pfad',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(707,'GCS Project Name',NULL,NULL,'GCS -Projektname',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(708,'GDPR',NULL,NULL,'GDPR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(709,'GDPR Settings',NULL,NULL,'DSGVO -Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(710,'GDPR alert text. You can use HTML tags.',NULL,NULL,'GDPR -Alarmtext. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(711,'GENERAL',NULL,NULL,'ALLGEMEIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(712,'GPT-4 Turbo (Updated Knowledge cutoff of April 2023, 128k)',NULL,NULL,'GPT-4 Turbo (aktualisierter Wissens Cutoff von April 2023, 128K)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(713,'GPT-4 Turbo with vision (Understand images, in addition to all other GPT-4 Turbo capabilities)',NULL,NULL,'GPT-4-Turbo mit Vision (Bilder verstehen, zusätzlich zu allen anderen GPT-4-Turbo-Funktionen)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(714,'Gabon',NULL,NULL,'Gabon',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(715,'Galician',NULL,NULL,'galizisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(716,'Galician (Spain)',NULL,NULL,'Galizisch (Spanien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(717,'Gambia',NULL,NULL,'Gambia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(718,'Gateway',NULL,NULL,'Tor',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(719,'Gateway Mode',NULL,NULL,'Gateway -Modus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(720,'Gateway is set to use sandbox. Please set mode to development!',NULL,NULL,'Das Gateway ist so eingestellt, dass Sandbox verwendet wird. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(721,'General',NULL,NULL,'Allgemein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(722,'General Inquiry',NULL,NULL,'Allgemeine Anfrage',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(723,'General Settings',NULL,NULL,'Allgemeine Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(724,'Generate',NULL,NULL,'Erzeugen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(725,'Generate <strong>text, image, code, chat</strong> and even more with MagicAI.',NULL,NULL,'Generieren Sie <strong> Text, Bild, Code, Chat </strong> und noch mehr mit Magicai.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(726,'Generate Image',NULL,NULL,'Bild erzeugen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(727,'Generate JSON File',NULL,NULL,'Generieren Sie die JSON -Datei',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(728,'Generate Keywords',NULL,NULL,'Schlüsselwörter generieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(729,'Generate Outline',NULL,NULL,'Umriss erzeugen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:15','2026-09-12 20:18:15',NULL),(730,'Generate Text',NULL,NULL,'Text erzeugen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(731,'Generate Title',NULL,NULL,'Titel erzeugen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(732,'Generate Workbook',NULL,NULL,'Arbeitsmappe erstellen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(733,'Generate example prompt',NULL,NULL,'Beispielaufforderung erstellen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(734,'Generate high quality code in no time.',NULL,NULL,'Generieren Sie in kürzester Zeit einen Code von hoher Qualität.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(735,'Generate high quality code in seconds.',NULL,NULL,'Generieren Sie in Sekunden einen hohen Code.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(736,'Generate high qualtity images for a wide range of applications, including web design, advertising, and social media. Whether you’re looking to create eye-catching graphics for your business or simply want to experiment with different design concepts, MagicAI is the perfect solution.',NULL,NULL,'Generieren Sie hochkarätige Bilder für eine Vielzahl von Anwendungen, einschließlich Webdesign, Werbung und sozialen Medien. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(737,'Generate new price definitions in your gateway accounts.',NULL,NULL,'Generieren Sie neue Preisdefinitionen in Ihren Gateway -Konten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(738,'Generate new price definitions in your new gateway account.',NULL,NULL,'Generieren Sie neue Preisdefinitionen in Ihrem neuen Gateway -Konto.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(739,'Generate new product definitions in your gateway accounts.',NULL,NULL,'Generieren Sie neue Produktdefinitionen in Ihren Gateway -Konten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(740,'Generate new product definitions in your new gateway account.',NULL,NULL,'Generieren Sie neue Produktdefinitionen in Ihrem neuen Gateway -Konto.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(741,'Generate new support request. We will answer as soon as possible.',NULL,NULL,'Neue Support -Anfrage generieren. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(742,'Generate the Article',NULL,NULL,'Generieren Sie den Artikel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(743,'Generate, edit, export.',NULL,NULL,'Generieren, bearbeiten, exportieren.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(744,'Generated',NULL,NULL,'Generiert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(745,'Generated Content',NULL,NULL,'Erzeugte Inhalte',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(746,'Generated Successfully!',NULL,NULL,'Erfolgreich erzeugt!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(747,'Generating is aborted.',NULL,NULL,'Die Erzeugung ist abgebrochen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(748,'Generating the article',NULL,NULL,'Erzeugen des Artikels',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(749,'Generation Model',NULL,NULL,'Generationsmodell',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(750,'Generation.',NULL,NULL,'Generation.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(751,'Generators Active',NULL,NULL,'Generatoren aktiv',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(752,'Generators List',NULL,NULL,'Generatorenliste',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(753,'Generators List Section',NULL,NULL,'Listenabschnitt der Generatoren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(754,'Generators Section',NULL,NULL,'Generatorenabschnitt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(755,'Georgia',NULL,NULL,'Georgia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(756,'German',NULL,NULL,'Deutsch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(757,'German (Germany)',NULL,NULL,'Deutsch (Deutschland)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(758,'Germany',NULL,NULL,'Deutschland',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(759,'Get Serper Api Key',NULL,NULL,'Holen Sie sich Serper -API -Schlüssel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(760,'Get instant answers to your questions, no matter the topic. Whether you’re looking to book a reservation, get product recommendations, or just chat about the weather, MagicAI is always ready and willing to help. ',NULL,NULL,'Erhalten Sie sofortige Antworten auf Ihre Fragen, unabhängig vom Thema. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(761,'Ghana',NULL,NULL,'Ghana',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(762,'Gibraltar',NULL,NULL,'Gibraltar',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(763,'GitHub Repo',NULL,NULL,'Github Repo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(764,'Github',NULL,NULL,'Github',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(765,'Glitchcore',NULL,NULL,'Glitchcore',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(766,'Global Settings',NULL,NULL,'Globale Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(767,'Go',NULL,NULL,'Gehen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(768,'Go to',NULL,NULL,'Gehen zu',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(769,'Go to dashboard',NULL,NULL,'Gehen Sie zum Dashboard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(770,'Golden Hour',NULL,NULL,'Goldene Stunde',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(771,'Good',NULL,NULL,'Gut',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(772,'Google',NULL,NULL,'Google',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(773,'Google Adsense',NULL,NULL,'Google Adsense',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(774,'Google Adsense Edit',NULL,NULL,'Google Adsense Edit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(775,'Google Adsense List',NULL,NULL,'Google Adsense -Liste',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(776,'Google Analytics Tracking ID',NULL,NULL,'Google Analytics Tracking ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(777,'Google Analytics Tracking ID (UA-1xxxxx)',NULL,NULL,'Google Analytics Tracking ID (UA-1xxxxx)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(778,'Google TTS',NULL,NULL,'Google TTS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(779,'Greece',NULL,NULL,'Griechenland',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(780,'Greek',NULL,NULL,'griechisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(781,'Greek (Greece)',NULL,NULL,'Griechisch (Griechenland)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(782,'Greenland',NULL,NULL,'Grönland',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(783,'Grenada',NULL,NULL,'Grenada',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(784,'Group',NULL,NULL,'Gruppe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(785,'Grumpy',NULL,NULL,'Mürrisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(786,'Guadeloupe',NULL,NULL,'Guadeloupe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(787,'Guam',NULL,NULL,'Guam',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(788,'Guatemala',NULL,NULL,'Guatemala',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(789,'Guernsey',NULL,NULL,'Guernsey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(790,'Guided <code>.env</code> Wizard',NULL,NULL,'Guided <Code> .Env </code> Assistent',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(791,'Guinea',NULL,NULL,'Guinea',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(792,'Guinea-bissau',NULL,NULL,'Guinea-Bissau',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(793,'Guyana',NULL,NULL,'Guyana',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(794,'Haiti',NULL,NULL,'Haiti',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(795,'Hard',NULL,NULL,'Hart',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(796,'Have a question?',NULL,NULL,'Haben Sie eine Frage?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(797,'Have an account?',NULL,NULL,'Einen Konto haben?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(798,'Having trouble?',NULL,NULL,'Schwierigkeiten haben?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(799,'Header Banner Text',NULL,NULL,'Header Banner Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(800,'Header Banner Title',NULL,NULL,'Header Banner Titel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(801,'Heard Island and Mcdonald Islands',NULL,NULL,'Hörte Island und McDonald Islands',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(802,'Hebrew',NULL,NULL,'hebräisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(803,'Hebrew (Israel)',NULL,NULL,'Hebräisch (Israel)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(804,'Hello',NULL,NULL,'Hallo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(805,'Help Center',NULL,NULL,'Hilfezentrum',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(806,'Helps With',NULL,NULL,'Hilft bei',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(807,'Hero Button',NULL,NULL,'Heldenknopf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(808,'Hero Button Type',NULL,NULL,'Hero -Button -Typ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(809,'Hero Button URL',NULL,NULL,'Hero Button URL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(810,'Hero Description',NULL,NULL,'Heldenbeschreibung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(811,'Hero Scroll Text',NULL,NULL,'Held Scroll Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(812,'Hero Subtitle',NULL,NULL,'Heldenuntertitel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(813,'Hero Title',NULL,NULL,'Heldentitel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(814,'Hero Title Text Rotator',NULL,NULL,'Hero Title Textrotator',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(815,'Hi! I am',NULL,NULL,'Hallo! ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(816,'Hide Alert',NULL,NULL,'Alarm ausblenden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(817,'High',NULL,NULL,'Hoch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(818,'Hindi',NULL,NULL,'Hindi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(819,'Hindi (India)',NULL,NULL,'Hindi (Indien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(820,'Holy See (Vatican City State',NULL,NULL,'Heiliges Stadium (Staat des Vatikanischen Stadt)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(821,'Holy See (Vatican City State)',NULL,NULL,'Heiliges Stadium (Staat des Vatikanischen Stadt)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(822,'Home',NULL,NULL,'Heim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(823,'Honduras',NULL,NULL,'Honduras',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(824,'Hong Kong',NULL,NULL,'Hongkong',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(825,'Hours Saved',NULL,NULL,'Stunden gespeichert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(826,'How It Works Active',NULL,NULL,'Wie es aktiv funktioniert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(827,'How It Works Section',NULL,NULL,'Wie es funktioniert Abschnitt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(828,'How It Works Title',NULL,NULL,'Wie es funktioniert Titel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(829,'How do you handle my data?',NULL,NULL,'Wie gehen Sie mit meinen Daten um?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(830,'How does it generate responses?',NULL,NULL,'Wie erzeugt es Antworten?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(831,'How it Works',NULL,NULL,'Wie es funktioniert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(832,'How it Works Section',NULL,NULL,'Wie es funktioniert Abschnitt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(833,'Human Name',NULL,NULL,'Menschlicher Name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(834,'Hungarian',NULL,NULL,'ungarisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(835,'Hungarian (Hungary)',NULL,NULL,'Ungarisch (Ungarn)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(836,'Hungary',NULL,NULL,'Ungarn',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(837,'Iceland',NULL,NULL,'Island',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(838,'Icelandic',NULL,NULL,'isländisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(839,'Icelandic (Iceland)',NULL,NULL,'Isländisch (Island)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(840,'Icon',NULL,NULL,'Symbol',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(841,'Identity Number',NULL,NULL,'Identitätsnummer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(842,'If error persist, please contact with us.',NULL,NULL,'Wenn der Fehler bestehen bleibt, wenden Sie sich bitte an uns.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(843,'If this is an error it will be logged and our technic team will resolve it shortly',NULL,NULL,'Wenn dies ein Fehler ist, wird er protokolliert und unser Technik -Team wird ihn in Kürze beheben',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(844,'If this is enabled users cannot login unless they confirm their emails.',NULL,NULL,'Wenn dies aktiviert ist, können sich Benutzer nur anmelden, es sei denn, sie bestätigen ihre E -Mails.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(845,'If you do not set the required minimum value, you may get possible errors during the update.',NULL,NULL,'Wenn Sie den erforderlichen Mindestwert nicht festlegen, können Sie während des Updates mögliche Fehler erhalten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(846,'If you have previously created or edited a language file (JSON), the Generate process will overwrite those files.',NULL,NULL,'Wenn Sie zuvor eine Sprachdatei (JSON) erstellt oder bearbeitet haben, überschreibt der Generierungsvorgang diese Dateien.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(847,'If you will leave empty: using the post title for the SEO',NULL,NULL,'Wenn Sie leer gehen: Verwenden Sie den Post -Titel für die SEO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(848,'If you will use SVG, you do not need the Retina (2x) option.',NULL,NULL,'Wenn Sie SVG verwenden, benötigen Sie die Option Retina (2x) nicht.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(849,'Illustration of a cat sitting on a couch in a living room with a coffee mug in its hand.',NULL,NULL,'Illustration einer Katze, die auf einer Couch in einem Wohnzimmer mit einer Kaffeetasse in der Hand sitzt.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(850,'Image',NULL,NULL,'Bild',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(851,'Image (optional)',NULL,NULL,'Bild (optional)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(852,'Image Count',NULL,NULL,'Bildanzahl',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(853,'Image Credits',NULL,NULL,'Bildnachweis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(854,'Image Diffusion Samples',NULL,NULL,'Bilddiffusionsproben',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(855,'Image Resolution',NULL,NULL,'Bildauflösung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(856,'Image Storage',NULL,NULL,'Bildspeicherung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(857,'Image Storage Settings',NULL,NULL,'Bildspeichereinstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(858,'Image Style',NULL,NULL,'Bildstil',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(859,'Image Subtitl',NULL,NULL,'Bild',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(860,'Image Subtitle',NULL,NULL,'Bilduntertitel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(861,'Image Title',NULL,NULL,'Bildbezeichnung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(862,'Image Tokens',NULL,NULL,'Bildtoken',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(863,'Image resolution',NULL,NULL,'Bildauflösung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(864,'Image-to-Image',NULL,NULL,'Bild-zu-Image',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(865,'Images',NULL,NULL,'Bilder',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(866,'Images Generated',NULL,NULL,'Bilder erzeugt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(867,'Images Left',NULL,NULL,'Bilder übrig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(868,'Imagine, Genearate, Publish.',NULL,NULL,'Stellen Sie sich vor, Genearat, veröffentlichen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(869,'Important:',NULL,NULL,'Wichtig:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(870,'Impressionism',NULL,NULL,'Impressionismus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(871,'Improvement Idea',NULL,NULL,'Verbesserungsidee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(872,'In Characters',NULL,NULL,'In Charakteren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(873,'In RevenueCat dashboard, create only one instance of offerings and set it as default. Mobile app checks for default offering and searches given package and entity.',NULL,NULL,'Erstellen Sie im Revenuecat -Dashboard nur eine Instanz von Angeboten und setzen Sie es als Standardeinstellung fest. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(874,'In Words. OpenAI has a hard limit based on Token limits for each model. Refer to OpenAI documentation to learn more. As a recommended by OpenAI, max result length is capped at 1500 words',NULL,NULL,'In Worten. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(875,'In Words. OpenAI has a hard limit based on Token limits for each model. Refer to OpenAI documentation to learn more. As a recommended by OpenAI, max result length is capped at 2000 words',NULL,NULL,'In Worten. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(876,'In Words. OpenAI has a hard limit based on Token limits for each model. Refer to OpenAI documentation to learn more. As a recommended by OpenAI, max result length.',NULL,NULL,'In Worten. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(877,'India',NULL,NULL,'Indien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(878,'Indonesia',NULL,NULL,'Indonesien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(879,'Indonesian',NULL,NULL,'Indonesisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(880,'Indonesian (Indonesia)',NULL,NULL,'Indonesisch (Indonesien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(881,'Info',NULL,NULL,'Info',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(882,'Input Description',NULL,NULL,'Eingabebeschreibung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(883,'Input Field',NULL,NULL,'Eingangsfeld',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(884,'Input Groups',NULL,NULL,'Eingabegruppen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(885,'Input Name',NULL,NULL,'Eingabenname',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(886,'Input fields for short texts and Textarea fields are good for long text.',NULL,NULL,'Eingabefelder für kurze Texte und TextArea -Felder sind gut für einen langen Text.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(887,'Input is empty!',NULL,NULL,'Eingabe ist leer!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(888,'Instagram',NULL,NULL,'Instagram',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(889,'Install',NULL,NULL,'Installieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(890,'Install Updates',NULL,NULL,'Aktualisierungen installieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(891,'Installation Completed.',NULL,NULL,'Installation abgeschlossen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(892,'Installation Finished',NULL,NULL,'Installation abgeschlossen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(893,'Installation Log Entry:',NULL,NULL,'Installationsprotokolleintrag:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(894,'Intelligent Writing Assistant.',NULL,NULL,'Intelligenter Schreibassistent.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(895,'Intuitive / Humanlike Chatbot',NULL,NULL,'Intuitiver / menschlicher Chatbot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(896,'Invalid coupon code. Please try again',NULL,NULL,'Ungültiger Gutscheincode. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(897,'Invite',NULL,NULL,'Einladen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(898,'Invite your friend and get',NULL,NULL,'Lade deinen Freund ein und bekomme',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(899,'Invite your friends and earn lifelong recurring commissions from every purchase they make',NULL,NULL,'Laden Sie Ihre Freunde ein und verdienen Sie lebenslange wiederkehrende Provisionen aus jedem Kauf, den sie tätigen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(900,'Invoice',NULL,NULL,'Rechnung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(901,'Invoice Address',NULL,NULL,'Rechnungsprüfung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(902,'Invoice City',NULL,NULL,'Rechnung der Stadt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(903,'Invoice Country',NULL,NULL,'Rechnungsland',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(904,'Invoice Name',NULL,NULL,'Rechnungsname',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(905,'Invoice Phone',NULL,NULL,'Rechnungstelefon',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(906,'Invoice Postal',NULL,NULL,'Rechnungspostal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(907,'Invoice Settings',NULL,NULL,'Rechnungseinstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(908,'Invoice State',NULL,NULL,'Rechnungszustand',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(909,'Invoice VAT',NULL,NULL,'Rechnungsprüfung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(910,'Invoice Website',NULL,NULL,'Rechnungswebsite',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(911,'Iran, Islamic Republic of',NULL,NULL,'Iran, Islamische Republik von',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(912,'Iraq',NULL,NULL,'Irak',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(913,'Ireland',NULL,NULL,'Irland',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(914,'Is AI copywriting more cost-effective than hiring human writers?',NULL,NULL,'Ist AI Copywriting kostengünstiger als die Einstellung menschlicher Schriftsteller?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(915,'Isle of Man',NULL,NULL,'Isle of Man',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(916,'Isometric',NULL,NULL,'Isometrisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(917,'Israel',NULL,NULL,'Israel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(918,'It should be minimum',NULL,NULL,'Es sollte minimal sein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(919,'Italian',NULL,NULL,'Italienisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(920,'Italian (Italy)',NULL,NULL,'Italienisch (Italien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(921,'Italy',NULL,NULL,'Italien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(922,'Items:',NULL,NULL,'Artikel:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(923,'Jamaica',NULL,NULL,'Jamaika',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(924,'Japan',NULL,NULL,'Japan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(925,'Japanese',NULL,NULL,'japanisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(926,'Japanese (Japan)',NULL,NULL,'Japanisch (Japan)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(927,'Jersey',NULL,NULL,'Jersey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(928,'Job Title',NULL,NULL,'Berufsbezeichnung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(929,'Join',NULL,NULL,'Verbinden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(930,'Join Hub',NULL,NULL,'Mach Hub bei',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(931,'Join Magic',NULL,NULL,'Mach Magic',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(932,'Join hub',NULL,NULL,'Mach Hub bei',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(933,'Join our community',NULL,NULL,'Treten Sie unserer Gemeinschaft bei',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(934,'Join the Community',NULL,NULL,'Treten Sie der Community bei',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(935,'Jordan',NULL,NULL,'Jordanien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(936,'Jump to:',NULL,NULL,'Springen zu:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(937,'Just choose your topic, and watch AI whip up SEO-optimized blog content in a matter of seconds!',NULL,NULL,'Wählen Sie einfach Ihr Thema und sehen Sie sich in Sekundenschnelle den SEO-optimierten Blog-Inhalt an!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(938,'K_DPMPP_2M',NULL,NULL,'K_DPMPP_2M',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(939,'K_DPM_2',NULL,NULL,'K_DPM_2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(940,'K_DPM_2_ANCESTRAL',NULL,NULL,'K_DPM_2_ancestral',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(941,'K_EULER',NULL,NULL,'K_EULER',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(942,'K_EULER_ANCESTRAL',NULL,NULL,'K_EULER_ancestral',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(943,'K_HEUN',NULL,NULL,'K_heun',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(944,'K_LMS',NULL,NULL,'K_lms',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(945,'Kannada (India)',NULL,NULL,'Kannada (Indien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(946,'Kazakh',NULL,NULL,'Kasachisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(947,'Kazakh (Kazakhstan)',NULL,NULL,'Kasacher (Kasachstan)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(948,'Kazakhstan',NULL,NULL,'Kasachstan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(949,'Keep your site up-to-date with a single click.',NULL,NULL,'Halten Sie Ihre Website mit einem einzigen Klick auf dem neuesten Stand.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(950,'Kenya',NULL,NULL,'Kenia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(951,'Key',NULL,NULL,'Schlüssel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(952,'Keywords',NULL,NULL,'Schlüsselwörter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(953,'Kiribati',NULL,NULL,'Kiribati',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(954,'Know that all defined products and prices will reset.',NULL,NULL,'Wisse, dass alle definierten Produkte und Preise zurückgesetzt werden.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(955,'Korea, Democratic People\'s Republic of',NULL,NULL,'Korea, demokratische Volksrepublik von',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(956,'Korea, Republic of',NULL,NULL,'Korea, Republik von',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(957,'Korean',NULL,NULL,'Koreanisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(958,'Korean (South Korea)',NULL,NULL,'Koreanisch (Südkorea)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(959,'Kuwait',NULL,NULL,'Kuwait',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(960,'Kyrgyzstan',NULL,NULL,'Kirgisistan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(961,'LOGS',NULL,NULL,'Protokolle',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(962,'Language',NULL,NULL,'Sprache',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(963,'Languages',NULL,NULL,'Sprachen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(964,'Lao People\'s Democratic Republic',NULL,NULL,'Lao Volks demokratische Republik',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(965,'Laravel Installer',NULL,NULL,'Laravel Installer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(966,'Laravel Installer successfully INSTALLED on ',NULL,NULL,'Laravel -Installationsprogramm wurde erfolgreich installiert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(967,'Laravel Installer successfully UPDATED on ',NULL,NULL,'Laravel -Installationsprogramm wurde erfolgreich aktualisiert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(968,'Laravel Version',NULL,NULL,'Laravel -Version',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(969,'Last Name',NULL,NULL,'Nachname',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(970,'Last Updated',NULL,NULL,'Zuletzt aktualisiert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(971,'Latest Transactions',NULL,NULL,'Neueste Transaktionen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(972,'Latest news and updates',NULL,NULL,'Neueste Nachrichten und Updates',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(973,'Latvia',NULL,NULL,'Lettland',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(974,'Latvian',NULL,NULL,'lettisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(975,'Latvian (Latvia)',NULL,NULL,'Lettisch (Lettland)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(976,'Learn more',NULL,NULL,'Erfahren Sie mehr',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(977,'Lebanon',NULL,NULL,'Libanon',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(978,'Lesotho',NULL,NULL,'Lesotho',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(979,'Let’s start.',NULL,NULL,'Fangen wir an.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(980,'Liberia',NULL,NULL,'Liberia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(981,'Libyan Arab Jamahiriya',NULL,NULL,'Libyan arabischer Jamahiriya',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(982,'License',NULL,NULL,'Lizenz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(983,'Liechtenstein',NULL,NULL,'Liechtenstein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(984,'Lightning Style',NULL,NULL,'Blitzstil',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(985,'Limit',NULL,NULL,'Limit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(986,'Limited Offer',NULL,NULL,'Begrenztes Angebot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(987,'Line Art',NULL,NULL,'Linienkunst',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(988,'Links',NULL,NULL,'Links',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(989,'Lithuania',NULL,NULL,'Litauen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(990,'Lithuanian',NULL,NULL,'litauisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(991,'Lithuanian (Lithuania)',NULL,NULL,'Litauen (Litauen)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(992,'Local',NULL,NULL,'Lokal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(993,'Local Storage',NULL,NULL,'Lokale Speicherung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(994,'Login Successful, Redirecting...',NULL,NULL,'Erfolgreich anmelden, umleiten ...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(995,'Login with Facebook',NULL,NULL,'Melden Sie sich bei Facebook an',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(996,'Login with Github',NULL,NULL,'Melden Sie sich mit GitHub an',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(997,'Login with Google',NULL,NULL,'Melden Sie sich bei Google an',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(998,'Login with Twitter',NULL,NULL,'Melden Sie sich mit Twitter an',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(999,'Logo Settings',NULL,NULL,'Logoeinstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1000,'Logout',NULL,NULL,'Abmelden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1001,'Logs',NULL,NULL,'Protokolle',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1002,'Low',NULL,NULL,'Niedrig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1003,'Low Poly',NULL,NULL,'Niedrige Poly',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1004,'Luxembourg',NULL,NULL,'Luxemburg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1005,'Macao',NULL,NULL,'Macao',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1006,'Macedonia, The Former Yugoslav Republic of',NULL,NULL,'Mazedonien, die ehemalige jugoslawische Republik von',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1007,'Madagascar',NULL,NULL,'Madagaskar',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1008,'Magento',NULL,NULL,'Magento',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1009,'Magic AI helps you write code faster, efficiently and error-free.',NULL,NULL,'Magic AI hilft Ihnen, Code schneller, effizient und fehlerfrei zu schreiben.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1010,'Magic Tools.',NULL,NULL,'Magische Werkzeuge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1011,'MagicAI has all the tools you need to create and manage your SaaS platform.',NULL,NULL,'Magicai verfügt über alle Tools, die Sie benötigen, um Ihre SaaS -Plattform zu erstellen und zu verwalten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1012,'MagicAI is designed to help you generate high-quality content instantly, without breaking a sweat.',NULL,NULL,'Magicai soll Ihnen dabei helfen, sofort hochwertige Inhalte zu erzeugen, ohne ins Schwitzen zu kommen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1013,'MagicAI is up to date',NULL,NULL,'Magicai ist auf dem neuesten Stand',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1014,'Mail',NULL,NULL,'Post',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1015,'Mail Driver',NULL,NULL,'Postfahrer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1016,'Mail Encryption',NULL,NULL,'Postverschlüsselung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1017,'Mail Host',NULL,NULL,'Mail -Host',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1018,'Mail Password',NULL,NULL,'Mail Passwort',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1019,'Mail Port',NULL,NULL,'Postanschluss',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1020,'Mail SMTP',NULL,NULL,'Mail SMTP',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1021,'Mail Username',NULL,NULL,'Mail -Benutzername',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1022,'MailChimp',NULL,NULL,'Mailchimp',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1023,'Maintenance',NULL,NULL,'Wartung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1024,'Malawi',NULL,NULL,'Malawi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1025,'Malay',NULL,NULL,'malaiisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1026,'Malay (Malaysia)',NULL,NULL,'Malaiisch (Malaysia)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1027,'Malayalam',NULL,NULL,'Malayalam',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1028,'Malayalam (India)',NULL,NULL,'Malayalam (Indien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1029,'Malaysia',NULL,NULL,'Malaysia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1030,'Maldives',NULL,NULL,'Malediven',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1031,'Male',NULL,NULL,'Männlich',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1032,'Mali',NULL,NULL,'Mali',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1033,'Malta',NULL,NULL,'Malta',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1034,'Manage AI Writer Categories',NULL,NULL,'Verwalten Sie die Kategorien der KI -Schriftsteller',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1035,'Manage Blog Posts',NULL,NULL,'Blog -Beiträge verwalten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1036,'Manage Built-in Prompts and Templates',NULL,NULL,'Verwalten Sie integrierte Eingabeaufforderungen und Vorlagen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1037,'Manage Chat Categories',NULL,NULL,'Chat -Kategorien verwalten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1038,'Manage Chat Templates',NULL,NULL,'Chat -Vorlagen verwalten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1039,'Manage Clients',NULL,NULL,'Kunden verwalten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1040,'Manage Coupons',NULL,NULL,'Gutscheine verwalten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1041,'Manage Custom Pages',NULL,NULL,'Benutzerdefinierte Seiten verwalten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1042,'Manage Custom Prompts and Templates',NULL,NULL,'Verwalten Sie benutzerdefinierte Eingabeaufforderungen und Vorlagen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1043,'Manage Email Templates',NULL,NULL,'E -Mail -Vorlagen verwalten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1044,'Manage How it Works',NULL,NULL,'Verwalten Sie, wie es funktioniert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1045,'Manage How it Works Steps',NULL,NULL,'Verwalten Sie, wie es Schritte funktioniert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1046,'Manage Languages',NULL,NULL,'Sprachen verwalten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1047,'Manage Mobile Subscription and Token Packs',NULL,NULL,'Verwalten Sie Mobile Abonnements und Token Packs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1048,'Manage Payment Gateways',NULL,NULL,'Zahlungsgateways verwalten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1049,'Manage Subscription and Pay to Go Plans',NULL,NULL,'Abonnement verwalten und plant zahlen, um Pläne zu gehen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1050,'Manage Subscription and Token Packs',NULL,NULL,'Verwalten Sie Abonnement- und Token -Packs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1051,'Manage Testimonials',NULL,NULL,'Testimonials verwalten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1052,'Manage the Features',NULL,NULL,'Verwalten Sie die Funktionen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1053,'Manage the features you want to activate for users.',NULL,NULL,'Verwalten Sie die Funktionen, die Sie für Benutzer aktivieren möchten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1054,'Mandarin Chinese',NULL,NULL,'Mandarin Chinesisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1055,'Mandarin Chinese (T)',NULL,NULL,'Mandarin Chinese (T)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1056,'Manual Generate',NULL,NULL,'Handbuch erzeugen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1057,'Marathi (India)',NULL,NULL,'Marathi (Indien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1058,'Marketers',NULL,NULL,'Vermarkter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1059,'Marshall Islands',NULL,NULL,'Marshall Islands',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1060,'Martinique',NULL,NULL,'Martinique',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1061,'Masculine',NULL,NULL,'Männlich',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1062,'Mauritania',NULL,NULL,'Mauretanien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1063,'Mauritius',NULL,NULL,'Mauritius',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1064,'Max Input Vars',NULL,NULL,'Max Eingangsvars',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1065,'Max Tokens',NULL,NULL,'Max -Token',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1066,'Maximum Input Length',NULL,NULL,'Maximale Eingangslänge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1067,'Maximum Length',NULL,NULL,'Maximale Länge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1068,'Maximum Output Length',NULL,NULL,'Maximale Ausgangslänge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1069,'Maximum Title length',NULL,NULL,'Maximale Titellänge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1070,'Maximum character length of text',NULL,NULL,'Maximale Charakterlänge des Textes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1071,'Mayotte',NULL,NULL,'Mayotte',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1072,'Medium',NULL,NULL,'Medium',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1073,'Meet your next virtual assistant.',NULL,NULL,'Treffen Sie Ihren nächsten virtuellen Assistenten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1074,'Membership Plans',NULL,NULL,'Mitgliedschaftspläne',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1075,'Memphis style painting of a flower vase on a kitchen table with a window in the backdrop.',NULL,NULL,'Memphis -Stilmalerei einer Blumenvase auf einem Küchentisch mit einem Fenster im Hintergrund.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1076,'Menu',NULL,NULL,'Speisekarte',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1077,'Menu Settings',NULL,NULL,'Menüeinstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1078,'Menu Title',NULL,NULL,'Menütitel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1079,'Marketplace',NULL,NULL,'Marktplatz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1080,'Mermory Limit',NULL,NULL,'Speichergrenze',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1081,'Message',NULL,NULL,'Nachricht',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1082,'Meta Description',NULL,NULL,'Meta Beschreibung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1083,'Meta Keywords',NULL,NULL,'Meta -Schlüsselwörter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1084,'Meta Title',NULL,NULL,'Meta -Titel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1085,'Method',NULL,NULL,'Verfahren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1086,'Mexico',NULL,NULL,'Mexiko',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1087,'Micronesia, Federated States of',NULL,NULL,'Mikronesien, Föderierte Zustände von',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1088,'Migration &amp; Seed Console Output:',NULL,NULL,'Migration und Saatgutkonsoleausgabe:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1089,'Minimalism',NULL,NULL,'Minimalismus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1090,'Minimum Withdrawal Amount is',NULL,NULL,'Mindestabhebungsbetrag ist',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1091,'Mobile',NULL,NULL,'Mobile',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1092,'Mobile Payment',NULL,NULL,'Mobile Zahlung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1093,'Mobile Settings',NULL,NULL,'Mobile Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1094,'Mobile Subscriptions and Packs',NULL,NULL,'Mobile Abonnements und Packungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1095,'Model',NULL,NULL,'Modell',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1096,'Modeling Compound',NULL,NULL,'Modellierungsverbindung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1097,'Modern',NULL,NULL,'Modern',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1098,'Moldova, Republic of',NULL,NULL,'Moldawien, Republik von',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1099,'Monaco',NULL,NULL,'Monaco',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1100,'Mongolia',NULL,NULL,'Mongolei',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1101,'Montenegro',NULL,NULL,'Montenegro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1102,'Monthly',NULL,NULL,'Monatlich',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1103,'Monthly Billing',NULL,NULL,'Monatliche Abrechnung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1104,'Montserrat',NULL,NULL,'Montserrat',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1105,'Mood',NULL,NULL,'Stimmung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1106,'More Info',NULL,NULL,'Weitere Informationen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1107,'Morocco',NULL,NULL,'Marokko',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1108,'Move',NULL,NULL,'Bewegen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1109,'Move File',NULL,NULL,'Datei verschieben',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1110,'Mozambique',NULL,NULL,'Mosambik',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1111,'Multi-Lingual',NULL,NULL,'Mehrsprachig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1112,'Multi-Prompting',NULL,NULL,'Multi-Spreng',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1113,'Multilingual',NULL,NULL,'Mehrsprachig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1114,'Must be between 0 and 1',NULL,NULL,'Muss zwischen 0 und 1 sein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1115,'Must be between 0 and 1 (1 Most Creative, 0.1 Not creative)',NULL,NULL,'Muss zwischen 0 und 1 sein (1 kreativste, 0,1 nicht kreativ)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1116,'My Documents',NULL,NULL,'Meine Dokumente',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1117,'My Orders',NULL,NULL,'Meine Bestellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1118,'Myanmar',NULL,NULL,'Myanmar',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1119,'Name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1120,'Name On Card',NULL,NULL,'Name auf Karte',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1121,'Namibia',NULL,NULL,'Namibia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1122,'Natural',NULL,NULL,'Natürlich',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1123,'Nauru',NULL,NULL,'Nauru',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1124,'Need help?',NULL,NULL,'Benötigen Sie Hilfe?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1125,'Negative Prompt',NULL,NULL,'Negative Aufforderung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1126,'Negative Prompts',NULL,NULL,'Negative Aufforderungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1127,'Neon',NULL,NULL,'Neon',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1128,'Neon Punk',NULL,NULL,'Neon Punk',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1129,'Nepal',NULL,NULL,'Nepal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1130,'Netherlands',NULL,NULL,'Niederlande',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1131,'Netherlands Antilles',NULL,NULL,'Niederlande Antillen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1132,'Neutral',NULL,NULL,'Neutral',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1133,'New',NULL,NULL,'Neu',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1134,'New Caledonia',NULL,NULL,'Neukaledonien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1135,'New Conversation',NULL,NULL,'Neues Gespräch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1136,'New File Name:',NULL,NULL,'Neuer Dateiname:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1137,'New Folder',NULL,NULL,'Neuer Ordner',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1138,'New Folder Name:',NULL,NULL,'Neuer Ordner Name:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1139,'New Keyword',NULL,NULL,'Neues Keyword',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1140,'New Outline',NULL,NULL,'Neue Umrisse',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1141,'New Password',NULL,NULL,'Neues Passwort',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1142,'New Title',NULL,NULL,'Neuer Titel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1143,'New Zealand',NULL,NULL,'Neuseeland',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1144,'New users',NULL,NULL,'Neue Benutzer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1145,'Newsletter',NULL,NULL,'Newsletter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1146,'Next',NULL,NULL,'Nächste',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1147,'Next Article',NULL,NULL,'Nächster Artikel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1148,'Next Step',NULL,NULL,'Nächster Schritt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1149,'Nicaragua',NULL,NULL,'Nicaragua',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1150,'Niger',NULL,NULL,'Niger',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1151,'Nigeria',NULL,NULL,'Nigeria',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1152,'Niue',NULL,NULL,'Niue',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1153,'No',NULL,NULL,'NEIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1154,'No Active Subscription',NULL,NULL,'Kein aktives Abonnement',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1155,'No Prompts, Please input new one',NULL,NULL,'Keine Eingabeaufforderungen, bitte geben Sie einen neuen ein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1156,'No Tokens Left',NULL,NULL,'Keine Token übrig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1157,'No activity logged yet.',NULL,NULL,'Noch keine Aktivität protokolliert.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1158,'No entries created yet.',NULL,NULL,'Noch keine Einträge erstellt.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1159,'No logged any data.',NULL,NULL,'Kein angemeldete Daten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1160,'No new notifications',NULL,NULL,'Keine neuen Benachrichtigungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1161,'No results.',NULL,NULL,'Keine Ergebnisse.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1162,'None',NULL,NULL,'Keiner',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1163,'Norfolk Island',NULL,NULL,'Norfolk Island',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1164,'Normal',NULL,NULL,'Normal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1165,'Northern Mariana Islands',NULL,NULL,'Nordmariana -Inseln',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1166,'Norway',NULL,NULL,'Norwegen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1167,'Norwegian',NULL,NULL,'norwegisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1168,'Norwegian (Norway)',NULL,NULL,'Norwegisch (Norwegen)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1169,'Not Needed',NULL,NULL,'Nicht benötigt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1170,'Not Set',NULL,NULL,'Nicht gesetzt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1171,'Note that we do not store old keys. So every save action is new.',NULL,NULL,'Beachten Sie, dass wir keine alten Schlüssel speichern. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1172,'Note that, we do not collect or store any personal data. All information above are sent to iyzico directly.',NULL,NULL,'Beachten Sie, dass wir keine personenbezogenen Daten sammeln oder speichern. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1173,'Nova',NULL,NULL,'Nova',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1174,'Number of Images',NULL,NULL,'Anzahl der Bilder',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1175,'Number of Keywords',NULL,NULL,'Anzahl der Schlüsselwörter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1176,'Number of Outlines',NULL,NULL,'Anzahl der Umrisse',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1177,'Number of Results',NULL,NULL,'Anzahl der Ergebnisse',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1178,'Number of Subtitles',NULL,NULL,'Anzahl der Untertitel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1179,'Number of Titles',NULL,NULL,'Anzahl der Titel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1180,'Number of images',NULL,NULL,'Anzahl der Bilder',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1181,'Number of keywords',NULL,NULL,'Anzahl der Schlüsselwörter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1182,'Number of outlines',NULL,NULL,'Anzahl der Umrisse',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1183,'Number of results',NULL,NULL,'Anzahl der Ergebnisse',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1184,'Number of titles',NULL,NULL,'Anzahl der Titel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1185,'ON to display (0) image count in plans',NULL,NULL,'Ein weiter auf (0) Bildanzahl in Plänen anzeigen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1186,'ON to display (0) word count in plans',NULL,NULL,'Auf, um (0) Wortzahl in Plänen anzuzeigen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1187,'ON to display image count in plans',NULL,NULL,'Ein weiter, um die Bildanzahl in Plänen anzuzeigen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1188,'ON to display word count in plans',NULL,NULL,'Ein weiter, um die Wortanzahl in Plänen anzuzeigen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1189,'Old Password',NULL,NULL,'Altes Passwort',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1190,'Oman',NULL,NULL,'Oman',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1191,'One Click Update',NULL,NULL,'Ein Klick -Update',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1192,'One time',NULL,NULL,'Einmal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1193,'Only accepts javascript code wrapped with <script> tags and HTML markup that is valid inside the </body> tag.',NULL,NULL,'Akzeptiert nur JavaScript -Code, das mit <Script> -Tags und HTML -Markup umwickelt ist, das im </body> -Tag gültig ist.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1194,'Only accepts javascript code wrapped with <script> tags and HTML markup that is valid inside the </head> tag.',NULL,NULL,'Akzeptiert nur JavaScript -Code, der mit <Script> -Tags und HTML -Markup umwickelt ist, das im </head> -Tag gültig ist.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1195,'Onyx',NULL,NULL,'Onyx',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1196,'Oops… You just found an error page',NULL,NULL,'Hoppla… Sie haben gerade eine Fehlerseite gefunden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1197,'Open In New Tab',NULL,NULL,'Offen in neuer Registerkarte',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1198,'Open Source',NULL,NULL,'Open Source',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1199,'OpenAI',NULL,NULL,'Openai',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1200,'OpenAI Settings',NULL,NULL,'OpenAI -Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1201,'OpenAI TTS',NULL,NULL,'Openai TTS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1202,'OpenAI API Secret',NULL,NULL,'Openai API Secret',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1203,'Openai Settings',NULL,NULL,'OpenAI -Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1204,'Operating System',NULL,NULL,'Betriebssystem',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1205,'Optimize your content for search engines and reach more customers.',NULL,NULL,'Optimieren Sie Ihre Inhalte für Suchmaschinen und erreichen Sie mehr Kunden.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1206,'Options',NULL,NULL,'Optionen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1207,'Order',NULL,NULL,'Befehl',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1208,'Order Id',NULL,NULL,'Bestellausweis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1209,'Orders',NULL,NULL,'Bestellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1210,'Origami',NULL,NULL,'Origami',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1211,'Other',NULL,NULL,'Andere',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1212,'Our support team will get assistance from AI-powered suggestions, making it quicker than ever to handle support requests.',NULL,NULL,'Unser Support-Team erhält Unterstützung durch KI-angetriebene Vorschläge, wodurch es schneller als je zuvor, Supportanfragen zu bearbeiten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1213,'Outline',NULL,NULL,'Gliederung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1214,'Outline Topic(Optional)',NULL,NULL,'Umriss Thema (optional)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1215,'Output',NULL,NULL,'Ausgabe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1216,'Overview',NULL,NULL,'Überblick',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1217,'PAYMENTS',NULL,NULL,'Zahlungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1218,'PDF',NULL,NULL,'PDF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1219,'PHP Version',NULL,NULL,'PHP -Version',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1220,'PRO',NULL,NULL,'Pro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1221,'Pace',NULL,NULL,'Tempo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1222,'Package',NULL,NULL,'Paket',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1223,'Package Type',NULL,NULL,'Paketart',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1224,'Page Status',NULL,NULL,'Seitenstatus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1225,'Page Title',NULL,NULL,'Seitentitel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1226,'Pages',NULL,NULL,'Seiten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1227,'Pagination Navigation',NULL,NULL,'Paginierungsnavigation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1228,'Painting of a flower vase on a kitchen table with a window in the backdrop.',NULL,NULL,'Malen einer Blumenvase auf einem Küchentisch mit einem Fenster im Hintergrund.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1229,'Pakistan',NULL,NULL,'Pakistan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1230,'Palau',NULL,NULL,'Palau',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1231,'Palestinian Territory, Occupied',NULL,NULL,'Palästinensisches Territorium, besetzt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1232,'Panama',NULL,NULL,'Panama',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1233,'Papua New Guinea',NULL,NULL,'Papua -Neuguinea',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1234,'Paraguay',NULL,NULL,'Paraguay',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1235,'Passive',NULL,NULL,'Passiv',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1236,'Password',NULL,NULL,'Passwort',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1237,'Password confirmation',NULL,NULL,'Passwortbestätigung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1238,'Password reset link sent succesfully. Please also check your spam folder.',NULL,NULL,'Kennwort Reset Link gesendet erfolgreich. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1239,'Password succesfully changed.',NULL,NULL,'Passwort erfolgreich geändert.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1240,'Paste the svg code you get from the Tabler Icons or any other icon sets',NULL,NULL,'Fügen Sie den SVG -Code ein, den Sie aus den Tabller -Symbolen oder einem anderen Symbolsätzen erhalten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1241,'Pause',NULL,NULL,'Pause',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1242,'Pay',NULL,NULL,'Zahlen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1243,'Pay once, own forever.',NULL,NULL,'Einmal bezahlen, für immer besitzen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1244,'Pay with 2checkout',NULL,NULL,'Zahlen Sie mit 2Checkout',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1245,'PayPal',NULL,NULL,'Paypal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1246,'Payment Failed',NULL,NULL,'Zahlung fehlgeschlagen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1247,'Payment Gateways',NULL,NULL,'Zahlungsgateways',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1248,'Payment ID',NULL,NULL,'Zahlungs -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1249,'Payment Stripe',NULL,NULL,'Zahlungsstreifen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1250,'Payment Stripe Settings',NULL,NULL,'Zahlungsstreifeneinstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1251,'Payment Success',NULL,NULL,'Zahlungserfolg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1252,'Payment is incomplete. Please try again',NULL,NULL,'Die Zahlung ist unvollständig. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1253,'Payments secured via Stripe.',NULL,NULL,'Zahlungen über Stripe gesichert.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1254,'Paypal Save cancelled! Please set mode to development!',NULL,NULL,'Paypal sparen storniert! ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1255,'Pencil Drawing',NULL,NULL,'Bleistiftzeichnung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1256,'Per month',NULL,NULL,'Pro Monat',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1257,'Permissions',NULL,NULL,'Berechtigungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1258,'Personal',NULL,NULL,'Persönlich',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1259,'Personality',NULL,NULL,'Persönlichkeit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1260,'Peru',NULL,NULL,'Peru',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1261,'Philippines',NULL,NULL,'Philippinen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1262,'Phone',NULL,NULL,'Telefon',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1263,'Pick a category for the template.',NULL,NULL,'Wählen Sie eine Kategorie für die Vorlage.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1264,'Pick a color for for the icon container shape. Color is in HEX format.',NULL,NULL,'Wählen Sie eine Farbe für die Form der Symbolbehälter. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1265,'Pick a name for the template.',NULL,NULL,'Wählen Sie einen Namen für die Vorlage.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1266,'Pitcairn',NULL,NULL,'Pitcairn',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1267,'Pixel',NULL,NULL,'Pixel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1268,'Pixel Art',NULL,NULL,'Pixelkunst',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1269,'Plan',NULL,NULL,'Planen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1270,'Plan / Price ID',NULL,NULL,'Plan / Preis -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1271,'Plan Name',NULL,NULL,'Plan Name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1272,'Plan Type',NULL,NULL,'Plantyp',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1273,'Play',NULL,NULL,'Spielen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1274,'Please Wait...',NULL,NULL,'Bitte warten...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1275,'Please ask system administrator to add API key to the system.',NULL,NULL,'Bitte bitten Sie den Systemadministrator, dem System den API -Schlüssel hinzuzufügen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1276,'Please connect to',NULL,NULL,'Bitte verbinden Sie sich mit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1277,'Please do not enter / at the end of the url. For Example; https://liquid-themes.com',NULL,NULL,'Bitte geben Sie nicht am Ende der URL ein. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1278,'Please enable Stripe',NULL,NULL,'Bitte aktivieren Sie Stripe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1279,'Please enable a payment gateway',NULL,NULL,'Bitte aktivieren Sie ein Zahlungsgateway',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1280,'Please enable at least one gateway!',NULL,NULL,'Bitte aktivieren Sie mindestens ein Tor!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1281,'Please enable this to activate turbo writer',NULL,NULL,'Bitte ermöglichen Sie dies, den Turbo -Autor zu aktivieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1282,'Please ensure that your OpenAI API key is fully functional and billing defined on your OpenAI account.',NULL,NULL,'Bitte stellen Sie sicher, dass Ihr OpenAI -API -Schlüssel voll funktionsfähig ist und in Ihrem OpenAI -Konto definiert ist.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1283,'Please ensure that your Serper api key is fully functional and billing defined on your Serper account.',NULL,NULL,'Bitte stellen Sie sicher, dass Ihr Serper -API -Schlüssel voll funktionsfähig und in Ihrem Serperkonto definiert ist.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1284,'Please ensure that your Unsplash api key is fully functional and billing defined on your Unsplash account.',NULL,NULL,'Bitte stellen Sie sicher, dass Ihr nicht -plash -API -Schlüssel voll funktionsfähig ist und in Ihrem Unplash -Konto abgebrochen wird.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1285,'Please ensure that your stable diffusion API key is fully functional and billing defined on your stable diffusion account.',NULL,NULL,'Bitte stellen Sie sicher, dass Ihr stabiler Diffusion -API -Schlüssel voll funktionsfähig ist und in Ihrem stabilen Diffusionskonto definiert ist.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1286,'Please enter Entitlement Identifier',NULL,NULL,'Bitte geben Sie die Berechtigungskennung ein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1287,'Please enter Package Identifier',NULL,NULL,'Bitte geben Sie die Paketkennung ein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1288,'Please enter Product Identifier',NULL,NULL,'Bitte geben Sie die Produktkennung ein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1289,'Please enter a coupon code',NULL,NULL,'Bitte geben Sie einen Gutscheincode ein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1290,'Please enter subject of the support request',NULL,NULL,'Bitte geben Sie das Thema der Support -Anfrage ein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1291,'Please enter your billing details',NULL,NULL,'Bitte geben Sie Ihre Abrechnungsdetails ein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1292,'Please enter your email address.',NULL,NULL,'Bitte geben Sie Ihre E -Mail -Adresse ein.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1293,'Please enter your message',NULL,NULL,'Bitte geben Sie Ihre Nachricht ein',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1294,'Please enter your password.',NULL,NULL,'Bitte geben Sie Ihr Passwort ein.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1295,'Please fill all fields.',NULL,NULL,'Bitte füllen Sie alle Felder.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1296,'Please fill the stripe settings',NULL,NULL,'Bitte füllen Sie die Streifeneinstellungen aus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1297,'Please leave empty if you don\'t want to change your password.',NULL,NULL,'Bitte lassen Sie leer, wenn Sie Ihr Passwort nicht ändern möchten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1298,'Please leave empty if you don’t want to change your password.',NULL,NULL,'Bitte lassen Sie leer, wenn Sie Ihr Passwort nicht ändern möchten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1299,'Please note GPT-4 is not working with every api_key. You have to have an api key which can work with GPT-4.',NULL,NULL,'Bitte beachten Sie, dass GPT-4 nicht mit jedem API_Key funktioniert. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1300,'Please provide full URL with http:// or https://',NULL,NULL,'Bitte geben Sie die vollständige URL mit http: // oder https: // an',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1301,'Please save payment ID',NULL,NULL,'Bitte sparen Sie Zahlungs -ID.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1302,'Please save reference ID',NULL,NULL,'Bitte speichern Sie die Referenz -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1303,'Please save setting with the mode you want.',NULL,NULL,'Bitte speichern Sie die Einstellung mit dem gewünschten Modus.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1304,'Please select how you want to configure the apps <code>.env</code> file.',NULL,NULL,'Bitte wählen Sie, wie Sie die Apps <Code> .Env </code> Datei konfigurieren möchten.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1305,'Please try with another word.',NULL,NULL,'Bitte versuchen Sie es mit einem anderen Wort.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1306,'Please upload your file to the /public_html/storage folder within your project and provide the file name in the space provided.',NULL,NULL,'Bitte laden Sie Ihre Datei in den Ordner /public_html /speicher in Ihrem Projekt hoch und geben Sie den Dateinamen in dem bereitgestellten Speicherplatz an.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1307,'Please use comma seperated like; Generator,Chatbot,Assistant',NULL,NULL,'Bitte verwenden Sie das von Komma getrennte. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:16','2026-09-12 20:18:16',NULL),(1308,'Please wait...',NULL,NULL,'Bitte warten...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1309,'Plugins',NULL,NULL,'Plugins',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1310,'Pointillism',NULL,NULL,'Pointillismus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1311,'Poland',NULL,NULL,'Polen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1312,'Polish',NULL,NULL,'Polieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1313,'Polish (Poland)',NULL,NULL,'Polnisch (Polen)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1314,'Pop',NULL,NULL,'Pop',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1315,'Popular pack',NULL,NULL,'Beliebtes Paket',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1316,'Popular plan',NULL,NULL,'Beliebter Plan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1317,'Popularity',NULL,NULL,'Popularität',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1318,'Portugal',NULL,NULL,'Portugal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1319,'Portuguese',NULL,NULL,'Portugiesisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1320,'Portuguese (Brazil)',NULL,NULL,'Portugiesisch (Brasilien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1321,'Portuguese (Portugal)',NULL,NULL,'Portugiesisch (Portugal)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1322,'Post Image',NULL,NULL,'Post Bild',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1323,'Post Max Size',NULL,NULL,'Maximale Größe posten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1324,'Post Status',NULL,NULL,'Poststatus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1325,'Post Title',NULL,NULL,'Posttitel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1326,'Powered by ChatGPT 4, Babbage, Ada and Dall-E.',NULL,NULL,'Angetrieben von Chatgpt 4, Babbage, Ada und Dall-e.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1327,'Powered by Dall-E.',NULL,NULL,'Angetrieben von Dall-e.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1328,'Powered by OpenAI.',NULL,NULL,'Angetrieben von Openai.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1329,'Pre-Paid Plan',NULL,NULL,'Vorbezahlungsplan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1330,'PreHeader Section',NULL,NULL,'Vorheader -Abschnitt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1331,'PreHeader Text',NULL,NULL,'Vorheader -Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1332,'PreHeader Title',NULL,NULL,'Vorheader -Titel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1333,'Premium',NULL,NULL,'Prämie',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1334,'Prepaid Plan Payment',NULL,NULL,'Prepaid -Planzahlung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1335,'Prepaid Plans',NULL,NULL,'Vorbezahlte Pläne',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1336,'Prepare Payment',NULL,NULL,'Zahlung vorbereiten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1337,'Prev',NULL,NULL,'Vorläufig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1338,'Prevent unauthorized access by  adding an extra layer of protection.',NULL,NULL,'Verhindern Sie den unbefugten Zugriff, indem Sie eine zusätzliche Schutzschicht hinzufügen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1339,'Preview',NULL,NULL,'Vorschau',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1340,'Previous',NULL,NULL,'Vorherige',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1341,'Previus Article',NULL,NULL,'Vorheriger Artikel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1342,'Price',NULL,NULL,'Preis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1343,'Price ID',NULL,NULL,'Preis -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1344,'Pricing',NULL,NULL,'Preisgestaltung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1345,'Pricing Active',NULL,NULL,'Preisgestaltung aktiv',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1346,'Pricing Description',NULL,NULL,'Preisbeschreibung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1347,'Pricing Save Percent',NULL,NULL,'Preisgestaltung sparen Prozent',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1348,'Pricing Save Percent\'',NULL,NULL,'Preisgestaltung prozentuiert \'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1349,'Pricing Section',NULL,NULL,'Preisabschnitt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1350,'Pricing Title',NULL,NULL,'Preistitel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1351,'Print Invoice',NULL,NULL,'Rechnung drucken',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1352,'Priority',NULL,NULL,'Priorität',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1353,'Privacy Policy',NULL,NULL,'Datenschutzrichtlinie',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1354,'Privacy Policy and Terms',NULL,NULL,'Datenschutzrichtlinien und -bedingungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1355,'Privacy Policy and Terms Settings',NULL,NULL,'Datenschutzrichtlinien und Bedingungen Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1356,'Product',NULL,NULL,'Produkt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1357,'Product Designers',NULL,NULL,'Produktdesigner',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1358,'Product ID',NULL,NULL,'Produkt -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1359,'Product ID and Price ID of all membership plans are generated.',NULL,NULL,'Produkt -ID und Preis -ID aller Mitgliedschaftspläne werden generiert.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1360,'Product ID is not set!',NULL,NULL,'Produkt -ID ist nicht festgelegt!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1361,'Product ID is not set! Please save Membership Plan again.',NULL,NULL,'Produkt -ID ist nicht festgelegt! ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1362,'Production',NULL,NULL,'Produktion',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1363,'Professional',NULL,NULL,'Professional',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1364,'Prompt',NULL,NULL,'Prompt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1365,'Prompt Library',NULL,NULL,'Einsprechende Bibliothek',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1366,'Prompts',NULL,NULL,'Aufforderungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1367,'Publish',NULL,NULL,'Veröffentlichen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1368,'Publish All JSON Files',NULL,NULL,'Veröffentlichen Sie alle JSON -Dateien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1369,'Publish All Json Files',NULL,NULL,'Veröffentlichen Sie alle JSON -Dateien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1370,'Published',NULL,NULL,'Veröffentlicht',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1371,'Puerto Rico',NULL,NULL,'Puerto Rico',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1372,'Punjabi (India)',NULL,NULL,'Punjabi (Indien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1373,'Pusher',NULL,NULL,'Pusher',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1374,'Pusher App Id',NULL,NULL,'Pusher App ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1375,'Pusher App Key',NULL,NULL,'Pusher App -Schlüssel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1376,'Pusher App Secret',NULL,NULL,'Pusher App Secret',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1377,'Qa',NULL,NULL,'QA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1378,'Qatar',NULL,NULL,'Katar',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1379,'Qnt',NULL,NULL,'Qnt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1380,'Quality of Images',NULL,NULL,'Qualität der Bilder',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1381,'Question',NULL,NULL,'Frage',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1382,'Queue Driver',NULL,NULL,'Warteschlangenfahrer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1383,'RC Apple Id',NULL,NULL,'RC Apple ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1384,'RC Entitlement Id',NULL,NULL,'RC -Berechtigungs -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1385,'RC Google Id',NULL,NULL,'RC Google ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1386,'RC Package Id',NULL,NULL,'RC -Paket -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1387,'Read More',NULL,NULL,'Mehr lesen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1388,'Realistic',NULL,NULL,'Realistisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1389,'Recently Launched',NULL,NULL,'Kürzlich gestartet',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1390,'Record audio',NULL,NULL,'Audio aufnehmen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1391,'Redis Driver',NULL,NULL,'Redis -Fahrer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1392,'Redis Host',NULL,NULL,'Redis Host',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1393,'Redis Password',NULL,NULL,'Redis Passwort',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1394,'Redis Port',NULL,NULL,'Redis -Port',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1395,'Redo',NULL,NULL,'Wiederholen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1396,'Reference ID',NULL,NULL,'Referenz -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1397,'Referral Program',NULL,NULL,'Überweisungsprogramm',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1398,'Regenerate',NULL,NULL,'Regenerieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1399,'Register',NULL,NULL,'Registrieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1400,'Registration Active',NULL,NULL,'Registrierung aktiv',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1401,'Registration is currently unavailable.',NULL,NULL,'Die Registrierung ist derzeit nicht verfügbar.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1402,'Regular',NULL,NULL,'Regulär',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1403,'Reinstall Language Files',NULL,NULL,'Installieren Sie Sprachdateien neu',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1404,'Remaining',NULL,NULL,'Übrig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1405,'Remaining Credits',NULL,NULL,'Verbleibende Credits',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1406,'Remaining Images',NULL,NULL,'Verbleibende Bilder',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1407,'Remaining Words',NULL,NULL,'Verbleibende Wörter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1408,'Remember Your Password?',NULL,NULL,'Erinnerst du dich an dein Passwort?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1409,'Remember me',NULL,NULL,'Erinnere dich an mich',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1410,'Remove',NULL,NULL,'Entfernen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1411,'Remove all products and prices defined before for old settings.',NULL,NULL,'Entfernen Sie alle Produkte und Preise, die zuvor für alte Einstellungen definiert wurden.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1412,'Remove all webhooks defined before and create new webhook.',NULL,NULL,'Entfernen Sie alle zuvor definierten Webhooks und erstellen Sie neue Webhook.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1413,'Renaissance',NULL,NULL,'Renaissance',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1414,'Rename',NULL,NULL,'Umbenennen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1415,'Rename File',NULL,NULL,'Datei umbenennen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1416,'Rename Folder',NULL,NULL,'Ordner umbenennen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1417,'Reset Password',NULL,NULL,'Passwort zurücksetzen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1418,'Responsive Dashboard',NULL,NULL,'Responsives Dashboard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1419,'Result',NULL,NULL,'Ergebnis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1420,'Retina Logos (2x) - Optional',NULL,NULL,'Retina -Logos (2x) - Optional',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1421,'Retro',NULL,NULL,'Retro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1422,'Reunion',NULL,NULL,'Wiedervereinigung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1423,'Revenue',NULL,NULL,'Einnahmen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1424,'RevenueCat Apple Product Id',NULL,NULL,'Revenuecat Apple Product ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1425,'RevenueCat Entitlement Id',NULL,NULL,'Revenuecat -Anspruchs -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1426,'RevenueCat Google Product Id',NULL,NULL,'Revenuecat Google -Produkt -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1427,'RevenueCat Package Id',NULL,NULL,'Revenuecat -Paket -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1428,'Role',NULL,NULL,'Rolle',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1429,'Romania',NULL,NULL,'Rumänien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1430,'Romanian',NULL,NULL,'rumänisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1431,'Romanian (Romania)',NULL,NULL,'Rumänisch (Rumänien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1432,'Russian',NULL,NULL,'Russisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1433,'Russian (Russia)',NULL,NULL,'Russisch (Russland)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1434,'Russian Federation',NULL,NULL,'Russische Föderation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1435,'Rwanda',NULL,NULL,'Ruanda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1436,'SEO',NULL,NULL,'SEO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1437,'SEO Copywriting',NULL,NULL,'SEO -Texten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1438,'SEO Description',NULL,NULL,'SEO -Beschreibung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1439,'SEO Title',NULL,NULL,'SEO -Titel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1440,'SIMPLE',NULL,NULL,'EINFACH',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1441,'SLOW',NULL,NULL,'LANGSAM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1442,'SLOWER',NULL,NULL,'LANGSAMER',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1443,'SLOWEST',NULL,NULL,'Langsamste',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1444,'SMTP',NULL,NULL,'SMTP',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1445,'SMTP Encryption',NULL,NULL,'SMTP -Verschlüsselung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1446,'SMTP Host',NULL,NULL,'SMTP -Host',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1447,'SMTP Password',NULL,NULL,'SMTP -Passwort',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1448,'SMTP Port',NULL,NULL,'SMTP -Port',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1449,'SMTP Sender Email',NULL,NULL,'SMTP -Absender -E -Mail',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1450,'SMTP Sender Name',NULL,NULL,'SMTP -Absendername',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1451,'SMTP Settings',NULL,NULL,'SMTP -Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1452,'SMTP Test',NULL,NULL,'SMTP -Test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1453,'SMTP Username',NULL,NULL,'SMTP -Benutzername',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1454,'Saint Helena',NULL,NULL,'Saint Helena',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1455,'Saint Kitts and Nevis',NULL,NULL,'Saint Kitts und Nevis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1456,'Saint Lucia',NULL,NULL,'Saint Lucia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1457,'Saint Pierre and Miquelon',NULL,NULL,'Saint Pierre und Miquelon',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1458,'Saint Vincent and The Grenadines',NULL,NULL,'Saint Vincent und die Grenadinen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1459,'Samoa',NULL,NULL,'Samoa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1460,'San Marino',NULL,NULL,'San Marino',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1461,'Sandbox',NULL,NULL,'Sandkasten',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1462,'Sao Tome and Principe',NULL,NULL,'Sao Tome und Principe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1463,'Sarcastic',NULL,NULL,'Sarkastisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1464,'Saudi Arabia',NULL,NULL,'Saudi-Arabien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1465,'Save',NULL,NULL,'Speichern',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1466,'Save .env',NULL,NULL,'Retten .env',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1467,'Save and Install',NULL,NULL,'Speichern und installieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1468,'Save changes',NULL,NULL,'Änderungen speichern',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1469,'Save gateway settings',NULL,NULL,'Speichern Sie die Gateway -Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1470,'Save your settings.',NULL,NULL,'Speichern Sie Ihre Einstellungen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1471,'Saved to',NULL,NULL,'Gerettet zu',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1472,'Saved. Redirecting...',NULL,NULL,'Gerettet. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1473,'Say goodbye to writer’s block',NULL,NULL,'Verabschieden Sie sich vom Block des Schriftstellers',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1474,'Say goodbye to writer’s block and get more done with our revolutionary tool.',NULL,NULL,'Verabschieden Sie sich vom Block des Schriftstellers und machen Sie sich mehr mit unserem revolutionären Tool aus.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1475,'Seamlessly generate and craft a diverse array of images without ever leaving your chat environment.',NULL,NULL,'Erzeugen Sie nahtlos eine Vielzahl von Bildern und erstellen Sie eine Vielzahl von Bildern, ohne jemals Ihre Chat -Umgebung zu verlassen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1476,'Seamlessly upload any image you want to explore and get insightful conversations.',NULL,NULL,'Laden Sie das Bild, das Sie erforschen möchten, nahtlos hoch, und führen Sie aufschlussreiche Gespräche.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1477,'Search',NULL,NULL,'Suchen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1478,'Search Result for',NULL,NULL,'Suchsergebnis für',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1479,'Search for templates and documents...',NULL,NULL,'Suche nach Vorlagen und Dokumenten ...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1480,'Search in website',NULL,NULL,'Suche in der Website',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1481,'Search results',NULL,NULL,'Suchergebnisse',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1482,'Secretive',NULL,NULL,'Geheimnisvoll',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1483,'Securely process credit card or other electronic payment methods by using payment gateways.',NULL,NULL,'Verarbeiten Sie die Kreditkarte oder andere elektronische Zahlungsmethoden mithilfe von Zahlungsgateways sicher.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1484,'Securely process credit card or other electronic payment methods.',NULL,NULL,'Verarbeiten Sie die Kreditkarte oder andere elektronische Zahlungsmethoden sicher.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1485,'Securely process credit card, debit card, or other methods.',NULL,NULL,'Verarbeiten Sie Kreditkarte, Debitkarte oder andere Methoden sicher.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1486,'See how it works',NULL,NULL,'Sehen Sie, wie es funktioniert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1487,'Select',NULL,NULL,'Wählen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1488,'Select All',NULL,NULL,'Wählen Sie alle aus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1489,'Select Default Language ↓',NULL,NULL,'Wählen Sie Standardsprache ↓',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1490,'Select Folder:',NULL,NULL,'Ordner auswählen:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1491,'Select Input Type',NULL,NULL,'Wählen Sie den Eingabetyp',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1492,'Select Keywords',NULL,NULL,'Wählen Sie Schlüsselwörter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1493,'Select a Plan',NULL,NULL,'Wählen Sie einen Plan aus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1494,'Select a pre-defined template or create your own.',NULL,NULL,'Wählen Sie eine vordefinierte Vorlage oder erstellen Sie Ihre eigene.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1495,'Select a voice',NULL,NULL,'Wählen Sie eine Stimme',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1496,'Select speech language',NULL,NULL,'Wählen Sie Sprachsprache',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1497,'Send',NULL,NULL,'Schicken',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1498,'Send Instructions',NULL,NULL,'Anweisungen senden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1499,'Send Request',NULL,NULL,'Anfrage senden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1500,'Senegal',NULL,NULL,'Senegal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1501,'Seo Settings',NULL,NULL,'SEO -Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1502,'Serbia',NULL,NULL,'Serbien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1503,'Serbian',NULL,NULL,'serbisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1504,'Serbian (Cyrillic)',NULL,NULL,'Serbisch (kyrillisch)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1505,'Serper API',NULL,NULL,'Serper -API',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1506,'Serper API Key',NULL,NULL,'Serper -API -Schlüssel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1507,'Serper API Settings',NULL,NULL,'Serper -API -Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1508,'Server Details',NULL,NULL,'Serverdetails',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1509,'Server Error. This error is logged and our technic team will resolve this issue in short time.',NULL,NULL,'Serverfehler. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1510,'Server Requirements',NULL,NULL,'Serveranforderungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1511,'Session Driver',NULL,NULL,'Sitzungstreiber',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1512,'Set as Sent',NULL,NULL,'Festgelegt wie gesendet',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1513,'Set mode to Development',NULL,NULL,'Setzen Sie den Modus auf die Entwicklung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1514,'Set mode to Production',NULL,NULL,'Setzen Sie den Modus auf Produktion',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1515,'Settings',NULL,NULL,'Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1516,'Setup',NULL,NULL,'Aufstellen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1517,'Setup Application',NULL,NULL,'Setup -Anwendung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1518,'Setup Database',NULL,NULL,'Setup -Datenbank',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1519,'Seychelles',NULL,NULL,'Seychellen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1520,'Share on',NULL,NULL,'Teilen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1521,'Shortened name of the template or human name. Maximum 3 letters is suggested.',NULL,NULL,'Verkürzter Name der Vorlage oder des menschlichen Namens. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1522,'Show',NULL,NULL,'Zeigen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1523,'Show More',NULL,NULL,'Zeigen Sie mehr',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1524,'Show more',NULL,NULL,'Zeigen Sie mehr',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1525,'Show on the Login Page',NULL,NULL,'Auf der Anmeldeseite anzeigen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1526,'Show password',NULL,NULL,'Passwort anzeigen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1527,'Showing',NULL,NULL,'Zeigen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1528,'Sierra Leone',NULL,NULL,'Sierra Leone',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1529,'Sign In',NULL,NULL,'Anmelden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1530,'Sign In Text',NULL,NULL,'Melden Sie sich im Text an',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1531,'Sign Up',NULL,NULL,'Melden Sie sich an',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1532,'Sign Up Text',NULL,NULL,'Text anmelden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1533,'Sign in',NULL,NULL,'anmelden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1534,'Sign up',NULL,NULL,'Melden Sie sich an',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1535,'Sign up and receive 20% bonus discount on checkout.',NULL,NULL,'Melden Sie sich an und erhalten Sie einen Bonusrabatt von 20% an der Kasse.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1536,'Simple Pricing.',NULL,NULL,'Einfache Preisgestaltung.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1537,'Simply input some basic information or keywords about your brand.',NULL,NULL,'Geben Sie einfach einige grundlegende Informationen oder Schlüsselwörter über Ihre Marke ein.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1538,'Simply upload a file (PDF, CSV, .doc or .docx) and extract key insights or summarize the entire document.',NULL,NULL,'Laden Sie einfach eine Datei (PDF, CSV, .DOC oder .docx) hoch und extrahieren Sie wichtige Erkenntnisse oder fassen Sie das gesamte Dokument zusammen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1539,'Singapore',NULL,NULL,'Singapur',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1540,'Site Email',NULL,NULL,'Site -E -Mail',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1541,'Site Favicon',NULL,NULL,'Site Favicon',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1542,'Site Health',NULL,NULL,'Standortgesundheit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1543,'Site Logo',NULL,NULL,'Site -Logo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1544,'Site Logo (Dark',NULL,NULL,'Site -Logo (dunkel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1545,'Site Logo (Dark)',NULL,NULL,'Site -Logo (dunkel)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1546,'Site Logo Sticky',NULL,NULL,'Site -Logo klebrig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1547,'Site Name',NULL,NULL,'Standortname',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1548,'Site URL',NULL,NULL,'Site URL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1549,'Size (Optional)',NULL,NULL,'Größe (optional)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1550,'Skip this step',NULL,NULL,'Überspringen Sie diesen Schritt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1551,'Slovak',NULL,NULL,'slowakisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1552,'Slovak (Slovakia)',NULL,NULL,'Slowakische (Slowakei)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1553,'Slovakia',NULL,NULL,'Slowakei',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1554,'Slovenia',NULL,NULL,'Slowenien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1555,'Slovenian',NULL,NULL,'Slowenisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1556,'Slovenian (Slovenia)',NULL,NULL,'Slowenisch (Slowenien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1557,'Slow',NULL,NULL,'Langsam',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1558,'Slug',NULL,NULL,'Slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1559,'So, how does it work?',NULL,NULL,'Wie funktioniert es?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1560,'Social Login',NULL,NULL,'Soziale Login',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1561,'Social Media',NULL,NULL,'Social Media',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1562,'Solomon Islands',NULL,NULL,'Solomonen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1563,'Somalia',NULL,NULL,'Somalia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1564,'Some of the inputs were deprecated. Show them and edit.',NULL,NULL,'Einige der Eingaben wurden veraltet. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1565,'Sort by:',NULL,NULL,'Sortieren durch:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1566,'South Africa',NULL,NULL,'Südafrika',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1567,'South Georgia and The South Sandwich Islands',NULL,NULL,'Südgeorgien und die Südsandwichinseln',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1568,'Spain',NULL,NULL,'Spanien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1569,'Spanish',NULL,NULL,'Spanisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1570,'Spanish (Mexico)',NULL,NULL,'Spanisch (Mexiko)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1571,'Spanish (Spain)',NULL,NULL,'Spanisch (Spanien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1572,'Spanish (US)',NULL,NULL,'Spanisch (USA)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1573,'Speech speed',NULL,NULL,'Sprachgeschwindigkeit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1574,'Speeches',NULL,NULL,'Reden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1575,'Sri Lanka',NULL,NULL,'Sri Lanka',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1576,'Stable Diffusion 1.6',NULL,NULL,'Stabile Diffusion 1.6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1577,'Stable Diffusion 2.2.2 Beta',NULL,NULL,'Stabile Diffusion 2.2.2 Beta',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1578,'Stable Diffusion Settings',NULL,NULL,'Stabile Diffusionseinstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1579,'Stable Diffusion XL 0.9',NULL,NULL,'Stabile Diffusion xl 0,9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1580,'Stable Diffusion XL 1.0',NULL,NULL,'Stabile Diffusion xl 1.0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1581,'StableDiffusion',NULL,NULL,'Stabilitätsunterschied',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1582,'StableDiffusion API Secret',NULL,NULL,'STIFLEFENDEFUSION API -Geheimnis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1583,'StableDiffusion Settings',NULL,NULL,'Einstellungen für stellverträte Stifteusion',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1584,'Stablediffusion default model',NULL,NULL,'STABLEDSFUSION -Standardmodell',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1585,'Start Making Money',NULL,NULL,'Geld verdienen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1586,'Start your free trial.',NULL,NULL,'Starten Sie Ihre kostenlose Testversion.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1587,'Status',NULL,NULL,'Status',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1588,'Steampunk',NULL,NULL,'Steampunk',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1589,'Step 1 | Server Requirements',NULL,NULL,'Schritt 1 | ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1590,'Step 2 | Permissions',NULL,NULL,'Schritt 2 | ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1591,'Step 3 | Environment Settings',NULL,NULL,'Schritt 3 | ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1592,'Step 3 | Environment Settings | Classic Editor',NULL,NULL,'Schritt 3 | ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1593,'Step 3 | Environment Settings | Guided Wizard',NULL,NULL,'Schritt 3 | ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1594,'Sticker',NULL,NULL,'Aufkleber',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1595,'Stop',NULL,NULL,'Stoppen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1596,'Stop recording',NULL,NULL,'Hören Sie auf, die Aufnahme abzubauen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1597,'Storage',NULL,NULL,'Lagerung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1598,'String',NULL,NULL,'Saite',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1599,'Strings saved successfully',NULL,NULL,'Saiten erfolgreich gerettet',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1600,'Stripe Api Key (Stripe Key)',NULL,NULL,'Streifen -API -Schlüssel (Streifenschlüssel)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1601,'Stripe Base URL (https://api.stripe.com)',NULL,NULL,'Stripe Base URL (https://api.stripe.com)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1602,'Stripe Price Id',NULL,NULL,'Streifenpreis -ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1603,'Stripe Secret Key (Stripe Secret)',NULL,NULL,'Stripe Secret Key (Stripe Secret)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1604,'Stripe Settings',NULL,NULL,'Streifeneinstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1605,'Studio',NULL,NULL,'Studio',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1606,'Subject',NULL,NULL,'Thema',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1607,'Subscribe',NULL,NULL,'Abonnieren',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1608,'Subscription',NULL,NULL,'Abonnement',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1609,'Subscription Payment',NULL,NULL,'Abonnementzahlung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1610,'Subscription Plan Payment',NULL,NULL,'Abonnementplanzahlung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1611,'Subscription Plans',NULL,NULL,'Abonnementpläne',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1612,'Subscription is ACTIVE',NULL,NULL,'Abonnement ist aktiv',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1613,'Subscription status',NULL,NULL,'Abonnementstatus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1614,'Subscriptions and Packs',NULL,NULL,'Abonnements und Packungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1615,'Subtitle One',NULL,NULL,'Untertitel eins',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1616,'Subtitle Two',NULL,NULL,'Untertitel zwei',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1617,'Subtotal',NULL,NULL,'Zwischensumme',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1618,'Succesfull Withdrawal Requests',NULL,NULL,'Erfolgreiche Auszahlungsanfragen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1619,'Success',NULL,NULL,'Erfolg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1620,'Successfully Generated',NULL,NULL,'Erfolgreich erzeugt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1621,'Sudan',NULL,NULL,'Sudan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1622,'Summarize a book for Research',NULL,NULL,'Fassen Sie ein Buch für die Forschung zusammen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1623,'Support',NULL,NULL,'Unterstützung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1624,'Support Category',NULL,NULL,'Unterstützungskategorie',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1625,'Support Platform',NULL,NULL,'Support -Plattform',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1626,'Support Priority',NULL,NULL,'Priorität unterstützen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1627,'Support Request',NULL,NULL,'Support -Anfrage',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1628,'Support Requests',NULL,NULL,'Supportanfragen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1629,'Suriname',NULL,NULL,'Suriname',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1630,'Surname',NULL,NULL,'Nachname',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1631,'Svalbard and Jan Mayen',NULL,NULL,'Svalbard und Jan Mayen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1632,'Swahili (Kenya)',NULL,NULL,'Swahili (Kenia)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1633,'Swaziland',NULL,NULL,'Swasiland',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1634,'Sweden',NULL,NULL,'Schweden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1635,'Swedish',NULL,NULL,'Schwedisch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1636,'Swedish (Sweden)',NULL,NULL,'Schwedisch (Schweden)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1637,'Swift',NULL,NULL,'Schnell',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1638,'Switzerland',NULL,NULL,'Schweiz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1639,'Syrian Arab Republic',NULL,NULL,'Syrische arabische Republik',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1640,'TTS',NULL,NULL,'TTS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1641,'TTS Settings',NULL,NULL,'TTS -Einstellungen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1642,'TTS-1',NULL,NULL,'TTS-1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1643,'TTS-1-HD',NULL,NULL,'TTS-1-HD',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1644,'Tag',NULL,NULL,'Etikett',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1645,'Tags:',NULL,NULL,'Tags:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1646,'Taiwan',NULL,NULL,'Taiwan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1647,'Tajikistan',NULL,NULL,'Tadschikistan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1648,'Take a backup before process!',NULL,NULL,'Nehmen Sie vor dem Prozess ein Backup!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1649,'Take me home',NULL,NULL,'Bring mich nach Hause',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1650,'Tamil',NULL,NULL,'Tamil',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1651,'Tamil (India)',NULL,NULL,'Tamil (Indien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1652,'Tanzania, United Republic of',NULL,NULL,'Tansania, Vereinigte Republik von',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1653,'Technical Issue',NULL,NULL,'Technisches Problem',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1654,'Telegram Channel',NULL,NULL,'Telegrammkanal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1655,'Telugu',NULL,NULL,'Telugu',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1656,'Telugu (India)',NULL,NULL,'Telugu (Indien)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1657,'Template',NULL,NULL,'Vorlage',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1658,'Template Access',NULL,NULL,'Vorlagezugriff',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1659,'Template Category',NULL,NULL,'Vorlagenkategorie',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1660,'Template Color',NULL,NULL,'Vorlagefarbe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1661,'Template Description',NULL,NULL,'Vorlage Beschreibung',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1662,'Template Icon',NULL,NULL,'Vorlagensymbol',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1663,'Template Name',NULL,NULL,'Vorlagenname',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1664,'Template Role',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1665,'Template Short Name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1666,'Template Title',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1667,'Template title.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1668,'Templates',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1669,'Terms & Conditions',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1670,'Terms and Conditions',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1671,'Test Credentials',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1672,'Test Email',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1673,'Testimonial',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1674,'Testimonial Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1675,'Testimonials',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1676,'Testimonials Active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1677,'Testimonials Section',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1678,'Testimonials Subtitle One',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1679,'Testimonials Subtitle Two',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1680,'Testimonials Title',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1681,'Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1682,'Text Generator & AI Copywriting Assistant',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1683,'Text-to-Image',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1684,'Textarea Field',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1685,'Thai',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1686,'Thai (Thailand)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1687,'Thailand',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1688,'Thank you for your payment!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1689,'Thank you very much for doing business with us. We look forward to working with you again!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1690,'Thanks for purchashing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1691,'Thanks for purchasing MagicAI! You can now install your product in seconds and unlock the magic of AI. Let\'s get you started!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1692,'Thanks for purchasing MagicAI! You can now install your product in seconds and unlock the magic of AI. Let’s get you started!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1693,'Thanks for your purchase...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1694,'The Following errors occurred:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1695,'The Future of Copy.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1696,'The future of AI.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1697,'The future of development',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1698,'The maximum output length is set above 2000. Are you sure you want to continue?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1699,'The maximum output length refers to the point at which the AI-generated response will stop. It can occur when the response reaches 4096 bytes or when the generat...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1700,'The process is simple. All you have to do is provide a topic or idea, and our AI-based text generator will take care of the rest.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1701,'The system has maintenance! We will back in short time!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1702,'There is 1 update.|There are :number updates.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1703,'There is a mistake for you purchaes. Please try again',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1704,'There is no coupons yet',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1705,'There is no succesfull withdrawal request',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1706,'There is no users used the coupon yet',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1707,'There is no withdrawal request',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1708,'These values are generated for you',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1709,'This feature is disabled in Demo version',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1710,'This process will take time. So, please be patient and wait until success message appears.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1711,'This setting is in early alpha stage. Please do not activate until offically released.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1712,'This will affect the button style',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1713,'Ticked ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1714,'Ticket',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1715,'Ticket Category',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1716,'Ticket Status',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1717,'Ticket Subject',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1718,'Tile Texture',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1719,'Timor-leste',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1720,'Title',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1721,'Title Topic(Optional)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1722,'To access this page, you should upgrade to Extended License.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1723,'To use live settings:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1724,'To use sandbox settings:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1725,'Togo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1726,'Tokelau',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1727,'Token Pack',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1728,'Token Packs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1729,'Token is missing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1730,'Tokens',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1731,'Tone of Voice',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1732,'Tonga',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1733,'Tools Active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1734,'Tools Description',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1735,'Tools Section',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1736,'Tools Title',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1737,'Top Button Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1738,'Top Button URL (Please enter full url)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1739,'Top Countries',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1740,'Topic',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1741,'Total',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1742,'Total Due',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1743,'Total Images',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1744,'Total Sales',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1745,'Total Words',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1746,'Total sales',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1747,'Track a wide range of data points, including user traffic and sales.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1748,'Track, analyze and access.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1749,'Transcribe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1750,'Transcribe your speech into text.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1751,'Transcription',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1752,'Translate a book',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1753,'Translation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1754,'Trial Days',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1755,'Trinidad and Tobago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1756,'True',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1757,'Trusted by millions.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1758,'Trustpilot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1759,'Tunisia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1760,'Turbo Writer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1761,'Turkey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1762,'Turkish',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1763,'Turkish (Turkey)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1764,'Turkmenistan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1765,'Turks and Caicos Islands',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1766,'Tuvalu',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1767,'Twitter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1768,'Txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1769,'Type',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1770,'Type a message',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1771,'Type your image title or description what you are looking for',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1772,'Type your image title or description what you are looking for.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1773,'Typing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1774,'UPDATE 1.30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1775,'UPDATE 1.35',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1776,'URL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1777,'Uganda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1778,'Ukiyo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1779,'Ukraine',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1780,'Ukrainian',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1781,'Ukrainian (Ukraine)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1782,'Ultimate AI Generator',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1783,'Ultra Fast',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1784,'Unable to save the .env file, Please create it manually.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1785,'Undo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1786,'Unique input name that you can use in your prompts later.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1787,'Unit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1788,'United Arab Emirates',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1789,'United Kingdom',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1790,'United States',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1791,'United States Minor Outlying Islands',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1792,'Unleash the Power of AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1793,'Unleash your creativity',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1794,'Unlimited',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1795,'Unlimited Words',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1796,'Unlock your business potential by letting the AI work and generate money for you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1797,'Unselect All',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1798,'Unsplash API',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1799,'Unsplash API Key',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1800,'Unsplash API Settings',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1801,'Untitled Document...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1802,'Update',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1803,'Update Now',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1804,'Update Plan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1805,'Update the memory_limit value',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1806,'Updated At',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1807,'Updated On',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:17','2026-09-12 20:18:17',NULL),(1808,'Upgrade',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1809,'Upgrade License',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1810,'Upload Image',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1811,'Upload a document or image',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1812,'Upload an image and ask me anything',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1813,'Upload, Analyze, Generate.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1814,'Upscaling',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1815,'Urdu',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1816,'Uruguay',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1817,'Use Form Wizard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1818,'Real-Time Data',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1819,'Used',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1820,'User',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1821,'User Access',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1822,'User Dashboard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1823,'User Input Groups',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1824,'User Management',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1825,'Users',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1826,'Using Date',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1827,'Uzbekistan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1828,'VIP Support',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1829,'Valuable insight and analytics, monitor user activity and manage site settings.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1830,'Vanuatu',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1831,'Vaporwave',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1832,'Vat Due',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1833,'Vat Rate',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1834,'Vector',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1835,'Venezuela',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1836,'Version',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1837,'Very Slow',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1838,'Video',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1839,'Video Script',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1840,'Viet Nam',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1841,'Vietnamese',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1842,'Vietnamese (Vietnam)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1843,'View',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1844,'View Log File',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1845,'View and edit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1846,'View, edit or export your result with a few clicks. And you’re done!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1847,'Virgin Islands, British',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1848,'Virgin Islands, U.S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1849,'Virgin Islands, U.S.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1850,'Vision AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1851,'Visit App Store',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1852,'Voice',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1853,'Volume Based Pricing.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1854,'Wait x seconds after the speech. Represents the time before the next sentence.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1855,'Wallis and Futuna',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1856,'Warm',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1857,'Warning',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1858,'Watercolor',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1859,'We are sorry but the page you are looking for was not found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1860,'Website',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1861,'Welcome',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1862,'Western Sahara',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1863,'What happens when you save?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1864,'What is this article about?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1865,'What kind of support is available for AI copywriting tools?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1866,'When you make online payments, your data is securely transmitted through a protected socket layer to a payment processor. The payment processor uses tokenization',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1867,'While saving, all active membership plans\' keys will be created. So, please be patient and wait until success message appears.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1868,'Who Can Use Section',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1869,'Who is script for section',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1870,'Will refill automatically in',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1871,'Window closed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1872,'With our intuitive interface and powerful features, you can easily edit, export or publish your AI-generated result.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1873,'Withdrawal Form',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1874,'Withdrawal Requests',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1875,'Witty',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1876,'Word',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1877,'Word Credits',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1878,'Word Tokens',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1879,'Word Tokens Used',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1880,'Words',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1881,'Words Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1882,'Words Left',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1883,'Workbook',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1884,'Workbooks',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1885,'Writer is designed to help you <strong>generate high-quality texts instantly</strong>, without breaking a sweat. With our intuitive interface and powerful features, you can easily edit, export or publish your AI-generated result.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1886,'Xbox Play',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1887,'Yearly',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1888,'Yemen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1889,'Yes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1890,'You <strong>send your invitation link</strong> to your friends.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1891,'You <strong>start earning commision</strong> from their first purchase',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1892,'You are in Trial time.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1893,'You can add more filters, just add a filter and hit enter.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1894,'You can add more, just add a filter and hit enter.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1895,'You can copy the below info as simple text with Ctrl+C / Ctrl+V:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1896,'You can disable or enable this page. When this option is disabled, the page cannot be accessible to users.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1897,'You can edit your article in documents once it is generated.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1898,'You can enter as much API KEY as you want. Click \"Enter\" after each api key.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1899,'You can enter as much api key as you want. Click \"Enter\" after each api key.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1900,'You can select speech model',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1901,'You can select speech voice',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1902,'You can select speech voice. Female, Male, and type',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1903,'You can use HTML. Not: All html elements not competible for mails.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1904,'You can use this tags',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1905,'You have an active subscription.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1906,'You have completed the smart installation. You can now register your product in 10 seconds unlock exclusive features.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1907,'You have currently',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1908,'You have no message... Please start typing.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1909,'You have no subscription at the moment. Please select a subscription plan or a token pack.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1910,'You have no subscription at the moment. Please select a subscription plan or prepaid plan.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1911,'You have no withdrawal request',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1912,'You have subscribed and may have some usage left from your subscription. With this payment it will add more usage to your remaining words and images. And they w',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1913,'You have subscribed and may have some usage left from your subscription. With this payment it will add more usage to your remaining words and images. And they will be reset after your subscription end. Please cancel your subscription first otherwise you accept this issue.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1914,'You may also like',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1915,'Your .env file settings have been saved.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1916,'Your Bank Information',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1917,'Your Documents',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1918,'Your Last Name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1919,'Your Message',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1920,'Your Name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1921,'You are using Extended License.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1922,'Your are using Regular License. Please upgrade to Extended License.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1923,'Your changes will override en.json file!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1924,'Your password',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1925,'Your security is of utmost importance to us. We want to assure you that we do not store your credit card information.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1926,'Your server memory_limit is',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1927,'Your token has been expired. Please go previous page and reload.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1928,'Zambia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1929,'Zimbabwe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1930,'Zip Code',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1931,'alert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1932,'an astronaut riding a horse on mars, hd, dramatic lighting',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1933,'and',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1934,'and create your Liquid account before activating',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1935,'and increase your productivity.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1936,'bleep',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1937,'cardinal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1938,'characters',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1939,'critical',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1940,'currency',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1941,'date',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1942,'debug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1943,'emergency',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1944,'enter string',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1945,'error',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1946,'fraction',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1947,'hours ago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1948,'iOS Development',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1949,'image tokens left.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1950,'in Workbook',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1951,'in format',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1952,'info',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1953,'is available.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1954,'is designed to make coding faster, easier, and more efficient than ever before. Whether you’re a seasoned developer or a coding newbie, our tool will help you streamline your coding process and get your projects up and running in no time.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1955,'is up to date',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1956,'martin-kopecky',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1957,'my-project-123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1958,'notice',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1959,'of',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1960,'on all their purchases.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1961,'or',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1962,'ordinal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1963,'pagination.next',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1964,'pagination.previous',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1965,'per month',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1966,'per year',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1967,'plan.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1968,'preview',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1969,'required',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1970,'results',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1971,'riding horse on mars',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1972,'say-as',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1973,'shimmer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1974,'telephone',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1975,'text generator is designed to help you generate high-quality texts instantly, without breaking a sweat.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1976,'the product page.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1977,'time',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1978,'to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1979,'to verify your purchase.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1980,'tokens left.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1981,'unit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1982,'verbatim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1983,'version',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1984,'visit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1985,'warning',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1986,'with',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1987,'word and',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1988,'write something...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1989,'your@email.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1990,'Åland Islands',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1991,'“Not only did it save me time, but it also helped me produce content that was more engaging and effective than what I had been creating on my own.”',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1992,'AI ReWriter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1993,'AI Chat Image',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1994,'AI Chat PDF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1995,'AI YouTube',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1996,'Join Now',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1997,'7 Day Free Trial',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1998,'No Credit Card',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(1999,'Live Support',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2000,'Powered by',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2001,'Read More Blog Posts',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2002,'AI-Powered Content Generator',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2003,'Try it now',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2004,'Get more done',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2005,'in seconds.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2006,'Meet your',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2007,'co-pilot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2008,'Next-gen automation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2009,'We pride ourselves on offering AI Generators that are unmatched in their quality, versatility, and ease of use. Here’s what sets us apart from the competition:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2010,'One Time Payment',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2011,'Build for everyone.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2012,'“\' . $entry->words . \'”',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2013,'Get started for free',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2014,'Download on AppStore',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2015,'Coming Soon',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2016,'Download from PlayStore',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2017,'Follow on X',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2018,'Facebook Group',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2019,'Refund',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2020,'Contact',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2021,'Your Documents Values',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2022,'Active Workspace:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2023,'a super detailed infographic of a working time machine 8k',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2024,'hedgehog smelling a flower',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2025,'Freeform ferrofluids, beautiful dark chaos',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2026,'a home built in a huge Soap bubble, windows',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2027,'photo of an extremely cute alien fish swimming an alien habitable underwater planet',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2028,'DALL-E',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2029,'Stable Diffusion',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2030,'Loading more',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2031,'All images loaded',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2032,'Image Details',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2033,'Copied prompt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2034,'Remove item',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2035,'Read more',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2036,'Robot hand',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2037,'technology.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2038,'Lates news & articles',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2039,'<strong>We\\\'ve brought together</strong> the exciting developments for you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2040,'Custom promt templates',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2041,'Robot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2042,'The future of AI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2043,'LET’S MEET',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2044,'We offer a wide range of content creation capabilities, <span class=\"text-heading-foreground\">from text to images, videos to audio files.</span>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2045,'Step by step',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2046,'FELXIBLE. Versatile.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2047,'Flexible pricing options that allow you to choose the best fit for your requirements',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2048,'Lifetime',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2049,'Pre-Paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2050,'“\' . $item->words . \'”',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2051,'Build for everyone',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2052,'High potential',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2053,'While making content creation effortless for users, it maximizes the quality of the results.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2054,'This feature is disabled in Demo version.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2055,'Move Document',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2056,'Move to folder',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2057,'Favorite',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2058,'Hold cmd(on mac) or ctrl(on pc) to select multiple items.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2059,'New value',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2060,'Toggle dark/light',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2061,'Skip to content',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2062,'AI Editor',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2063,'AI Video',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2064,'AI File Chat',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2065,'AI RSS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2066,'AI Voice Clone',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2067,'Team',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2068,'Brand Voice',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2069,'API Keys',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2070,'Integration',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2071,'Themes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2072,'Chat Settings',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2073,'Floating Chat Settings',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2074,'Auth Settings',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2075,'Bank Transactions',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2076,'Trial Features',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2077,'ChatBot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2078,'Premium Support',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2079,'Premium Membership',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2080,'Looks like you’re lost.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2081,'We can’t seem to find the page you’re looking for.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2082,'If this is an error it will be logged and our technic team will resolve it shortly.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2083,'Take me back to the homepage',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2084,'No ads created yet',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2085,'My Advertis',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2086,'Order ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2087,'Proof Of Purchase',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2088,'One Time',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2089,'User:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2090,'Email:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2091,'Plan name:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2092,'Plan price:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2093,'Tax Rate:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2094,'Tax:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2095,'Total:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2096,'Change Order Status',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2097,'Current Status',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2098,'Select Status',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2099,'Waiting',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2100,'Approved',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2101,'Rejected',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2102,'Save Changes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2103,'You have the ability to provide directives to your personalized GPT and tailor it according to your preferences, ensuring it aligns seamlessly with your brand and tone.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2104,'Train AI on your own data (website or PDF) and make your AI content exclusive.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2105,'Add New Chatbot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2106,'Created',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2107,'Are you sure you want to delete the chatbot?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2108,'UPLOAD PDF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2109,'Upload a PDF File (Max: 25Mb)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2110,'Add Q/A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2111,'Type your question here',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2112,'Type your answer here',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2113,'Manage Content',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2114,'Add Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2115,'Type your title here',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2116,'Type your text here',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2117,'Add URL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2118,'Select Pages',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2119,'Show ChatBot Ballon on',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2120,'Disabled',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2121,'Both',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2122,'Position',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2123,'Top Left',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2124,'Top Right',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2125,'Bottom Right',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2126,'Bottom Left',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2127,'Message Limit per day',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2128,'First Message',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2129,'Instructions',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2130,'You can provide instructions to your GPT-3 model to ensure it aligns with your brand and tone.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2131,'Disable if user not logged in?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2132,'Show timestamp?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2133,'Q&A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2134,'You can deploy your trained chatbot to an existing AI Chat template. Simply navigate to Chat Templates select Edit Template, and assign your chatbot there.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2135,'Trial Feature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2136,'Inactive',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2137,'Tax Setting',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2138,'Tax Rate (%)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2139,'Editing the tax will have no impact on existing users or lead to cancellations.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2140,'Payment Intructions',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2141,'Bank Account Details',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2142,'In RevenueCat dashboard, create only one instance of offerings and set it as default. Mobile app checks for default offering and searches given package and entitlement ids in there.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2143,'Congate or Razorpay subscriptions require you to set up cron jobs on your server. You can find detailed instructions in ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2144,'the documentation.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2145,'If you use razorpay, don\\\'t forget to add a webhook. \' . \\App\\Helpers\\Classes\\Helper::setting(\'site_url',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2146,'Choose Available Templates',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2147,'documentation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2148,'Trial days cannot be set for free and lifetime plans.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2149,'7 Days',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2150,'14 Days',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2151,'0 - No Trial',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2152,'1 Day',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2153,'$i Days',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2154,'Renewal Type',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2155,'Lifetime - Monthly Renewal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2156,'Lifetime - Yearly Renewal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2157,'Is team plan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2158,'A team will be create in this plan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2159,'Number of Seats',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2160,'Davinci',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2161,'ChatGPT 3.5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2162,'ChatGPT 4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2163,'Frequency',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2164,'Sign Pages',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2165,'ْuse custom image',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2166,'Login Image',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2167,'Edit F.A.Q',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2168,'Add New F.A.Q',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2169,'Edit Feature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2170,'Add New Feature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2171,'Edit Generator',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2172,'Add Generator',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2173,'Deprecated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2174,'Edit Tool',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2175,'Add New Tool',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2176,'Site Logs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2177,'Bottom Line Text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2178,'Bottom line text. Accepts <a> tags for links',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2179,'Update License',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2180,'How can i upgrade?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2181,'Select a payment method',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2182,'How do you want to pay? Select a payment method to confirm your order',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2183,'Theme',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2184,'Add-on',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2185,'Tax included. Your payment is secured vis SSL.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2186,'Search for add-ons',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2187,'Manage Addons',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2188,'Browse Add-ons',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2189,'Installed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2190,'Tested with MagicAI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2191,'Recently Updated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2192,'About this add-on',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2193,'For a limited time only',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2194,'Free',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2195,'Price is in US dollars. Tax included.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2196,'Buy Now',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2197,'Install Now',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2198,'Details',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2199,'View details',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2200,'Not Installed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2201,'Uninstall',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2202,'System',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2203,'Allison Burgers',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2204,'Finance Expert',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2205,'I can help you with managing your finance',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2206,'Choose any trained chatbot. If you need to train a new chatbot, visit the Chatbot Training',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2207,'Edit Custom Template',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2208,'Add Custom Template',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2209,'Enter Title Here',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2210,'Enter Category Here',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2211,'Selectlist Field',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2212,'Select List Inputs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2213,'Enter Inputs Here',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2214,'Select list inputs for the template.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2215,'Enter Prompt Here',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2216,'Cote D\\\'ivoire',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2217,'Korea, Democratic People\\\'s Republic of',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2218,'Lao People\\\'s Democratic Republic',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2219,'AI advanced editor',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2220,'AI Rewriter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2221,'AI voice clone',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2222,'Team Functionality',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2223,'Chat setting (extension)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2224,'Users API Key Option',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2225,'Upon activating this feature, the admin API key will be deactivated, and users will need to input their own API keys for continued functionality.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2226,'Convert To Users Api',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2227,'Kazakh (Kazakhistan)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2228,'In Words. OpenAI has a hard limit based on Token limits for each model. Refer to OpenAI documentation to learn more. As a recommended by OpenAI, max result length is capped at 2000 tokens',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:18','2026-09-12 20:18:18',NULL),(2229,'The maximum output length refers to the point at which the AI-generated response will stop. It can occur when the response reaches 4096 bytes or when the generated content is considered sufficient for the given context.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2230,'Fine Tune',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2231,'Add Fine Tune',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2232,'Custom Name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2233,'File ID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2234,'Bytes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2235,'Base Model',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2236,'Fine Tuned Model',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2237,'Enter name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2238,'Purpose',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2239,'Select File (JSON)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2240,'Fine Tune Created!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2241,'Are you sure?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2242,'Model under on process. Reload the page before delete!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2243,'Fine Tune Deleted!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2244,'Cloudflare R2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2245,'Themes and skins',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2246,'Back to themes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2247,'About this theme',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2248,'Finance Management',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2249,'No users found.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2250,'User Informations are hidden in demo due to GDPR. See',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2251,'What is GDPR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2252,'Re-Password',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2253,'Repeat password',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2254,'User Information',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2255,'Username',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2256,'User Since',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2257,'Manage Subscription',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2258,'Current Subscription',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2259,'Assign or delete user subscription.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2260,'Assign Pack',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2261,'Assign token pack.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2262,'word',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2263,'image',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2264,'Are you sure you want to cancel the plan?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2265,'Select Subscription Plan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2266,'Please note: Only Free and Lifetime plans are currently available.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2267,'Add new user',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2268,'Search users',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2269,'Add voice',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2270,'Voice training',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2271,'Voice id',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2272,'Tags of the post. Useful for filtering in the blog posts.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2273,'MagicAI Bot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2274,'I am AI Assistant. How can I help you?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2275,'You are a assistant and your name is MagicAI.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2276,'Custom Width',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2277,'Custom Height',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2278,'Manage ChatBot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2279,'Your message',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2280,'now',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2281,'Email Title',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2282,'Send email',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2283,'Receiver',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2284,'Please only include users available in the system, and if you have used {user_name} in the template, you should be mindful of this.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2285,'All customers',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2286,'Registration is complete. Redirecting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2287,'New conversation created successfully.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2288,'Conversation deleted successfully.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2289,'Analyzing uploaded file.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2290,'Analyzing file is done. You can start the conversation.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2291,'Titlebar Status',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2292,'New Support Request',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2293,'Create new support request. We will answer as soon as possible.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2294,'Affilated Users',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2295,'<strong>They subscribe</strong> to a paid plan by using your refferral link.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2296,'Affiliated Users',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2297,'Search for username',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2298,'Start Date',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2299,'End Date',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2300,'You have no affiliate users',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2301,'Integrate your own personal OpenAI API Key and generate AI content.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2302,'Api Keys Setting',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2303,'Api Keys Secret',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2304,'Riding horse on mars',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2305,'New Image',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2306,'Manage Voices',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2307,'New Company',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2308,'Company',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2309,'Company Name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2310,'Enter the name of your company or organization.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2311,'The official name of your business entity.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2312,'Industry',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2313,'The field or sector of business activity your company primarily belongs to.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2314,'A concise summary describing your company, its mission, and what sets it apart.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2315,'Provide a brief description of your company.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2316,'Please provide the full web address (URL) of your company’s official website.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2317,'Enter the URL of your company’s website.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2318,'Tagline',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2319,'A memorable and succinct phrase encapsulating your company’s mission or value proposition.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2320,'Write a catchy tagline for your company.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2321,'Target Audience',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2322,'Describe the primary demographic or audience your company is targeting.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2323,'Brand Color',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2324,'Products or Services',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2325,'The primary item or service your company provides to its customers.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2326,'Service',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2327,'Explain the features of your Product/Service.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2328,'Key Features',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2329,'Describe the key services your company offers to its clients or customers.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2330,'Have a coupon?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2331,'Tax',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2332,'Team allow seats',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2333,'Bank transfer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2334,'Upon confirmation, your application will be promptly submitted. Following successful payment verification, your plan will be activated. For seamless transactions, please utilize the order ID number as a reference when making payments in the upcoming months.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2335,'Confirm',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2336,'Payment',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2337,'Upon confirmation, your application will be promptly submitted.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2338,'Free Token Pack',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2339,'This pack alredy purchased',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2340,'Buy for free now',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2341,'Payment Succesful',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2342,'Thanks for your purchase! Now, you can explore our AI tools and start generating content in seconds.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2343,'Generate New Content',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2344,' Token Packs ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2345,'Payment for token packs ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2346,'Pay now',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2347,'Start free trial ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2348,'Upload Proof of Purchase',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2349,'Upon confirmation, your application will be promptly submitted. Following successful payment verification, your plan will be activated. To ensure the continuous activation of your plan in the subsequent months, kindly make payments by the end of each recurring payment date. For seamless transactions, please utilize the order ID number as a reference when making payments in the upcoming months.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2350,'Subscribe for free now',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2351,'Continue to Payment with',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2352,'When you make online payments, your data is securely transmitted through a protected socket layer to a payment processor. The payment processor uses tokenization, which means your information is replaced by a random number to represent your payment.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2353,'Plans',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2354,'Back to Dashboard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2355,'Print',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2356,'MagicAI Doc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2357,'Add New Document',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2358,'Keep writing the next paragraph...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2359,'You haven\\\'t created any content',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2360,'Fetch RSS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2361,'Choose a Template',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2362,'Add Information',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2363,'Share post your integrations.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2364,'Share',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2365,'Integration Edit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2366,'Integrations',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2367,'Send blog posts directly to your CMS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2368,'Source Image',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2369,'Drop your image here or browse. 1024x576, 576x1024, 768x768 images are avaiable.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2370,'(Only jpg, png will be accepted)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2371,'Seed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2372,'A specific value from 0 to 4294967294 that is used to guide the randomness of the generation.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2373,'Fidelity',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2374,'A specific value from 0 to 10 to express how strongly the video sticks to the original image.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2375,'Motion intensity',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2376,'Lower values generally result in less motion in the output video, while higher values generally result in more motion. The range is 0 ~ 255',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2377,'All videos loaded',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2378,'Video Details',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2379,'Delete Video',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2380,'Untitled Voice...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2381,'Afrikaans',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2382,'Armenian',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2383,'Azerbaijani',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2384,'Belarusian',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2385,'Bosnian',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2386,'Chinese',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2387,'Kannada',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2388,'Macedonian',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2389,'Marathi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2390,'Maori',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2391,'Nepali',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2392,'Persian',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2393,'Swahili',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2394,'Tagalog',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2395,'Welsh',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2396,'Bengali (India)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2397,'Gujarati (India)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2398,'Audio Files',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2399,'Write something...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2400,'Error deleting folder',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2401,'Folder deleted successfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2402,'Delete all files inside the folder',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2403,'Error updating folder name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2404,'Folder name updated successfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2405,'Folder new name:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2406,'Folder: $currfolder?->name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2407,'Back to documents',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2408,'You don\'t have any documents.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2409,'Start generating texts by adding a document.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2410,'Include Your Brand',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2411,'Select Company',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2412,'Select Product/Service',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2413,'Select Product',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2414,'Enter the RSS URL!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2415,'RSS Fetched Successifuly!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2416,'Effortlessly reshape and elevate your pre-existing content with a single click.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2417,'Mode',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2418,'Output Language',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2419,'Drafts',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2420,'Simply upload a PDF, find specific information. extract key insights or summarize the entire document.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2421,'(Only jpg, png and webp will be accepted)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2422,'Upload Document',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2423,'Add the template',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2424,'Order Ref',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2425,'Order Date/Time',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2426,'My Account',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2427,'Displays the number of words generated by this team member.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2428,'Displays the number of images generated by this team member.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2429,'Set unlimited or limited credits for this user.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2430,'Image Credit Limit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2431,'Set a specific image credit limit for this user. This function works only if unlimited credits are disabled.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2432,'Word Credit Limit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2433,'Set a specific word credit limit for this user. This function works only if unlimited credits are disabled.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2434,'Team Members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2435,'unknown',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2436,'Power Elite Author',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2437,'Favorite Documents',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2438,'Recently Launched Documents',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2439,'Auto Translate (Each click will translate the next 100 key)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2440,'Please Active The MagicAI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2441,'Please enter the URL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2442,'You cannot withdrawal with this amount. Please check',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2443,'Error while sending information. Please contact us.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2444,'Please fill the message field',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2445,'Api Connection Error. You hit the rate limites of openai requests. Please check your Openai API Key',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2446,'Api Connection Error. Please contact system administrator via Support Ticket. Error is: API Connection failed due to API keys',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2447,'Invalid extension. Accepted extensions are mp3, mp4, mpeg, mpga, m4a, wav, and webm',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2448,'This file exceed the limit of file upload',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2449,'Something went wrong. Please reload the page and try it again',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2450,'Please fill all fields in User Group Input areas',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2451,'Workbook Error',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2452,'Settings saved successfully. Redirecting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2453,'Request Sent Succesfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2454,'Invitation Sent Succesfully!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2455,'Page Saved Succesfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2456,'Template Saved Succesfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2457,'Saved Succesfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2458,'Client Saved Succesfully. Redirecting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2459,'Plan Saved Succesfully. Redirecting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2460,'How it Works Step Saved Succesfully. Redirecting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2461,'How it Works Bottom Line updated successfully. Redirecting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2462,'Add-on installed succesfully.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2463,'Add-on uninstalled succesfully.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2464,'Status changed succesfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2465,'Chat Template Saved Succesfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2466,'Settings saved succesfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2467,'Settings saved succesfully. Redirecting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2468,'Faq saved succesfully. Redirecting',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2469,'Item saved succesfully. Redirecting',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2470,'Support Ticket Created Succesfully. Redirecting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2471,'Message sent succesfully. Please Wait',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2472,'Testimonial Saved Succesfully. Redirecting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2473,'User saved succesfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2474,'Workbook saved succesfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2475,'Code copied to clipboard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2476,'Content copied to clipboard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2477,'Affiliate Comission Percentage',NULL,NULL,NULL,'Ποσοστό προμήθειας θυγατρικών',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2478,'Comission Rate',NULL,NULL,NULL,'Ποσοστό προμήθειας',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2479,'AI Bots',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2480,'MagicBots',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2481,'View and manage external chatbots',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2482,'Chat History',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2483,'Create and configure a chatbot that interacts with your users.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2484,'Create and configure a chatbot that interacts with your users, ensuring it delivers accurate information.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2485,'Active Chatbots',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2486,'View Chat History',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2487,'Explore recent conversations from your users.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2488,'Are you sure you want to delete this chatbot?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2489,'Failed to delete chatbot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2490,'Chatbot deleted successfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2491,'Chatbot created successfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2492,'Chatbot updated successfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2493,'This chatbot is not active.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2494,'Chatbot Options',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2495,'Customize',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2496,'Train',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2497,'Test & Embed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2498,'seconds ago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2499,'minute ago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2500,'hour ago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2501,'day ago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2502,'Add File',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2503,'UPLOAD PDF, XLSX, CSV',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2504,'Upload a File (Max: 25Mb)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2505,'UPLOADING...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2506,'Train GPT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2507,'Single URL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2508,'Fetch',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2509,'Configure',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2510,'Bubble Message',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2511,'MagicBot',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2512,'Welcome Message',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2513,'Enter welcome message',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2514,'Chatbot Instructions',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2515,'Explain chatbot role',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2516,'Do Not Go Beyond Instructions',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2517,'Upload Logo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2518,'Select an avatar for your chatbot.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2519,'Choose an accent color that represents your brand.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2520,'Show Logo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2521,'Show Date and Time',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2522,'Transparent Trigger',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2523,'Trigger Avatar Size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2524,'If activated, the trigger will be transparent in idle state. But we add a background to the trigger in active mode to make it more visible.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2525,'Test and Embed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2526,'Your external AI chatbot has been successfully created! You can now integrate it into your website and start engaging with your audience.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2527,'Embed Code',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2528,'Width',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2529,'Height',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2530,'Copy to Clipboard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2531,'Paste this code just before the closing &lt;/body&gt; tag in your HTML file, then save the changes. Refresh your site to ensure your chatbot works correctly.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2532,'This step is optional but highly recommended to personalize your chatbot experience.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2533,'Skip',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2534,'Skip Tour',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2535,'Take a Quick Tour',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2536,'Go to Dashboard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2537,'Hi, how can I help you?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2538,'SupportHub, 3 min ago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2539,'I need to make a refund.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2540,'You, 3 min ago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2541,'A refund will be provided after we process your return item at our facilities. It may take additional time for your financial institution to  process the refund.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2542,'20.08.2024 / 15:29:21',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2543,'Double click to edit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2544,'Mixed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2545,'You have unsaved changes. Are you sure you want to leave?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2546,'Could not fetch templates list. Please try again.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2547,'Could not fetch template data. Please try again.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2548,'All your current edits will be lost. Are you sure?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2549,'Document Deleted Successfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2550,'Duplicated The Document Successfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2551,'Name Updated Successfully',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2552,'Could not save the Canvas data',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2553,'Updating Cart',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2554,'GPT-4 Turbo (Updated Knowleddge cutoff of April 2023, 128k)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2555,'GPT-4 Turbo with vision (Understand images, in addition to all other GPT-4 Turbo capabilites)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2556,'Merketplace',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2557,'OpenAi API Secret',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2558,'Use Real-Time Data',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL),(2559,'Your are using Extended License.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:18:19','2026-09-12 20:18:19',NULL);
/*!40000 ALTER TABLE `strings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_items`
--

DROP TABLE IF EXISTS `subscription_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint unsigned NOT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_product` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_price` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscription_items_subscription_id_stripe_price_unique` (`subscription_id`,`stripe_price`),
  UNIQUE KEY `subscription_items_stripe_id_unique` (`stripe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_items`
--

LOCK TABLES `subscription_items` WRITE;
/*!40000 ALTER TABLE `subscription_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `plan_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_price` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `paid_with` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'stripe',
  `tax_rate` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auto_renewal` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscriptions_stripe_id_unique` (`stripe_id`),
  KEY `subscriptions_plan_id_foreign` (`plan_id`),
  KEY `subscriptions_user_id_stripe_status_index` (`user_id`,`stripe_status`),
  KEY `idx_subscriptions_user_status` (`user_id`,`stripe_status`),
  CONSTRAINT `subscriptions_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions_yokassa`
--

DROP TABLE IF EXISTS `subscriptions_yokassa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions_yokassa` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `plan_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscription_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `next_pay_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tax_rate` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auto_renewal` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `subscriptions_yokassa_plan_id_foreign` (`plan_id`),
  KEY `subscriptions_yokassa_user_id_subscription_status_index` (`user_id`,`subscription_status`),
  CONSTRAINT `subscriptions_yokassa_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions_yokassa`
--

LOCK TABLES `subscriptions_yokassa` WRITE;
/*!40000 ALTER TABLE `subscriptions_yokassa` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions_yokassa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_members`
--

DROP TABLE IF EXISTS `team_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_members` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `team_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'member',
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'waiting',
  `is_human_agent` tinyint(1) NOT NULL DEFAULT '0',
  `allow_unlimited_credits` tinyint(1) NOT NULL DEFAULT '1',
  `daily_shared_credit_limit` decimal(10,4) DEFAULT NULL,
  `remaining_images` decimal(15,2) DEFAULT NULL,
  `remaining_words` decimal(15,2) DEFAULT NULL,
  `used_image_credit` int NOT NULL DEFAULT '0',
  `used_word_credit` int NOT NULL DEFAULT '0',
  `joined_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `team_members_team_id_foreign` (`team_id`),
  KEY `team_members_user_id_foreign` (`user_id`),
  CONSTRAINT `team_members_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `team_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_members`
--

LOCK TABLES `team_members` WRITE;
/*!40000 ALTER TABLE `team_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `entity_credits` json DEFAULT NULL,
  `credit_system_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'separated',
  `shared_credits` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `user_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `allow_seats` int NOT NULL DEFAULT '0',
  `used_image_credit` int NOT NULL DEFAULT '0',
  `word_credit` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_teams_user_id` (`user_id`),
  CONSTRAINT `teams_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES (1,NULL,'separated',0.0000,1,'Admin Admin',0,0,0,'2026-09-12 18:13:49','2026-09-12 18:18:07'),(2,NULL,'separated',0.0000,2,'u_YjjT l_pODh',0,0,0,'2026-09-12 20:31:22','2026-09-12 20:31:22'),(3,NULL,'separated',0.0000,3,'u_CeGj l_gq8g',0,0,0,'2026-09-13 14:47:14','2026-09-13 14:47:14');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telescope_entries`
--

DROP TABLE IF EXISTS `telescope_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telescope_entries` (
  `sequence` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `family_hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `should_display_on_index` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`sequence`),
  UNIQUE KEY `telescope_entries_uuid_unique` (`uuid`),
  KEY `telescope_entries_batch_id_index` (`batch_id`),
  KEY `telescope_entries_family_hash_index` (`family_hash`),
  KEY `telescope_entries_created_at_index` (`created_at`),
  KEY `telescope_entries_type_should_display_on_index_index` (`type`,`should_display_on_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telescope_entries`
--

LOCK TABLES `telescope_entries` WRITE;
/*!40000 ALTER TABLE `telescope_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `telescope_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telescope_entries_tags`
--

DROP TABLE IF EXISTS `telescope_entries_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telescope_entries_tags` (
  `entry_uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`entry_uuid`,`tag`),
  KEY `telescope_entries_tags_tag_index` (`tag`),
  CONSTRAINT `telescope_entries_tags_entry_uuid_foreign` FOREIGN KEY (`entry_uuid`) REFERENCES `telescope_entries` (`uuid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telescope_entries_tags`
--

LOCK TABLES `telescope_entries_tags` WRITE;
/*!40000 ALTER TABLE `telescope_entries_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `telescope_entries_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telescope_monitoring`
--

DROP TABLE IF EXISTS `telescope_monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telescope_monitoring` (
  `tag` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telescope_monitoring`
--

LOCK TABLES `telescope_monitoring` WRITE;
/*!40000 ALTER TABLE `telescope_monitoring` DISABLE KEYS */;
/*!40000 ALTER TABLE `telescope_monitoring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testimonials`
--

DROP TABLE IF EXISTS `testimonials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testimonials` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'assets/img/auth/default-avatar.png',
  `full_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `words` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testimonials`
--

LOCK TABLES `testimonials` WRITE;
/*!40000 ALTER TABLE `testimonials` DISABLE KEYS */;
INSERT INTO `testimonials` VALUES (1,'202306020840avatar-1.jpg','Peline Jan','Entrepreneur','“Not only did it save me time, but it also helped me \nproduce content that was more engaging and \neffective than what I had been creating on my own.”','2023-05-29 19:30:53','2023-06-02 08:40:35'),(2,'202306020840avatar-3.jpg','Tom Daniel','Writer','As a freelance writer, I was looking for a tool that could help me generate ideas and write faster. This AI Text website has done that and more.','2023-05-30 07:52:22','2023-06-02 08:40:47'),(3,'202306020840avatar-2.jpg','Eric Sanchez','UX Designer','The customer support team has been incredibly helpful whenever I’ve had any questions. I can’t imagine going back to my old content-creation methods!','2023-05-30 07:53:14','2023-06-02 08:40:58');
/*!40000 ALTER TABLE `testimonials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'word',
  `entity_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tokens_entity_id_foreign` (`entity_id`),
  CONSTRAINT `tokens_entity_id_foreign` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,'word',1,'2026-09-12 17:01:53','2026-09-12 17:01:53'),(2,'word',2,'2026-09-12 17:01:53','2026-09-12 17:01:53'),(3,'word',3,'2026-09-12 17:01:53','2026-09-12 17:01:53'),(4,'word',4,'2026-09-12 17:01:53','2026-09-12 17:01:53'),(5,'word',5,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(6,'word',6,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(7,'word',7,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(8,'word',8,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(9,'word',9,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(10,'word',10,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(11,'word',11,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(12,'word',12,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(13,'word',13,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(14,'word',14,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(15,'word',15,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(16,'word',16,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(17,'word',17,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(18,'word',18,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(19,'word',19,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(20,'word',20,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(21,'word',21,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(22,'word',22,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(23,'word',23,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(24,'word',24,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(25,'word',25,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(26,'word',26,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(27,'word',27,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(28,'word',28,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(29,'word',29,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(30,'word',30,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(31,'word',31,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(32,'word',32,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(33,'word',33,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(34,'word',34,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(35,'word',35,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(36,'word',36,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(37,'word',37,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(38,'word',38,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(39,'word',39,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(40,'word',40,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(41,'word',41,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(42,'word',42,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(43,'word',43,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(44,'word',44,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(45,'word',45,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(46,'word',46,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(47,'word',47,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(48,'word',48,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(49,'word',49,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(50,'word',50,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(51,'word',51,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(52,'word',52,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(53,'word',53,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(54,'word',54,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(55,'word',55,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(56,'word',56,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(57,'word',57,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(58,'word',58,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(59,'word',59,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(60,'word',60,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(61,'word',61,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(62,'word',62,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(63,'word',63,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(64,'word',64,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(65,'word',65,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(66,'word',66,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(67,'word',67,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(68,'word',68,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(69,'word',69,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(70,'second',70,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(71,'second',71,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(72,'word',72,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(73,'word',73,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(74,'word',74,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(75,'image_to_video',75,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(76,'image',76,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(77,'image',77,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(78,'image',78,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(79,'image',79,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(80,'image',80,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(81,'image',81,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(82,'image',82,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(83,'image',83,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(84,'image',84,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(85,'image',85,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(86,'image',86,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(87,'image',87,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(88,'image',88,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(89,'word',89,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(90,'word',90,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(91,'word',91,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(92,'word',92,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(93,'word',93,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(94,'word',94,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(95,'word',95,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(96,'word',96,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(97,'word',97,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(98,'word',98,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(99,'word',99,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(100,'word',100,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(101,'word',101,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(102,'word',102,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(103,'word',103,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(104,'word',104,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(105,'image',105,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(106,'image',106,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(107,'image',107,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(108,'plagiarism',108,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(109,'text_to_video',109,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(110,'text_to_video',110,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(111,'second',111,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(112,'minute',112,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(113,'image',113,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(114,'word',114,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(115,'word',115,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(116,'image',116,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(117,'image',117,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(118,'image',118,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(119,'character',119,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(120,'character',120,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(121,'character',121,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(122,'character',122,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(123,'minute',123,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(124,'second',124,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(125,'second',125,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(126,'character',126,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(127,'character',127,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(128,'word',128,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(129,'character',129,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(130,'word',130,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(131,'word',131,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(132,'speech_to_text',132,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(133,'image',133,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(134,'image',134,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(135,'image',135,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(136,'image',136,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(137,'image',137,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(138,'character',138,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(139,'character',139,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(140,'word',140,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(141,'word',141,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(142,'word',142,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(143,'word',143,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(144,'word',144,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(145,'word',145,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(146,'word',146,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(147,'word',147,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(148,'word',148,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(149,'word',149,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(150,'word',150,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(151,'presentation',151,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(152,'text_to_video',152,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(153,'text_to_video',153,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(154,'text_to_video',154,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(155,'text_to_video',155,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(156,'text_to_video',156,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(157,'text_to_video',157,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(158,'text_to_video',158,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(159,'text_to_video',159,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(160,'text_to_video',160,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(161,'text_to_video',161,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(162,'text_to_video',162,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(163,'text_to_video',163,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(164,'text_to_video',164,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(165,'text_to_video',165,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(166,'text_to_video',166,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(167,'image',167,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(168,'image',168,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(169,'image',169,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(170,'image',170,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(171,'image',171,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(172,'image',172,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(173,'image',173,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(174,'image',174,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(175,'text_to_video',175,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(176,'image_to_video',176,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(177,'image',177,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(178,'image',178,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(179,'text_to_video',179,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(180,'image_to_video',180,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(181,'text_to_video',181,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(182,'text_to_video',182,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(183,'image_to_video',183,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(184,'text_to_video',184,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(185,'text_to_video',185,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(186,'image_to_video',186,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(187,'text_to_video',187,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(188,'text_to_video',188,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(189,'image_to_video',189,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(190,'text_to_video',190,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(191,'image',191,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(192,'image',192,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(193,'image',193,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(194,'image',194,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(195,'image',195,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(196,'image',196,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(197,'image',197,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(198,'image',198,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(199,'image',199,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(200,'image',200,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(201,'image',201,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(202,'text_to_video',202,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(203,'image_to_video',203,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(204,'text_to_video',204,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(205,'image_to_video',205,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(206,'image_to_video',206,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(207,'text_to_video',207,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(208,'image_to_video',208,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(209,'image_to_video',209,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(210,'image_to_video',210,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(211,'text_to_video',211,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(212,'image_to_video',212,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(213,'text_to_video',213,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(214,'image_to_video',214,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(215,'image_to_video',215,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(216,'text_to_video',216,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(217,'text_to_video',217,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(218,'text_to_video',218,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(219,'text_to_video',219,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(220,'minute',220,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(221,'word',221,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(222,'word',222,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(223,'word',223,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(224,'word',224,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(225,'word',225,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(226,'word',226,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(227,'word',227,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(228,'word',228,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(229,'word',229,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(230,'word',230,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(231,'word',231,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(232,'word',232,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(233,'word',233,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(234,'word',234,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(235,'word',235,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(236,'word',236,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(237,'word',237,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(238,'word',238,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(239,'word',239,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(240,'word',240,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(241,'word',241,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(242,'word',242,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(243,'word',243,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(244,'word',244,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(245,'word',245,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(246,'word',246,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(247,'word',247,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(248,'image',248,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(249,'video_to_video',249,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(250,'video_to_video',250,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(251,'video_to_video',251,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(252,'video_to_video',252,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(253,'video_to_video',253,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(254,'image',254,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(255,'text_to_video',255,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(256,'text_to_video',256,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(257,'text_to_video',257,'2026-09-12 17:01:54','2026-09-12 17:01:54'),(258,'text_to_video',258,'2026-09-12 17:01:54','2026-09-12 17:01:54');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `twitter_settings`
--

DROP TABLE IF EXISTS `twitter_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `twitter_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `consumer_key` text COLLATE utf8mb4_unicode_ci,
  `consumer_secret` text COLLATE utf8mb4_unicode_ci,
  `access_token` text COLLATE utf8mb4_unicode_ci,
  `access_token_secret` text COLLATE utf8mb4_unicode_ci,
  `bearer_token` text COLLATE utf8mb4_unicode_ci,
  `account_id` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `twitter_settings`
--

LOCK TABLES `twitter_settings` WRITE;
/*!40000 ALTER TABLE `twitter_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage`
--

DROP TABLE IF EXISTS `usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usage` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `total_user_count` int unsigned NOT NULL DEFAULT '0',
  `this_week_user_count` int unsigned NOT NULL DEFAULT '0',
  `last_week_user_count` int unsigned NOT NULL DEFAULT '0',
  `total_word_count` int unsigned NOT NULL DEFAULT '0',
  `this_week_word_count` int unsigned NOT NULL DEFAULT '0',
  `last_week_word_count` int unsigned NOT NULL DEFAULT '0',
  `total_image_count` int unsigned NOT NULL DEFAULT '0',
  `this_week_image_count` int unsigned NOT NULL DEFAULT '0',
  `last_week_image_count` int unsigned NOT NULL DEFAULT '0',
  `total_sales` int unsigned NOT NULL DEFAULT '0',
  `this_week_sales` int unsigned NOT NULL DEFAULT '0',
  `last_week_sales` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage`
--

LOCK TABLES `usage` WRITE;
/*!40000 ALTER TABLE `usage` DISABLE KEYS */;
INSERT INTO `usage` VALUES (1,3,3,0,0,0,0,0,0,0,0,0,0,'2026-09-12 17:01:36','2026-09-13 14:47:11');
/*!40000 ALTER TABLE `usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_affiliates`
--

DROP TABLE IF EXISTS `user_affiliates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_affiliates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Waiting',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_affiliates_user_id_foreign` (`user_id`),
  CONSTRAINT `user_affiliates_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_affiliates`
--

LOCK TABLES `user_affiliates` WRITE;
/*!40000 ALTER TABLE `user_affiliates` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_affiliates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_credits`
--

DROP TABLE IF EXISTS `user_credits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_credits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `credits` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_credits`
--

LOCK TABLES `user_credits` WRITE;
/*!40000 ALTER TABLE `user_credits` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_credits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_docs_favorite`
--

DROP TABLE IF EXISTS `user_docs_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_docs_favorite` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `user_openai_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_docs_favorite_user_id_foreign` (`user_id`),
  KEY `user_docs_favorite_user_openai_id_foreign` (`user_openai_id`),
  CONSTRAINT `user_docs_favorite_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_docs_favorite_user_openai_id_foreign` FOREIGN KEY (`user_openai_id`) REFERENCES `user_openai` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_docs_favorite`
--

LOCK TABLES `user_docs_favorite` WRITE;
/*!40000 ALTER TABLE `user_docs_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_docs_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_favorites`
--

DROP TABLE IF EXISTS `user_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_favorites` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `openai_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_favorites_user_id_foreign` (`user_id`),
  KEY `user_favorites_openai_id_foreign` (`openai_id`),
  CONSTRAINT `user_favorites_openai_id_foreign` FOREIGN KEY (`openai_id`) REFERENCES `openai` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_favorites`
--

LOCK TABLES `user_favorites` WRITE;
/*!40000 ALTER TABLE `user_favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_integrations`
--

DROP TABLE IF EXISTS `user_integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_integrations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `integration_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `credentials` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_integrations`
--

LOCK TABLES `user_integrations` WRITE;
/*!40000 ALTER TABLE `user_integrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_integrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_openai`
--

DROP TABLE IF EXISTS `user_openai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_openai` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `is_demo` tinyint(1) DEFAULT '0',
  `request_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` bigint DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `openai_id` bigint unsigned DEFAULT NULL,
  `input` text COLLATE utf8mb4_unicode_ci,
  `response` text COLLATE utf8mb4_unicode_ci,
  `output` text COLLATE utf8mb4_unicode_ci,
  `hash` text COLLATE utf8mb4_unicode_ci,
  `credits` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `words` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_id` bigint unsigned DEFAULT NULL,
  `payload` json DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'COMPLETED',
  `engine` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_openai_openai_id_foreign` (`openai_id`),
  KEY `user_openai_folder_id_foreign` (`folder_id`),
  KEY `user_openai_user_id_updated_at_index` (`user_id`,`updated_at` DESC),
  KEY `idx_user_id_updated_at` (`user_id`,`updated_at`),
  KEY `idx_user_openai_user_team` (`user_id`,`team_id`),
  CONSTRAINT `user_openai_folder_id_foreign` FOREIGN KEY (`folder_id`) REFERENCES `folders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_openai_openai_id_foreign` FOREIGN KEY (`openai_id`) REFERENCES `openai` (`id`) ON DELETE SET NULL,
  CONSTRAINT `user_openai_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_openai`
--

LOCK TABLES `user_openai` WRITE;
/*!40000 ALTER TABLE `user_openai` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_openai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_openai_chat`
--

DROP TABLE IF EXISTS `user_openai_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_openai_chat` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `social_media_analysis_id` bigint unsigned DEFAULT NULL,
  `team_id` bigint DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `chat_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chatbot_id` bigint DEFAULT NULL,
  `openai_chat_category_id` bigint unsigned DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_credits` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_words` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_chatbot` tinyint NOT NULL DEFAULT '0',
  `website_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `reference_url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `doc_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `thread_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0',
  `openai_vector_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `openai_file_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_empty` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_openai_chat_user_id_foreign` (`user_id`),
  KEY `user_openai_chat_openai_chat_category_id_foreign` (`openai_chat_category_id`),
  KEY `user_openai_chat_is_empty_index` (`is_empty`),
  CONSTRAINT `user_openai_chat_openai_chat_category_id_foreign` FOREIGN KEY (`openai_chat_category_id`) REFERENCES `openai_chat_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_openai_chat_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_openai_chat`
--

LOCK TABLES `user_openai_chat` WRITE;
/*!40000 ALTER TABLE `user_openai_chat` DISABLE KEYS */;
INSERT INTO `user_openai_chat` VALUES (2,NULL,NULL,1,'social-media-agent',NULL,1,'Default AI Chat Bot Chat','0','0','2026-09-13 13:34:00','2026-09-13 14:41:24',0,'','','',NULL,0,NULL,NULL,0),(5,NULL,NULL,1,NULL,NULL,14,'VisionAI Chat','0','0','2026-09-13 15:00:16','2026-09-13 15:01:04',0,'','','',NULL,0,NULL,NULL,0);
/*!40000 ALTER TABLE `user_openai_chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_openai_chat_messages`
--

DROP TABLE IF EXISTS `user_openai_chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_openai_chat_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_openai_chat_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `input` text COLLATE utf8mb4_unicode_ci,
  `response` text COLLATE utf8mb4_unicode_ci,
  `output` text COLLATE utf8mb4_unicode_ci,
  `hash` text COLLATE utf8mb4_unicode_ci,
  `credits` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `words` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `images` text COLLATE utf8mb4_unicode_ci,
  `pdfName` text COLLATE utf8mb4_unicode_ci,
  `pdfPath` text COLLATE utf8mb4_unicode_ci,
  `outputImage` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `realtime` tinyint(1) NOT NULL DEFAULT '0',
  `is_chatbot` tinyint NOT NULL DEFAULT '0',
  `used_skills` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_openai_chat_messages_user_openai_chat_id_foreign` (`user_openai_chat_id`),
  KEY `user_openai_chat_messages_user_id_foreign` (`user_id`),
  CONSTRAINT `user_openai_chat_messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_openai_chat_messages_user_openai_chat_id_foreign` FOREIGN KEY (`user_openai_chat_id`) REFERENCES `user_openai_chat` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_openai_chat_messages`
--

LOCK TABLES `user_openai_chat_messages` WRITE;
/*!40000 ALTER TABLE `user_openai_chat_messages` DISABLE KEYS */;
INSERT INTO `user_openai_chat_messages` VALUES (4,2,1,NULL,'First Initiation','Hi! I am Default AI Chat Bot, and I\'m here to answer all your questions','7kZZVzHuoB5xLPZbwJNgpz1Mdlzr0e2spRfvNEhuIA2pFuWs3izgEVNHHGB8N1QETIV3XCSBWpfPjN6aaAMAhnQXoLIxPhM9aT6VpZjtAtyaonRAaSE0X44JzwVuQ1PQvcPeluSNpeDbM0WfA8nBs11iMq7R2DNBMKzGjJOVczJOU9pAoRdoUrxPZD9e8klX38HhDTZou3EhWLTVyYP5Qqi2nF5dvEezQZ49eBbwtKkB8j69pdd1banCxDCQxsHU','0','0','2026-09-13 13:34:00','2026-09-13 13:34:00',NULL,NULL,NULL,NULL,0,0,NULL),(11,2,1,'are you deeseek',NULL,'(If you encounter this message, please attempt to send your message again. If the error persists beyond multiple attempts, please don\'t hesitate to contact us for assistance!)','4EqHymsmnyGcDsJAxi52KoLV1R9hhvBHvuHaKxBpAr9s98BcqdXf9AbSbTarNeh4uyZu3icqlOr7ZfzidBm6PytAgIBc7UNK3mMqwAKuUbM7nmAqLXh3ZohtDshr1SMV8WGk9ZLVezrC4G591mrjZeRSPbeM46e24z5kgBNIbwlZNde6GXZBacAookcuJhpvDR9OwPBWUCvDbv0Z1DmvHWHxvqv2EusysE6GoyUGheAV23SwU3Cfy0crVPeX4DHk','0','0','2026-09-13 14:05:48','2026-09-13 14:05:48',NULL,NULL,NULL,NULL,0,0,NULL),(12,2,1,'are you deeseek',NULL,'(If you encounter this message, please attempt to send your message again. If the error persists beyond multiple attempts, please don\'t hesitate to contact us for assistance!)','GXNYXwt2LpZvusoWsHfvAliBYKHHBKTQbDJ0StdZal4WyvG4fMNxAbpGt4qwVay8HrkUWAaPo5cZ6qkjl52xxmDngS4MXToBBYfDR5mvpwHn6R0bLERG9xm8bXbUGcG4s6WQrJJ9VAyVyAzkFDwWSQkbSNNUq8yuGjATAFWc7RJMGLVPFvhj4r0MoaPNBuxrFoSEMPYj9l4XAKKkCE38neQ0QfbNyDF0ik9JBah0Gs8z0qcW4o4f24YEJSu42hzf','0','0','2026-09-13 14:07:21','2026-09-13 14:07:21',NULL,NULL,NULL,NULL,1,0,NULL),(13,2,1,'are you deeseek',NULL,'(If you encounter this message, please attempt to send your message again. If the error persists beyond multiple attempts, please don\'t hesitate to contact us for assistance!)','sv5ecEAf11AgLcaS24WyNDtLENp7yfbHxAlsh4yhvvWxDwjSY1TeTCnPJEhGwR1ajd8R7GVzh6FM5hFgYaYuTagpIoDf3kITBrLU44Sq3CLJHmraLG60O6VOnkv7C4stZY7VeYME10nZuP7mC9WnIVx3S8GOp7Bm3VIxZjKIv8UjlS7lEJ2Y20obPras80PVRdHBR1qNiZjI7XSDFDU9Ja8RbemQSC5TFVcuAJInP8yFM1teAnIRVbba9UqQUmnT','0','0','2026-09-13 14:41:24','2026-09-13 14:41:24',NULL,NULL,NULL,NULL,0,0,NULL),(14,5,1,NULL,'First Initiation','Hi! I am VisionAI, and I\'m Image Expert. I can assist you with PDF or Images-related information or questions','9hwkIQq9NjQPTCupNhAGcWeI2GOIqRK1OF7ptWyrXAqSIen42nJkbpi7IMhelflG5RDGN36eJtbq0piW0WUkspv5x1WgtufKMWIzd7SnpLKsPOpPdRHK7MjGZ211I6H6nX7xJHZtgzoVkYeOamn6vq4Ba5uB1dZOKCYOmf5sjK0KmDzqc2wEjgHjThWvmMMRUBYb5diT3U6cKA7vmWr3458gtanOsCP1iqaDIwqEDhX3D9hwBm1JdaBTIcoB635Z','0','0','2026-09-13 15:00:16','2026-09-13 15:00:16',NULL,NULL,NULL,NULL,0,0,NULL),(15,5,1,'A sleek, high-end modern office desk setup with a professional software developer working on a high-resolution multi-monitor workstation. The main screen displays a stunning, minimalist website UI/UX design with clean code editor windows open alongside. On the desk, there is a modern mechanical keyboard, a wireless mouse, a sleek tablet, and a cup of coffee. The lighting is cinematic and professional, with a cool blue and soft warm accent glow, highlighting a high-tech and sophisticated atmosphere. Photorealistic, 8k resolution, commercial advertising style, depth of field.',NULL,'(If you encounter this message, please attempt to send your message again. If the error persists beyond multiple attempts, please don\'t hesitate to contact us for assistance!)','SAxIKEsdaJwrXEjEGfjFzzskN8pV8aDhQ2X0hzt8n3ydGCgGOwhaLoeTvfacPnm3GAIDUurYvt2gxCHbBrHn2jcwPiN9M0K3bjXTI9AW16G8twABBj9g7HWcmPz0KHXCYZ5EIOuEFfLghARJBuLKoN0AnmCG11MRSKvJxWfxBR0RXnS5Y8qevJUgdEyCKxoWW32QsYFTk3cWsn6uoEacmNXppYaN02uQVXmzL4P8UxX7Fy2MA1HMELiq9lQ3IxGP','0','0','2026-09-13 15:01:04','2026-09-13 15:01:04',NULL,NULL,NULL,NULL,0,0,NULL);
/*!40000 ALTER TABLE `user_openai_chat_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_orders`
--

DROP TABLE IF EXISTS `user_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plan_id` bigint unsigned DEFAULT NULL,
  `payment_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Waiting',
  `country` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'United States of America',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'subscription',
  `affiliate_earnings` double NOT NULL DEFAULT '0',
  `tax_rate` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_orders_plan_id_foreign` (`plan_id`),
  KEY `user_orders_user_id_foreign` (`user_id`),
  CONSTRAINT `user_orders_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE SET NULL,
  CONSTRAINT `user_orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_orders`
--

LOCK TABLES `user_orders` WRITE;
/*!40000 ALTER TABLE `user_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_support`
--

DROP TABLE IF EXISTS `user_support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_support` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Waiting for answer',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `ticket_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Low',
  `category` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_support_user_id_foreign` (`user_id`),
  CONSTRAINT `user_support_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_support`
--

LOCK TABLES `user_support` WRITE;
/*!40000 ALTER TABLE `user_support` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_support` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_support_messages`
--

DROP TABLE IF EXISTS `user_support_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_support_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_support_id` bigint unsigned DEFAULT NULL,
  `sender` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_support_messages_user_support_id_foreign` (`user_support_id`),
  CONSTRAINT `user_support_messages_user_support_id_foreign` FOREIGN KEY (`user_support_id`) REFERENCES `user_support` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_support_messages`
--

LOCK TABLES `user_support_messages` WRITE;
/*!40000 ALTER TABLE `user_support_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_support_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_usage_credits`
--

DROP TABLE IF EXISTS `user_usage_credits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_usage_credits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `model_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credit` int NOT NULL,
  `unit_price` decimal(8,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_usage_credits_user_id_foreign` (`user_id`),
  CONSTRAINT `user_usage_credits_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_usage_credits`
--

LOCK TABLES `user_usage_credits` WRITE;
/*!40000 ALTER TABLE `user_usage_credits` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_usage_credits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `entity_credits` json DEFAULT NULL,
  `credit_system_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'separated',
  `shared_credits` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `coingate_subscriber_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` bigint unsigned DEFAULT NULL,
  `team_manager_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `surname` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(1055) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'assets/img/auth/default-avatar.png',
  `company_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `remaining_words` decimal(15,2) DEFAULT '0.00',
  `remaining_images` decimal(15,2) DEFAULT '0.00',
  `last_seen` date DEFAULT NULL,
  `github_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `github_token` text COLLATE utf8mb4_unicode_ci,
  `google_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_token` text COLLATE utf8mb4_unicode_ci,
  `facebook_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook_token` text COLLATE utf8mb4_unicode_ci,
  `twitter_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google2fa_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_checkout_customer_reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pm_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pm_last_four` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `affiliate_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `affiliate_earnings` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `affiliate_bank_account` text COLLATE utf8mb4_unicode_ci,
  `affiliate_id` bigint unsigned DEFAULT NULL,
  `email_confirmation_code` text COLLATE utf8mb4_unicode_ci,
  `email_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `password_reset_code` text COLLATE utf8mb4_unicode_ci,
  `github_refresh_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_refresh_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iyzico_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revenuecat_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apple_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apple_token` text COLLATE utf8mb4_unicode_ci,
  `apple_refresh_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_keys` text COLLATE utf8mb4_unicode_ci,
  `gemini_api_keys` text COLLATE utf8mb4_unicode_ci,
  `anthropic_api_keys` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `defi_setting` text COLLATE utf8mb4_unicode_ci,
  `affiliate_status` tinyint DEFAULT '1',
  `tour_seen` tinyint(1) NOT NULL DEFAULT '0',
  `otp` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dash_notify_seen` tinyint(1) NOT NULL DEFAULT '0',
  `xai_api_keys` text COLLATE utf8mb4_unicode_ci,
  `last_activity_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_stripe_id_index` (`stripe_id`),
  KEY `users_affiliate_id_foreign` (`affiliate_id`),
  KEY `users_razorpay_id_index` (`razorpay_id`),
  KEY `users_last_activity_at_index` (`last_activity_at`),
  KEY `idx_users_team_id` (`team_id`),
  KEY `idx_users_team_manager_id` (`team_manager_id`),
  KEY `idx_users_type` (`type`),
  KEY `idx_users_last_activity_at` (`last_activity_at`),
  CONSTRAINT `users_affiliate_id_foreign` FOREIGN KEY (`affiliate_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'{\"klap\": {\"ai-clip-klap\": {\"credit\": 100, \"isUnlimited\": true}}, \"x_ai\": {\"grok-3\": {\"credit\": 5000, \"isUnlimited\": true}, \"grok-4__5\": {\"credit\": 5000, \"isUnlimited\": true}, \"grok-2-1212\": {\"credit\": 5000, \"isUnlimited\": true}, \"grok-3-fast\": {\"credit\": 5000, \"isUnlimited\": true}, \"grok-3-mini\": {\"credit\": 5000, \"isUnlimited\": true}, \"grok-4-0709\": {\"credit\": 5000, \"isUnlimited\": true}, \"grok-3-mini-fast\": {\"credit\": 5000, \"isUnlimited\": true}, \"grok-2-vision-1212\": {\"credit\": 5000, \"isUnlimited\": true}, \"grok-4-fast-reasoning\": {\"credit\": 5000, \"isUnlimited\": true}, \"grok-4-1-fast-reasoning\": {\"credit\": 5000, \"isUnlimited\": true}, \"grok-4-1-fast-non-reasoning\": {\"credit\": 5000, \"isUnlimited\": true}}, \"azure\": {\"azure\": {\"credit\": 5000, \"isUnlimited\": true}, \"azure-openai\": {\"credit\": 5000, \"isUnlimited\": true}}, \"piapi\": {\"midjourney\": {\"credit\": 200, \"isUnlimited\": true}}, \"fal_ai\": {\"veed\": {\"credit\": 100, \"isUnlimited\": true}, \"veo2\": {\"credit\": 100, \"isUnlimited\": true}, \"veo3\": {\"credit\": 100, \"isUnlimited\": true}, \"kling\": {\"credit\": 100, \"isUnlimited\": true}, \"haiper\": {\"credit\": 100, \"isUnlimited\": true}, \"imagen4\": {\"credit\": 200, \"isUnlimited\": true}, \"minimax\": {\"credit\": 100, \"isUnlimited\": true}, \"flux-pro\": {\"credit\": 200, \"isUnlimited\": true}, \"klingV21\": {\"credit\": 100, \"isUnlimited\": true}, \"veo3-fast\": {\"credit\": 100, \"isUnlimited\": true}, \"klingImage\": {\"credit\": 100, \"isUnlimited\": true}, \"flux-2-flex\": {\"credit\": 200, \"isUnlimited\": true}, \"ideogram-v2\": {\"credit\": 200, \"isUnlimited\": true}, \"kling-video\": {\"credit\": 100, \"isUnlimited\": true}, \"nano-banana\": {\"credit\": 200, \"isUnlimited\": true}, \"flux-realism\": {\"credit\": 200, \"isUnlimited\": true}, \"flux/schnell\": {\"credit\": 200, \"isUnlimited\": true}, \"veo3__1/lite\": {\"credit\": 100, \"isUnlimited\": true}, \"nano-banana-2\": {\"credit\": 200, \"isUnlimited\": true}, \"flux-pro/v1__1\": {\"credit\": 200, \"isUnlimited\": true}, \"video-upscaler\": {\"credit\": 100, \"isUnlimited\": true}, \"animatediff-v2v\": {\"credit\": 100, \"isUnlimited\": true}, \"nano-banana-pro\": {\"credit\": 200, \"isUnlimited\": true}, \"flux-2-flex/edit\": {\"credit\": 200, \"isUnlimited\": true}, \"flux-pro/kontext\": {\"credit\": 200, \"isUnlimited\": true}, \"nano-banana/edit\": {\"credit\": 200, \"isUnlimited\": true}, \"seedream/v4/edit\": {\"credit\": 200, \"isUnlimited\": true}, \"veed/fabric-1__0\": {\"credit\": 100, \"isUnlimited\": true}, \"luma-dream-machine\": {\"credit\": 100, \"isUnlimited\": true}, \"nano-banana-2/edit\": {\"credit\": 200, \"isUnlimited\": true}, \"nano-banana-pro/edit\": {\"credit\": 200, \"isUnlimited\": true}, \"veo3__1/text-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"veo3__1/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"xai/grok-imagine-image\": {\"credit\": 200, \"isUnlimited\": true}, \"google/gemini-omni-flash\": {\"credit\": 100, \"isUnlimited\": true}, \"seedream/v4/text-to-image\": {\"credit\": 200, \"isUnlimited\": true}, \"flux-pro/kontext/max/multi\": {\"credit\": 200, \"isUnlimited\": true}, \"veo3__1/fast/text-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"veo3__1/reference-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"cogvideox-5b/video-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"veo3__1/fast/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"veo3__1/lite/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"xai/grok-imagine-image/edit\": {\"credit\": 200, \"isUnlimited\": true}, \"veed/video-background-removal\": {\"credit\": 100, \"isUnlimited\": true}, \"flux-pro/kontext/text-to-image\": {\"credit\": 200, \"isUnlimited\": true}, \"kling-video/v3/pro/text-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"kling-video/v3/pro/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"veo3__1/first-last-frame-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"kling-2__5-turbo/pro/text-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"kling-2__5-turbo/pro/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"kling-video/v2__6/pro/text-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"kling-video/v2__6/pro/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"kling-video/v2__6/pro/motion-control\": {\"credit\": 100, \"isUnlimited\": true}, \"xai/grok-imagine-video/text-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"bytedance/seedance-2__0/text-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"bytedance/seedance-2__5/text-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"fast-animatediff/turbo/video-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"kling-video/v3/standard/text-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"xai/grok-imagine-video/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"bytedance/seedance-2__0/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"bytedance/seedance-2__5/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"kling-video/v3/standard/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"veo3__1/fast/first-last-frame-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"veo3__1/lite/first-last-frame-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"google/gemini-omni-flash/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"kling-2__5-turbo/standard/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"kling-video/v2__6/standard/motion-control\": {\"credit\": 100, \"isUnlimited\": true}, \"bytedance/seedance-2__0/fast/text-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"bytedance/seedance-2__0/reference-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"bytedance/seedance-2__5/reference-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"bytedance/seedance-2__0/fast/image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"google/gemini-omni-flash/reference-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"bytedance/seedance-2__0/fast/reference-to-video\": {\"credit\": 100, \"isUnlimited\": true}}, \"gemini\": {\"lyria-3-pro\": {\"credit\": 8, \"isUnlimited\": true}, \"lyria-3-clip\": {\"credit\": 8, \"isUnlimited\": true}, \"gemini-1__5-pro\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-2__5-pro\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-1__5-flash\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-2__0-flash\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-3__5-flash\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-3__6-flash\": {\"credit\": 5000, \"isUnlimited\": true}, \"text-embedding-004\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-3-pro-preview\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-deep-research\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-embedding-exp\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-2__0-flash-lite\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-3-flash-preview\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-3__5-flash-lite\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-3__1-pro-preview\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-3__1-flash-live-preview\": {\"credit\": 5000, \"isUnlimited\": true}, \"gemini-2__5-flash-preview-05-20\": {\"credit\": 5000, \"isUnlimited\": true}}, \"google\": {\"google\": {\"credit\": 5000, \"isUnlimited\": true}}, \"heygen\": {\"heygen\": {\"credit\": 100, \"isUnlimited\": true}, \"video-dubbing\": {\"credit\": 8, \"isUnlimited\": true}}, \"novita\": {\"novita\": {\"credit\": 200, \"isUnlimited\": true}}, \"openai\": {\"o1\": {\"credit\": 5000, \"isUnlimited\": true}, \"o3\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-4\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5\": {\"credit\": 5000, \"isUnlimited\": true}, \"tts-1\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-4o\": {\"credit\": 5000, \"isUnlimited\": true}, \"sora-2\": {\"credit\": 8, \"isUnlimited\": true}, \"o1-mini\": {\"credit\": 5000, \"isUnlimited\": true}, \"o3-mini\": {\"credit\": 5000, \"isUnlimited\": true}, \"o4-mini\": {\"credit\": 5000, \"isUnlimited\": true}, \"dall-e-2\": {\"credit\": 200, \"isUnlimited\": true}, \"dall-e-3\": {\"credit\": 200, \"isUnlimited\": true}, \"gpt-4__1\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5__1\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5__2\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5__4\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5__5\": {\"credit\": 5000, \"isUnlimited\": true}, \"tts-1-hd\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5-pro\": {\"credit\": 5000, \"isUnlimited\": true}, \"whisper-1\": {\"credit\": 100, \"isUnlimited\": true}, \"gpt-5-mini\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5-nano\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-live-1\": {\"credit\": 5000, \"isUnlimited\": true}, \"o1-preview\": {\"credit\": 5000, \"isUnlimited\": true}, \"sora-2-pro\": {\"credit\": 8, \"isUnlimited\": true}, \"davinci-002\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-4-turbo\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-4o-mini\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-image-1\": {\"credit\": 200, \"isUnlimited\": true}, \"gpt-image-2\": {\"credit\": 200, \"isUnlimited\": true}, \"gpt-5__2-pro\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5__6-sol\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-realtime\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-4__1-mini\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-4__1-nano\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5__4-mini\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5__4-nano\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5__6-luna\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-3__5-turbo\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5__6-terra\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-image-1__5\": {\"credit\": 200, \"isUnlimited\": true}, \"gpt-live-1-mini\": {\"credit\": 5000, \"isUnlimited\": true}, \"o3-deep-research\": {\"credit\": 5000, \"isUnlimited\": true}, \"text-davinci-003\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5-chat-latest\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-4-0125-preview\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-4-1106-preview\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-3__5-turbo-0125\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-3__5-turbo-1106\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5__1-chat-latest\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-5__3-chat-latest\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-4o-search-preview\": {\"credit\": 5000, \"isUnlimited\": true}, \"o4-mini-deep-research\": {\"credit\": 5000, \"isUnlimited\": true}, \"text-embedding-3-large\": {\"credit\": 5000, \"isUnlimited\": true}, \"text-embedding-3-small\": {\"credit\": 5000, \"isUnlimited\": true}, \"text-embedding-ada-002\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-4o-mini-search-preview\": {\"credit\": 5000, \"isUnlimited\": true}, \"gpt-4o-realtime-preview-2024-12-17\": {\"credit\": 5000, \"isUnlimited\": true}}, \"pexels\": {\"pexels\": {\"credit\": 200, \"isUnlimited\": true}}, \"serper\": {\"serper\": {\"credit\": 5000, \"isUnlimited\": true}}, \"vizard\": {\"ai-clip-vizard\": {\"credit\": 100, \"isUnlimited\": true}}, \"freepik\": {\"freepik\": {\"credit\": 200, \"isUnlimited\": true}}, \"minimax\": {\"music-01\": {\"credit\": 20, \"isUnlimited\": true}}, \"pixabay\": {\"pixabay\": {\"credit\": 200, \"isUnlimited\": true}}, \"topview\": {\"ad-marketing-video-topview\": {\"credit\": 100, \"isUnlimited\": true}}, \"captions\": {\"ai-captions\": {\"credit\": 20, \"isUnlimited\": true}}, \"clipdrop\": {\"clipdrop\": {\"credit\": 200, \"isUnlimited\": true}}, \"creatify\": {\"ad-marketing-video\": {\"credit\": 100, \"isUnlimited\": true}}, \"gamma_ai\": {\"gamma-ai\": {\"credit\": 100, \"isUnlimited\": true}}, \"pebblely\": {\"pebblely\": {\"credit\": 200, \"isUnlimited\": true}}, \"together\": {\"black-forest-labs/FLUX__1-schnell\": {\"credit\": 200, \"isUnlimited\": true}}, \"unsplash\": {\"unsplash\": {\"credit\": 200, \"isUnlimited\": true}}, \"anthropic\": {\"voyage-2\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-2__0\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-2__1\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-opus-5\": {\"credit\": 5000, \"isUnlimited\": true}, \"voyage-code-2\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-fable-5\": {\"credit\": 5000, \"isUnlimited\": true}, \"voyage-large-2\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-opus-4-6\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-opus-4-7\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-opus-4-8\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-sonnet-5\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-sonnet-4-6\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-3-opus-20240229\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-opus-4-20250514\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-3-haiku-20240307\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-3-haiku-20241022\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-3-sonnet-20240229\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-opus-4-1-20250805\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-opus-4-5-20251101\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-sonnet-4-20250514\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-3-5-sonnet-20240620\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-3-5-sonnet-20241022\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-3-7-sonnet-20250219\": {\"credit\": 5000, \"isUnlimited\": true}, \"claude-sonnet-4-5-20250929\": {\"credit\": 5000, \"isUnlimited\": true}}, \"deep_seek\": {\"deepseek-chat\": {\"credit\": 0, \"isUnlimited\": false}, \"deepseek-reasoner\": {\"credit\": 5000, \"isUnlimited\": true}}, \"speechify\": {\"speechify\": {\"credit\": 5000, \"isUnlimited\": true}}, \"synthesia\": {\"synthesia\": {\"credit\": 100, \"isUnlimited\": true}}, \"elevenlabs\": {\"isolator\": {\"credit\": 5000, \"isUnlimited\": true}, \"eleven_v3\": {\"credit\": 5000, \"isUnlimited\": true}, \"elevenlabs\": {\"credit\": 5000, \"isUnlimited\": true}, \"elevenlabs-ai-music\": {\"credit\": 20, \"isUnlimited\": true}, \"elevenlabs-voice-chatbot\": {\"credit\": 5000, \"isUnlimited\": true}}, \"perplexity\": {\"perplexity\": {\"credit\": 5000, \"isUnlimited\": true}}, \"open_router\": {\"liquid/lfm-40b\": {\"credit\": 5000, \"isUnlimited\": true}, \"x-ai/grok-beta\": {\"credit\": 5000, \"isUnlimited\": true}, \"liquid/lfm-40b:free\": {\"credit\": 5000, \"isUnlimited\": true}, \"mistralai/ministral-3b\": {\"credit\": 5000, \"isUnlimited\": true}, \"mistralai/ministral-8b\": {\"credit\": 5000, \"isUnlimited\": true}, \"thedrummer/rocinante-12b\": {\"credit\": 5000, \"isUnlimited\": true}, \"anthropic/claude-3-5-haiku\": {\"credit\": 5000, \"isUnlimited\": true}, \"inflection/inflection-3-pi\": {\"credit\": 5000, \"isUnlimited\": true}, \"qwen/qwen-2__5-7b-instruct\": {\"credit\": 5000, \"isUnlimited\": true}, \"anthracite-org/magnum-v2-72b\": {\"credit\": 5000, \"isUnlimited\": true}, \"anthracite-org/magnum-v4-72b\": {\"credit\": 5000, \"isUnlimited\": true}, \"eva-unit-01/eva-qwen-2__5-14b\": {\"credit\": 5000, \"isUnlimited\": true}, \"anthropic/claude-3-5-haiku:beta\": {\"credit\": 5000, \"isUnlimited\": true}, \"meta-llama/llama-3__2-1b-instruct\": {\"credit\": 5000, \"isUnlimited\": true}, \"meta-llama/llama-3__2-3b-instruct\": {\"credit\": 5000, \"isUnlimited\": true}, \"neversleep/llama-3__1-lumimaid-70b\": {\"credit\": 5000, \"isUnlimited\": true}, \"anthropic/claude-3-5-haiku-20241022\": {\"credit\": 5000, \"isUnlimited\": true}, \"inflection/inflection-3-productivity\": {\"credit\": 5000, \"isUnlimited\": true}, \"meta-llama/llama-3__2-1b-instruct:free\": {\"credit\": 5000, \"isUnlimited\": true}, \"meta-llama/llama-3__2-3b-instruct:free\": {\"credit\": 5000, \"isUnlimited\": true}, \"nvidia/llama-3__1-nemotron-70b-instruct\": {\"credit\": 5000, \"isUnlimited\": true}, \"anthropic/claude-3-5-haiku-20241022:beta\": {\"credit\": 5000, \"isUnlimited\": true}, \"perplexity/llama-3__1-sonar-large-128k-chat\": {\"credit\": 5000, \"isUnlimited\": true}, \"perplexity/llama-3__1-sonar-small-128k-chat\": {\"credit\": 5000, \"isUnlimited\": true}, \"perplexity/llama-3__1-sonar-huge-128k-online\": {\"credit\": 5000, \"isUnlimited\": true}, \"perplexity/llama-3__1-sonar-large-128k-online\": {\"credit\": 5000, \"isUnlimited\": true}, \"perplexity/llama-3__1-sonar-small-128k-online\": {\"credit\": 5000, \"isUnlimited\": true}}, \"plagiarism_check\": {\"plagiarismcheck\": {\"credit\": 100, \"isUnlimited\": true}}, \"stable_diffusion\": {\"sd3\": {\"credit\": 200, \"isUnlimited\": true}, \"core\": {\"credit\": 200, \"isUnlimited\": true}, \"ultra\": {\"credit\": 200, \"isUnlimited\": true}, \"sd3-large\": {\"credit\": 200, \"isUnlimited\": true}, \"sd3-turbo\": {\"credit\": 200, \"isUnlimited\": true}, \"sd3-medium\": {\"credit\": 200, \"isUnlimited\": true}, \"aws_bedrock\": {\"credit\": 200, \"isUnlimited\": true}, \"sd3__5-large\": {\"credit\": 200, \"isUnlimited\": true}, \"sd3__5-medium\": {\"credit\": 200, \"isUnlimited\": true}, \"image-to-video\": {\"credit\": 100, \"isUnlimited\": true}, \"sd3-large-turbo\": {\"credit\": 200, \"isUnlimited\": true}, \"sd3__5-large-turbo\": {\"credit\": 200, \"isUnlimited\": true}, \"stable-diffusion-v1-6\": {\"credit\": 200, \"isUnlimited\": true}, \"stable-diffusion-xl-1024-v1-0\": {\"credit\": 200, \"isUnlimited\": true}}}','separated',0.0000,NULL,NULL,NULL,'Admin','Admin','admin@admin.com','5555555555','super_admin','$2y$10$XptdAOeFTxl7Yx2KmyfEluWY9Im6wpMIHoJ9V5yB96DgQgTafzzs6','assets/img/auth/default-avatar.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 17:01:47','2026-09-13 15:28:16',NULL,NULL,NULL,NULL,NULL,'P60NPGHAAFGD','0',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,1,0,NULL,0,NULL,'2026-09-13 15:28:16'),(2,'{\"klap\": {\"ai-clip-klap\": {\"credit\": 0, \"isUnlimited\": false}}, \"x_ai\": {\"grok-3\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-4__5\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-2-1212\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-3-fast\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-3-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-4-0709\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-3-mini-fast\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-2-vision-1212\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-4-fast-reasoning\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-4-1-fast-reasoning\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-4-1-fast-non-reasoning\": {\"credit\": 0, \"isUnlimited\": false}}, \"azure\": {\"azure\": {\"credit\": 0, \"isUnlimited\": false}, \"azure-openai\": {\"credit\": 0, \"isUnlimited\": false}}, \"piapi\": {\"midjourney\": {\"credit\": 0, \"isUnlimited\": false}}, \"fal_ai\": {\"veed\": {\"credit\": 0, \"isUnlimited\": false}, \"veo2\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3\": {\"credit\": 0, \"isUnlimited\": false}, \"kling\": {\"credit\": 0, \"isUnlimited\": false}, \"haiper\": {\"credit\": 0, \"isUnlimited\": false}, \"imagen4\": {\"credit\": 0, \"isUnlimited\": false}, \"minimax\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"klingV21\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3-fast\": {\"credit\": 0, \"isUnlimited\": false}, \"klingImage\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-2-flex\": {\"credit\": 0, \"isUnlimited\": false}, \"ideogram-v2\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-realism\": {\"credit\": 0, \"isUnlimited\": false}, \"flux/schnell\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/lite\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana-2\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-pro/v1__1\": {\"credit\": 0, \"isUnlimited\": false}, \"video-upscaler\": {\"credit\": 0, \"isUnlimited\": false}, \"animatediff-v2v\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-2-flex/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-pro/kontext\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"seedream/v4/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"veed/fabric-1__0\": {\"credit\": 0, \"isUnlimited\": false}, \"luma-dream-machine\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana-2/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana-pro/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"xai/grok-imagine-image\": {\"credit\": 0, \"isUnlimited\": false}, \"google/gemini-omni-flash\": {\"credit\": 0, \"isUnlimited\": false}, \"seedream/v4/text-to-image\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-pro/kontext/max/multi\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/fast/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/reference-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"cogvideox-5b/video-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/fast/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/lite/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"xai/grok-imagine-image/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"veed/video-background-removal\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-pro/kontext/text-to-image\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v3/pro/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v3/pro/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/first-last-frame-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-2__5-turbo/pro/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-2__5-turbo/pro/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v2__6/pro/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v2__6/pro/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v2__6/pro/motion-control\": {\"credit\": 0, \"isUnlimited\": false}, \"xai/grok-imagine-video/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__5/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"fast-animatediff/turbo/video-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v3/standard/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"xai/grok-imagine-video/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__5/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v3/standard/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/fast/first-last-frame-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/lite/first-last-frame-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"google/gemini-omni-flash/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-2__5-turbo/standard/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v2__6/standard/motion-control\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/fast/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/reference-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__5/reference-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/fast/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"google/gemini-omni-flash/reference-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/fast/reference-to-video\": {\"credit\": 0, \"isUnlimited\": false}}, \"gemini\": {\"lyria-3-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"lyria-3-clip\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-1__5-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-2__5-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-1__5-flash\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-2__0-flash\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3__5-flash\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3__6-flash\": {\"credit\": 0, \"isUnlimited\": false}, \"text-embedding-004\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3-pro-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-deep-research\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-embedding-exp\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-2__0-flash-lite\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3-flash-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3__5-flash-lite\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3__1-pro-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3__1-flash-live-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-2__5-flash-preview-05-20\": {\"credit\": 0, \"isUnlimited\": false}}, \"google\": {\"google\": {\"credit\": 0, \"isUnlimited\": false}}, \"heygen\": {\"heygen\": {\"credit\": 0, \"isUnlimited\": false}, \"video-dubbing\": {\"credit\": 0, \"isUnlimited\": false}}, \"novita\": {\"novita\": {\"credit\": 0, \"isUnlimited\": false}}, \"openai\": {\"o1\": {\"credit\": 0, \"isUnlimited\": false}, \"o3\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5\": {\"credit\": 0, \"isUnlimited\": false}, \"tts-1\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4o\": {\"credit\": 0, \"isUnlimited\": false}, \"sora-2\": {\"credit\": 0, \"isUnlimited\": false}, \"o1-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"o3-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"o4-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"dall-e-2\": {\"credit\": 0, \"isUnlimited\": false}, \"dall-e-3\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4__1\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__1\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__2\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__4\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__5\": {\"credit\": 0, \"isUnlimited\": false}, \"tts-1-hd\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"whisper-1\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5-nano\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-live-1\": {\"credit\": 0, \"isUnlimited\": false}, \"o1-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"sora-2-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"davinci-002\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4-turbo\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4o-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-image-1\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-image-2\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__2-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__6-sol\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-realtime\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4__1-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4__1-nano\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__4-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__4-nano\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__6-luna\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-3__5-turbo\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__6-terra\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-image-1__5\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-live-1-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"o3-deep-research\": {\"credit\": 0, \"isUnlimited\": false}, \"text-davinci-003\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5-chat-latest\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4-0125-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4-1106-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-3__5-turbo-0125\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-3__5-turbo-1106\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__1-chat-latest\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__3-chat-latest\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4o-search-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"o4-mini-deep-research\": {\"credit\": 0, \"isUnlimited\": false}, \"text-embedding-3-large\": {\"credit\": 0, \"isUnlimited\": false}, \"text-embedding-3-small\": {\"credit\": 0, \"isUnlimited\": false}, \"text-embedding-ada-002\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4o-mini-search-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4o-realtime-preview-2024-12-17\": {\"credit\": 0, \"isUnlimited\": false}}, \"pexels\": {\"pexels\": {\"credit\": 0, \"isUnlimited\": false}}, \"serper\": {\"serper\": {\"credit\": 0, \"isUnlimited\": false}}, \"vizard\": {\"ai-clip-vizard\": {\"credit\": 0, \"isUnlimited\": false}}, \"freepik\": {\"freepik\": {\"credit\": 0, \"isUnlimited\": false}}, \"minimax\": {\"music-01\": {\"credit\": 0, \"isUnlimited\": false}}, \"pixabay\": {\"pixabay\": {\"credit\": 0, \"isUnlimited\": false}}, \"topview\": {\"ad-marketing-video-topview\": {\"credit\": 0, \"isUnlimited\": false}}, \"captions\": {\"ai-captions\": {\"credit\": 0, \"isUnlimited\": false}}, \"clipdrop\": {\"clipdrop\": {\"credit\": 0, \"isUnlimited\": false}}, \"creatify\": {\"ad-marketing-video\": {\"credit\": 0, \"isUnlimited\": false}}, \"gamma_ai\": {\"gamma-ai\": {\"credit\": 0, \"isUnlimited\": false}}, \"pebblely\": {\"pebblely\": {\"credit\": 0, \"isUnlimited\": false}}, \"together\": {\"black-forest-labs/FLUX__1-schnell\": {\"credit\": 0, \"isUnlimited\": false}}, \"unsplash\": {\"unsplash\": {\"credit\": 0, \"isUnlimited\": false}}, \"anthropic\": {\"voyage-2\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-2__0\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-2__1\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-5\": {\"credit\": 0, \"isUnlimited\": false}, \"voyage-code-2\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-fable-5\": {\"credit\": 0, \"isUnlimited\": false}, \"voyage-large-2\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-6\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-7\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-8\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-sonnet-5\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-sonnet-4-6\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-opus-20240229\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-20250514\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-haiku-20240307\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-haiku-20241022\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-sonnet-20240229\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-1-20250805\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-5-20251101\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-sonnet-4-20250514\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-5-sonnet-20240620\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-5-sonnet-20241022\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-7-sonnet-20250219\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-sonnet-4-5-20250929\": {\"credit\": 0, \"isUnlimited\": false}}, \"deep_seek\": {\"deepseek-chat\": {\"credit\": 0, \"isUnlimited\": false}, \"deepseek-reasoner\": {\"credit\": 0, \"isUnlimited\": true}}, \"speechify\": {\"speechify\": {\"credit\": 0, \"isUnlimited\": false}}, \"synthesia\": {\"synthesia\": {\"credit\": 0, \"isUnlimited\": false}}, \"elevenlabs\": {\"isolator\": {\"credit\": 0, \"isUnlimited\": false}, \"eleven_v3\": {\"credit\": 0, \"isUnlimited\": false}, \"elevenlabs\": {\"credit\": 0, \"isUnlimited\": false}, \"elevenlabs-ai-music\": {\"credit\": 0, \"isUnlimited\": false}, \"elevenlabs-voice-chatbot\": {\"credit\": 0, \"isUnlimited\": false}}, \"perplexity\": {\"perplexity\": {\"credit\": 0, \"isUnlimited\": false}}, \"open_router\": {\"liquid/lfm-40b\": {\"credit\": 0, \"isUnlimited\": false}, \"x-ai/grok-beta\": {\"credit\": 0, \"isUnlimited\": false}, \"liquid/lfm-40b:free\": {\"credit\": 0, \"isUnlimited\": false}, \"mistralai/ministral-3b\": {\"credit\": 0, \"isUnlimited\": false}, \"mistralai/ministral-8b\": {\"credit\": 0, \"isUnlimited\": false}, \"thedrummer/rocinante-12b\": {\"credit\": 0, \"isUnlimited\": false}, \"anthropic/claude-3-5-haiku\": {\"credit\": 0, \"isUnlimited\": false}, \"inflection/inflection-3-pi\": {\"credit\": 0, \"isUnlimited\": false}, \"qwen/qwen-2__5-7b-instruct\": {\"credit\": 0, \"isUnlimited\": false}, \"anthracite-org/magnum-v2-72b\": {\"credit\": 0, \"isUnlimited\": false}, \"anthracite-org/magnum-v4-72b\": {\"credit\": 0, \"isUnlimited\": false}, \"eva-unit-01/eva-qwen-2__5-14b\": {\"credit\": 0, \"isUnlimited\": false}, \"anthropic/claude-3-5-haiku:beta\": {\"credit\": 0, \"isUnlimited\": false}, \"meta-llama/llama-3__2-1b-instruct\": {\"credit\": 0, \"isUnlimited\": false}, \"meta-llama/llama-3__2-3b-instruct\": {\"credit\": 0, \"isUnlimited\": false}, \"neversleep/llama-3__1-lumimaid-70b\": {\"credit\": 0, \"isUnlimited\": false}, \"anthropic/claude-3-5-haiku-20241022\": {\"credit\": 0, \"isUnlimited\": false}, \"inflection/inflection-3-productivity\": {\"credit\": 0, \"isUnlimited\": false}, \"meta-llama/llama-3__2-1b-instruct:free\": {\"credit\": 0, \"isUnlimited\": false}, \"meta-llama/llama-3__2-3b-instruct:free\": {\"credit\": 0, \"isUnlimited\": false}, \"nvidia/llama-3__1-nemotron-70b-instruct\": {\"credit\": 0, \"isUnlimited\": false}, \"anthropic/claude-3-5-haiku-20241022:beta\": {\"credit\": 0, \"isUnlimited\": false}, \"perplexity/llama-3__1-sonar-large-128k-chat\": {\"credit\": 0, \"isUnlimited\": false}, \"perplexity/llama-3__1-sonar-small-128k-chat\": {\"credit\": 0, \"isUnlimited\": false}, \"perplexity/llama-3__1-sonar-huge-128k-online\": {\"credit\": 0, \"isUnlimited\": false}, \"perplexity/llama-3__1-sonar-large-128k-online\": {\"credit\": 0, \"isUnlimited\": false}, \"perplexity/llama-3__1-sonar-small-128k-online\": {\"credit\": 0, \"isUnlimited\": false}}, \"plagiarism_check\": {\"plagiarismcheck\": {\"credit\": 0, \"isUnlimited\": false}}, \"stable_diffusion\": {\"sd3\": {\"credit\": 0, \"isUnlimited\": false}, \"core\": {\"credit\": 0, \"isUnlimited\": false}, \"ultra\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3-large\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3-turbo\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3-medium\": {\"credit\": 0, \"isUnlimited\": false}, \"aws_bedrock\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3__5-large\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3__5-medium\": {\"credit\": 0, \"isUnlimited\": false}, \"image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3-large-turbo\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3__5-large-turbo\": {\"credit\": 0, \"isUnlimited\": false}, \"stable-diffusion-v1-6\": {\"credit\": 0, \"isUnlimited\": false}, \"stable-diffusion-xl-1024-v1-0\": {\"credit\": 0, \"isUnlimited\": false}}}','separated',0.0000,NULL,NULL,NULL,'u_YjjT','l_pODh','rafedred7@gmail.com',NULL,'user','$2y$10$UEX0R2Q3RoGFq/lHG69P5e0FUuSNFr45EIWkzg0aT0Rwj/B6AS5Nq','assets/img/auth/default-avatar.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-12 20:31:18','2026-09-13 14:03:53',NULL,NULL,NULL,NULL,NULL,'1NJIRCKCJQQS','0',NULL,NULL,'EbeOVYGAu9PdRK5Vg0r7rx0Y7TRK8Ybf5HslbMIyvQfj8gpZKerCLBf6W6vWybXAiwe',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,1,0,NULL,0,NULL,'2026-09-12 20:40:32'),(3,'{\"klap\": {\"ai-clip-klap\": {\"credit\": 0, \"isUnlimited\": false}}, \"x_ai\": {\"grok-3\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-4__5\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-2-1212\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-3-fast\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-3-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-4-0709\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-3-mini-fast\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-2-vision-1212\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-4-fast-reasoning\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-4-1-fast-reasoning\": {\"credit\": 0, \"isUnlimited\": false}, \"grok-4-1-fast-non-reasoning\": {\"credit\": 0, \"isUnlimited\": false}}, \"azure\": {\"azure\": {\"credit\": 0, \"isUnlimited\": false}, \"azure-openai\": {\"credit\": 0, \"isUnlimited\": false}}, \"piapi\": {\"midjourney\": {\"credit\": 0, \"isUnlimited\": false}}, \"fal_ai\": {\"veed\": {\"credit\": 0, \"isUnlimited\": false}, \"veo2\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3\": {\"credit\": 0, \"isUnlimited\": false}, \"kling\": {\"credit\": 0, \"isUnlimited\": false}, \"haiper\": {\"credit\": 0, \"isUnlimited\": false}, \"imagen4\": {\"credit\": 0, \"isUnlimited\": false}, \"minimax\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"klingV21\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3-fast\": {\"credit\": 0, \"isUnlimited\": false}, \"klingImage\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-2-flex\": {\"credit\": 0, \"isUnlimited\": false}, \"ideogram-v2\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-realism\": {\"credit\": 0, \"isUnlimited\": false}, \"flux/schnell\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/lite\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana-2\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-pro/v1__1\": {\"credit\": 0, \"isUnlimited\": false}, \"video-upscaler\": {\"credit\": 0, \"isUnlimited\": false}, \"animatediff-v2v\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-2-flex/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-pro/kontext\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"seedream/v4/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"veed/fabric-1__0\": {\"credit\": 0, \"isUnlimited\": false}, \"luma-dream-machine\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana-2/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"nano-banana-pro/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"xai/grok-imagine-image\": {\"credit\": 0, \"isUnlimited\": false}, \"google/gemini-omni-flash\": {\"credit\": 0, \"isUnlimited\": false}, \"seedream/v4/text-to-image\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-pro/kontext/max/multi\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/fast/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/reference-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"cogvideox-5b/video-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/fast/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/lite/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"xai/grok-imagine-image/edit\": {\"credit\": 0, \"isUnlimited\": false}, \"veed/video-background-removal\": {\"credit\": 0, \"isUnlimited\": false}, \"flux-pro/kontext/text-to-image\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v3/pro/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v3/pro/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/first-last-frame-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-2__5-turbo/pro/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-2__5-turbo/pro/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v2__6/pro/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v2__6/pro/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v2__6/pro/motion-control\": {\"credit\": 0, \"isUnlimited\": false}, \"xai/grok-imagine-video/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__5/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"fast-animatediff/turbo/video-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v3/standard/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"xai/grok-imagine-video/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__5/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v3/standard/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/fast/first-last-frame-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"veo3__1/lite/first-last-frame-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"google/gemini-omni-flash/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-2__5-turbo/standard/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"kling-video/v2__6/standard/motion-control\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/fast/text-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/reference-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__5/reference-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/fast/image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"google/gemini-omni-flash/reference-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"bytedance/seedance-2__0/fast/reference-to-video\": {\"credit\": 0, \"isUnlimited\": false}}, \"gemini\": {\"lyria-3-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"lyria-3-clip\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-1__5-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-2__5-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-1__5-flash\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-2__0-flash\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3__5-flash\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3__6-flash\": {\"credit\": 0, \"isUnlimited\": false}, \"text-embedding-004\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3-pro-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-deep-research\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-embedding-exp\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-2__0-flash-lite\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3-flash-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3__5-flash-lite\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3__1-pro-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-3__1-flash-live-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gemini-2__5-flash-preview-05-20\": {\"credit\": 0, \"isUnlimited\": false}}, \"google\": {\"google\": {\"credit\": 0, \"isUnlimited\": false}}, \"heygen\": {\"heygen\": {\"credit\": 0, \"isUnlimited\": false}, \"video-dubbing\": {\"credit\": 0, \"isUnlimited\": false}}, \"novita\": {\"novita\": {\"credit\": 0, \"isUnlimited\": false}}, \"openai\": {\"o1\": {\"credit\": 0, \"isUnlimited\": false}, \"o3\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5\": {\"credit\": 0, \"isUnlimited\": false}, \"tts-1\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4o\": {\"credit\": 0, \"isUnlimited\": false}, \"sora-2\": {\"credit\": 0, \"isUnlimited\": false}, \"o1-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"o3-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"o4-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"dall-e-2\": {\"credit\": 0, \"isUnlimited\": false}, \"dall-e-3\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4__1\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__1\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__2\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__4\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__5\": {\"credit\": 0, \"isUnlimited\": false}, \"tts-1-hd\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"whisper-1\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5-nano\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-live-1\": {\"credit\": 0, \"isUnlimited\": false}, \"o1-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"sora-2-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"davinci-002\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4-turbo\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4o-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-image-1\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-image-2\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__2-pro\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__6-sol\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-realtime\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4__1-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4__1-nano\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__4-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__4-nano\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__6-luna\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-3__5-turbo\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__6-terra\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-image-1__5\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-live-1-mini\": {\"credit\": 0, \"isUnlimited\": false}, \"o3-deep-research\": {\"credit\": 0, \"isUnlimited\": false}, \"text-davinci-003\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5-chat-latest\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4-0125-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4-1106-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-3__5-turbo-0125\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-3__5-turbo-1106\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__1-chat-latest\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-5__3-chat-latest\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4o-search-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"o4-mini-deep-research\": {\"credit\": 0, \"isUnlimited\": false}, \"text-embedding-3-large\": {\"credit\": 0, \"isUnlimited\": false}, \"text-embedding-3-small\": {\"credit\": 0, \"isUnlimited\": false}, \"text-embedding-ada-002\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4o-mini-search-preview\": {\"credit\": 0, \"isUnlimited\": false}, \"gpt-4o-realtime-preview-2024-12-17\": {\"credit\": 0, \"isUnlimited\": false}}, \"pexels\": {\"pexels\": {\"credit\": 0, \"isUnlimited\": false}}, \"serper\": {\"serper\": {\"credit\": 0, \"isUnlimited\": false}}, \"vizard\": {\"ai-clip-vizard\": {\"credit\": 0, \"isUnlimited\": false}}, \"freepik\": {\"freepik\": {\"credit\": 0, \"isUnlimited\": false}}, \"minimax\": {\"music-01\": {\"credit\": 0, \"isUnlimited\": false}}, \"pixabay\": {\"pixabay\": {\"credit\": 0, \"isUnlimited\": false}}, \"topview\": {\"ad-marketing-video-topview\": {\"credit\": 0, \"isUnlimited\": false}}, \"captions\": {\"ai-captions\": {\"credit\": 0, \"isUnlimited\": false}}, \"clipdrop\": {\"clipdrop\": {\"credit\": 0, \"isUnlimited\": false}}, \"creatify\": {\"ad-marketing-video\": {\"credit\": 0, \"isUnlimited\": false}}, \"gamma_ai\": {\"gamma-ai\": {\"credit\": 0, \"isUnlimited\": false}}, \"pebblely\": {\"pebblely\": {\"credit\": 0, \"isUnlimited\": false}}, \"together\": {\"black-forest-labs/FLUX__1-schnell\": {\"credit\": 0, \"isUnlimited\": false}}, \"unsplash\": {\"unsplash\": {\"credit\": 0, \"isUnlimited\": false}}, \"anthropic\": {\"voyage-2\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-2__0\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-2__1\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-5\": {\"credit\": 0, \"isUnlimited\": false}, \"voyage-code-2\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-fable-5\": {\"credit\": 0, \"isUnlimited\": false}, \"voyage-large-2\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-6\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-7\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-8\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-sonnet-5\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-sonnet-4-6\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-opus-20240229\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-20250514\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-haiku-20240307\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-haiku-20241022\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-sonnet-20240229\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-1-20250805\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-opus-4-5-20251101\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-sonnet-4-20250514\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-5-sonnet-20240620\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-5-sonnet-20241022\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-3-7-sonnet-20250219\": {\"credit\": 0, \"isUnlimited\": false}, \"claude-sonnet-4-5-20250929\": {\"credit\": 0, \"isUnlimited\": false}}, \"deep_seek\": {\"deepseek-chat\": {\"credit\": 0, \"isUnlimited\": false}, \"deepseek-reasoner\": {\"credit\": 0, \"isUnlimited\": false}}, \"speechify\": {\"speechify\": {\"credit\": 0, \"isUnlimited\": false}}, \"synthesia\": {\"synthesia\": {\"credit\": 0, \"isUnlimited\": false}}, \"elevenlabs\": {\"isolator\": {\"credit\": 0, \"isUnlimited\": false}, \"eleven_v3\": {\"credit\": 0, \"isUnlimited\": false}, \"elevenlabs\": {\"credit\": 0, \"isUnlimited\": false}, \"elevenlabs-ai-music\": {\"credit\": 0, \"isUnlimited\": false}, \"elevenlabs-voice-chatbot\": {\"credit\": 0, \"isUnlimited\": false}}, \"perplexity\": {\"perplexity\": {\"credit\": 0, \"isUnlimited\": false}}, \"open_router\": {\"liquid/lfm-40b\": {\"credit\": 0, \"isUnlimited\": false}, \"x-ai/grok-beta\": {\"credit\": 0, \"isUnlimited\": false}, \"liquid/lfm-40b:free\": {\"credit\": 0, \"isUnlimited\": false}, \"mistralai/ministral-3b\": {\"credit\": 0, \"isUnlimited\": false}, \"mistralai/ministral-8b\": {\"credit\": 0, \"isUnlimited\": false}, \"thedrummer/rocinante-12b\": {\"credit\": 0, \"isUnlimited\": false}, \"anthropic/claude-3-5-haiku\": {\"credit\": 0, \"isUnlimited\": false}, \"inflection/inflection-3-pi\": {\"credit\": 0, \"isUnlimited\": false}, \"qwen/qwen-2__5-7b-instruct\": {\"credit\": 0, \"isUnlimited\": false}, \"anthracite-org/magnum-v2-72b\": {\"credit\": 0, \"isUnlimited\": false}, \"anthracite-org/magnum-v4-72b\": {\"credit\": 0, \"isUnlimited\": false}, \"eva-unit-01/eva-qwen-2__5-14b\": {\"credit\": 0, \"isUnlimited\": false}, \"anthropic/claude-3-5-haiku:beta\": {\"credit\": 0, \"isUnlimited\": false}, \"meta-llama/llama-3__2-1b-instruct\": {\"credit\": 0, \"isUnlimited\": false}, \"meta-llama/llama-3__2-3b-instruct\": {\"credit\": 0, \"isUnlimited\": false}, \"neversleep/llama-3__1-lumimaid-70b\": {\"credit\": 0, \"isUnlimited\": false}, \"anthropic/claude-3-5-haiku-20241022\": {\"credit\": 0, \"isUnlimited\": false}, \"inflection/inflection-3-productivity\": {\"credit\": 0, \"isUnlimited\": false}, \"meta-llama/llama-3__2-1b-instruct:free\": {\"credit\": 0, \"isUnlimited\": false}, \"meta-llama/llama-3__2-3b-instruct:free\": {\"credit\": 0, \"isUnlimited\": false}, \"nvidia/llama-3__1-nemotron-70b-instruct\": {\"credit\": 0, \"isUnlimited\": false}, \"anthropic/claude-3-5-haiku-20241022:beta\": {\"credit\": 0, \"isUnlimited\": false}, \"perplexity/llama-3__1-sonar-large-128k-chat\": {\"credit\": 0, \"isUnlimited\": false}, \"perplexity/llama-3__1-sonar-small-128k-chat\": {\"credit\": 0, \"isUnlimited\": false}, \"perplexity/llama-3__1-sonar-huge-128k-online\": {\"credit\": 0, \"isUnlimited\": false}, \"perplexity/llama-3__1-sonar-large-128k-online\": {\"credit\": 0, \"isUnlimited\": false}, \"perplexity/llama-3__1-sonar-small-128k-online\": {\"credit\": 0, \"isUnlimited\": false}}, \"plagiarism_check\": {\"plagiarismcheck\": {\"credit\": 0, \"isUnlimited\": false}}, \"stable_diffusion\": {\"sd3\": {\"credit\": 0, \"isUnlimited\": false}, \"core\": {\"credit\": 0, \"isUnlimited\": false}, \"ultra\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3-large\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3-turbo\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3-medium\": {\"credit\": 0, \"isUnlimited\": false}, \"aws_bedrock\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3__5-large\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3__5-medium\": {\"credit\": 0, \"isUnlimited\": false}, \"image-to-video\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3-large-turbo\": {\"credit\": 0, \"isUnlimited\": false}, \"sd3__5-large-turbo\": {\"credit\": 0, \"isUnlimited\": false}, \"stable-diffusion-v1-6\": {\"credit\": 0, \"isUnlimited\": false}, \"stable-diffusion-xl-1024-v1-0\": {\"credit\": 0, \"isUnlimited\": false}}}','separated',0.0000,NULL,NULL,NULL,'u_CeGj','l_gq8g','rafedred@gmail.com',NULL,'user','$2y$10$ENQWv.GLiLOfQiMm0ZRBdOBdRV2IavPu7SnIJb8iuxiyYCzTxsmIu','assets/img/auth/default-avatar.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-13 14:47:11','2026-09-13 15:03:59',NULL,NULL,NULL,NULL,NULL,'877CJJVVVFNP','0',NULL,NULL,'3URd0YYGLg7Tqr6dyPGfXO2A55KbYLMY1URMpXqMLS8RiB8suBcqEcGfxGTrOvvEqga',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,1,0,NULL,0,NULL,'2026-09-13 15:03:59');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_activity`
--

DROP TABLE IF EXISTS `users_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_activity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `connection` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_activity`
--

LOCK TABLES `users_activity` WRITE;
/*!40000 ALTER TABLE `users_activity` DISABLE KEYS */;
INSERT INTO `users_activity` VALUES (1,'admin@admin.com','super_admin','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36','2026-09-12 17:42:57'),(2,'admin@admin.com','super_admin','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36','2026-09-12 18:11:37'),(3,'rafedred7@gmail.com','user','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36','2026-09-12 20:31:18'),(4,'admin@admin.com','super_admin','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36','2026-09-12 21:29:47'),(5,'admin@admin.com','super_admin','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36','2026-09-13 12:12:03'),(6,'admin@admin.com','super_admin','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36','2026-09-13 13:43:57'),(7,'rafedred@gmail.com','user','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36','2026-09-13 14:47:12');
/*!40000 ALTER TABLE `users_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhookhistory`
--

DROP TABLE IF EXISTS `webhookhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhookhistory` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `gatewaycode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `webhook_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_payment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_total` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `incoming_json` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhookhistory`
--

LOCK TABLES `webhookhistory` WRITE;
/*!40000 ALTER TABLE `webhookhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhookhistory` ENABLE KEYS */;
UNLOCK TABLES;
/*!50112 SET @disable_bulk_load = IF (@is_rocksdb_supported, 'SET SESSION rocksdb_bulk_load = @old_rocksdb_bulk_load', 'SET @dummy_rocksdb_bulk_load = 0') */;
/*!50112 PREPARE s FROM @disable_bulk_load */;
/*!50112 EXECUTE s */;
/*!50112 DEALLOCATE PREPARE s */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-13 15:28:19
