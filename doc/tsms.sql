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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Additional_emailapply`
--

LOCK TABLES `Additional_emailapply` WRITE;
/*!40000 ALTER TABLE `Additional_emailapply` DISABLE KEYS */;
INSERT INTO `Additional_emailapply` VALUES (3,'2020-07-05',4,1,1,0,'2020-09-03 16:00:00.000000',1,'2020-07-05 14:58:37.310690',3,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Additional_emailcollect`
--

LOCK TABLES `Additional_emailcollect` WRITE;
/*!40000 ALTER TABLE `Additional_emailcollect` DISABLE KEYS */;
INSERT INTO `Additional_emailcollect` VALUES (38,1,'{\'id\': \'<20200705150038.1.DA5610C398B34EDF@mg.visocare.com.hk>\', \'message\': \'Queued. Thank you.\'}','2020-07-05 15:00:38.884691',1,1,'2020-07-05 15:00:38.884599',3,2),(39,1,'{\'id\': \'<20200705153146.1.D8BD688B15F84F0A@mg.visocare.com.hk>\', \'message\': \'Queued. Thank you.\'}','2020-07-05 15:31:46.399614',2,1,'2020-07-05 15:31:46.399542',3,2),(40,1,'{\'id\': \'<20200705162852.1.912AF136BCB82FF8@mg.visocare.com.hk>\', \'message\': \'Queued. Thank you.\'}','2020-07-05 16:28:52.654835',3,1,'2020-07-05 16:28:52.654797',3,2),(41,1,'{\'id\': \'<20200705172701.1.681813211981C3DF@mg.visocare.com.hk>\', \'message\': \'Queued. Thank you.\'}','2020-07-05 17:27:01.788327',4,1,'2020-07-05 17:27:01.788242',3,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Additional_emailtemplate`
--

LOCK TABLES `Additional_emailtemplate` WRITE;
/*!40000 ALTER TABLE `Additional_emailtemplate` DISABLE KEYS */;
INSERT INTO `Additional_emailtemplate` VALUES (1,'测试标题','<p>这是测试的邮件的内容～～～<img src=\"http://crm99.svr.up5d.com/media/img/HSIZE_69db16a69fa9479f89a0b2abc3170b00.jpg\" style=\"width: 825.5px;\"></p>',1,'Crm99 - Test（每月）',1,'2020-07-01 07:28:18.542753',4),(2,'她把风衣的扣子扣上，一手拉着小拖箱，一手提着一只米白色布袋，一路小跑到高架桥下。','<p><span style=\"color: rgb(17, 17, 17); font-family: &quot;Microsoft YaHei&quot;, &quot;Microsoft JhengHei&quot;, SimSun; font-size: 25px; font-weight: 600; background-color: rgb(238, 250, 255);\">看见他嘴唇动了几下，倪简松了口气，赶紧打开后车门，把小拖箱提进去，然后把手里的布袋放到后座上，人跟着坐进去。</span><br></p>',2,'倪简昏头涨脑',1,'2020-07-04 09:40:20.119672',5),(3,'你认识路吗？','<p><img src=\"http://crm99.svr.up5d.com/media/img/HSIZE_fe5505ee1e4144c0a66ac36135a2b472.jpg\" style=\"width: 100%;\"><span style=\"color: rgb(17, 17, 17); font-family: &quot;Microsoft YaHei&quot;, &quot;Microsoft JhengHei&quot;, SimSun; font-size: 25px; font-weight: 600; background-color: rgb(238, 250, 255);\">&nbsp; &nbsp; 他刚才转过脸时，后面的车灯恰好打过来，倪简不仅看清了他说的话，也看清了他整张脸。</span><br></p>',0,'经纬公寓',1,'2020-07-04 10:10:49.846943',6);
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
  `time_rule_belong` smallint NOT NULL,
  `numed` smallint DEFAULT NULL,
  `send_finish_time` datetime(6) DEFAULT NULL,
  `schedule_id` varchar(90) NOT NULL,
  `apply_status` tinyint(1) DEFAULT NULL,
  `send_status` tinyint(1) NOT NULL,
  `temp_para` longtext,
  `jsms_response` longtext,
  `status` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `sms_task_id` int DEFAULT NULL,
  `contact_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Record_everytask_sms_task_id_7a04a1a5_fk_Record_smstask_id` (`sms_task_id`),
  KEY `Record_everytask_contact_id_96df4c9f_fk_User_contact_id` (`contact_id`),
  CONSTRAINT `Record_everytask_contact_id_96df4c9f_fk_User_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `User_contact` (`id`),
  CONSTRAINT `Record_everytask_sms_task_id_7a04a1a5_fk_Record_smstask_id` FOREIGN KEY (`sms_task_id`) REFERENCES `Record_smstask` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Record_everytask`
--

LOCK TABLES `Record_everytask` WRITE;
/*!40000 ALTER TABLE `Record_everytask` DISABLE KEYS */;
INSERT INTO `Record_everytask` VALUES (9,0,1,'2020-07-05 13:44:10.697768','SM53a66c998963446197224a149bddcb31',1,1,'{\'named\': \'Eric\', \'numed\': 1}','SM53a66c998963446197224a149bddcb31',0,'2020-07-05 13:42:07.406394',6,4),(10,1,2,'2020-07-05 17:37:00.000000','SM46b5c5963fb4457090a987bcb59c9ea4',1,0,'{\'named\': \'Eric\', \'numed\': 2}','SM46b5c5963fb4457090a987bcb59c9ea4',0,'2020-07-05 13:42:00.000000',6,4),(11,0,1,'2020-07-05 15:31:47.692906','{\'error\': {\'code\': 50021, \'message\': \'template not pass\'}}',1,1,'{\'named\': \'莎莎\', \'numed\': 1}','{\'error\': {\'code\': 50021, \'message\': \'template not pass\'}}',0,'2020-07-05 15:29:45.188255',7,5),(12,0,1,'2020-07-05 17:40:31.378172','SMee24ce38f2ee49478cc18dd310a97f5f',1,1,'{\'named\': \'Eric\', \'numed\': 1}','SMee24ce38f2ee49478cc18dd310a97f5f',0,'2020-07-05 17:38:30.100182',8,4),(13,1,2,'2020-08-04 17:40:31.000000','0',0,0,'無',NULL,1,'2020-07-05 17:38:30.103927',8,4),(14,6,3,'2021-01-01 17:40:31.000000','0',0,0,'無',NULL,1,'2020-07-05 17:38:30.109457',8,4),(15,0,0,NULL,'0',NULL,0,'無',NULL,1,'2020-07-15 11:23:51.439950',9,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Record_smstask`
--

LOCK TABLES `Record_smstask` WRITE;
/*!40000 ALTER TABLE `Record_smstask` DISABLE KEYS */;
INSERT INTO `Record_smstask` VALUES (1,'92779625','Eric',0,NULL,1,'2020-07-01 07:36:21.826838',3,1),(6,'92779625','Eric',0,NULL,1,'2020-07-05 13:42:07.399118',3,20),(7,'13576639986','莎莎',0,NULL,1,'2020-07-05 15:29:45.176697',1,35),(8,'92779625','Eric',0,NULL,1,'2020-07-05 17:38:30.090165',3,10),(9,'92779621','EEEE',0,NULL,1,'2020-07-15 11:23:51.433090',3,30);
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
INSERT INTO `Sms_area` VALUES (1,'+86','大陆',1,'2020-07-01 07:20:22.666729'),(2,'+853','澳門',1,'2020-07-01 07:20:22.671777'),(3,'+852','香港',1,'2020-07-01 07:20:22.674903');
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
INSERT INTO `Sms_category` VALUES (1,'疫苗',1,1,1,'2020-07-01 07:20:22.677458'),(2,'手術',2,1,1,'2020-07-01 07:20:22.679793'),(3,'美容',3,1,1,'2020-07-01 07:20:22.682141'),(4,'產品',21,2,1,'2020-07-01 07:20:22.683496'),(5,'服務',22,2,1,'2020-07-01 07:20:22.684983'),(6,'檢查',23,2,1,'2020-07-01 07:20:22.686680');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_contact`
--

LOCK TABLES `User_contact` WRITE;
/*!40000 ALTER TABLE `User_contact` DISABLE KEYS */;
INSERT INTO `User_contact` VALUES (2,'Eric',NULL,NULL,0,'92779625','',0,0,'2020-07-01 07:36:13.225845',3),(3,'陆繁',NULL,NULL,1,'','vcrting@163.com',0,1,'2020-07-04 09:10:11.188410',NULL),(4,'Eric',NULL,NULL,0,'92779625',NULL,0,1,'2020-07-05 13:42:03.015834',3),(5,'莎莎',NULL,NULL,0,'13576639986',NULL,0,1,'2020-07-05 15:29:41.749148',1),(6,'EEEE',NULL,'1995-12-19',0,'92779621','',0,1,'2020-07-15 11:18:15.632497',3);
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
INSERT INTO `User_userprofile` VALUES (1,'2020-07-01 07:28:40.009831','VcrTing','','',1,'2020-07-01 07:21:00.000000','沙','2020-07-01','13576639986','vcrting@163.com','male',1,1,'pbkdf2_sha256$150000$hGJlFVngLu7g$3UCZQzjtJFNeZYmJ5OehZk81Eq1koWgtG+n/Z+DETUw=',1,'2020-07-01 07:21:39.504260');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Web_systemmsg`
--

LOCK TABLES `Web_systemmsg` WRITE;
/*!40000 ALTER TABLE `Web_systemmsg` DISABLE KEYS */;
INSERT INTO `Web_systemmsg` VALUES (1,'123medhk 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, \n',2,2,1,1,'2020-07-09 10:56:31.394834'),(2,' 平台数据备份状态反馈。','磁盘剩余容量为：24827 MB，不足以支持媒体库进行备份，请解决。<br/>磁盘剩余容量：24827 MB，媒体库容量：24827 MB。',2,2,1,1,'2020-07-10 08:03:54.953730'),(3,' 平台数据备份状态反馈。','磁盘剩余容量为：24826 MB，不足以支持媒体库进行备份，请解决。<br/>磁盘剩余容量：24826 MB，媒体库容量：24826 MB。',2,2,1,1,'2020-07-10 08:19:30.429178'),(4,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24765 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 02:58:36.485598'),(5,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24754 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 03:06:40.160074'),(6,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24754 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 03:08:35.337901'),(7,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24754 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 03:16:40.278358'),(8,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24754 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 03:18:35.395020'),(9,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24754 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 03:26:40.463142'),(10,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 03:28:36.035003'),(11,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 03:36:40.358433'),(12,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 03:38:35.491235'),(13,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 03:46:40.539385'),(14,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 03:48:35.594478'),(15,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24754 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 04:06:40.794804'),(16,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24754 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 04:10:16.748758'),(17,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24754 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 04:16:40.242740'),(18,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24754 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 04:20:17.022905'),(19,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 04:26:40.280452'),(20,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 04:30:16.735204'),(21,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 04:36:40.352680'),(22,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 04:40:16.726681'),(23,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 04:46:40.548099'),(24,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 04:50:16.982815'),(25,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 04:56:40.175305'),(26,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:00:16.705858'),(27,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:06:40.361906'),(28,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24753 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:10:16.845545'),(29,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24752 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:16:40.249824'),(30,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24752 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:20:16.652715'),(31,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24752 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:26:40.401265'),(32,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24752 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:30:17.107157'),(33,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24752 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:36:40.451019'),(34,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24752 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:40:17.074574'),(35,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24752 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:46:40.516753'),(36,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24752 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:50:17.038364'),(37,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24752 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 05:56:40.516022'),(38,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24752 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 06:00:16.972370'),(39,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24751 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 07:20:16.953258'),(40,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24751 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 07:26:40.108187'),(41,' 平台数据备份状态反馈。','[eye]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24751 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 07:30:16.702214'),(42,' 平台数据备份状态反馈。','[123medhk]Mysql 备份状态： True, \n媒体库 备份状态： True, <br/><br/>磁盘剩余容量：24745 MB，媒体库容量：11 MB。',2,2,1,1,'2020-07-15 17:07:59.258804');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Admin');
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
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,46),(46,1,48),(47,1,49),(48,1,50),(49,1,51),(50,1,52),(51,1,56),(52,1,57),(53,1,58),(54,1,59),(55,1,60),(56,1,61),(57,1,62),(58,1,63),(59,1,64),(60,1,65),(61,1,66),(62,1,67),(63,1,68),(64,1,69),(65,1,70),(66,1,71),(67,1,72),(68,1,73),(69,1,74),(70,1,75),(71,1,76),(72,1,77),(73,1,78),(74,1,79),(75,1,80),(76,1,81),(77,1,82),(78,1,83),(79,1,84),(80,1,85),(81,1,86),(82,1,87),(83,1,88);
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
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add django job',6,'add_djangojob'),(22,'Can change django job',6,'change_djangojob'),(23,'Can delete django job',6,'delete_djangojob'),(24,'Can view django job',6,'view_djangojob'),(25,'Can add django job execution',7,'add_djangojobexecution'),(26,'Can change django job execution',7,'change_djangojobexecution'),(27,'Can delete django job execution',7,'delete_djangojobexecution'),(28,'Can view django job execution',7,'view_djangojobexecution'),(29,'Can add 地域与电话号码前缀',8,'add_area'),(30,'Can change 地域与电话号码前缀',8,'change_area'),(31,'Can delete 地域与电话号码前缀',8,'delete_area'),(32,'Can view 地域与电话号码前缀',8,'view_area'),(33,'Can add 服务分类',9,'add_category'),(34,'Can change 服务分类',9,'change_category'),(35,'Can delete 服务分类',9,'delete_category'),(36,'Can view 服务分类',9,'view_category'),(37,'Can add 服务项目',10,'add_service'),(38,'Can change 服务项目',10,'change_service'),(39,'Can delete 服务项目',10,'delete_service'),(40,'Can view 服务项目',10,'view_service'),(41,'Can add 短信模版',11,'add_smstemplate'),(42,'Can change 短信模版',11,'change_smstemplate'),(43,'Can delete 短信模版',11,'delete_smstemplate'),(44,'Can view 短信模版',11,'view_smstemplate'),(45,'Can add 图片',12,'add_img'),(46,'Can change 图片',12,'change_img'),(47,'Can delete 图片',12,'delete_img'),(48,'Can view 图片',12,'view_img'),(49,'Can add SMS配置',13,'add_smsconf'),(50,'Can change SMS配置',13,'change_smsconf'),(51,'Can delete SMS配置',13,'delete_smsconf'),(52,'Can view SMS配置',13,'view_smsconf'),(53,'Can add 系统消息',14,'add_systemmsg'),(54,'Can change 系统消息',14,'change_systemmsg'),(55,'Can delete 系统消息',14,'delete_systemmsg'),(56,'Can view 系统消息',14,'view_systemmsg'),(57,'Can add 员工',15,'add_userprofile'),(58,'Can change 员工',15,'change_userprofile'),(59,'Can delete 员工',15,'delete_userprofile'),(60,'Can view 员工',15,'view_userprofile'),(61,'Can add 联系人',16,'add_contact'),(62,'Can change 联系人',16,'change_contact'),(63,'Can delete 联系人',16,'delete_contact'),(64,'Can view 联系人',16,'view_contact'),(65,'Can add 极光任務队列',17,'add_everytask'),(66,'Can change 极光任務队列',17,'change_everytask'),(67,'Can delete 极光任務队列',17,'delete_everytask'),(68,'Can view 极光任務队列',17,'view_everytask'),(69,'Can add 短信发送完成记录',18,'add_smstaskrecord'),(70,'Can change 短信发送完成记录',18,'change_smstaskrecord'),(71,'Can delete 短信发送完成记录',18,'delete_smstaskrecord'),(72,'Can view 短信发送完成记录',18,'view_smstaskrecord'),(73,'Can add 任務申请',19,'add_smstask'),(74,'Can change 任務申请',19,'change_smstask'),(75,'Can delete 任務申请',19,'delete_smstask'),(76,'Can view 任務申请',19,'view_smstask'),(77,'Can add 邮件任务申请列表',20,'add_emailapply'),(78,'Can change 邮件任务申请列表',20,'change_emailapply'),(79,'Can delete 邮件任务申请列表',20,'delete_emailapply'),(80,'Can view 邮件任务申请列表',20,'view_emailapply'),(81,'Can add 邮件模版',21,'add_emailtemplate'),(82,'Can change 邮件模版',21,'change_emailtemplate'),(83,'Can delete 邮件模版',21,'delete_emailtemplate'),(84,'Can view 邮件模版',21,'view_emailtemplate'),(85,'Can add 单期邮件记录',22,'add_emailcollect'),(86,'Can change 单期邮件记录',22,'change_emailcollect'),(87,'Can delete 单期邮件记录',22,'delete_emailcollect'),(88,'Can view 单期邮件记录',22,'view_emailcollect');
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-07-01 07:29:45.858246','1','vcrting@163.com',2,'[{\"changed\": {\"fields\": [\"nickName\", \"bith\", \"phone\"]}}]',15,1),(2,'2020-07-01 07:32:59.342908','1','Admin',1,'[{\"added\": {}}]',3,1),(3,'2020-07-01 07:35:06.020531','1','测试（0，1，3）',1,'[{\"added\": {}}]',10,1),(4,'2020-07-01 07:35:16.573973','1','ID: 181407, 模版: 先手模版，客人名为 {{named}}。...',1,'[{\"added\": {}}]',11,1),(5,'2020-07-01 07:39:02.083120','1','所属时间规则：1 schedule_id：0',2,'[{\"changed\": {\"fields\": [\"send_finish_time\"]}}]',17,1),(6,'2020-07-02 14:16:07.182341','1','所属时间规则：1 schedule_id：0',2,'[{\"changed\": {\"fields\": [\"send_finish_time\"]}}]',17,1),(7,'2020-07-04 09:04:17.972999','1','所属时间规则：1 schedule_id：0',2,'[{\"changed\": {\"fields\": [\"contact_key\"]}}]',17,1),(8,'2020-07-04 09:04:47.631556','1','所属时间规则：1 schedule_id：0',2,'[{\"changed\": {\"fields\": [\"contact_key\"]}}]',17,1),(9,'2020-07-04 09:05:13.178891','1','Eric',3,'',16,1),(10,'2020-07-05 13:38:36.270553','8','所属时间规则：1 schedule_id：0',3,'',17,1),(11,'2020-07-05 13:38:36.273004','7','所属时间规则：0 schedule_id：0',3,'',17,1),(12,'2020-07-05 13:38:36.275088','6','所属时间规则：1 schedule_id：0',3,'',17,1),(13,'2020-07-05 13:38:36.278340','5','所属时间规则：0 schedule_id：0',3,'',17,1),(14,'2020-07-05 13:38:36.280429','4','所属时间规则：1 schedule_id：0',3,'',17,1),(15,'2020-07-05 13:38:36.282507','3','所属时间规则：0 schedule_id：0',3,'',17,1),(16,'2020-07-05 13:38:36.284701','2','所属时间规则：0 schedule_id：0',3,'',17,1),(17,'2020-07-05 13:39:25.369956','1','所属时间规则：1 schedule_id：0',2,'[{\"changed\": {\"fields\": [\"contact\"]}}]',17,1),(18,'2020-07-05 13:39:40.271486','5','接收者：Eric，电话：92779625',3,'',19,1),(19,'2020-07-05 13:39:40.273680','4','接收者：Eric，电话：92779625',3,'',19,1),(20,'2020-07-05 13:39:40.277539','3','接收者：Eric，电话：92779625',3,'',19,1),(21,'2020-07-05 13:39:40.279801','2','接收者：Eric，电话：92779625',3,'',19,1),(22,'2020-07-05 13:39:54.901580','1','所属时间规则：1 schedule_id：0',3,'',17,1),(23,'2020-07-05 13:41:17.191354','3','图片: img/HSIZE_fe5505ee1e4144c0a66ac36135a2b472.jpg',3,'',12,1),(24,'2020-07-05 13:41:17.194170','2','图片: img/HSIZE_69db16a69fa9479f89a0b2abc3170b00.jpg',3,'',12,1),(25,'2020-07-05 13:47:24.253847','10','所属时间规则：1 schedule_id：0',2,'[{\"changed\": {\"fields\": [\"send_finish_time\"]}}]',17,1),(26,'2020-07-05 14:31:09.145070','2','邮件任务申请列表: 2020-07-04...',3,'',20,1),(27,'2020-07-05 14:31:09.147193','1','邮件任务申请列表: 2020-07-04...',3,'',20,1),(28,'2020-07-05 15:03:30.495341','3','邮件任务申请列表: 2020-07-05...',2,'[{\"changed\": {\"fields\": [\"next_time\"]}}]',20,1),(29,'2020-07-05 16:27:15.791725','10','所属时间规则：1 schedule_id：SM8a788635fb4b4170a3c50e4e3693e86d',2,'[{\"changed\": {\"fields\": [\"send_finish_time\", \"send_status\", \"apply_status\"]}}]',17,1),(30,'2020-07-05 16:27:41.078670','3','邮件任务申请列表: 2020-07-05...',2,'[{\"changed\": {\"fields\": [\"next_time\"]}}]',20,1),(31,'2020-07-05 17:22:42.670502','3','邮件任务申请列表: 2020-07-05...',2,'[{\"changed\": {\"fields\": [\"next_time\"]}}]',20,1),(32,'2020-07-05 17:34:10.960886','10','所属时间规则：1 schedule_id：SM31e76c73d9324519974e97618a9323d8',2,'[{\"changed\": {\"fields\": [\"send_finish_time\", \"send_status\", \"apply_status\"]}}]',17,1),(33,'2020-07-06 08:24:01.777655','10','所属时间规则：1 schedule_id：SM46b5c5963fb4457090a987bcb59c9ea4',2,'[{\"changed\": {\"fields\": [\"send_finish_time\", \"send_status\", \"status\"]}}]',17,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_apscheduler_djangojob`
--

DROP TABLE IF EXISTS `django_apscheduler_djangojob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_apscheduler_djangojob` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `next_run_time` datetime(6) DEFAULT NULL,
  `job_state` longblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `django_apscheduler_djangojob_next_run_time_2f022619` (`next_run_time`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_apscheduler_djangojob`
--

LOCK TABLES `django_apscheduler_djangojob` WRITE;
/*!40000 ALTER TABLE `django_apscheduler_djangojob` DISABLE KEYS */;
INSERT INTO `django_apscheduler_djangojob` VALUES (1,'123medhk','2020-07-16 02:37:01.333691',_binary '��\�\0\0\0\0\0\0}�(�version�K�id��123medhk��func��Appis.Web.views:fun��trigger��apscheduler.triggers.interval��IntervalTrigger���)��}�(hK�timezone��pytz��_p���(�\rAsia/Shanghai�M\�qK\0�LMT�t�R��\nstart_date��datetime��datetime���C\n\�{�h(hM�pK\0�CST�t�R���R��end_date�N�interval�h�	timedelta���K\0MXK\0��R��jitter�Nub�executor��default��args�)�kwargs�}��name��fun��misfire_grace_time�K�coalesce���\rmax_instances�K�\rnext_run_time�hC\n\�\n%{�h��R�u.'),(2,'eye','2020-07-16 02:39:18.948245',_binary '��\�\0\0\0\0\0\0}�(�version�K�id��eye��func��Appis.Web.views:fun��trigger��apscheduler.triggers.interval��IntervalTrigger���)��}�(hK�timezone��pytz��_p���(�\rAsia/Shanghai�M\�qK\0�LMT�t�R��\nstart_date��datetime��datetime���C\n\�	x�h(hM�pK\0�CST�t�R���R��end_date�N�interval�h�	timedelta���K\0MXK\0��R��jitter�Nub�executor��default��args�)�kwargs�}��name��fun��misfire_grace_time�K�coalesce���\rmax_instances�K�\rnext_run_time�hC\n\�\n\'x�h��R�u.');
/*!40000 ALTER TABLE `django_apscheduler_djangojob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_apscheduler_djangojobexecution`
--

DROP TABLE IF EXISTS `django_apscheduler_djangojobexecution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_apscheduler_djangojobexecution` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `run_time` datetime(6) NOT NULL,
  `duration` decimal(15,2) DEFAULT NULL,
  `started` decimal(15,2) DEFAULT NULL,
  `finished` decimal(15,2) DEFAULT NULL,
  `exception` varchar(1000) DEFAULT NULL,
  `traceback` longtext,
  `job_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_apscheduler_d_job_id_daf5090a_fk_django_ap` (`job_id`),
  KEY `django_apscheduler_djangojobexecution_run_time_16edd96b` (`run_time`),
  CONSTRAINT `django_apscheduler_d_job_id_daf5090a_fk_django_ap` FOREIGN KEY (`job_id`) REFERENCES `django_apscheduler_djangojob` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_apscheduler_djangojobexecution`
--

LOCK TABLES `django_apscheduler_djangojobexecution` WRITE;
/*!40000 ALTER TABLE `django_apscheduler_djangojobexecution` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_apscheduler_djangojobexecution` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (20,'Additional','emailapply'),(22,'Additional','emailcollect'),(21,'Additional','emailtemplate'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(6,'django_apscheduler','djangojob'),(7,'django_apscheduler','djangojobexecution'),(17,'Record','everytask'),(19,'Record','smstask'),(18,'Record','smstaskrecord'),(5,'sessions','session'),(8,'Sms','area'),(9,'Sms','category'),(10,'Sms','service'),(11,'Sms','smstemplate'),(16,'User','contact'),(15,'User','userprofile'),(12,'Web','img'),(13,'Web','smsconf'),(14,'Web','systemmsg');
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-07-01 07:14:29.665356'),(2,'contenttypes','0002_remove_content_type_name','2020-07-01 07:14:29.712429'),(3,'auth','0001_initial','2020-07-01 07:14:29.796194'),(4,'auth','0002_alter_permission_name_max_length','2020-07-01 07:14:29.919059'),(5,'auth','0003_alter_user_email_max_length','2020-07-01 07:14:29.926414'),(6,'auth','0004_alter_user_username_opts','2020-07-01 07:14:29.934065'),(7,'auth','0005_alter_user_last_login_null','2020-07-01 07:14:29.941075'),(8,'auth','0006_require_contenttypes_0002','2020-07-01 07:14:29.944054'),(9,'auth','0007_alter_validators_add_error_messages','2020-07-01 07:14:29.951810'),(10,'auth','0008_alter_user_username_max_length','2020-07-01 07:14:29.959908'),(11,'auth','0009_alter_user_last_name_max_length','2020-07-01 07:14:29.967600'),(12,'auth','0010_alter_group_name_max_length','2020-07-01 07:14:29.991937'),(13,'auth','0011_update_proxy_permissions','2020-07-01 07:14:29.999793'),(14,'Sms','0001_initial','2020-07-01 07:14:30.070152'),(15,'User','0001_initial','2020-07-01 07:14:30.206804'),(16,'Additional','0001_initial','2020-07-01 07:14:30.405335'),(17,'Additional','0002_auto_20200630_1844','2020-07-01 07:14:30.510338'),(18,'Record','0001_initial','2020-07-01 07:14:30.645380'),(19,'Web','0001_initial','2020-07-01 07:14:30.784222'),(20,'admin','0001_initial','2020-07-01 07:14:30.810146'),(21,'admin','0002_logentry_remove_auto_add','2020-07-01 07:14:30.879386'),(22,'admin','0003_logentry_add_action_flag_choices','2020-07-01 07:14:30.894541'),(23,'django_apscheduler','0001_initial','2020-07-01 07:14:30.945078'),(24,'django_apscheduler','0002_auto_20180412_0758','2020-07-01 07:14:31.018721'),(25,'sessions','0001_initial','2020-07-01 07:14:31.034037'),(26,'Record','0002_auto_20200705_1722','2020-07-05 13:37:33.833155'),(27,'Web','0002_auto_20200705_1722','2020-07-05 13:37:33.885560');
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
INSERT INTO `django_session` VALUES ('80ex9e62hbgwehezxbinx2igvo5s2ncb','MWRlMWIyYThmODY1OWYxN2U3M2NlY2QyYzI5MWQzZDU5NzU4ZGFkNDp7InVzZXIiOiJ2Y3J0aW5nQDE2My5jb20iLCJpc0xvZ2luIjp0cnVlLCJjb21wYW55IjoiMTIzbWVkaGsifQ==','2020-07-19 17:38:04.121506'),('avpa8s8m5e3971ujdpbikok93s924517','OGJlNTIyZGRkOThmNjIwYTFlMzU0ZDMzMTZhNjliZGM5MzA4M2Q0ZDp7ImlzTG9naW4iOmZhbHNlLCJ1c2VyIjpudWxsfQ==','2020-07-18 15:55:28.569165'),('en6uwo5efrssv5y0pr1ayl512b8153g6','MGVlYTkyOTlhZmFhYTgyZTA1N2U2YWRlNDdkZWM5NThjMmMzMDZiNzp7InVzZXIiOiJ2Y3J0aW5nQDE2My5jb20iLCJpc0xvZ2luIjp0cnVlLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZmIyYzU5YTEwNDQ0MjAyMDQwYzg5NGUzMDI1MmRlN2JhOTE4YmRjOCIsImNvbXBhbnkiOiIxMjNtZWRoayIsImxheW91dCI6eyJzbXMiOjEsImVtYWlsIjowfX0=','2020-07-29 11:07:54.733773'),('ih2zqv9konoem3vgr8zg2j4x5dv9i115','ZTY3OGQ2OWE1MmM2NDMxNDQ5NzQxMGNiZmQ2MzJkNzE2MDE5MmExZjp7InVzZXIiOiJ2Y3J0aW5nQDE2My5jb20iLCJpc0xvZ2luIjp0cnVlLCJjb21wYW55IjoiMTIzbWVkaGsiLCJsYXlvdXQiOnsic21zIjoxLCJlbWFpbCI6MH19','2020-07-30 02:30:24.165402'),('qianrtx6y3ukb1crbz12383o8ae5jkzn','MWRlMWIyYThmODY1OWYxN2U3M2NlY2QyYzI5MWQzZDU5NzU4ZGFkNDp7InVzZXIiOiJ2Y3J0aW5nQDE2My5jb20iLCJpc0xvZ2luIjp0cnVlLCJjb21wYW55IjoiMTIzbWVkaGsifQ==','2020-07-19 10:44:58.941118');
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

-- Dump completed on 2020-07-16  2:32:59
