-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: d7MBTQ
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `Additional_emailapply`
--

DROP TABLE IF EXISTS `Additional_emailapply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Additional_emailapply` (
  `id` int NOT NULL AUTO_INCREMENT,
  `visit_time` date NOT NULL,
  `now_index` int NOT NULL,
  `apply_status` tinyint(1) NOT NULL,
  `send_status` tinyint(1) NOT NULL,
  `over_status` tinyint(1) NOT NULL,
  `next_time` datetime(6) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `contact_id` int DEFAULT NULL,
  `email_template_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Additional_emailapply_contact_id_48d6d922_fk_User_contact_id` (`contact_id`),
  KEY `Additional_emailappl_email_template_id_0c33814b_fk_Additiona` (`email_template_id`),
  CONSTRAINT `Additional_emailappl_email_template_id_0c33814b_fk_Additiona` FOREIGN KEY (`email_template_id`) REFERENCES `Additional_emailtemplate` (`id`),
  CONSTRAINT `Additional_emailapply_contact_id_48d6d922_fk_User_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `User_contact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Additional_emailapply`
--

LOCK TABLES `Additional_emailapply` WRITE;
/*!40000 ALTER TABLE `Additional_emailapply` DISABLE KEYS */;
/*!40000 ALTER TABLE `Additional_emailapply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Additional_emailcollect`
--

DROP TABLE IF EXISTS `Additional_emailcollect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Additional_emailcollect` (
  `id` int NOT NULL AUTO_INCREMENT,
  `success_status` tinyint(1) NOT NULL,
  `json_response` longtext,
  `send_time` datetime(6) NOT NULL,
  `index` int NOT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `email_apply_id` int DEFAULT NULL,
  `email_template_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Additional_emailcoll_email_apply_id_05afc83a_fk_Additiona` (`email_apply_id`),
  KEY `Additional_emailcoll_email_template_id_8dfb2275_fk_Additiona` (`email_template_id`),
  CONSTRAINT `Additional_emailcoll_email_apply_id_05afc83a_fk_Additiona` FOREIGN KEY (`email_apply_id`) REFERENCES `Additional_emailapply` (`id`),
  CONSTRAINT `Additional_emailcoll_email_template_id_8dfb2275_fk_Additiona` FOREIGN KEY (`email_template_id`) REFERENCES `Additional_emailtemplate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Additional_emailcollect`
--

LOCK TABLES `Additional_emailcollect` WRITE;
/*!40000 ALTER TABLE `Additional_emailcollect` DISABLE KEYS */;
/*!40000 ALTER TABLE `Additional_emailcollect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Additional_emailtemplate`
--

DROP TABLE IF EXISTS `Additional_emailtemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Additional_emailtemplate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject` varchar(120) DEFAULT NULL,
  `message` longtext,
  `time_rule` smallint NOT NULL,
  `service` varchar(120) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Additional_emailtemplate_category_id_61f973ee_fk_Sms_category_id` (`category_id`),
  CONSTRAINT `Additional_emailtemplate_category_id_61f973ee_fk_Sms_category_id` FOREIGN KEY (`category_id`) REFERENCES `Sms_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Additional_emailtemplate`
--

LOCK TABLES `Additional_emailtemplate` WRITE;
/*!40000 ALTER TABLE `Additional_emailtemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `Additional_emailtemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Record_everytask`
--

DROP TABLE IF EXISTS `Record_everytask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Record_everytask` (
  `id` int NOT NULL AUTO_INCREMENT,
  `schedule_id` varchar(90) NOT NULL,
  `send_finish_time` datetime(6) DEFAULT NULL,
  `temp_para` longtext,
  `time_rule_belong` smallint NOT NULL,
  `numed` smallint DEFAULT NULL,
  `apply_status` tinyint(1) DEFAULT NULL,
  `send_status` tinyint(1) NOT NULL,
  `contact_id` int NOT NULL,
  `jsms_response` longtext,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `sms_task_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Record_everytask_sms_task_id_7a04a1a5_fk_Record_smstask_id` (`sms_task_id`),
  CONSTRAINT `Record_everytask_sms_task_id_7a04a1a5_fk_Record_smstask_id` FOREIGN KEY (`sms_task_id`) REFERENCES `Record_smstask` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Record_everytask`
--

LOCK TABLES `Record_everytask` WRITE;
/*!40000 ALTER TABLE `Record_everytask` DISABLE KEYS */;
INSERT INTO `Record_everytask` VALUES (31,'SM544b2712a02f46afbb2e91d1e31ebde6','2020-06-26 16:02:14.000000','{\'named\': \'Eric\', \'numed\': 1}',0,1,1,1,1,'SM544b2712a02f46afbb2e91d1e31ebde6',1,'2020-06-26 16:00:13.176352',11),(32,'0','2020-07-26 16:02:14.000000','無',1,2,0,0,1,NULL,1,'2020-06-26 16:00:13.179701',11),(33,'SM0a5fbd0907514bdbbea35368474ad940','2020-06-26 16:18:11.000000','{\'named\': \'Eric\', \'numed\': 1}',0,1,1,1,1,'SM0a5fbd0907514bdbbea35368474ad940',1,'2020-06-26 16:16:10.234468',12),(34,'0','2020-12-23 16:18:11.000000','無',6,2,0,0,1,NULL,1,'2020-06-26 16:16:10.235912',12),(35,'SMad5cfd3c673b435b98c51a8cb11659de','2020-06-26 16:25:24.000000','{\'named\': \'chiwai\', \'numed\': 1}',0,1,1,1,6,'SMad5cfd3c673b435b98c51a8cb11659de',1,'2020-06-26 16:23:23.195574',13),(36,'0','2020-08-25 16:25:24.000000','無',2,2,0,0,6,NULL,1,'2020-06-26 16:23:23.197202',13),(37,'0','2020-10-24 16:25:24.000000','無',4,3,0,0,6,NULL,1,'2020-06-26 16:23:23.199752',13),(38,'SM34c808a801624b77a2339c7e65ffa245','2020-06-27 07:44:21.000000','{\'named\': \'Eric\', \'numed\': 1}',0,1,1,1,1,'SM34c808a801624b77a2339c7e65ffa245',1,'2020-06-27 07:42:20.078621',14),(39,'0','2020-08-26 07:44:21.000000','無',2,2,0,0,1,NULL,1,'2020-06-27 07:42:20.081247',14),(40,'0','2021-02-22 07:44:21.000000','無',8,3,0,0,1,NULL,1,'2020-06-27 07:42:20.082666',14),(41,'SM5c0601aee5b04639befd2da0a1311536','2020-07-01 03:27:33.000000','{\'named\': \'曾超然\', \'numed\': 1}',0,1,1,1,10,'SM5c0601aee5b04639befd2da0a1311536',1,'2020-07-01 03:25:31.766175',15),(42,'0','2020-07-31 03:27:33.000000','無',1,2,0,0,10,NULL,1,'2020-07-01 03:25:31.768209',15),(43,'0','2020-12-28 03:27:33.000000','無',6,3,0,0,10,NULL,1,'2020-07-01 03:25:31.769406',15),(44,'SM98be7c8b7952494ea2d66ffd188bf402','2020-07-06 07:33:08.000000','{\'named\': \'何洪清\', \'numed\': 1}',0,1,1,1,12,'SM98be7c8b7952494ea2d66ffd188bf402',1,'2020-07-06 07:31:06.807024',16),(45,'0','2020-09-04 07:33:08.000000','無',2,2,0,0,12,NULL,1,'2020-07-06 07:31:06.809493',16),(46,'0','2021-01-02 07:33:08.000000','無',6,3,0,0,12,NULL,1,'2020-07-06 07:31:06.811007',16),(47,'SMa098e4e7adc844588ba62b034724a1cd','2020-07-12 03:10:07.000000','{\'named\': \'趙敏\', \'numed\': 1}',0,1,1,1,14,'SMa098e4e7adc844588ba62b034724a1cd',1,'2020-07-12 03:08:05.950803',17),(48,'0','2020-09-10 03:10:07.000000','無',2,2,0,0,14,NULL,1,'2020-07-12 03:08:05.953469',17),(49,'0','2021-01-08 03:10:07.000000','無',6,3,0,0,14,NULL,1,'2020-07-12 03:08:05.954988',17);
/*!40000 ALTER TABLE `Record_everytask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Record_smstask`
--

DROP TABLE IF EXISTS `Record_smstask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Record_smstask` (
  `id` int NOT NULL AUTO_INCREMENT,
  `phoned` varchar(60) DEFAULT NULL,
  `named` varchar(120) DEFAULT NULL,
  `task_status` tinyint(1) DEFAULT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `area_id` int DEFAULT NULL,
  `sms_template_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Record_smstask_area_id_eeb6779c_fk_Sms_area_id` (`area_id`),
  KEY `Record_smstask_sms_template_id_79dfd8c8_fk_Sms_smstemplate_id` (`sms_template_id`),
  CONSTRAINT `Record_smstask_area_id_eeb6779c_fk_Sms_area_id` FOREIGN KEY (`area_id`) REFERENCES `Sms_area` (`id`),
  CONSTRAINT `Record_smstask_sms_template_id_79dfd8c8_fk_Sms_smstemplate_id` FOREIGN KEY (`sms_template_id`) REFERENCES `Sms_smstemplate` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Record_smstask`
--

LOCK TABLES `Record_smstask` WRITE;
/*!40000 ALTER TABLE `Record_smstask` DISABLE KEYS */;
INSERT INTO `Record_smstask` VALUES (11,'92779625','Eric',0,NULL,1,'2020-06-26 16:00:13.165481',3,20),(12,'92779625','Eric',0,NULL,1,'2020-06-26 16:16:10.221586',3,12),(13,'61515651','chiwai',0,NULL,1,'2020-06-26 16:23:23.186918',3,24),(14,'92779625','Eric',0,NULL,1,'2020-06-27 07:42:20.070480',3,18),(15,'92379666','曾超然',0,NULL,1,'2020-07-01 03:25:31.756945',3,10),(16,'55372253','何洪清',0,NULL,1,'2020-07-06 07:31:06.755745',3,16),(17,'98452717','趙敏',0,NULL,1,'2020-07-12 03:08:05.942319',3,16);
/*!40000 ALTER TABLE `Record_smstask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Record_smstaskrecord`
--

DROP TABLE IF EXISTS `Record_smstaskrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Record_smstaskrecord` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(120) NOT NULL,
  `phoned` longtext,
  `sms_template` varchar(240) NOT NULL,
  `send_time` datetime(6) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `every_task_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Record_smstaskrecord_every_task_id_87641563_fk_Record_ev` (`every_task_id`),
  CONSTRAINT `Record_smstaskrecord_every_task_id_87641563_fk_Record_ev` FOREIGN KEY (`every_task_id`) REFERENCES `Record_everytask` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Record_smstaskrecord`
--

LOCK TABLES `Record_smstaskrecord` WRITE;
/*!40000 ALTER TABLE `Record_smstaskrecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `Record_smstaskrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sms_area`
--

DROP TABLE IF EXISTS `Sms_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sms_area` (
  `id` int NOT NULL AUTO_INCREMENT,
  `phoned_prefix` varchar(30) DEFAULT NULL,
  `named` varchar(60) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sms_area`
--

LOCK TABLES `Sms_area` WRITE;
/*!40000 ALTER TABLE `Sms_area` DISABLE KEYS */;
INSERT INTO `Sms_area` VALUES (1,'+86','大陆',1,'2020-06-24 08:22:44.833837'),(2,'+853','澳門',1,'2020-06-24 08:22:44.838359'),(3,'+852','香港',1,'2020-06-24 08:22:44.840587');
/*!40000 ALTER TABLE `Sms_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sms_category`
--

DROP TABLE IF EXISTS `Sms_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sms_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `named` varchar(30) DEFAULT NULL,
  `flag` smallint DEFAULT NULL,
  `way` smallint DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sms_category`
--

LOCK TABLES `Sms_category` WRITE;
/*!40000 ALTER TABLE `Sms_category` DISABLE KEYS */;
INSERT INTO `Sms_category` VALUES (1,'疫苗',1,1,1,'2020-06-24 08:22:44.842787'),(2,'手術',2,1,1,'2020-06-24 08:22:44.844622'),(3,'美容',3,1,1,'2020-06-24 08:22:44.846615'),(4,'產品',21,2,1,'2020-06-24 08:22:44.848080'),(5,'服務',22,2,1,'2020-06-24 08:22:44.849560'),(6,'檢查',23,2,1,'2020-06-24 08:22:44.850928');
/*!40000 ALTER TABLE `Sms_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sms_service`
--

DROP TABLE IF EXISTS `Sms_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sms_service` (
  `id` int NOT NULL AUTO_INCREMENT,
  `named` varchar(60) NOT NULL,
  `time_rule` varchar(25) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sms_service`
--

LOCK TABLES `Sms_service` WRITE;
/*!40000 ALTER TABLE `Sms_service` DISABLE KEYS */;
INSERT INTO `Sms_service` VALUES (1,'Hepatitis B Vaccine','0,1,6',1,'2020-06-24 08:22:51.402372'),(2,'Hepatitis A Vaccine','0,6',1,'2020-06-24 08:22:51.406951'),(3,'Twinrix Vaccine','0,1,6',1,'2020-06-24 08:22:51.408498'),(4,'Gardasil Vaccine','0,2,6',1,'2020-06-24 08:22:51.409823'),(5,'ATT Vaccine','0,2,8',1,'2020-06-24 08:22:51.410954'),(6,'influenza vaccine (<8y.o. 1st time)','0,1',1,'2020-06-24 08:22:51.411924'),(7,'Rotateq Vaccine Po','0,2,4',1,'2020-06-24 08:22:51.412867'),(8,'Plan A Vaccine','0,2,4,6',1,'2020-06-24 08:22:51.413766'),(9,'Plan D Vaccine','0,2,4,6',1,'2020-06-24 08:22:51.414624'),(10,'小手術','0',1,'2020-06-24 08:22:51.415463'),(11,'1064 激光美白，去斑，嫩膚','0,2,8',1,'2020-06-24 08:22:51.416332'),(12,'去毛激光','0',1,'2020-06-24 08:22:51.417355'),(13,'HiB Vaccine','0,2,4',1,'2020-06-24 08:22:51.418311');
/*!40000 ALTER TABLE `Sms_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sms_smstemplate`
--

DROP TABLE IF EXISTS `Sms_smstemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sms_smstemplate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sms_id` varchar(90) NOT NULL,
  `sms_id_sub` varchar(90) NOT NULL,
  `content` longtext NOT NULL,
  `content_sub` longtext NOT NULL,
  `lang` smallint DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `category_id` int DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Sms_smstemplate_category_id_22ea5c27_fk_Sms_category_id` (`category_id`),
  KEY `Sms_smstemplate_service_id_7f01ee03_fk_Sms_service_id` (`service_id`),
  CONSTRAINT `Sms_smstemplate_category_id_22ea5c27_fk_Sms_category_id` FOREIGN KEY (`category_id`) REFERENCES `Sms_category` (`id`),
  CONSTRAINT `Sms_smstemplate_service_id_7f01ee03_fk_Sms_service_id` FOREIGN KEY (`service_id`) REFERENCES `Sms_service` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sms_smstemplate`
--

LOCK TABLES `Sms_smstemplate` WRITE;
/*!40000 ALTER TABLE `Sms_smstemplate` DISABLE KEYS */;
INSERT INTO `Sms_smstemplate` VALUES (10,'181407','181408','歡迎你蒞臨123醫務中心。剛才已為你接種了第一針乙型肝炎預防針，第二，三針將會在1，5個月後接種。乙型肝炎主要透過母嬰，血液和性接觸三種方法傳染。完成接種疫苗後可預防乙型肝炎所引發的急性肝炎，肝衰竭和肝癌。','温馨提示。親愛的客戶，你在123醫務中心接種的乙型肝炎預防針，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，未來二天不需做劇烈運動。期待你的來臨！',1,1,'2020-06-24 08:26:44.523773',1,1),(11,'181407','181408','Welcome to 123 Medical Centre. You have just received your first dose of hepatitis B vaccine. The second and third dose will be 1, 5 month later respectively. Hepatitis B is transmitted via mother-to-infant, blood borne and sexual contact. Upon completion of the hepatitis B vaccination, one is protected against acute hepatitis, cirrhosis and hepatocarcinoma.','Warm Reminder. Dear customer, your order on hepatitis B vaccine, second / third dose is due now. You may visit 123 medical centre during the opening hours for the vaccination. Please be reminded that you should feel good, no fever and no vigorous exercise in coming few days before coming for vaccination. We are looking forward to your visit.',2,1,'2020-06-24 08:27:38.503366',1,1),(12,'181429','181430','歡迎你蒞臨123醫務中心。剛才已為你接種了第一針甲型肝炎預防針，第二針將會在6個月後接種。甲型肝炎主要是透過受污染的食水，污水清洗的生果和食用海鲜傳染。完成接種疫苗後可預防甲型肝炎所引發的急性肝炎。','温馨提示。親愛的客戶，你在123醫務中心接種的甲型肝炎預防針，第二針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，未來二天不需做劇烈運動。期待你的來臨！',1,1,'2020-06-26 13:57:30.366024',1,2),(13,'181429','181430','Welcome to 123 Medical Centre. You have just received your first dose of hepatitis A vaccine. The second dose will be 6 month later. Hepatitis A is transmitted by consumption of contaminated water, seafood and fruit cleaned by contaminated water. Upon completion of the hepatitis A vaccination, one is protected against acute hepatitis.','Warm Reminder. Dear customer, your order on hepatitis A vaccine, second dose is due now. You may visit 123 medical centre during the opening hours for the vaccination. Please be reminded that you should feel good, no fever and no vigorous exercise in coming few days before coming for vaccination. We are looking forward to your visit.',2,1,'2020-06-26 13:58:28.947306',1,2),(14,'181431','181432','歡迎你蒞臨123醫務中心。剛才已為你接種了第一針甲乙型混合肝炎預防針，第二，三針將會在1，5個月後接種。乙型肝炎主要透過母嬰，血液和性接觸三種方法傳染。甲型肝炎主要是透過受污染的食水，污水清洗的生果和食用海鲜傳染。完成接種疫苗後可預防甲 / 乙型肝炎所引發的急性肝炎，肝衰竭和肝癌。','温馨提示。親愛的客戶，你在123醫務中心接種的甲乙型肝炎預防針，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，未來二天不需做劇烈運動。期待你的來臨！',1,1,'2020-06-26 14:01:24.694182',1,3),(15,'181431','181432','Welcome to 123 Medical Centre. You have just received your first dose of hepatitis A, B Twinrix vaccine. The second and third dose will be 1, 5 month later respectively. Hepatitis A is transmitted by consumption of contaminated water, seafood and fruit cleaned by contaminated water. Hepatitis B is transmitted via mother-to-infant, blood borne and sexual contact. Upon completion of the hepatitis A, B Twinrix vaccination, one is protected against acute hepatitis, cirrhosis and hepatocarcinoma.','Warm Reminder. Dear customer, your order on hepatitis A / B Twinrix vaccine, second / third dose is due now. You may visit 123 medical centre during the opening hours for the vaccination. Please be reminded that you should feel good, no fever and no vigorous exercise in coming few days before coming for vaccination. We are looking forward to your visit.',2,1,'2020-06-26 14:02:36.687517',1,3),(16,'181434','181435','歡迎蒞臨123醫務中心。你剛剛接種了第一針宮頸癌9價預防針，接下來的第二/三針將於第2 , 6個月接種。宮頸癌HPV 病毒主要透過性接觸或傷口傳染。感炎後會增加患宮頸癌，肛門癌，皮膚疣等機會。九價子宮頸癌預防針可預防 HPV 6, 11, 16, 18, 31, 33, 45, 52, 58, 九種常見的 過濾性病毒，從而減少患上子宮頸癌機會約9成。','温馨提示。親愛的客戶，你在123醫務中心接種的 Gardasil 宮頸癌預防針，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，沒有懷孕，未來二天不需做劇烈運動。期待你的來臨！',1,1,'2020-06-26 14:07:27.718358',1,4),(17,'181434','181435','Welcome to 123 Medical Centre. You have just received the first dose of Gardasil HPV9 vaccine. The second / third dose will be st 2, 6 months later. Human Papilloma Virus infection mainly transmitted via sexual or direct contact. It increases risk of cervical cancer, anal cancer and skin wart. Gardasil 9 can prevent HPV 6, 11, 16, 18, 31, 33, 45, 52, 58 viral infection, it reduces cervical cancer by 90%.','Warm Reminder. Dear customer, your order on Gardasil cervical cancer vaccine, second / third dose is due now. You may visit 123 medical centre during the opening hours for the vaccination. Please be reminded that you should feel good, no fever, not pregnant now and no vigorous exercise in coming few days before coming for vaccination. We are looking forward to your visit.',2,1,'2020-06-26 14:08:33.451976',1,4),(18,'181436','181437','歡迎蒞臨123醫務中心。你剛剛接種了第一針破傷風針預防針，接下來的第二/三針將於第2 , 8個月接種。破傷風主要經過傷口傳染，特別是穿刺性傷口，會引致急性肌肉抽搐，死亡率可達6成。','温馨提示。親愛的客戶，你在123醫務中心接種的破傷風預防針，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，未來二天不需做劇烈運動。期待你的來臨！',1,1,'2020-06-26 14:11:10.928648',1,5),(19,'181436','18147','Welcome to 123 Medical Centre. You have just received the first dose of tetanus vaccine. The second and third dose will be 2, 8 months later. Tetanus is mainly trasmitted by open wound, especially stab wound. It may cause acute local or generalised muscle spasm and even death.','Warm Reminder. Dear customer, your order on ATT tetanus vaccine, second / third dose is due now. You may visit 123 medical centre during the opening hours for the vaccination. Please be reminded that you should feel good, no fever and no vigorous exercise in coming few days before coming for vaccination. We are looking forward to your visit.',2,1,'2020-06-26 14:11:56.954353',1,5),(20,'181438','181439','歡迎蒞臨123醫務中心。你的小朋友剛剛接種了第一針季節性流感預防針，接下來的第二針將於第1個月接種。季節性流感主要經過飛沫傳染，患者會出現發燒，肌肉疼痛，傷風等症狀。每年9至1月是接種疫苗的最佳時間。照顧者亦應每年接種流感疫苗以保護小朋友。','温馨提示。親愛的客戶，你在123醫務中心接種的季節性流感預防針，第二針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，未來二天不需做劇烈運動。期待你的來臨！',1,1,'2020-06-26 14:13:36.649758',1,6),(21,'181438','181439','Welcome to 123 Medical Centre. Your child has just received the first dose of Seasonal Influenza vaccine. The second dose will be 1 month later. Seasonal Influenza may cause fever, myalgia and coryza. Each year, the best injection time is between September and January. Care givers are advised to receive flu vaccine to gain extra protection to their children.','Warm Reminder. Dear customer, your order on influenza vaccine, second dose is due now. You may visit 123 medical centre during the opening hours for the vaccination. Please be reminded that you should feel good, no fever and no vigorous exercise in coming few days before coming for vaccination. We are looking forward to your visit.',2,1,'2020-06-26 14:14:39.939326',1,6),(22,'181440','181441','歡迎蒞臨123醫務中心。你的小朋友剛剛接種了第一針輪狀病毒口服預防液，接下來的第二次將於第2,4個月接種。輪狀病毒主要經過不潔食物傳染，或小孩把不潔東西放進口中而感染，患者會出現發燒，嚴重嘔吐和肚瀉，嚴重者需要入院打點滴。','温馨提示。親愛的客戶，你在123醫務中心接種的輪狀口服疫苗，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你BB身體狀況良好，沒有發燒。期待你的來臨！',1,1,'2020-06-26 14:20:13.854931',1,7),(23,'181440','181441','Welcome to 123 Medical Centre. Your child has just received the first dose of Rotavirus oral vaccine. The second dose will be 2, 4 month later. Rotavirus is caused by ingestion of contamined food or putting things in mouth. It may results in fever, severe vomiting and diarrhea. Hospitalisation maybe required in severe case.','Warm Reminder. Dear customer, your order on Rotavirus oral vaccine, second / third dose is due now. You may visit 123 medical centre during the opening hours for the vaccination. Please be reminded that your BB should feel good, no fever before coming for vaccination. We are looking forward to your visit.',2,1,'2020-06-26 14:20:55.970296',1,7),(24,'181442','181443','歡迎蒞臨123醫務中心。你的小朋友剛剛接種了第一針乙型啫血流感預防針，接下來的第二次將於第2，第4個月接種。乙型嗜血流感主要經過飛沫和接觸傳染，患者會出現發燒， 流鼻水，咳嗽，扁桃腺發炎等症狀，嚴重者需要入院。','温馨提示。親愛的客戶，你在123醫務中心接種的乙型嗜血流感預防針 (HiB)，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你BB身體狀況良好，沒有發燒。期待你的來臨！',1,1,'2020-06-26 14:23:54.227357',1,13),(25,'181442','181443','Welcome to 123 Medical Centre. Your child has just received the first dose of Haemophilus influenza type b vaccine (HiB). The second dose will be 2, 4 month later. Hib is transmitted by droplet, direct contact. It may result in fever, coryz, tonsillitis and pneumonia. Hospitalisation maybe required in severe case.','Warm Reminder. Dear customer, your order on Hemophilus influenza type B vaccine (HiB), second / third dose is due now. You may visit 123 medical centre during the opening hours for the vaccination. Please be reminded that your BB should feel good, no fever before coming for vaccination. We are looking forward to your visit.',2,1,'2020-06-26 14:24:25.634914',1,13),(26,'181444','181446','歡迎蒞臨123醫務中心。你的小朋友剛剛接種了第一針乙型啫血流感預防針和第一針輪狀病毒口服預防液，接下來的第二次將於第2，第4，和第16個月接種。乙型嗜血流感主要經過飛沫和接觸傳染，患者會出現發燒，流鼻水，咳嗽，扁桃腺發炎等症狀，嚴重者需要入院。輪狀病毒主要經過不潔食物傳染，或小孩把不潔東西放進口中而感染，患者會出現發燒，嚴重嘔吐和肚瀉，嚴重者需要入院打點滴。','温馨提示。親愛的客戶，你BB在123醫務中心接種的輪狀口服疫苗 / 乙型啃血流感預防針 (HiB)，第二/三/四針已到期，你可以在診所辦工時間內來接種疫苗。請確定你BB身體狀況良好，沒有發燒，飲食正常。期待你的來臨！',1,1,'2020-06-26 14:26:33.707778',1,8),(27,'181444','181446','Welcome to 123 Medical Centre. Your child has just received the first dose of Haemophilus influenza type b vaccine (HiB), and first dose of Rotavirus vaccination. The second dose will be 2, 4 and 16 month later. Hib is transmitted by droplet, direct contact. It may result in fever, coryz, tonsillitis and pneumonia. Rotavirus is caused by ingestion of contamined food or putting things in mouth. It may results in fever, severe vomiting and diarrhea. Hospitalisation maybe required in severe case.','Warm Reminder. Dear customer, your order on Plan A. Rotavirus vaccine, Hemophilus Influenza type B vaccine (HiB), second / third /fourth dose is due now. You may visit 123 medical centre during the opening hours for the vaccination. Please be reminded that your BB should feel good, no fever and normal appetite before vaccination. We are looking forward to your visit.',2,1,'2020-06-26 14:27:06.610009',1,8),(28,'181448','181449','歡迎蒞臨123醫務中心。你的小朋友剛剛接種了第一針五合一/ 六合一預防針和第一針輪狀病毒口服預防液，接下來的第二次將於第2，第4，和第16個月接種。你仍要到母嬰健康院接種13價肺炎預防針。乙型嗜血流感主要經過 飛沫和接觸傳染，患者會出現發燒， 流鼻水，咳嗽，扁桃腺發炎等症狀，嚴重者需要入院。輪狀病毒主要經過不潔食物傳染，或小孩把不潔東西放進口中而感染，患者會出現發燒，嚴重嘔吐和肚瀉，嚴重者需要入院打點滴。','温馨提示。親愛的客戶，你BB在123醫務中心接種的輪狀口服疫苗 / 五合一 / 六合一 預防針 ，第二/三/四針已到期，你可以在診所辦工時間內來接種疫苗。請確定你BB身體狀況良好，沒有發燒，飲食正常。期待你的來臨！提醒你仍要到母嬰健康院為BB 接種13價肺炎預防針。',1,1,'2020-06-26 14:29:37.078104',1,9),(29,'181448','181449','Welcome to 123 Medical Centre. Your child has just received the first dose of 5 in 1 / 6 in 1, and first dose of Rotavirus vaccination. Your BB still need to receive Pneumococcal vaccine Prevenar 13 at MCHC. The second dose will be 2, 4 and 16 month later. Hib is transmitted by droplet, direct contact. It may result in fever, coryz, tonsillitis and pneumonia. Rotavirus is caused by ingestion of contamined food or putting things in mouth. It may results in fever, severe vomiting and diarrhea. Hospitalisation maybe required in severe case.','Warm Reminder. Dear customer, your order on Plan D. Rotavirus vaccine, 5 in 1 / 6 in 1, second / third /fourth dose is due now. You may visit 123 medical centre during the opening hours for the vaccination. Please be reminded that your BB should feel good, no fever and normal appetite before vaccination. We are looking forward to your visit. You are reminded that your BB still need to receive pneumococcal Prevenar 13 vaccine at MCHC.',2,1,'2020-06-26 14:30:11.650159',1,9),(30,'181450','181450','多謝你今天蒞臨123醫務中心，針對你今天做的小手術有幾個注意事項要提一提你\r\n1. 傷口今天不要濕水\r\n2. 若傷口出現異常痛楚 / 出血 / 麻痺感覺 / 爆線，請第一時間通知我們。Tel: 55448155 (Whatsapp / 微訊) / 37020123. \r\n3. 傷口癒合需要四大元素，包括適當溫度，濕度和透氣，並且沒有發炎。選擇適合敷料非常重要，記得先用藥水清洗傷口，再放上紗布。\r\n4. 大部分需要縫針的傷口都是在五至七天可以拆線。請自行安排時間來拆線。\r\n5. 手術時支付的費用已包含覆診和拆線, 若有什麼問題，可隨時詢問，費用全免。','多謝你今天蒞臨123醫務中心，針對你今天做的小手術有幾個注意事項要提一提你\r\n1. 傷口今天不要濕水\r\n2. 若傷口出現異常痛楚 / 出血 / 麻痺感覺 / 爆線，請第一時間通知我們。Tel: 55448155 (Whatsapp / 微訊) / 37020123. \r\n3. 傷口癒合需要四大元素，包括適當溫度，濕度和透氣，並且沒有發炎。選擇適合敷料非常重要，記得先用藥水清洗傷口，再放上紗布。\r\n4. 大部分需要縫針的傷口都是在五至七天可以拆線。請自行安排時間來拆線。\r\n5. 手術時支付的費用已包含覆診和拆線, 若有什麼問題，可隨時詢問，費用全免。',1,1,'2020-06-26 14:31:26.335827',2,10),(31,'181450','181450','Welcome to 123 Medical Centre. There are few warm reminders to you concerning the minor operations you have done today. \r\n1. No water for coming 24 hours please.\r\n2. Contact us immediately in cases of uncontrolled bleeding, extra ordinary pain, numbness or sensory loss, wound dehiscence. Tel: 55448155 (Whatsapp / Wechat) / 37020123.\r\n3. Wound healing depends on TIME... Temperature, no Infection, Moisture and Evaporation. That is why an appropriate dressing cover is advised. For enquiry, please do not hesitate to contact us.\r\n4. For wound with stitches applied, please return 5 to 7 days for removal of stitches.\r\n5. The fee paid at surgery date has already covered all medication and follow up, so please do come back for any enquiries.','Welcome to 123 Medical Centre. There are few warm reminders to you concerning the minor operations you have done today. \r\n1. No water for coming 24 hours please.\r\n2. Contact us immediately in cases of uncontrolled bleeding, extra ordinary pain, numbness or sensory loss, wound dehiscence. Tel: 55448155 (Whatsapp / Wechat) / 37020123.\r\n3. Wound healing depends on TIME... Temperature, no Infection, Moisture and Evaporation. That is why an appropriate dressing cover is advised. For enquiry, please do not hesitate to contact us.\r\n4. For wound with stitches applied, please return 5 to 7 days for removal of stitches.\r\n5. The fee paid at surgery date has already covered all medication and follow up, so please do come back for any enquiries.',2,1,'2020-06-26 14:32:16.432683',2,10),(32,'181451','181452','多謝你今天蒞臨123醫務中心， 1064 / 532 / 808nm 激光, 有美白 / 去斑 / 收緊毛孔 / 嫩膚 / 去血管絲等多種功能， 效果會隨著接受療程次數多少而一次比一次好。 最快可以四星期來做，來之前敬請預約。\r\n以下有幾點是做完激光後的注意事項\r\n1. 防曬是終生職業，特別是激光後首兩星期，每天出門前記得要搽防曬，SPF 30, PA 3+ 已足夠。\r\n2. 正常洗面便可，盡量避免搽太多化妝品。\r\n3. 做完激光後首兩星期，應避免游水，曬日光浴。\r\n4. 建議使用今天給你的口服抗敏感藥和搽面的抗敏感藥膏。可舒緩激光後皮膚痕癢的情況。\r\n5. 要達至做激光的最佳效果，必須保持充足睡眠，充足水分，避免太多壓力。和要有恆心讓皮下血管把黑色素帶走，需時可以是數個月至一兩年。\r\n6. 有一部分人首數次接受激光後，皮膚有機會會更黑多一點，但不用擔心，這是正常的現象，會有其他方法讓它慢慢變白。','溫馨提示， 繼上次做完激光後已經有四星期以上，你可隨時來做第二次激光。最佳做激光時間是放假前，敬請先預約。',1,1,'2020-06-26 14:43:15.238226',3,11),(33,'181451','181452','Welcome to visit 123 Medical Centre. We hope you enjoy our hospitable service. The combination of 1064 / 532 / 808 laser treatment is good at skin rejuvenation, depigmentation, polish poles, whitening effect, removal of telangiectasia. Upon few treatment cycles, skin color and quality are expected to improve. You are advised to receive next laser treatment 4 weeks later to achieve the best effect. Please kindly reserve your booking with our nurses in advance. \r\nHere are few warm tips to you\r\n1. Always do sun protection, especially before you leave home in morning. Sun block of SPF 30, PA 3+ is good enough, re-apply 3 hours later if persistent sun exposure is expected. \r\n2. Clean face as usual. You may continue to use your own facial cleanser. Avoid too much makeup.\r\n3. Avoid swimming, sunna in coming few days.\r\n4. Use the dispensed topical cream and anti-itchiness drug can relieve the skin discomfort on first few days after laser treatment\r\n5. Few cycles of laser treatments are required to achieve the best good result, so please be patient. \r\n6. Some people may experience darkening of skin after few cycles of laser treatment. This is a physiological change. Do not panic, there are many ways to tackle this problem.','Warm reminder, there has been more than 4 weeks since last laser treatment at 123 Medical Centre. You are warmly welcome to receive further treatment. Kindly make your appointment in advance. The best time for laser treatment is right before holiday.',2,1,'2020-06-26 14:43:56.912804',3,11),(34,'181451','181452','Welcome to visit 123 Medical Centre. We hope you enjoy our hospitable service. The combination of 1064 / 532 / 808 laser treatment is good at skin rejuvenation, depigmentation, polish poles, whitening effect, removal of telangiectasia. Upon few treatment cycles, skin color and quality are expected to improve. You are advised to receive next laser treatment 4 weeks later to achieve the best effect. Please kindly reserve your booking with our nurses in advance. \r\nHere are few warm tips to you\r\n1. Always do sun protection, especially before you leave home in morning. Sun block of SPF 30, PA 3+ is good enough, re-apply 3 hours later if persistent sun exposure is expected. \r\n2. Clean face as usual. You may continue to use your own facial cleanser. Avoid too much makeup.\r\n3. Avoid swimming, sunna in coming few days.\r\n4. Use the dispensed topical cream and anti-itchiness drug can relieve the skin discomfort on first few days after laser treatment\r\n5. Few cycles of laser treatments are required to achieve the best good result, so please be patient. \r\n6. Some people may experience darkening of skin after few cycles of laser treatment. This is a physiological change. Do not panic, there are many ways to tackle this problem.','Warm reminder, there has been more than 4 weeks since last laser treatment at 123 Medical Centre. You are warmly welcome to receive further treatment. Kindly make your appointment in advance. The best time for laser treatment is right before holiday.',2,1,'2020-06-26 14:45:03.680447',3,11),(35,'181453','181453','多謝你今天蒞臨123醫務中心，今天用了808nm 激光去毛，效果會隨著接受療程次數多少而一次比一次好。建議三星期後再來做，來之前敬請預約。\r\n以下有幾點是做完激光後的注意事項\r\n1. 防曬是終生職業，特別是激光後首兩星期，每天出門前記得要搽防曬，SPF 30, PA 3+ 已足夠。\r\n2. 做完激光後首兩星期，應避免游水，曬日光浴。\r\n3. 要達至做激光的最佳效果，必須保持充足睡眠，充足水分，避免太多壓力。 \r\n4. 三次去毛療程約可減少毛髮一半，大部分人做六至九次已有很明顯的去毛效果。','多謝你今天蒞臨123醫務中心，今天用了808nm 激光去毛，效果會隨著接受療程次數多少而一次比一次好。建議三星期後再來做，來之前敬請預約。\r\n以下有幾點是做完激光後的注意事項\r\n1. 防曬是終生職業，特別是激光後首兩星期，每天出門前記得要搽防曬，SPF 30, PA 3+ 已足夠。\r\n2. 做完激光後首兩星期，應避免游水，曬日光浴。\r\n3. 要達至做激光的最佳效果，必須保持充足睡眠，充足水分，避免太多壓力。 \r\n4. 三次去毛療程約可減少毛髮一半，大部分人做六至九次已有很明顯的去毛效果。',1,1,'2020-06-26 14:45:51.512439',3,12),(36,'181453','181453','Welcome to 123 Medical Centre. Hope you enjoy our hospitable service. Epilation by laser is a long lasting option to get rid of body hair. The main concern is the pain during treatment, which can be controlled by oral pre-medication and application of anaesthetic cream. You are advised to re-do epilation laser 3 weeks later. Here are few warm reminders\r\n1. Always do sun protection, especially before you leave home in morning. Sun block of SPF 30, PA 3+ is good enough, re-apply 3 hours later if persistent sun exposure is expected. \r\n2. Avoid swimming, sunna in coming few days.\r\n3. Few cycles of laser treatments are required to achieve the best good result, so please be patient. Maintain adequate sleep, hyadration and avoid excessive stress.\r\n4. 3 cycles of epilation laser can reduce half of hair in general, most people experience excellent satisfaction after 6 to 9 cycles.','Welcome to 123 Medical Centre. Hope you enjoy our hospitable service. Epilation by laser is a long lasting option to get rid of body hair. The main concern is the pain during treatment, which can be controlled by oral pre-medication and application of anaesthetic cream. You are advised to re-do epilation laser 3 weeks later. Here are few warm reminders\r\n1. Always do sun protection, especially before you leave home in morning. Sun block of SPF 30, PA 3+ is good enough, re-apply 3 hours later if persistent sun exposure is expected. \r\n2. Avoid swimming, sunna in coming few days.\r\n3. Few cycles of laser treatments are required to achieve the best good result, so please be patient. Maintain adequate sleep, hyadration and avoid excessive stress.\r\n4. 3 cycles of epilation laser can reduce half of hair in general, most people experience excellent satisfaction after 6 to 9 cycles.',2,1,'2020-06-26 14:46:18.333996',3,12);
/*!40000 ALTER TABLE `Sms_smstemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_contact`
--

DROP TABLE IF EXISTS `User_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_named` varchar(20) DEFAULT NULL,
  `last_named` varchar(20) DEFAULT NULL,
  `bith` date DEFAULT NULL,
  `star` tinyint(1) NOT NULL,
  `phoned` varchar(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `gender` smallint NOT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `area_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `User_contact_area_id_68110367_fk_Sms_area_id` (`area_id`),
  CONSTRAINT `User_contact_area_id_68110367_fk_Sms_area_id` FOREIGN KEY (`area_id`) REFERENCES `Sms_area` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_contact`
--

LOCK TABLES `User_contact` WRITE;
/*!40000 ALTER TABLE `User_contact` DISABLE KEYS */;
INSERT INTO `User_contact` VALUES (1,'Eric',NULL,NULL,0,'92779625','',0,1,'2020-06-24 09:41:33.576680',3),(2,'Eric',NULL,NULL,0,'92779625','',0,1,'2020-06-24 09:41:33.579159',3),(3,'沙荔枝',NULL,NULL,0,'13576639986','',0,1,'2020-06-26 13:11:01.256754',1),(4,'傻傻',NULL,NULL,0,'13576639986','',0,1,'2020-06-26 13:11:01.338367',3),(5,'chiwai',NULL,NULL,0,'61515651','',0,1,'2020-06-26 16:23:20.956702',3),(6,'chiwai',NULL,NULL,0,'61515651','',0,1,'2020-06-26 16:23:20.958729',3),(7,'夏美俐',NULL,NULL,0,'69937074','',0,1,'2020-06-28 03:27:38.695548',3),(8,'夏美俐',NULL,NULL,0,'69937074','',0,1,'2020-06-28 03:27:38.698007',3),(9,'曾超然',NULL,NULL,0,'92379666','',0,1,'2020-07-01 03:25:22.982075',3),(10,'曾超然',NULL,NULL,0,'92379666','',0,1,'2020-07-01 03:25:22.983664',3),(11,'何洪清',NULL,NULL,0,'55372253','',0,1,'2020-07-06 07:30:27.545232',3),(12,'何洪清',NULL,NULL,0,'55372253','',0,1,'2020-07-06 07:30:27.547365',3),(13,'趙敏',NULL,NULL,0,'98452717','',0,1,'2020-07-12 03:07:32.656092',3),(14,'趙敏',NULL,NULL,0,'98452717','',0,1,'2020-07-12 03:07:32.658154',3);
/*!40000 ALTER TABLE `User_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_userprofile`
--

DROP TABLE IF EXISTS `User_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_userprofile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `last_login` datetime(6) DEFAULT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `nickName` varchar(20) DEFAULT NULL,
  `bith` date DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `gender` varchar(6) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `password` varchar(240) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_userprofile`
--

LOCK TABLES `User_userprofile` WRITE;
/*!40000 ALTER TABLE `User_userprofile` DISABLE KEYS */;
INSERT INTO `User_userprofile` VALUES (1,'2020-06-24 08:18:25.640437','VcrTing','','',1,'2020-06-24 08:15:00.000000','沙','2020-06-26','13576639986','vcrting@163.com','male',1,1,'pbkdf2_sha256$150000$gGHZmtBQWF89$X8f+SsKL/QCT/3EUvKkIHXDPLSKtjTMFPJlFD23lYvI=',1,'2020-06-24 08:15:11.518503'),(2,'2020-06-26 16:20:23.041130','support@manfulls.com','','',1,'2020-06-26 16:08:22.987556',NULL,NULL,NULL,'support@manfulls.com','male',1,1,'pbkdf2_sha256$150000$uezMt3tk61GM$SIZYZc6iF+P4luKh9JL9wfk3YiyvsZKQ63tkI62STo8=',1,'2020-06-26 16:08:22.987575'),(3,NULL,'123medhk@gmail.com','','',1,'2020-06-26 16:21:00.000000',NULL,NULL,NULL,'123medhk@gmail.com','male',1,0,'pbkdf2_sha256$150000$AwHlix4iE2eS$yvJ1sFXIjqPnlN/5lVpFmIP9ZUVTKhh6n7GKDZBlS+s=',1,'2020-06-26 16:21:42.424617');
/*!40000 ALTER TABLE `User_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_userprofile_groups`
--

DROP TABLE IF EXISTS `User_userprofile_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_userprofile_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userprofile_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_userprofile_groups_userprofile_id_group_id_6ef09298_uniq` (`userprofile_id`,`group_id`),
  KEY `User_userprofile_groups_group_id_508a2183_fk_auth_group_id` (`group_id`),
  CONSTRAINT `User_userprofile_gro_userprofile_id_6b5554d1_fk_User_user` FOREIGN KEY (`userprofile_id`) REFERENCES `User_userprofile` (`id`),
  CONSTRAINT `User_userprofile_groups_group_id_508a2183_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_userprofile_groups`
--

LOCK TABLES `User_userprofile_groups` WRITE;
/*!40000 ALTER TABLE `User_userprofile_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `User_userprofile_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_userprofile_user_permissions`
--

DROP TABLE IF EXISTS `User_userprofile_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_userprofile_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userprofile_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_userprofile_user_pe_userprofile_id_permissio_b23258ac_uniq` (`userprofile_id`,`permission_id`),
  KEY `User_userprofile_use_permission_id_948bcf18_fk_auth_perm` (`permission_id`),
  CONSTRAINT `User_userprofile_use_permission_id_948bcf18_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `User_userprofile_use_userprofile_id_4e02c612_fk_User_user` FOREIGN KEY (`userprofile_id`) REFERENCES `User_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_userprofile_user_permissions`
--

LOCK TABLES `User_userprofile_user_permissions` WRITE;
/*!40000 ALTER TABLE `User_userprofile_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `User_userprofile_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Web_img`
--

DROP TABLE IF EXISTS `Web_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Web_img` (
  `id` int NOT NULL AUTO_INCREMENT,
  `img` varchar(100) DEFAULT NULL,
  `img_tiny` varchar(100) DEFAULT NULL,
  `w` varchar(60) DEFAULT NULL,
  `h` varchar(60) DEFAULT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Web_img`
--

LOCK TABLES `Web_img` WRITE;
/*!40000 ALTER TABLE `Web_img` DISABLE KEYS */;
/*!40000 ALTER TABLE `Web_img` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Web_smsconf`
--

DROP TABLE IF EXISTS `Web_smsconf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Web_smsconf` (
  `id` int NOT NULL AUTO_INCREMENT,
  `flag` varchar(30) NOT NULL,
  `sid` varchar(200) NOT NULL,
  `token` varchar(200) NOT NULL,
  `sender` varchar(120) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Web_smsconf`
--

LOCK TABLES `Web_smsconf` WRITE;
/*!40000 ALTER TABLE `Web_smsconf` DISABLE KEYS */;
/*!40000 ALTER TABLE `Web_smsconf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Web_systemmsg`
--

DROP TABLE IF EXISTS `Web_systemmsg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Web_systemmsg` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject` varchar(120) DEFAULT NULL,
  `message` longtext,
  `typed` smallint DEFAULT NULL,
  `way` smallint DEFAULT NULL,
  `success_status` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Web_systemmsg`
--

LOCK TABLES `Web_systemmsg` WRITE;
/*!40000 ALTER TABLE `Web_systemmsg` DISABLE KEYS */;
/*!40000 ALTER TABLE `Web_systemmsg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add 地域与电话号码前缀',6,'add_area'),(22,'Can change 地域与电话号码前缀',6,'change_area'),(23,'Can delete 地域与电话号码前缀',6,'delete_area'),(24,'Can view 地域与电话号码前缀',6,'view_area'),(25,'Can add 服务分类',7,'add_category'),(26,'Can change 服务分类',7,'change_category'),(27,'Can delete 服务分类',7,'delete_category'),(28,'Can view 服务分类',7,'view_category'),(29,'Can add 服务项目',8,'add_service'),(30,'Can change 服务项目',8,'change_service'),(31,'Can delete 服务项目',8,'delete_service'),(32,'Can view 服务项目',8,'view_service'),(33,'Can add 短信模版',9,'add_smstemplate'),(34,'Can change 短信模版',9,'change_smstemplate'),(35,'Can delete 短信模版',9,'delete_smstemplate'),(36,'Can view 短信模版',9,'view_smstemplate'),(37,'Can add 图片',10,'add_img'),(38,'Can change 图片',10,'change_img'),(39,'Can delete 图片',10,'delete_img'),(40,'Can view 图片',10,'view_img'),(41,'Can add SMS配置',11,'add_smsconf'),(42,'Can change SMS配置',11,'change_smsconf'),(43,'Can delete SMS配置',11,'delete_smsconf'),(44,'Can view SMS配置',11,'view_smsconf'),(45,'Can add 系统消息',12,'add_systemmsg'),(46,'Can change 系统消息',12,'change_systemmsg'),(47,'Can delete 系统消息',12,'delete_systemmsg'),(48,'Can view 系统消息',12,'view_systemmsg'),(49,'Can add 员工',13,'add_userprofile'),(50,'Can change 员工',13,'change_userprofile'),(51,'Can delete 员工',13,'delete_userprofile'),(52,'Can view 员工',13,'view_userprofile'),(53,'Can add 联系人',14,'add_contact'),(54,'Can change 联系人',14,'change_contact'),(55,'Can delete 联系人',14,'delete_contact'),(56,'Can view 联系人',14,'view_contact'),(57,'Can add 极光任務队列',15,'add_everytask'),(58,'Can change 极光任務队列',15,'change_everytask'),(59,'Can delete 极光任務队列',15,'delete_everytask'),(60,'Can view 极光任務队列',15,'view_everytask'),(61,'Can add 短信发送完成记录',16,'add_smstaskrecord'),(62,'Can change 短信发送完成记录',16,'change_smstaskrecord'),(63,'Can delete 短信发送完成记录',16,'delete_smstaskrecord'),(64,'Can view 短信发送完成记录',16,'view_smstaskrecord'),(65,'Can add 任務申请',17,'add_smstask'),(66,'Can change 任務申请',17,'change_smstask'),(67,'Can delete 任務申请',17,'delete_smstask'),(68,'Can view 任務申请',17,'view_smstask'),(69,'Can add 邮件任务申请列表',18,'add_emailapply'),(70,'Can change 邮件任务申请列表',18,'change_emailapply'),(71,'Can delete 邮件任务申请列表',18,'delete_emailapply'),(72,'Can view 邮件任务申请列表',18,'view_emailapply'),(73,'Can add 邮件模版',19,'add_emailtemplate'),(74,'Can change 邮件模版',19,'change_emailtemplate'),(75,'Can delete 邮件模版',19,'delete_emailtemplate'),(76,'Can view 邮件模版',19,'view_emailtemplate'),(77,'Can add 单期邮件记录',20,'add_emailcollect'),(78,'Can change 单期邮件记录',20,'change_emailcollect'),(79,'Can delete 单期邮件记录',20,'delete_emailcollect'),(80,'Can view 单期邮件记录',20,'view_emailcollect');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_User_userprofile_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_User_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `User_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-06-24 08:23:57.503632','1','ID: 176714, 模版: 親愛的客戶{{named}}，歡迎你蒞臨...',3,'',9,1),(2,'2020-06-24 08:23:57.506024','2','ID: 176717, 模版: 親愛的客戶{{named}}，歡迎你蒞臨...',3,'',9,1),(3,'2020-06-24 08:23:57.509005','3','ID: 176397, 模版: 親愛的客戶{{named}}，歡迎蒞臨1...',3,'',9,1),(4,'2020-06-24 08:23:57.510776','4','ID: 176397, 模版: 親愛的客戶{{named}}，歡迎蒞臨1...',3,'',9,1),(5,'2020-06-24 08:23:57.512462','5','ID: 176397, 模版: 親愛的客戶{{named}}，歡迎蒞臨1...',3,'',9,1),(6,'2020-06-24 08:23:57.514102','6','ID: 176397, 模版: 親愛的客戶{{named}}，歡迎蒞臨1...',3,'',9,1),(7,'2020-06-24 08:23:57.515961','7','ID: 176397, 模版: 親愛的客戶{{named}}，歡迎蒞臨1...',3,'',9,1),(8,'2020-06-24 08:23:57.518082','8','ID: 176397, 模版: 親愛的客戶{{named}}，歡迎蒞臨1...',3,'',9,1),(9,'2020-06-24 08:23:57.519744','9','ID: 176397, 模版: 多謝你今天蒞臨123醫務中心， 針對你今...',3,'',9,1),(10,'2020-06-24 08:26:44.530760','10','ID: 111, 模版: 歡迎你蒞臨123醫務中心。剛才已為你接種...',1,'[{\"added\": {}}]',9,1),(11,'2020-06-24 08:27:38.511131','11','ID: 222, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(12,'2020-06-24 08:27:54.831244','10','ID: 111, 模版: 歡迎你蒞臨123醫務中心。剛才已為你接種...',2,'[{\"changed\": {\"fields\": [\"service\"]}}]',9,1),(13,'2020-06-24 09:35:24.286466','10','ID: 181407, 模版: 歡迎你蒞臨123醫務中心。剛才已為你接種...',2,'[{\"changed\": {\"fields\": [\"sms_id\", \"sms_id_sub\"]}}]',9,1),(14,'2020-06-24 09:35:37.837818','11','ID: 181407, 模版: Welcome to 123 Medic...',2,'[{\"changed\": {\"fields\": [\"sms_id\", \"sms_id_sub\"]}}]',9,1),(15,'2020-06-24 11:14:55.109307','3','地域名称：香港前缀：+852',2,'[{\"changed\": {\"fields\": [\"phoned_prefix\"]}}]',6,1),(16,'2020-06-24 11:15:04.246825','2','地域名称：澳門前缀：+853',2,'[{\"changed\": {\"fields\": [\"phoned_prefix\"]}}]',6,1),(17,'2020-06-24 11:15:13.605983','1','地域名称：大陆前缀：+86',2,'[{\"changed\": {\"fields\": [\"phoned_prefix\"]}}]',6,1),(18,'2020-06-26 10:00:53.772222','15','所属时间规则：6 schedule_id：0',3,'',15,1),(19,'2020-06-26 10:00:53.776665','14','所属时间规则：1 schedule_id：0',3,'',15,1),(20,'2020-06-26 10:00:53.778877','13','所属时间规则：0 schedule_id：0',3,'',15,1),(21,'2020-06-26 10:00:53.782840','12','所属时间规则：6 schedule_id：0',3,'',15,1),(22,'2020-06-26 10:00:53.785195','11','所属时间规则：1 schedule_id：0',3,'',15,1),(23,'2020-06-26 10:00:53.787460','10','所属时间规则：0 schedule_id：0',3,'',15,1),(24,'2020-06-26 10:00:53.789721','9','所属时间规则：6 schedule_id：0',3,'',15,1),(25,'2020-06-26 10:00:53.792172','8','所属时间规则：1 schedule_id：0',3,'',15,1),(26,'2020-06-26 10:00:53.794707','7','所属时间规则：0 schedule_id：0',3,'',15,1),(27,'2020-06-26 10:00:53.797269','6','所属时间规则：6 schedule_id：0',3,'',15,1),(28,'2020-06-26 10:00:53.799565','5','所属时间规则：1 schedule_id：0',3,'',15,1),(29,'2020-06-26 10:00:53.801613','4','所属时间规则：0 schedule_id：0',3,'',15,1),(30,'2020-06-26 10:00:53.803867','3','所属时间规则：6 schedule_id：0',3,'',15,1),(31,'2020-06-26 10:00:53.805908','2','所属时间规则：1 schedule_id：0',3,'',15,1),(32,'2020-06-26 10:00:53.808280','1','所属时间规则：0 schedule_id：0',3,'',15,1),(33,'2020-06-26 10:01:06.409356','5','接收者：Eric，电话：92779625',3,'',17,1),(34,'2020-06-26 10:01:06.411088','4','接收者：Eric，电话：92779625',3,'',17,1),(35,'2020-06-26 10:01:06.412414','3','接收者：Eric，电话：92779625',3,'',17,1),(36,'2020-06-26 10:01:06.413681','2','接收者：Eric，电话：92779625',3,'',17,1),(37,'2020-06-26 10:01:06.415252','1','接收者：Eric，电话：92779625',3,'',17,1),(38,'2020-06-26 10:15:23.543613','7','接收者：Eric，电话：92779625',2,'[{\"changed\": {\"fields\": [\"task_status\"]}}]',17,1),(39,'2020-06-26 10:15:48.037039','6','接收者：Eric，电话：92779625',2,'[{\"changed\": {\"fields\": [\"task_status\"]}}]',17,1),(40,'2020-06-26 13:27:39.231029','27','所属时间规则：6 schedule_id：0',3,'',15,1),(41,'2020-06-26 13:27:39.233010','26','所属时间规则：1 schedule_id：0',3,'',15,1),(42,'2020-06-26 13:27:39.234473','25','所属时间规则：0 schedule_id：0',3,'',15,1),(43,'2020-06-26 13:27:39.235758','21','所属时间规则：6 schedule_id：0',3,'',15,1),(44,'2020-06-26 13:27:39.237994','20','所属时间规则：1 schedule_id：0',3,'',15,1),(45,'2020-06-26 13:27:39.239430','19','所属时间规则：0 schedule_id：0',3,'',15,1),(46,'2020-06-26 13:27:39.241040','18','所属时间规则：6 schedule_id：0',3,'',15,1),(47,'2020-06-26 13:27:39.242477','17','所属时间规则：1 schedule_id：0',3,'',15,1),(48,'2020-06-26 13:27:39.243686','16','所属时间规则：0 schedule_id：0',3,'',15,1),(49,'2020-06-26 13:29:34.454406','23','所属时间规则：1 schedule_id：0',2,'[{\"changed\": {\"fields\": [\"send_finish_time\"]}}]',15,1),(50,'2020-06-26 13:45:14.188916','29','所属时间规则：1 schedule_id：0',2,'[{\"changed\": {\"fields\": [\"send_finish_time\", \"apply_status\"]}}]',15,1),(51,'2020-06-26 13:57:30.373695','12','ID: 181429, 模版: 歡迎你蒞臨123醫務中心。剛才已為你接種...',1,'[{\"added\": {}}]',9,1),(52,'2020-06-26 13:58:28.952467','13','ID: 181429, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(53,'2020-06-26 14:01:24.700491','14','ID: 181431, 模版: 歡迎你蒞臨123醫務中心。剛才已為你接種...',1,'[{\"added\": {}}]',9,1),(54,'2020-06-26 14:02:36.695258','15','ID: 181431, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(55,'2020-06-26 14:07:27.723747','16','ID: 181434, 模版: 歡迎蒞臨123醫務中心。你剛剛接種了第一...',1,'[{\"added\": {}}]',9,1),(56,'2020-06-26 14:08:33.459757','17','ID: 181434, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(57,'2020-06-26 14:11:10.934175','18','ID: 181436, 模版: 歡迎蒞臨123醫務中心。你剛剛接種了第一...',1,'[{\"added\": {}}]',9,1),(58,'2020-06-26 14:11:56.959745','19','ID: 181436, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(59,'2020-06-26 14:13:36.656150','20','ID: 181438, 模版: 歡迎蒞臨123醫務中心。你的小朋友剛剛接...',1,'[{\"added\": {}}]',9,1),(60,'2020-06-26 14:14:39.944552','21','ID: 181438, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(61,'2020-06-26 14:20:13.860592','22','ID: 181440, 模版: 歡迎蒞臨123醫務中心。你的小朋友剛剛接...',1,'[{\"added\": {}}]',9,1),(62,'2020-06-26 14:20:55.975793','23','ID: 181440, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(63,'2020-06-26 14:23:54.232489','24','ID: 181442, 模版: 歡迎蒞臨123醫務中心。你的小朋友剛剛接...',1,'[{\"added\": {}}]',9,1),(64,'2020-06-26 14:24:25.639775','25','ID: 181442, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(65,'2020-06-26 14:26:33.712996','26','ID: 181444, 模版: 歡迎蒞臨123醫務中心。你的小朋友剛剛接...',1,'[{\"added\": {}}]',9,1),(66,'2020-06-26 14:27:06.616067','27','ID: 181444, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(67,'2020-06-26 14:29:37.083806','28','ID: 181448, 模版: 歡迎蒞臨123醫務中心。你的小朋友剛剛接...',1,'[{\"added\": {}}]',9,1),(68,'2020-06-26 14:30:11.656162','29','ID: 181448, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(69,'2020-06-26 14:31:26.341795','30','ID: 181450, 模版: 多謝你今天蒞臨123醫務中心，針對你今天...',1,'[{\"added\": {}}]',9,1),(70,'2020-06-26 14:32:16.437453','31','ID: 181450, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(71,'2020-06-26 14:43:15.243365','32','ID: 181451, 模版: 多謝你今天蒞臨123醫務中心， 1064...',1,'[{\"added\": {}}]',9,1),(72,'2020-06-26 14:43:56.917480','33','ID: 181451, 模版: Welcome to visit 123...',1,'[{\"added\": {}}]',9,1),(73,'2020-06-26 14:45:03.685377','34','ID: 181451, 模版: Welcome to visit 123...',1,'[{\"added\": {}}]',9,1),(74,'2020-06-26 14:45:51.565575','35','ID: 181453, 模版: 多謝你今天蒞臨123醫務中心，今天用了8...',1,'[{\"added\": {}}]',9,1),(75,'2020-06-26 14:46:18.339351','36','ID: 181453, 模版: Welcome to 123 Medic...',1,'[{\"added\": {}}]',9,1),(76,'2020-06-26 14:51:06.966740','10','接收者：沙荔枝，电话：13576639986',3,'',17,1),(77,'2020-06-26 14:51:06.968424','9','接收者：傻傻，电话：13576639986',3,'',17,1),(78,'2020-06-26 14:51:06.969742','8','接收者：Eric，电话：92779625',3,'',17,1),(79,'2020-06-26 14:51:06.970930','7','接收者：Eric，电话：92779625',3,'',17,1),(80,'2020-06-26 14:51:06.972028','6','接收者：Eric，电话：92779625',3,'',17,1),(81,'2020-06-26 14:52:01.690660','1','vcrting@163.com',2,'[{\"changed\": {\"fields\": [\"nickName\", \"bith\", \"phone\"]}}]',13,1),(82,'2020-06-26 16:21:42.531616','3','-空白-',1,'[{\"added\": {}}]',13,2),(83,'2020-06-26 16:21:53.992978','3','123medhk@gmail.com',2,'[{\"changed\": {\"fields\": [\"email\"]}}]',13,2);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (18,'Additional','emailapply'),(20,'Additional','emailcollect'),(19,'Additional','emailtemplate'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(15,'Record','everytask'),(17,'Record','smstask'),(16,'Record','smstaskrecord'),(5,'sessions','session'),(6,'Sms','area'),(7,'Sms','category'),(8,'Sms','service'),(9,'Sms','smstemplate'),(14,'User','contact'),(13,'User','userprofile'),(10,'Web','img'),(11,'Web','smsconf'),(12,'Web','systemmsg');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-06-24 08:14:28.267060'),(2,'contenttypes','0002_remove_content_type_name','2020-06-24 08:14:28.305710'),(3,'auth','0001_initial','2020-06-24 08:14:28.352438'),(4,'auth','0002_alter_permission_name_max_length','2020-06-24 08:14:28.455339'),(5,'auth','0003_alter_user_email_max_length','2020-06-24 08:14:28.462914'),(6,'auth','0004_alter_user_username_opts','2020-06-24 08:14:28.469933'),(7,'auth','0005_alter_user_last_login_null','2020-06-24 08:14:28.477102'),(8,'auth','0006_require_contenttypes_0002','2020-06-24 08:14:28.479753'),(9,'auth','0007_alter_validators_add_error_messages','2020-06-24 08:14:28.487117'),(10,'auth','0008_alter_user_username_max_length','2020-06-24 08:14:28.493857'),(11,'auth','0009_alter_user_last_name_max_length','2020-06-24 08:14:28.502341'),(12,'auth','0010_alter_group_name_max_length','2020-06-24 08:14:28.528562'),(13,'auth','0011_update_proxy_permissions','2020-06-24 08:14:28.537600'),(14,'Sms','0001_initial','2020-06-24 08:14:28.599943'),(15,'User','0001_initial','2020-06-24 08:14:28.721656'),(16,'Additional','0001_initial','2020-06-24 08:14:28.919547'),(17,'Additional','0002_auto_20200624_1609','2020-06-24 08:14:29.036648'),(18,'Record','0001_initial','2020-06-24 08:14:29.170263'),(19,'Web','0001_initial','2020-06-24 08:14:29.306735'),(20,'admin','0001_initial','2020-06-24 08:14:29.333448'),(21,'admin','0002_logentry_remove_auto_add','2020-06-24 08:14:29.387351'),(22,'admin','0003_logentry_add_action_flag_choices','2020-06-24 08:14:29.398171'),(23,'sessions','0001_initial','2020-06-24 08:14:29.415839');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0pwfr74z8qyu07v4j7kap4k0xqd2hbd0','N2ViZjlkNmJiM2RlYTdlMWYxYzA0ODM2YTUzMWFjNzRhMzNhZjFmMDp7InVzZXIiOiIxMjNtZWRoa0BnbWFpbC5jb20iLCJpc0xvZ2luIjp0cnVlfQ==','2020-07-20 07:29:50.678757'),('2rrlstum6wgqma66fze622u8830leif4','MWYwNDBiMjI5ZTk2OTA0N2NiNDkwY2RmM2ZhOTFhOWUwZTU5MWJmNTp7InVzZXIiOiJ2Y3J0aW5nQDE2My5jb20iLCJpc0xvZ2luIjp0cnVlfQ==','2020-07-10 15:59:52.268772'),('i113ocatniln984lhrdni7liofjuqecm','Y2FkODg4YWUzMjg0MmQ3NGU5MjdhYzRhNjc3ZmE2NDczNzNlZWUxMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNDg4OTkwYzEwNjBjNzMxMTJmNWIwYWI3MzkzYWYxMjM1MTFjMWFjIiwidXNlciI6InZjcnRpbmdAMTYzLmNvbSIsImlzTG9naW4iOnRydWV9','2020-07-08 09:37:40.075344'),('jo3agijt25uornuhfu8s91vje78hgxgp','OTMxZjc5YjMyMTIwMjU2MTcxY2MyYWZlYjkzZjI2NGFhNjNhZmNhYjp7InVzZXIiOiIxMjNtZWRoa0BnbWFpbC5jb20iLCJpc0xvZ2luIjp0cnVlLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjY1ZjU4ZDE5YTZlMjE1NTYyOTA1ZDliMTg0Yzk0ZWMzYjlhY2U0NSJ9','2020-07-10 16:22:39.600476'),('sbuatvcojzv6h0s3nhvibmgwwnxptxyk','ZTIxMDBiM2U4MWZhNzkyOWMzMDIxN2Y4ZWM0M2NlMTNjNWVmYzI3OTp7InVzZXIiOm51bGwsImlzTG9naW4iOmZhbHNlfQ==','2020-07-29 09:16:47.152493'),('xthe0vs7lywlt6y1h671nq19kq52bi3s','N2ViZjlkNmJiM2RlYTdlMWYxYzA0ODM2YTUzMWFjNzRhMzNhZjFmMDp7InVzZXIiOiIxMjNtZWRoa0BnbWFpbC5jb20iLCJpc0xvZ2luIjp0cnVlfQ==','2020-07-11 07:48:17.590420'),('zzmtcw6nx2rdharfmrfftxifm9w31w2s','N2ViZjlkNmJiM2RlYTdlMWYxYzA0ODM2YTUzMWFjNzRhMzNhZjFmMDp7InVzZXIiOiIxMjNtZWRoa0BnbWFpbC5jb20iLCJpc0xvZ2luIjp0cnVlfQ==','2020-07-26 03:06:40.070658');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-15  9:48:36
