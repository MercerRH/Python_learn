-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: jing_dong
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `address` varchar(100) NOT NULL,
  `tel` int(10) unsigned NOT NULL,
  `password` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'老王','1qaa',1111111,'1111111'),(5,'老李','2adf',2222222,'2222222'),(6,'老张','3dfsd',3333333,'3333333');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `cate_id` int(10) unsigned NOT NULL,
  `brand_id` int(10) unsigned NOT NULL,
  `price` decimal(10,3) NOT NULL DEFAULT '0.000',
  `is_show` bit(1) NOT NULL DEFAULT b'1',
  `is_saleoff` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`),
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`cate_id`) REFERENCES `goods_cates` (`id`),
  CONSTRAINT `goods_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `goods_brand` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1,'r510vc 15.6英寸笔记本',5,2,3399.000,_binary '',_binary '\0'),(2,'y400n 14.0英寸笔记本电脑',5,7,4999.000,_binary '',_binary '\0'),(3,'g150th 15.6英寸游戏本',4,9,8499.000,_binary '',_binary '\0'),(4,'x550cc 15.6英寸笔记本',5,2,2799.000,_binary '',_binary '\0'),(5,'x240 超极本',7,7,4880.000,_binary '',_binary '\0'),(6,'u330p 13.3英寸超极本',7,7,4299.000,_binary '',_binary '\0'),(7,'svp13226scb 触控超极本',7,6,7999.000,_binary '',_binary '\0'),(8,'ipad mini 7.9英寸平板电脑',2,8,1998.000,_binary '',_binary '\0'),(9,'ipad air 9.7英寸平板电脑',2,8,3388.000,_binary '',_binary '\0'),(10,'ipad mini 配备 retina 显示屏',2,8,2788.000,_binary '',_binary '\0'),(11,'ideacentre c340 20英寸一体电脑 ',1,7,3499.000,_binary '',_binary '\0'),(12,'vostro 3800-r1206 台式电脑',1,5,2899.000,_binary '',_binary '\0'),(13,'imac me086ch/a 21.5英寸一体电脑',1,8,9188.000,_binary '',_binary '\0'),(14,'at7-7414lp 台式电脑 linux ）',1,3,3699.000,_binary '',_binary '\0'),(15,'z220sff f4f06pa工作站',3,4,4288.000,_binary '',_binary '\0'),(16,'poweredge ii服务器',3,5,5388.000,_binary '',_binary '\0'),(17,'mac pro专业级台式电脑',3,8,28888.000,_binary '',_binary '\0'),(18,'hmz-t3w 头戴显示设备',6,6,6999.000,_binary '',_binary '\0'),(19,'商务双肩背包',6,6,99.000,_binary '',_binary '\0'),(20,'x3250 m4机架式服务器',3,1,6888.000,_binary '',_binary '\0'),(21,'商务双肩背包',6,6,99.000,_binary '',_binary '\0');
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_brand`
--

DROP TABLE IF EXISTS `goods_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods_brand` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_brand`
--

LOCK TABLES `goods_brand` WRITE;
/*!40000 ALTER TABLE `goods_brand` DISABLE KEYS */;
INSERT INTO `goods_brand` VALUES (1,'ibm'),(2,'华硕'),(3,'宏碁'),(4,'惠普'),(5,'戴尔'),(6,'索尼'),(7,'联想'),(8,'苹果'),(9,'雷神');
/*!40000 ALTER TABLE `goods_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_cates`
--

DROP TABLE IF EXISTS `goods_cates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods_cates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_cates`
--

LOCK TABLES `goods_cates` WRITE;
/*!40000 ALTER TABLE `goods_cates` DISABLE KEYS */;
INSERT INTO `goods_cates` VALUES (1,'台式机'),(2,'平板电脑'),(3,'服务器/工作站'),(4,'游戏本'),(5,'笔记本'),(6,'笔记本配件'),(7,'超级本');
/*!40000 ALTER TABLE `goods_cates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `good_id` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `good_id` (`good_id`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`good_id`) REFERENCES `goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (1,1,10,15),(2,2,13,45);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_date_time` varchar(60) NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2020.03.12',1),(2,'2020.03.12',1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-12 16:56:46