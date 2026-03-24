-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: karuna
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

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

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoryImage` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cretedAt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifiedAt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentCategory` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Clothes',NULL,'2025-12-22 16:26:40','1','2025-12-22 16:26:40','1',NULL),(2,'Shoes & Accessories',NULL,'2025-12-22 16:26:40','1','2025-12-22 16:26:40','1',NULL),(3,'Toiletries',NULL,'2025-12-22 16:26:40','1','2025-12-22 16:26:40','1',NULL),(4,'Electric & Electronics',NULL,'2025-12-22 16:26:40','1','2025-12-22 16:26:40','1',NULL),(5,'Food (Dry or Packaged)',NULL,'2025-12-22 16:26:40','1','2025-12-22 16:26:40','1',NULL),(6,'Sports',NULL,'2025-12-22 16:26:40','1','2025-12-22 16:26:40','1',NULL),(7,'Toys',NULL,'2025-12-22 16:26:40','1','2025-12-22 16:26:40','1',NULL),(8,'Shirts',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(9,'T-shirts',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(10,'Shorts',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(11,'Pants',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(12,'Skirts',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(13,'Dress',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(14,'Night Suit',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(15,'Jackets',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(16,'Hoodies',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(17,'Woolens',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(18,'Gym Wear',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(19,'Others',NULL,'2025-12-22 16:27:00','1','2025-12-22 16:27:00','1',1),(20,'Formal Shoes',NULL,'2025-12-22 16:27:14','1','2025-12-22 16:27:14','1',2),(21,'Sports Shoes',NULL,'2025-12-22 16:27:14','1','2025-12-22 16:27:14','1',2),(22,'Sandals',NULL,'2025-12-22 16:27:14','1','2025-12-22 16:27:14','1',2),(23,'Slippers',NULL,'2025-12-22 16:27:14','1','2025-12-22 16:27:14','1',2),(24,'Watch',NULL,'2025-12-22 16:27:14','1','2025-12-22 16:27:14','1',2),(25,'Jewellery',NULL,'2025-12-22 16:27:14','1','2025-12-22 16:27:14','1',2),(26,'Soap',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(27,'Shampoo & Conditioner',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(28,'Toothpaste',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(29,'Toothbrush',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(30,'Hairbrush',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(31,'Moisturizer Cream',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(32,'Deodorant',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(33,'Makeup Kit',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(34,'Makeup Remover',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(35,'Sunscreen',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(36,'Razor',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(37,'Shaving Gel',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(38,'Others',NULL,'2025-12-22 16:27:30','1','2025-12-22 16:27:30','1',3),(39,'Phone',NULL,'2025-12-22 16:27:40','1','2025-12-22 16:27:40','1',4),(40,'Computer',NULL,'2025-12-22 16:27:40','1','2025-12-22 16:27:40','1',4),(41,'Laptop',NULL,'2025-12-22 16:27:40','1','2025-12-22 16:27:40','1',4),(42,'Microwave',NULL,'2025-12-22 16:27:40','1','2025-12-22 16:27:40','1',4),(43,'Lamp',NULL,'2025-12-22 16:27:40','1','2025-12-22 16:27:40','1',4),(44,'Table Fan',NULL,'2025-12-22 16:27:40','1','2025-12-22 16:27:40','1',4),(45,'Mixer Grinder',NULL,'2025-12-22 16:27:40','1','2025-12-22 16:27:40','1',4),(46,'Others',NULL,'2025-12-22 16:27:40','1','2025-12-22 16:27:40','1',4),(47,'Spices',NULL,'2025-12-22 16:27:52','1','2025-12-22 16:27:52','1',5),(48,'Dals',NULL,'2025-12-22 16:27:52','1','2025-12-22 16:27:52','1',5),(49,'Atta',NULL,'2025-12-22 16:27:52','1','2025-12-22 16:27:52','1',5),(50,'Rice',NULL,'2025-12-22 16:27:52','1','2025-12-22 16:27:52','1',5),(51,'Health Snacks',NULL,'2025-12-22 16:27:52','1','2025-12-22 16:27:52','1',5),(52,'Sweets',NULL,'2025-12-22 16:27:52','1','2025-12-22 16:27:52','1',5),(53,'Chocolate',NULL,'2025-12-22 16:27:52','1','2025-12-22 16:27:52','1',5),(54,'Cookies',NULL,'2025-12-22 16:27:52','1','2025-12-22 16:27:52','1',5),(55,'Chips',NULL,'2025-12-22 16:27:52','1','2025-12-22 16:27:52','1',5),(56,'Others',NULL,'2025-12-22 16:27:52','1','2025-12-22 16:27:52','1',5),(57,'Cricket Bat/Ball Set',NULL,'2025-12-22 16:28:05','1','2025-12-22 16:28:05','1',6),(58,'Football',NULL,'2025-12-22 16:28:05','1','2025-12-22 16:28:05','1',6),(59,'Basketball',NULL,'2025-12-22 16:28:05','1','2025-12-22 16:28:05','1',6),(60,'Hockey',NULL,'2025-12-22 16:28:05','1','2025-12-22 16:28:05','1',6),(61,'Tennis',NULL,'2025-12-22 16:28:05','1','2025-12-22 16:28:05','1',6),(62,'Others',NULL,'2025-12-22 16:28:05','1','2025-12-22 16:28:05','1',6),(63,'Puzzles',NULL,'2025-12-22 16:28:13','1','2025-12-22 16:28:13','1',7),(64,'Building Blocks',NULL,'2025-12-22 16:28:13','1','2025-12-22 16:28:13','1',7);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donates`
--

DROP TABLE IF EXISTS `donates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `categoryId` int DEFAULT NULL,
  `subcategoryId` int DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deliveryType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdAt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifiedAt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donates`
--

LOCK TABLES `donates` WRITE;
/*!40000 ALTER TABLE `donates` DISABLE KEYS */;
INSERT INTO `donates` VALUES (1,2,1,8,'Test','uploads/doner/2025/12/23/image1766467185.png','East Region','Drop off To Receiver','Airoli','Pending',1,'2025-12-23 13:19:45','2','2025-12-23 13:19:45','2'),(2,2,2,20,'Test',NULL,'Central Region','Drop off To Receiver','YNR','Matched',1,'2026-01-06 23:03:56','2','2026-01-06 23:03:56','2'),(4,11,5,53,'Toblerone bars ','uploads/doner/2026/03/21/image1774105287.png','Central Region','Drop off To Receiver','249693','Pending',1,'2026-03-21 23:01:27','11','2026-03-21 23:01:27','11'),(5,6,3,27,'Test ',NULL,'Central Region','Drop off To Receiver','YNR','Matched',1,'2026-03-21 23:16:02','6','2026-03-21 23:16:02','6'),(6,12,5,53,'Kit Kat mini','uploads/doner/2026/03/22/image1774111435.png','Central Region','Drop off To Receiver','249693','Pending',1,'2026-03-22 00:43:55','12','2026-03-22 00:43:55','12'),(7,14,4,39,'I need one smart phone ','uploads/doner/2026/03/22/image1774153462.png','North Region','Drop off To Receiver','Blk-A #06-08 Westlite Dormitory woodlands 737723 ','Pending',1,'2026-03-22 12:24:22','14','2026-03-22 12:24:22','14'),(8,14,2,21,'I need a shoes','uploads/doner/2026/03/22/image1774153523.png','North Region','Drop off To Receiver','Blk-A #06-08 Westlite Dormitory woodlands 737723 ','Pending',1,'2026-03-22 12:25:23','14','2026-03-22 12:25:23','14');
/*!40000 ALTER TABLE `donates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otp`
--

DROP TABLE IF EXISTS `otp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `otp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdTime` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expireTime` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otp`
--

LOCK TABLES `otp` WRITE;
/*!40000 ALTER TABLE `otp` DISABLE KEYS */;
INSERT INTO `otp` VALUES (1,6,'123456','2026-01-07 16:37:08','2026-01-07 16:47:08'),(2,9,'123456','2026-01-08 22:34:22','2026-01-08 22:44:22'),(3,6,'123456','2026-01-09 14:46:01','2026-01-09 14:56:01'),(4,6,'123456','2026-01-09 14:46:03','2026-01-09 14:56:03'),(5,3,'123456','2026-01-13 12:59:09','2026-01-13 13:09:09'),(6,3,'123456','2026-01-13 13:06:05','2026-01-13 13:16:05'),(7,3,'123456','2026-01-13 13:07:47','2026-01-13 13:17:47'),(8,3,'123456','2026-01-13 13:08:09','2026-01-13 13:18:09'),(9,3,'123456','2026-01-13 13:08:40','2026-01-13 13:18:40'),(10,3,'123456','2026-01-13 13:09:48','2026-01-13 13:19:48'),(12,3,'123456','2026-01-13 13:24:59','2026-01-13 13:34:59'),(13,3,'123456','2026-01-13 13:33:29','2026-01-13 13:43:29'),(14,3,'123456','2026-01-13 13:36:54','2026-01-13 13:46:54'),(15,3,'123456','2026-01-13 13:43:06','2026-01-13 13:53:06'),(16,3,'123456','2026-01-13 13:45:58','2026-01-13 13:55:58'),(17,3,'123456','2026-01-13 13:48:46','2026-01-13 13:58:46'),(18,3,'123456','2026-01-13 13:49:13','2026-01-13 13:59:13'),(19,3,'123456','2026-01-13 13:49:21','2026-01-13 13:59:21'),(20,3,'123456','2026-01-13 13:49:50','2026-01-13 13:59:50'),(21,3,'123456','2026-01-13 15:02:36','2026-01-13 15:12:36'),(24,6,'123456','2026-01-18 13:57:18','2026-01-18 14:07:18'),(25,3,'123456','2026-01-19 14:33:44','2026-01-19 14:43:44'),(26,3,'123456','2026-01-19 14:51:50','2026-01-19 15:01:50'),(27,3,'123456','2026-01-19 14:52:34','2026-01-19 15:02:34'),(28,3,'123456','2026-01-19 14:52:51','2026-01-19 15:02:51'),(29,3,'123456','2026-01-19 14:54:11','2026-01-19 15:04:11'),(30,3,'123456','2026-01-19 14:54:39','2026-01-19 15:04:39'),(31,3,'123456','2026-01-19 14:55:44','2026-01-19 15:05:44'),(32,3,'123456','2026-01-19 14:57:47','2026-01-19 15:07:47'),(33,3,'123456','2026-01-19 14:58:05','2026-01-19 15:08:05'),(36,6,'123456','2026-03-21 23:13:42','2026-03-21 23:23:42'),(39,12,'123456','2026-03-22 00:45:14','2026-03-22 00:55:14'),(40,13,'123456','2026-03-22 00:49:16','2026-03-22 00:59:16'),(41,12,'123456','2026-03-22 01:09:57','2026-03-22 01:19:57'),(42,13,'123456','2026-03-22 01:10:37','2026-03-22 01:20:37'),(43,13,'826339','2026-03-22 01:15:35','2026-03-22 01:25:35'),(44,13,'674673','2026-03-22 01:17:03','2026-03-22 01:27:03'),(45,12,'733515','2026-03-22 01:18:18','2026-03-22 01:28:18'),(46,13,'155998','2026-03-22 01:18:41','2026-03-22 01:28:41');
/*!40000 ALTER TABLE `otp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receive`
--

DROP TABLE IF EXISTS `receive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receive` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `categoryId` int DEFAULT NULL,
  `subcategoryId` int DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deliveryType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifiedAt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receive`
--

LOCK TABLES `receive` WRITE;
/*!40000 ALTER TABLE `receive` DISABLE KEYS */;
INSERT INTO `receive` VALUES (1,4,3,27,'Test ','Central Region','Drop off To Receiver','YNR','Matched','2025-12-23 13:20:34','4','2025-12-23 13:20:34','4',1),(2,4,2,20,'Test','Central Region','Drop off To Receiver','YNR','Matched','2025-12-23 15:19:54','4','2025-12-23 15:19:54','4',1);
/*!40000 ALTER TABLE `receive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requestMapping`
--

DROP TABLE IF EXISTS `requestMapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requestMapping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `donationId` int NOT NULL,
  `receiveId` int NOT NULL,
  `initiatedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifiedAt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requestMapping`
--

LOCK TABLES `requestMapping` WRITE;
/*!40000 ALTER TABLE `requestMapping` DISABLE KEYS */;
INSERT INTO `requestMapping` VALUES (1,2,2,'4','Central Region','Matched','2026-01-06 23:03:56','2','2026-01-06 23:03:56','2',1),(2,5,1,'4','Central Region','Matched','2026-03-21 23:16:02','6','2026-03-21 23:16:02','6',1);
/*!40000 ALTER TABLE `requestMapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deviceType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deviceToken` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'Doner','Doner','donor@gmail.com','79780216','Donor@123','doner','East Region','Airoli','IOS','devicetoken'),(3,'vikas','saini','vikas.syscode@gmail.com','98969957','12345678','admin','Central Region','Yamunanagar','IOS',NULL),(4,'Receiver','Receiver','receiver@gmail.com','98989898','Receiver@123','receiver','Central Region','YNR','IOS','cNxqKy-uTkeXp5pm0wRNYk:APA91bFwDqx6NO41zZqX8pAJqCOt0_phZl4pN0EybhnjyxO0OBLQ3Umw1ZaonctbJIfeH45ft_vCGI9MXimA4X2TtKaWigLm4ScdXAdlVVRPGQXMr9xtvCs'),(5,'Volunteer','Volunteer','volunteer@gmail.com','72727272','Volunteer@123','volunteer','Central Region','YNR','IOS','d-CDw2eR309uhj7z5wkJ-E:APA91bHNHPykZJeBqaGXDZkEjRD426NHtic-3vNwJcCXJVV3NzkSAiHUMJsAoecuWWkWmYR4v79cK79T_J_pwapgda3ni2pVe4v9ZjaDwwtRZwYnqx7irU0'),(6,'xxx','xxx','aditirazdan1706@gmail.com','92990017','Password123','doner','Central Region','Xxx','IOS',NULL),(9,'Dhruv','Kakkar','dhkakkar@gmail.com','98022755','@Naruto@1','doner','Central Region','1943, Sector 17, Huda, Yamunanagar, Haryana, India, 135001','IOS',NULL),(10,'xxx','xxx','razdan43004@sas.edu.sg','92990016','Slide004','doner','Central Region','Xx','IOS','appDelegate.deviceTokenString'),(11,'Sid ','Razdan ','razdansid28@gmail.com','90309596','Ramesh2811','doner','Central Region','10 Cuscaden walk','IOS','feQSQjyIWkiduxh03YuIjL:APA91bFRQYCx2XU-5XrPWNKheXdjqfSBi5aCpF2biP3sc1p_vQ1jOsWOe4_4w4gptMo4JksGunUP47aNpLJsGG6hTN50ODc7OkR8mEt7uccPDR6xIiiszAU'),(12,'Preeti ','Arora','preetiarorarazdan@gmail.com','90112371','Razdan05','doner','Central Region','249693','IOS','cM4kirrX1EimioqhHF6tsR:APA91bH89tsZ8ZW-yF_HPoq_sHAFeqt1FE5JKhVmhBO1CreUBnjFKAIns7aYzok1BC-IlKACfTM7V-v2-yxuttE-epLu6URTD7ZWrdO8cu3sYsGkBnDNAuQ'),(13,'Preeti ','Razdan ','preeti.razdan@diageo.com','98274160','Razdan05','doner','Central Region','249693','IOS','dmszR1niIkkzgiWlWX1wSH:APA91bFm66smPCaGh-RXMBWoG1cPF6IXtYFX3dDA6tcWhUiy83HhcAi59UpINV29LXj9-KGAXiqfFgfw-34VCl7g1_5CNYCv6gwdJiKoJ0-xcYy91vxz4Pk'),(14,'Madhan','S','madhanmech3097@gmail.com','84834421','Madhan@30','doner','North Region','Westlite','IOS','cBeq1OxV1UqOl0JWoZrGYb:APA91bFEsg2Rz-BTs5P9N72MpxQhxzDymcnKonoI84dB-xZvEfxn2Z7RPcI_ImYza6SZQYwesu1KRf28DU45wi5ZZr4MKlxiG-4nH22LT53QfjFUZj4i7JQ');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-24  6:05:08
