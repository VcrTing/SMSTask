-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: tsms
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Record_everytask`
--

LOCK TABLES `Record_everytask` WRITE;
/*!40000 ALTER TABLE `Record_everytask` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Record_smstask`
--

LOCK TABLES `Record_smstask` WRITE;
/*!40000 ALTER TABLE `Record_smstask` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sms_area`
--

LOCK TABLES `Sms_area` WRITE;
/*!40000 ALTER TABLE `Sms_area` DISABLE KEYS */;
INSERT INTO `Sms_area` VALUES (1,'+ 853','澳門',1,'2020-06-22 08:51:07.717761'),(2,'+ 852','香港',1,'2020-06-22 08:51:07.719105');
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
INSERT INTO `Sms_category` VALUES (1,'疫苗',1,1,1,'2020-06-22 08:51:07.720893'),(2,'手術',2,1,1,'2020-06-22 08:51:07.722029'),(3,'美容',3,1,1,'2020-06-22 08:51:07.723416'),(4,'產品',21,2,1,'2020-06-22 08:51:07.724379'),(5,'服務',22,2,1,'2020-06-22 08:51:07.725344'),(6,'檢查',23,2,1,'2020-06-22 08:51:07.726666');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sms_service`
--

LOCK TABLES `Sms_service` WRITE;
/*!40000 ALTER TABLE `Sms_service` DISABLE KEYS */;
INSERT INTO `Sms_service` VALUES (1,'Hepatitis B Vaccine','0,1,6',1,'2020-01-22 06:21:16.305722'),(2,'Hepatitis A Vaccine','0,6',1,'2020-01-22 06:23:01.135632'),(3,'Twinrix Vaccine','0,1,6',1,'2020-01-22 06:24:30.549779'),(6,'Gardasil Vaccine','0,2,6',1,'2020-03-02 11:02:47.997484'),(7,'ATT Vaccine','0,2,8',1,'2020-03-02 11:04:20.012902'),(8,'influenza vaccine (<8y.o. 1st time)','0,1',1,'2020-03-02 11:05:42.547067'),(9,'Rotateq Vaccine Po','0,2,4',1,'2020-03-02 11:06:37.018880'),(10,'Plan A Vaccine','0,2,4,6',1,'2020-03-02 11:07:27.104761'),(11,'Plan D Vaccine','0,2,4,6',1,'2020-03-02 11:08:06.895081'),(12,'小手術','0',1,'2020-03-02 11:08:41.150879'),(13,'1064 激光美白，去斑，嫩膚','0,2,8',1,'2020-03-02 11:09:32.304994'),(14,'去毛激光','0',1,'2020-03-02 11:11:57.400333'),(15,'HiB Vaccine','0,2,4',1,'2020-03-03 07:50:58.844733');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sms_smstemplate`
--

LOCK TABLES `Sms_smstemplate` WRITE;
/*!40000 ALTER TABLE `Sms_smstemplate` DISABLE KEYS */;
INSERT INTO `Sms_smstemplate` VALUES (1,'176714',1,'親愛的客戶{{named}}，歡迎你蒞臨123醫務中心。剛才已為你接種了第一針乙型肝炎預防針，第二，三針將會在1，5個月後接種。乙型肝炎主要透過母嬰，血液和性接觸三種方法傳染。完成接種疫苗後可預防乙型肝炎所引發的急性肝炎，肝衰竭和肝癌。','温馨提示。親愛的客戶{{named}}，你在123醫務中心接種的乙型肝炎預防針，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，未來二天不需做劇烈運動。期待你的來臨！',1,'2020-01-22 06:21:23.955044',2,1,'176722',1),(2,'176717',1,'親愛的客戶{{named}}，歡迎你蒞臨123醫務中心。剛才已為你接種了第一針甲型肝炎預防針，第二針將會在6個月後接種。甲型肝炎主要是透過受污染的食水，污水清洗的生果和食用海鲜傳染。完成接種疫苗後可預防甲型肝炎所引發的急性肝炎。','温馨提示。親愛的客戶{{named}}，你在123醫務中心接種的甲型肝炎預防針，第二針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，未來二天不需做劇烈運動。期待你的來臨！',1,'2020-01-22 06:23:04.348802',2,2,'176718',1),(3,'176721',1,'親愛的客戶{{named}}，剛才已為你接種了第一針甲乙型混合肝炎預防針，第二，三針將會在1，5個月後接種。乙型肝炎主要透過母嬰，血液和性接觸三種方法傳染。甲型肝炎主要是透過受污染的食水，污水清洗的生果和食用海鲜傳染。完成接種疫苗後可預防甲 / 乙型肝炎所引發的急性肝炎，肝衰竭和肝癌。','温馨提示。親愛的客戶{{named}}，你在123醫務中心接種的甲乙型肝炎預防針，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，未來二天不需做劇烈運動。期待你的來臨！',1,'2020-01-22 06:24:35.331213',2,3,'176716',1),(6,'176397',1,'親愛的客戶{{named}}，歡迎蒞臨123醫務中心。你剛剛接種了第一針宮頸癌9價預防針，接下來的第二/三針將於第2 , 6個月接種。宮頸癌HPV 病毒主要透過性接觸或傷口傳染。感炎後會增加患宮頸癌，肛門癌，皮膚疣等機會。 九價子宮頸癌預防針可預防 HPV 6, 11, 16, 18, 31, 33, 45, 52, 58, 九種常見的 過濾性病毒， 從而減少患上子宮頸癌機會約9成','温馨提示。親愛的客戶{{named}}，你在123醫務中心接種的 Gardasil 宮頸癌預防針，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，沒有懷孕，未來二天不需做劇烈運動。期待你的來臨！',1,'2020-03-02 11:03:05.757846',2,6,'176397',1),(7,'176397',1,'親愛的客戶{{named}}，歡迎蒞臨123醫務中心。你剛剛接種了第一針破傷風針預防針，接下來的第二/三針將於第2 , 8個月接種。破傷風主要經過傷口傳染，特別是穿刺性傷口，會引致急性肌肉抽搐，死亡率可達6成。','温馨提示。親愛的客戶{{named}}，你在123醫務中心接種的破傷風預防針，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，未來二天不需做劇烈運動。期待你的來臨！',1,'2020-03-02 11:04:24.601245',2,7,'176397',1),(8,'176397',1,'親愛的客戶{{named}}，歡迎蒞臨123醫務中心。你的小朋友剛剛接種了第一針季節性流感預防針，接下來的第二針將於第1個月接種。季節性流感主要經過飛沫傳染，患者會出現發燒，肌肉疼痛，傷風等症狀。每年9至1月是接種疫苗的最佳時間。照顧者亦應每年接種流感疫苗以保護小朋友。','温馨提示。親愛的客戶{{named}}，你在123醫務中心接種的季節性流感預防針，第二針已到期，你可以在診所辦工時間內來接種疫苗。請確定你身體狀況良好，沒有發燒，未來二天不需做劇烈運動。期待你的來臨！',1,'2020-03-02 11:05:45.836757',2,8,'176397',1),(9,'176397',1,'親愛的客戶{{named}}，歡迎蒞臨123醫務中心。你的小朋友剛剛接種了第一針輪狀病毒口服預防液，接下來的第二次將於第2,4個月接種。輪狀病毒主要經過不潔食物傳染，或小孩把不潔東西放進口中而感染，患者會出現發燒，嚴重嘔吐和肚瀉，嚴重者需要入院打點滴。','温馨提示。親愛的客戶{{named}}，你在123醫務中心接種的輪狀口服疫苗，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你BB身體狀況良好，沒有發燒。期待你的來臨！',1,'2020-03-02 11:06:40.428931',2,9,'176397',1),(10,'176397',1,'親愛的客戶{{named}}，歡迎蒞臨123醫務中心。你的小朋友剛剛接種了第一針 乙型啫血流感 預防針 和 第一針輪狀病毒口服預防液，接下來的第二次將於第2, 第4，和第16個月接種。 乙型嗜血流感 主要經過 飛沫和接觸 傳染，患者會出現發燒， 流鼻水，咳嗽， 扁桃腺發炎 等 症狀，嚴重者需要入院。輪狀病毒主要經過不潔食物傳染，或小孩把不潔東西放進口中而感染，患者會出現發燒，嚴重嘔吐和肚瀉，嚴重者需要入院打點滴。','温馨提示。親愛的客戶{{named}}，你BB在123醫務中心接種的輪狀口服疫苗 / 乙型啃血流感預防針 (HiB)，第二/三/四針已到期，你可以在診所辦工時間內來接種疫苗。請確定你 BB 身體狀況良好，沒有發燒，飲食正常。期待你的來臨！',1,'2020-03-02 11:07:30.122194',2,10,'176397',1),(11,'176397',1,'親愛的客戶{{named}}，歡迎蒞臨123醫務中心。你的小朋友剛剛接種了第一針 五合一/ 六合一 預防針 和 第一針輪狀病毒口服預防液，接下來的第二次將於第2, 第4，和第16個月接種。 你仍要到母嬰健康院接種13價肺炎預防針 。乙型嗜血流感 主要經過 飛沫和接觸 傳染，患者會出現發燒， 流鼻水，咳嗽， 扁桃腺發炎 等 症狀，嚴重者需要入院。輪狀病毒主要經過不潔食物傳染，或小孩把不潔東西放進口中而感染，患者會出現發燒，嚴重嘔吐和肚瀉，嚴重者需要入院打點滴。','温馨提示。親愛的客戶{{named}}，你BB在123醫務中心接種的輪狀口服疫苗 / 五合一 / 六合一 預防針 ，第二/三/四針已到期，你可以在診所辦工時間內來接種疫苗。請確定你 BB 身體狀況良好，沒有發燒，飲食正常。期待你的來臨！ 提醒你仍要到母嬰健康院為BB 接種13價肺炎預防針',1,'2020-03-02 11:08:09.757926',2,11,'176397',1),(12,'176397',0,'多謝你今天蒞臨123醫務中心， 針對你今天做的小手術有幾個注意事項要提一提你\r\n1. 傷口今天不要濕水\r\n2. 若傷口出現異常痛楚 / 出血 / 麻痺感覺 / 爆線， 請第一時間通知我們。tel: 55448155 (Whatsapp / 微訊) / 37020123. \r\n3. 傷口癒合需要四大元素, 包括適當溫度， 濕度 和透氣, 並且沒有發炎。 選擇適合敷料非常重要， 記得先用藥水清洗傷口，再放上紗布。\r\n4. 大部分 需要縫針的 傷口都是在五至七天可以拆線。 請自行安排時間來拆線。\r\n5. 手術時支付的費用已包含覆診和拆線, 若有什麼問題， 可隨時詢問，費用全免。','多謝你今天蒞臨123醫務中心， 針對你今天做的小手術有幾個注意事項要提一提你\r\n1. 傷口今天不要濕水\r\n2. 若傷口出現異常痛楚 / 出血 / 麻痺感覺 / 爆線， 請第一時間通知我們。tel: 55448155 (Whatsapp / 微訊) / 37020123. \r\n3. 傷口癒合需要四大元素, 包括適當溫度， 濕度 和透氣, 並且沒有發炎。 選擇適合敷料非常重要， 記得先用藥水清洗傷口，再放上紗布。\r\n4. 大部分 需要縫針的 傷口都是在五至七天可以拆線。 請自行安排時間來拆線。\r\n5. 手術時支付的費用已包含覆診和拆線, 若有什麼問題， 可隨時詢問，費用全免。',1,'2020-03-02 11:08:45.037259',1,12,'176397',1),(13,'176397',1,'親愛的客戶{{named}}，多謝你蒞臨123醫務中心，今天用了 808nm 激光去毛， 效果 會隨著 接受療程次數多少而一次比一次好。 建議三星期後再來做， 來之前 敬請預約。\r\n以下有幾點是做完激光後的注意事項\r\n1. 防曬是終生職業，特別是激光後首兩星期，每天出門前記得要搽防曬，SPF 30, PA 3+ 已足夠。\r\n2. 做完激光後首兩星期, 應避免游水, 曬日光浴。\r\n3. 要達至做激光的最佳效果，必須保持充足睡眠， 充足水分， 避免太多壓力。\r\n4. 三次去毛療程約可減少毛髮一半， 大部分人做六至九次已有很明顯的去毛效果。','親愛的客戶{{named}}，多謝你蒞臨123醫務中心，今天用了 808nm 激光去毛， 效果 會隨著 接受療程次數多少而一次比一次好。 建議三星期後再來做， 來之前 敬請預約。\r\n以下有幾點是做完激光後的注意事項\r\n1. 防曬是終生職業，特別是激光後首兩星期，每天出門前記得要搽防曬，SPF 30, PA 3+ 已足夠。\r\n2. 做完激光後首兩星期, 應避免游水, 曬日光浴。\r\n3. 要達至做激光的最佳效果，必須保持充足睡眠， 充足水分， 避免太多壓力。\r\n4. 三次去毛療程約可減少毛髮一半， 大部分人做六至九次已有很明顯的去毛效果。',1,'2020-03-02 11:12:01.569475',3,14,'176397',1),(14,'176397',1,'親愛的客戶{{named}}，多謝你今天蒞臨123醫務中心， 1064 / 532 / 808nm 激光, 有美白 / 去斑 / 收緊毛孔 / 嫩膚 / 去血管絲 等多種功能， 效果 會隨著 接受療程次數多少而一次比一次好。 最快可以四星期來做， 來之前 敬請預約。\r\n以下有幾點是做完激光後的注意事項\r\n1. 防曬是終生職業，特別是激光後首兩星期，每天出門前記得要搽防曬，SPF 30, PA 3+ 已足夠。\r\n2. 正常洗面便可， 盡量避免搽太多化妝品。\r\n3. 做完激光後首兩星期, 應避免游水, 曬日光浴。\r\n4. 建議使用 今天給你的 口服抗敏感藥和搽面的抗敏感藥膏。可舒緩激光後 皮膚痕癢的情況。\r\n5. 要達至做激光的最佳效果，必須保持充足睡眠， 充足水分， 避免太多壓力。 和要有恆心 讓 皮下血管把黑色素帶走， 需時可以是數個月至一兩年。\r\n6. 有一部分人首數次接受激光後，皮膚有機會會更黑 多一點，但不用擔心， 這是正常的現象， 會有其他方法讓它慢慢變白。','溫馨提示，親愛的客戶{{named}}， 繼上次做完激光後已經有四星期以上，你可隨時來做第二次激光。 最佳做激光時間是放假前， 敬請先預約。',1,'2020-03-02 11:19:54.790772',3,13,'176397',1),(15,'176397',1,'親愛的客戶{{named}}，歡迎蒞臨123醫務中心。你的小朋友剛剛接種了第一針 乙型啫血流感 預防針，接下來的第二次將於第2, 第4個月接種。 乙型嗜血流感 主要經過 飛沫和接觸 傳染，患者會出現發燒， 流鼻水，咳嗽， 扁桃腺發炎 等 症狀，嚴重者需要入院。','温馨提示。親愛的客戶{{named}}，你在123醫務中心接種的乙型嗜血流感預防針 (HiB)，第二/三針已到期，你可以在診所辦工時間內來接種疫苗。請確定你BB身體狀況良好，沒有發燒。期待你的來臨！',1,'2020-03-03 07:51:08.181254',2,15,'176397',1),(18,'123',1,'親愛的客戶{{named}}，歡迎你蒞臨123醫務中心。剛才已為你接種了第一針乙型肝炎預防針，第二，三針將會在1，5個月後接種。乙型肝炎主要透過母嬰，血液和性接觸三種方法傳染。完成接種疫苗後可預防乙型肝炎所引發的急性肝炎，肝衰竭和肝癌。','親愛的客戶{{named}}，歡迎你蒞臨123醫務中心。剛才已為你接種了第一針乙型肝炎預防針，第二，三針將會在1，5個月後接種。乙型肝炎主要透過母嬰，血液和性接觸三種方法傳染。完成接種疫苗後可預防乙型肝炎所引發的急性肝炎，肝衰竭和肝癌。',1,'2020-03-06 10:55:09.637359',2,15,'234',2);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_contact`
--

LOCK TABLES `User_contact` WRITE;
/*!40000 ALTER TABLE `User_contact` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_userprofile`
--

LOCK TABLES `User_userprofile` WRITE;
/*!40000 ALTER TABLE `User_userprofile` DISABLE KEYS */;
INSERT INTO `User_userprofile` VALUES (1,NULL,'VcrTing','','',1,'2020-06-22 08:50:08.819247',NULL,NULL,NULL,'vcrting@163.com','male',1,1,'pbkdf2_sha256$150000$DyHR0dTw99Qq$qzSsBDOkrU7hdcBYgeV9f/ILK6wdOPjzlPagDg89V2A=',1,'2020-06-22 08:50:08.819267');
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
  `add_time` datetime(6) NOT NULL,
  `h` varchar(60) DEFAULT NULL,
  `w` varchar(60) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-06-22 08:44:22.556204'),(2,'contenttypes','0002_remove_content_type_name','2020-06-22 08:44:22.587085'),(3,'auth','0001_initial','2020-06-22 08:44:22.627988'),(4,'auth','0002_alter_permission_name_max_length','2020-06-22 08:44:22.720688'),(5,'auth','0003_alter_user_email_max_length','2020-06-22 08:44:22.728958'),(6,'auth','0004_alter_user_username_opts','2020-06-22 08:44:22.737168'),(7,'auth','0005_alter_user_last_login_null','2020-06-22 08:44:22.748212'),(8,'auth','0006_require_contenttypes_0002','2020-06-22 08:44:22.752050'),(9,'auth','0007_alter_validators_add_error_messages','2020-06-22 08:44:22.759547'),(10,'auth','0008_alter_user_username_max_length','2020-06-22 08:44:22.769959'),(11,'auth','0009_alter_user_last_name_max_length','2020-06-22 08:44:22.779112'),(12,'auth','0010_alter_group_name_max_length','2020-06-22 08:44:22.802132'),(13,'auth','0011_update_proxy_permissions','2020-06-22 08:44:22.809836'),(14,'Sms','0001_initial','2020-06-22 08:44:22.874287'),(15,'User','0001_initial','2020-06-22 08:44:22.982148'),(16,'Additional','0001_initial','2020-06-22 08:44:23.138915'),(17,'Additional','0002_auto_20200611_1432','2020-06-22 08:44:23.230072'),(18,'Additional','0003_remove_emailapply_last_time','2020-06-22 08:44:23.323060'),(19,'Record','0001_initial','2020-06-22 08:44:23.403576'),(20,'Record','0002_remove_everytask_send_origin_time','2020-06-22 08:44:23.504645'),(21,'Sms','0002_remove_smstemplate_is_para','2020-06-22 08:44:23.530018'),(22,'Sms','0003_auto_20200619_1453','2020-06-22 08:44:23.558415'),(23,'User','0002_remove_contact_mark','2020-06-22 08:44:23.581252'),(24,'Web','0001_initial','2020-06-22 08:44:23.625636'),(25,'Web','0002_auto_20200612_1959','2020-06-22 08:44:23.659626'),(26,'Web','0003_remove_img_named','2020-06-22 08:44:23.674349'),(27,'Web','0004_auto_20200612_2100','2020-06-22 08:44:23.716486'),(28,'Web','0005_img_out_link','2020-06-22 08:44:23.731173'),(29,'Web','0006_remove_img_out_link','2020-06-22 08:44:23.748838'),(30,'admin','0001_initial','2020-06-22 08:44:23.772328'),(31,'admin','0002_logentry_remove_auto_add','2020-06-22 08:44:23.828232'),(32,'admin','0003_logentry_add_action_flag_choices','2020-06-22 08:44:23.838114'),(33,'sessions','0001_initial','2020-06-22 08:44:23.851638');
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
INSERT INTO `django_session` VALUES ('0h7i54xr1de6p0bvdqll5vm02xf4qzlj','MWYwNDBiMjI5ZTk2OTA0N2NiNDkwY2RmM2ZhOTFhOWUwZTU5MWJmNTp7InVzZXIiOiJ2Y3J0aW5nQDE2My5jb20iLCJpc0xvZ2luIjp0cnVlfQ==','2020-07-06 08:50:44.691635');
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

-- Dump completed on 2020-06-22  8:54:34
