-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: db0221
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `과목`
--
CREATE DATABASE db0309;
use db0309;
DROP TABLE IF EXISTS `과목`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `과목` (
  `과목번호` char(6) NOT NULL,
  `과목명` char(50) NOT NULL,
  `영문명` char(50) NOT NULL,
  `담당교수` char(7) NOT NULL,
  `학점` int NOT NULL,
  `시수` int NOT NULL,
  `이수구분` enum('교양','전공') NOT NULL,
  `학기` enum('1','여름','2','겨울') NOT NULL,
  `학년` enum('1','2','3','4') NOT NULL,
  `설명` text,
  PRIMARY KEY (`과목번호`),
  KEY `담당교수` (`담당교수`),
  CONSTRAINT `과목_ibfk_1` FOREIGN KEY (`담당교수`) REFERENCES `교수` (`사번`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `과목`
--

LOCK TABLES `과목` WRITE;
/*!40000 ALTER TABLE `과목` DISABLE KEYS */;
INSERT INTO `과목` VALUES ('K20002','컴퓨터네트워크','Computer Network','1000001',2,2,'전공','1','1','컴퓨터 네트워크에 대한 기본적 이해'),('K20012','정보보호개론','Introduction to Infromation Protection','1000001',4,3,'전공','2','1','정보보호 기술과 솔루션에 대한 기본적 이해'),('K20013','인터넷프로그래밍','Internet Programming','1000001',3,4,'전공','2','1','HTML과 CSS에 대한 학습'),('K20023','프로그래밍언어','Programming Language','1000002',4,4,'전공','2','1','프로그래밍 언어의 기본 원리'),('K20033','데이터베이스','Database','1000002',3,3,'전공','2','1','데이터 모델링 SQL 언어 습득'),('K20035','운영체제','Operating System','1000004',3,3,'전공','2','1','운영체제의 주요 역할 이해'),('K20045','컴퓨터소프트웨어개론','Introduction to Computer Software','1000002',3,3,'전공','1','1','컴퓨터 소프트웨어에 대한 기본적 이해'),('K20056','컴퓨터활용','Computer Practical Use','1000003',2,3,'전공','1','1','컴퓨터 활용에 대한 기본적 이해'),('K20077','컴퓨터개론','Introduction to Computer','1000004',3,3,'전공','1','1','컴퓨터에 대한 기본적 이해'),('Y00132','의사소통능력','Communication Skills','1000004',1,1,'교양','2','1','의사소통능력과 대인관계능력 계발');
/*!40000 ALTER TABLE `과목` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `교수`
--

DROP TABLE IF EXISTS `교수`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `교수` (
  `사번` char(7) NOT NULL,
  `이름` char(20) NOT NULL,
  `학과` char(2) NOT NULL,
  `전자우편` char(50) NOT NULL,
  `전화번호` char(20) DEFAULT NULL,
  PRIMARY KEY (`사번`),
  KEY `학과` (`학과`),
  CONSTRAINT `교수_ibfk_1` FOREIGN KEY (`학과`) REFERENCES `학과` (`학과번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `교수`
--

LOCK TABLES `교수` WRITE;
/*!40000 ALTER TABLE `교수` DISABLE KEYS */;
INSERT INTO `교수` VALUES ('1000001','김교수','01','kim@school.ac.kr','010-000-0001'),('1000002','이교수','01','lee@school.ac.kr','010-000-0002'),('1000003','박교수','01','park@school.ac.kr','010-000-0003'),('1000004','최교수','01','choi@school.ac.kr',NULL),('1000005','한교수','04','han@school.ac.kr',NULL);
/*!40000 ALTER TABLE `교수` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `수강신청`
--

DROP TABLE IF EXISTS `수강신청`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `수강신청` (
  `수강신청번호` char(7) NOT NULL,
  `학번` char(7) NOT NULL,
  `날짜` datetime NOT NULL,
  `연도` char(4) NOT NULL,
  `학기` enum('1','여름','2','겨울') NOT NULL,
  PRIMARY KEY (`수강신청번호`),
  KEY `학번` (`학번`),
  CONSTRAINT `수강신청_ibfk_1` FOREIGN KEY (`학번`) REFERENCES `학생` (`학번`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `수강신청`
--

LOCK TABLES `수강신청` WRITE;
/*!40000 ALTER TABLE `수강신청` DISABLE KEYS */;
INSERT INTO `수강신청` VALUES ('1610001','1601001','2016-03-02 00:00:00','2016','1'),('1610002','1601002','2016-03-01 00:00:00','2016','1'),('1810001','1801001','2018-03-02 00:00:00','2018','1'),('1810002','1801002','2018-03-02 00:00:00','2018','1'),('1810003','1804003','2018-03-01 00:00:00','2018','1'),('1820001','1801001','2018-08-28 00:00:00','2018','2'),('1820002','1601001','2018-08-29 00:00:00','2018','2'),('1820003','1801002','2018-08-25 00:00:00','2018','2'),('1820004','1601002','2018-08-26 00:00:00','2018','2'),('1820005','1804003','2018-08-27 00:00:00','2018','2'),('1820006','1804003','2023-03-06 00:00:00','2023','1'),('1820007','1804003','2023-03-06 00:00:00','2023','1');
/*!40000 ALTER TABLE `수강신청` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `수강신청내역`
--

DROP TABLE IF EXISTS `수강신청내역`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `수강신청내역` (
  `수강신청번호` char(7) NOT NULL,
  `일련번호` int NOT NULL,
  `과목번호` char(6) NOT NULL,
  `평점` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`수강신청번호`,`일련번호`),
  KEY `과목번호` (`과목번호`),
  CONSTRAINT `수강신청내역_ibfk_1` FOREIGN KEY (`수강신청번호`) REFERENCES `수강신청` (`수강신청번호`),
  CONSTRAINT `수강신청내역_ibfk_2` FOREIGN KEY (`과목번호`) REFERENCES `과목` (`과목번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `수강신청내역`
--

LOCK TABLES `수강신청내역` WRITE;
/*!40000 ALTER TABLE `수강신청내역` DISABLE KEYS */;
INSERT INTO `수강신청내역` VALUES ('1610001',1,'K20045',3),('1610001',2,'K20056',3),('1610001',3,'K20077',3),('1610002',1,'K20045',4),('1610002',2,'K20056',3),('1610002',3,'K20077',0),('1810001',1,'K20002',4),('1810001',2,'K20045',0),('1810001',3,'K20056',4),('1810002',1,'K20077',0),('1810002',2,'K20002',2),('1810002',3,'K20045',3),('1810003',1,'K20077',1),('1810003',2,'K20002',3),('1810003',3,'K20045',1),('1820001',1,'K20012',-1),('1820001',2,'K20013',-1),('1820001',3,'K20023',-1),('1820002',1,'K20013',-1),('1820002',2,'K20023',-1),('1820002',3,'K20033',-1),('1820003',1,'K20033',-1),('1820003',2,'K20035',-1),('1820003',3,'K20012',-1),('1820003',4,'Y00132',-1),('1820004',1,'K20012',-1),('1820004',2,'K20012',-1),('1820004',3,'K20023',-1),('1820005',1,'K20023',-1),('1820005',2,'K20033',-1),('1820005',3,'K20035',-1),('1820005',4,'K20012',-1),('1820005',5,'Y00132',-1);
/*!40000 ALTER TABLE `수강신청내역` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `학과`
--

DROP TABLE IF EXISTS `학과`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `학과` (
  `학과번호` char(2) NOT NULL,
  `학과명` char(20) NOT NULL,
  `전화번호` char(20) NOT NULL,
  PRIMARY KEY (`학과번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `학과`
--

LOCK TABLES `학과` WRITE;
/*!40000 ALTER TABLE `학과` DISABLE KEYS */;
INSERT INTO `학과` VALUES ('01','컴퓨터정보학과','022-200-3000'),('02','전자공학과','022-200-4000'),('03','전기공학과','022-200-5000'),('04','정보통신공학과','022-200-6000'),('08','컴퓨터보안학과','022-333-4000'),('16','컴퓨터보안2학과','022-123-4567'),('20','컴퓨터보안학과','022-200-7000');
/*!40000 ALTER TABLE `학과` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `학생`
--

DROP TABLE IF EXISTS `학생`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `학생` (
  `학번` char(7) NOT NULL,
  `학과` char(2) NOT NULL,
  `이름` char(20) NOT NULL,
  `학년` enum('1','2','3','4') NOT NULL,
  `주소` char(200) DEFAULT NULL,
  `시군구` char(20) DEFAULT NULL,
  `시도` char(20) DEFAULT NULL,
  `우편번호` char(20) DEFAULT NULL,
  `전자우편` char(50) DEFAULT NULL,
  PRIMARY KEY (`학번`),
  KEY `학과` (`학과`),
  CONSTRAINT `학생_ibfk_1` FOREIGN KEY (`학과`) REFERENCES `학과` (`학과번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `학생`
--

LOCK TABLES `학생` WRITE;
/*!40000 ALTER TABLE `학생` DISABLE KEYS */;
INSERT INTO `학생` VALUES ('1601001','01','이서준','1','이번길200','신한구','특별시','02345','seojoon@school.ac.kr'),('1601002','01','최예준','1','사번길400','산업시','그래도','04567',NULL),('1801001','01','김민준','1','일번길100','우리구','특별시','01234','minjoon@school.ac.kr'),('1801002','01','박주원','1','삼번길300','국민시','그래도','03456',NULL),('1804003','04','윤서연','1','오번길500','하나시','그래도','05678','seoyone@school.ac.kr');
/*!40000 ALTER TABLE `학생` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'db0221'
--

--
-- Dumping routines for database 'db0221'
--
/*!50003 DROP PROCEDURE IF EXISTS `과목수강자수` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `과목수강자수`(
	IN my과목번호 char(6),
    OUT 수강자수 INTEGER
)
BEGIN
	-- 검색 결과 변수에 저장
    SELECT count(*) INTO 수강자수 FROM 수강신청내역 WHERE 과목번호=my과목번호;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `새수강신청` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `새수강신청`(
	IN p학번 char(7),
    OUT p수강신청번호 int
)
BEGIN
	-- 마지막 수강신청번호 조회
	SELECT MAX(수강신청번호) INTO p수강신청번호 FROM 수강신청 WHERE 학번=p학번;
	-- 수강신청번호 조건
     SET p수강신청번호 = p수강신청번호 + 1 ;
    -- 입력하는 쿼리
     INSERT INTO 수강신청 (수강신청번호, 학번, 날짜, 연도, 학기) 
 		VALUES (p수강신청번호, p학번, CURDATE(), '2023', '1');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `새학과` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `새학과`(
	my학과번호 char(2),
    my학과명 char(20),
    my전화번호 char(20))
BEGIN
	INSERT INTO 학과(학과번호, 학과명, 전화번호)
		VALUES(my학과번호, my학과명, my전화번호);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `통계` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `통계`(
	OUT 학생수 INTEGER,
    OUT 과목수 INTEGER
)
BEGIN   
	-- 검색 결과 변수에 저장
    SELECT count(학번) INTO 학생수	FROM 수강신청;
    SELECT count(distinct (과목번호))	INTO 과목수	FROM 수강신청내역;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `학과_입력_수정` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `학과_입력_수정`(
	IN my학과번호 char(2),
    IN my학과명 char(20),
    IN my전화번호 char(20))
BEGIN
	-- 학과가 있는 경우는 업데이트, 없는 경우 입력이 되도록 하는 프로시저
    -- 학과번호가 존재하는지에 대한 결과를 변수에 저장해놓고
    DECLARE cnt INT;			-- 변수 선언
    SELECT count(*) INTO cnt	-- 검색 결과 변수에 저장 @
    FROM 학과 
    WHERE 학과번호 = my학과번호;
    
	-- 조건에 따라 경우의 수 나눠줌
    IF (cnt=0) THEN
		INSERT INTO 학과(학과번호, 학과명, 전화번호)
			VALUES(my학과번호, my학과명, my전화번호);
	ELSE 
		UPDATE 학과 SET 학과명=my학과명 , 전화번호=my전화번호 WHERE 학과번호=my학과번호;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-09 14:25:02
