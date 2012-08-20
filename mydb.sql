-- MySQL dump 10.13  Distrib 5.5.24, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.24-0ubuntu0.12.04.1

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
-- Table structure for table `Post`
--

DROP TABLE IF EXISTS `Post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Post` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Content` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `Thread` int(11) NOT NULL,
  `OrderNum` int(11) NOT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  `CreatedDate` datetime NOT NULL,
  `LastUpdate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Post_2_idx` (`Thread`),
  KEY `fk_Post_1_idx` (`CreatedBy`),
  CONSTRAINT `fk_Post_1` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_2` FOREIGN KEY (`Thread`) REFERENCES `Thread` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Post`
--

LOCK TABLES `Post` WRITE;
/*!40000 ALTER TABLE `Post` DISABLE KEYS */;
INSERT INTO `Post` VALUES (113,'',29,1,5,'2012-08-20 01:53:17','2012-08-20 01:53:17'),(114,'Oh my god! I can&#39;t believe! Is it true???',30,1,24,'2012-08-20 01:55:11','2012-08-20 18:25:42'),(115,'He bullied me by his artifacts :((',31,1,24,'2012-08-20 01:57:51','2012-08-20 18:25:20'),(116,'Yes, you won &quot;the best destructive singer&quot; =))',30,2,22,'2012-08-20 02:00:01',NULL),(117,'My favourite song :x',32,1,22,'2012-08-20 02:01:40','2012-08-20 02:01:40'),(118,'Is it true? ;)',33,1,22,'2012-08-20 02:03:09','2012-08-20 02:03:09'),(119,'Hey, I was borned before you &gt;:p',33,2,25,'2012-08-20 02:04:47',NULL),(121,'So riddiculous! In the name of &#x30EB;&#x30EB;&#x30FC;&#x30B7;&#x30E5;&#x30FB;&#x30E9;&#x30F3;&#x30DA;&#x30EB;&#x30FC;&#x30B8;, I commands &quot;the world belongs to me!&quot;',32,2,33,'2012-08-20 02:20:16',NULL),(122,'Why? Would you mind telling me why???',34,1,23,'2012-08-20 02:22:15',NULL),(123,'Because you are too stupid to make it work B-)',34,2,27,'2012-08-20 02:24:01',NULL),(124,'God! You are so unfair!',35,1,27,'2012-08-20 02:25:23',NULL),(125,'Wua ha ha ha ha &gt;:]]',31,2,34,'2012-08-20 02:29:29',NULL),(126,'Come on, everybody :D',36,1,34,'2012-08-20 02:30:26',NULL),(127,'Yes, it&#39;s true :D',37,1,34,'2012-08-20 02:31:05',NULL),(128,'Indeed, &#39;a trip to grave yard&#39; is more correctly.',36,2,28,'2012-08-20 02:32:27',NULL),(129,'Who will be my boyfriend? :&quot;&gt;',38,1,28,'2012-08-20 02:33:48',NULL),(130,'Oh I know ~ You are dreaming, arn&#39;t you? ;;)',30,3,28,'2012-08-20 02:34:43',NULL),(131,'Let&#39;s show! He ha ha ;))\r\n[IMG]http://buzzievjp1311.files.wordpress.com/2011/02/front_doraemon.gif[/IMG]',39,1,28,'2012-08-20 02:37:04','2012-08-20 13:51:22'),(132,'My turn: (quite small :P)\r\n[IMG]http://upload.wikimedia.org/wikipedia/vi/1/14/Nobita001.jpg[/IMG]',39,2,23,'2012-08-20 02:41:27',NULL),(133,'Pic #1: [IMG]http://www.ootte.com/i/Doraemon/gian.gif[/IMG] Pic #2: [IMG]http://t0.gstatic.com/images?q=tbn:ANd9GcQFh-yzD8FzEHtBw-Ltfo9n8pLIi5d-7fIphJHqo7msovTztWqqiOUT0VKx9w[/IMG] \r\nPic #3: [IMG]http://www.garbagenews.com/img/gn-20080130-02.jpg[/IMG]\r\nHe he he, how is it? :D',39,3,24,'2012-08-20 02:44:52','2012-08-20 02:45:13'),(134,'Haizzz, I&#39;m so bored because of my handsome face...\r\n[IMG]http://nl9.upanh.com/b4.s26.d2/83b3a67b10447efc4cf8609742b48707_43671309.normal49f8f5c2e08b7.jpg[/IMG]',39,4,27,'2012-08-20 02:47:37',NULL),(135,'@&#x30B9;&#x30CD;&#x592B;: that&#39;s not you! \r\n@&#x30C9;&#x30E9;&#x30DF;: You uploaded wrong pic, that&#39;s your brother =))\r\n@&#x306E;&#x3073;&#x592A;: Te he he he, sweet memories, huh? ;)\r\n[IMG]http://0-media-cdn.foolz.us/ffuuka/board/a/image/1334/32/1334325972380.jpg[/IMG]',39,5,27,'2012-08-20 02:51:17',NULL),(136,'Email: hatsune_miku@gmail.com\r\nFacebook: https://facebook.com/hatsune.miku\r\n[IMG]http://www.glogster.com/media/5/27/59/1/27590167.jpg[/IMG]\r\n:D',39,6,22,'2012-08-20 02:56:31','2012-08-20 02:57:22'),(137,'Is updating...',40,1,22,'2012-08-20 02:58:18',NULL),(138,'Download at: http://google.com/',41,1,33,'2012-08-20 02:59:09',NULL),(139,'Because you always bullies me, I just defense! ',31,3,23,'2012-08-21 14:00:34',NULL),(140,'You have a prolem with your eyes. Please have get a meeting with doctor.',35,2,23,'2012-08-21 14:01:41',NULL),(147,'&#x306F;&#x3058;&#x3081;&#x307E;&#x3057;&#x3066;&#x3002;&#x30EA;&#x30F3;&#x3067;&#x3059;&#x3002;&#x3069;&#x305E;&#x3088;&#x308D;&#x3057;&#x304F;&#x304A;&#x306D;&#x304C;&#x3044;&#x3057;&#x307E;&#x3059;&#x3002;&#xFF3E;&#xFF3E;',48,1,35,'2012-08-21 15:46:45',NULL),(148,'Hi &#x30EA;&#x30F3;&#x3055;&#x3093;, My name is &#x6E90; &#x9759;&#x9999;. Nice to meet you ^^ It&#39;s better if you post some of your pics. Here are my pics:\r\nPortrait 1: [IMG]http://1.bp.blogspot.com/_CZXNrcnE4sg/ShJYIusKLFI/AAAAAAAAAb4/OPWixbcTRrc/s200/shizuka.jpg[/IMG] and portrait 2: [IMG]http://images.wikia.com/doraemon/pt/images/d/dc/Shizuka_actual.jpg[/IMG]',48,2,25,'2012-08-21 15:56:54',NULL),(149,'&#x30EA;&#x30F3;&#x3055;&#x3093;, Do you know how to put HTML tags into your comment? I want to write some special style comments.\r\nExample: &lt;b&gt;Need to bold&lt;/b&gt;  &lt;a href=&quot;https://www.facebook.com/trungdv89&quot;&gt;My Idol&lt;/a&gt;',48,3,23,'2012-08-21 16:04:36',NULL),(150,'What the thread... =.=',40,2,NULL,'2012-08-20 18:33:30',NULL);
/*!40000 ALTER TABLE `Post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Thread`
--

DROP TABLE IF EXISTS `Thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Thread` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Topic` int(11) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `LastestPost` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Thread_1_idx` (`Topic`),
  KEY `fk_Thread_2_idx` (`CreatedBy`),
  KEY `fk_Thread_3_idx` (`LastestPost`),
  CONSTRAINT `fk_Thread_1` FOREIGN KEY (`Topic`) REFERENCES `Topic` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Thread_2` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Thread_3` FOREIGN KEY (`LastestPost`) REFERENCES `Post` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Thread`
--

LOCK TABLES `Thread` WRITE;
/*!40000 ALTER TABLE `Thread` DISABLE KEYS */;
INSERT INTO `Thread` VALUES (29,'Is any one want to have a cup of tea?',2,'2012-08-20 01:53:17',5,113),(30,'I have won national singing contest!!!',2,'2012-08-20 01:55:11',24,130),(31,'&#x306E;&#x3073;&#x592A; bullied me! :((',2,'2012-08-20 01:57:51',24,139),(32,'World is mine!',2,'2012-08-20 02:01:40',22,121),(33,'&#x6E90; &#x9759;&#x9999; mimic my hair style ;))',2,'2012-08-20 02:03:09',22,119),(34,'Why HTML tag is not working? &lt;h1&gt;test&lt;/h1&gt;',2,'2012-08-20 02:22:15',23,123),(35,'Why am I so handsome? Why????',2,'2012-08-20 02:25:23',27,140),(36,'A trip to dark hole! Who will take part in?',2,'2012-08-20 02:30:26',34,128),(37,'I am a cute cat :&quot;&gt;',2,'2012-08-20 02:31:05',34,127),(38,'I wanna a boy friend :((',2,'2012-08-20 02:33:48',28,129),(39,'Member&#39;s Pictures \\(^o^)/',4,'2012-08-20 02:37:04',28,136),(40,'New songs',5,'2012-08-20 02:58:18',22,150),(41,'How to conquer the world',3,'2012-08-20 02:59:09',33,138),(48,'I am little cutie evil&#39;s daughter :&quot;&gt;',2,'2012-08-21 15:46:45',35,149);
/*!40000 ALTER TABLE `Thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Topic`
--

DROP TABLE IF EXISTS `Topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Topic` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Description` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `LastestThread` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Topic_1_idx` (`CreatedBy`),
  KEY `fk_Topic_2_idx` (`LastestThread`),
  CONSTRAINT `fk_Topic_1` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Topic_2` FOREIGN KEY (`LastestThread`) REFERENCES `Thread` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Topic`
--

LOCK TABLES `Topic` WRITE;
/*!40000 ALTER TABLE `Topic` DISABLE KEYS */;
INSERT INTO `Topic` VALUES (2,'Chat chit','Let&#39;s connect to each other! Say what you think, do what you want! ','2012-08-13 15:34:16',5,48),(3,'Ebooks','A book collections of all forum&#39;s members. All books are able to download.','2012-08-13 16:04:40',5,41),(4,'Pictures','Are you beautiful? Share your pictures,so everyone can see your beauty! Are you not beautiful? It&#39;s ok,share your pictures too, so everyone are able to give you advices to make you more beautiful.','2012-08-13 16:04:57',5,39),(5,'Work','Burn! Shine! Time to work! \\(&gt;o&lt;)/','2012-08-20 00:02:45',5,40);
/*!40000 ALTER TABLE `Topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `Password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `LastVisited` datetime DEFAULT NULL,
  `IsAdmin` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`),
  UNIQUE KEY `Email_UNIQUE` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (5,'Admin','trungdv89@gmail.com','2012-08-12 10:09:59','5hX58.u3tBnkM',NULL,''),(22,'&#x521D;&#x97F3;&#x30DF;&#x30AF;','hatsune_miku@gmail.com','2012-08-20 01:22:41','lzSGgCysPTnrw',NULL,'\0'),(23,'&#x91CE;&#x6BD4; &#x306E;&#x3073;&#x592A;','nobita@yahoo.com','2012-08-20 01:25:11','DZgmx/9/psbGY',NULL,'\0'),(24,'&#x9AA8;&#x5DDD; &#x30B9;&#x30CD;&#x592B;','takeshi@gmail.com','2012-08-20 01:26:42','RzDFn6.yFnbOo',NULL,'\0'),(25,'&#x6E90; &#x9759;&#x9999;','shizuka@gmail.com','2012-08-20 01:27:43','zPK05XgVLKf.E',NULL,'\0'),(27,'&#x9AA8;&#x5DDD;&#x30B9;&#x30CD;&#x592B;','suneo@yahoo.com','2012-08-20 01:29:57','ccH/MsO9apEK.',NULL,'\0'),(28,'&#x30C9;&#x30E9;&#x30DF;','dorami@gmail.com','2012-08-20 01:47:27','WcCqvQw0.VMc2',NULL,'\0'),(33,'&#x30EB;&#x30EB;&#x30FC;&#x30B7;&#x30E5;&#x30FB;&#x30E9;&#x30F3;&#x30DA;&#x30EB;&#x30FC;&#x30B8;','lulu@gmail.com','2012-08-20 02:18:16','OANWkdxndTVc.',NULL,'\0'),(34,'&#x30C9;&#x30E9;&#x3048;&#x3082;&#x3093;','doraemon@gmail.com','2012-08-20 02:28:51','wc0PtoXsK/IXQ',NULL,'\0'),(35,'&#x93E1;&#x97F3;&#x30EA;&#x30F3;','rin@gmail.com','2012-08-21 14:27:47','BA4gADnY4Y0qk',NULL,'\0');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-08-20 20:54:47
