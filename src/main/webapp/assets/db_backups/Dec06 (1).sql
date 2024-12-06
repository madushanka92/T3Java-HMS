CREATE DATABASE  IF NOT EXISTS `hms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hms`;
-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (x86_64)
--
-- Host: 127.0.0.1    Database: hms
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `Admissions`
--

DROP TABLE IF EXISTS `Admissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admissions` (
  `admissionId` int NOT NULL AUTO_INCREMENT,
  `patientId` int NOT NULL,
  `roomId` int DEFAULT NULL,
  `departmentId` int NOT NULL,
  `admissionDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `dischargeDate` datetime DEFAULT NULL,
  `admissionStatus` enum('Active','Discharged','Transferred','Pending') NOT NULL DEFAULT 'Active',
  `notes` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`admissionId`),
  KEY `idx_patient_admission` (`patientId`),
  KEY `idx_room_admission` (`roomId`),
  KEY `idx_department_admission` (`departmentId`),
  KEY `idx_admission_status` (`admissionStatus`),
  KEY `idx_admission_date` (`admissionDate`),
  CONSTRAINT `admissions_ibfk_1` FOREIGN KEY (`patientId`) REFERENCES `Patient` (`patientId`) ON DELETE CASCADE,
  CONSTRAINT `admissions_ibfk_2` FOREIGN KEY (`roomId`) REFERENCES `Room` (`roomId`) ON DELETE SET NULL,
  CONSTRAINT `admissions_ibfk_3` FOREIGN KEY (`departmentId`) REFERENCES `Department` (`departmentId`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admissions`
--

LOCK TABLES `Admissions` WRITE;
/*!40000 ALTER TABLE `Admissions` DISABLE KEYS */;
INSERT INTO `Admissions` VALUES (5,7,4,2,'2024-12-06 12:04:00',NULL,'Active','','2024-12-06 17:03:41','2024-12-06 17:03:41');
/*!40000 ALTER TABLE `Admissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_admission_insert` AFTER INSERT ON `admissions` FOR EACH ROW BEGIN
    -- Check if a roomId is provided in the new admission
    IF NEW.roomId IS NOT NULL THEN
        -- Update the room status to 'Occupied'
        UPDATE Room
        SET availabilityStatus = 'Occupied'
        WHERE roomId = NEW.roomId;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_admission_update` AFTER UPDATE ON `admissions` FOR EACH ROW BEGIN
    -- Check if the admission status is changed to 'Discharged'
    IF OLD.admissionStatus != 'Discharged' AND NEW.admissionStatus = 'Discharged' THEN
        -- Update the room's availability status to 'Maintenance'
        IF NEW.roomId IS NOT NULL THEN
            UPDATE Room
            SET availabilityStatus = 'Maintenance'
            WHERE roomId = NEW.roomId;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Appointment`
--

DROP TABLE IF EXISTS `Appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Appointment` (
  `appointmentId` int NOT NULL AUTO_INCREMENT,
  `patientId` int NOT NULL,
  `doctorId` int NOT NULL,
  `departmentId` int NOT NULL,
  `appointmentDate` date NOT NULL,
  `appointmentTime` time NOT NULL,
  `status` enum('Scheduled','Completed','Canceled') NOT NULL DEFAULT 'Scheduled',
  `type` enum('Meeting','In-Person','Checkup','Emergency') NOT NULL,
  PRIMARY KEY (`appointmentId`),
  KEY `patientId` (`patientId`),
  KEY `doctorId` (`doctorId`),
  KEY `departmentId` (`departmentId`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`patientId`) REFERENCES `Patient` (`patientId`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`doctorId`) REFERENCES `User` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`departmentId`) REFERENCES `Department` (`departmentId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Appointment`
--

LOCK TABLES `Appointment` WRITE;
/*!40000 ALTER TABLE `Appointment` DISABLE KEYS */;
INSERT INTO `Appointment` VALUES (5,9,31,1,'2024-12-07','11:51:00','Scheduled','Meeting');
/*!40000 ALTER TABLE `Appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Billing`
--

DROP TABLE IF EXISTS `Billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Billing` (
  `billId` int NOT NULL AUTO_INCREMENT,
  `patientId` int NOT NULL,
  `appointmentId` int NOT NULL,
  `totalAmount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `paymentStatus` enum('Paid','Unpaid') NOT NULL DEFAULT 'Unpaid',
  `paymentDate` datetime DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`billId`),
  KEY `idx_patient_billing` (`patientId`),
  KEY `idx_appointment_billing` (`appointmentId`),
  KEY `idx_payment_status` (`paymentStatus`),
  CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`patientId`) REFERENCES `Patient` (`patientId`) ON DELETE RESTRICT,
  CONSTRAINT `billing_ibfk_2` FOREIGN KEY (`appointmentId`) REFERENCES `Appointment` (`appointmentId`) ON DELETE RESTRICT,
  CONSTRAINT `chk_totalAmount` CHECK ((`totalAmount` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Billing`
--

LOCK TABLES `Billing` WRITE;
/*!40000 ALTER TABLE `Billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `Billing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Department` (
  `departmentId` int NOT NULL AUTO_INCREMENT,
  `departmentName` varchar(100) NOT NULL,
  `headOfDepartmentId` int DEFAULT NULL,
  PRIMARY KEY (`departmentId`),
  KEY `fk_headOfDepartment` (`headOfDepartmentId`),
  CONSTRAINT `fk_headOfDepartment` FOREIGN KEY (`headOfDepartmentId`) REFERENCES `User` (`userId`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (1,'Surgical',NULL),(2,'ICU',NULL),(3,'ETU',NULL),(4,'OPD',NULL);
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DoctorPatientAssignment`
--

DROP TABLE IF EXISTS `DoctorPatientAssignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DoctorPatientAssignment` (
  `assignmentId` int NOT NULL AUTO_INCREMENT,
  `doctorUserId` int NOT NULL,
  `patientId` int NOT NULL,
  `assignedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Active','Inactive','Transferred') NOT NULL DEFAULT 'Active',
  `primaryDoctor` tinyint(1) NOT NULL DEFAULT '1',
  `notes` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`assignmentId`),
  UNIQUE KEY `unique_active_primary_doctor` (`patientId`,`primaryDoctor`,`status`),
  KEY `idx_doctor_assignments` (`doctorUserId`),
  KEY `idx_patient_assignments` (`patientId`),
  KEY `idx_assignment_status` (`status`),
  CONSTRAINT `doctorpatientassignment_ibfk_1` FOREIGN KEY (`patientId`) REFERENCES `Patient` (`patientId`) ON DELETE RESTRICT,
  CONSTRAINT `doctorpatientassignment_ibfk_2` FOREIGN KEY (`doctorUserId`) REFERENCES `User` (`userId`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DoctorPatientAssignment`
--

LOCK TABLES `DoctorPatientAssignment` WRITE;
/*!40000 ALTER TABLE `DoctorPatientAssignment` DISABLE KEYS */;
INSERT INTO `DoctorPatientAssignment` VALUES (5,31,8,'2024-12-06 11:51:57','Active',1,'new','2024-12-06 16:51:57','2024-12-06 16:51:57');
/*!40000 ALTER TABLE `DoctorPatientAssignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Feature`
--

DROP TABLE IF EXISTS `Feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Feature` (
  `featureId` int NOT NULL AUTO_INCREMENT,
  `featureName` varchar(100) NOT NULL,
  `description` text,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`featureId`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feature`
--

LOCK TABLES `Feature` WRITE;
/*!40000 ALTER TABLE `Feature` DISABLE KEYS */;
INSERT INTO `Feature` VALUES (10,'Admissions','Admissions Management',1,'2024-11-23 03:38:11','2024-12-03 17:48:52'),(11,'Assignment','Assignment Management',1,'2024-11-23 03:38:28','2024-11-23 03:38:58'),(12,'Patient','Patient Management',1,'2024-11-23 03:38:48','2024-11-23 03:38:48'),(13,'User','User Management',1,'2024-11-23 03:39:21','2024-11-23 03:39:21'),(14,'Department','Department Management',1,'2024-11-23 03:39:57','2024-11-30 00:59:17'),(15,'UserProfile','User Profile Management',1,'2024-11-23 03:43:44','2024-11-23 03:43:44'),(16,'Feature','Feature Management',1,'2024-11-23 03:44:10','2024-11-23 03:44:10'),(17,'DoctorPatient','Doctor Patient Assignment Management',1,'2024-11-30 05:02:03','2024-11-30 05:02:03'),(18,'NurseDoctor','Nurse Doctor Assignment Management',1,'2024-11-30 05:02:24','2024-11-30 05:02:24'),(19,'TechnicianPatient','Technician Patient Assignment Management',1,'2024-11-30 05:02:46','2024-11-30 05:02:46'),(20,'TechnicianDepartment','Technician Department Assignment Management',1,'2024-11-30 05:03:25','2024-11-30 05:03:25'),(21,'Appointments','Appointments Management',1,'2024-12-01 05:29:43','2024-12-03 17:48:44'),(23,'Rooms','Room Management',1,'2024-12-06 16:01:59','2024-12-06 16:02:44'),(24,'UserRoles','User Roles Management',1,'2024-12-06 16:04:55','2024-12-06 16:04:55'),(25,'PatientRecords','Patient Records Management',1,'2024-12-06 16:18:53','2024-12-06 16:18:53'),(26,'Payment','Payment Management',0,'2024-12-06 16:20:39','2024-12-06 16:20:42');
/*!40000 ALTER TABLE `Feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FeatureMapping`
--

DROP TABLE IF EXISTS `FeatureMapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FeatureMapping` (
  `mappingId` int NOT NULL AUTO_INCREMENT,
  `featureId` int NOT NULL,
  `roleId` int NOT NULL,
  `canCreate` tinyint(1) NOT NULL DEFAULT '0',
  `canRead` tinyint(1) NOT NULL DEFAULT '1',
  `canUpdate` tinyint(1) NOT NULL DEFAULT '0',
  `canDelete` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mappingId`),
  UNIQUE KEY `unique_feature_role` (`featureId`,`roleId`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `featuremapping_ibfk_1` FOREIGN KEY (`featureId`) REFERENCES `Feature` (`featureId`) ON DELETE CASCADE,
  CONSTRAINT `featuremapping_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `UserRole` (`roleId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=319 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FeatureMapping`
--

LOCK TABLES `FeatureMapping` WRITE;
/*!40000 ALTER TABLE `FeatureMapping` DISABLE KEYS */;
INSERT INTO `FeatureMapping` VALUES (65,10,4,1,1,1,1,'2024-11-23 03:38:11','2024-11-23 03:38:11'),(66,11,4,1,1,1,1,'2024-11-23 03:38:28','2024-11-23 03:38:28'),(67,12,4,1,1,1,1,'2024-11-23 03:38:48','2024-11-23 03:38:48'),(68,13,4,1,1,1,1,'2024-11-23 03:39:21','2024-11-23 03:39:21'),(69,14,4,1,1,1,1,'2024-11-23 03:39:57','2024-11-23 03:39:57'),(70,15,4,1,1,1,1,'2024-11-23 03:43:44','2024-11-23 03:43:44'),(71,16,4,1,1,1,1,'2024-11-23 03:44:10','2024-11-23 03:44:10'),(72,17,4,1,1,1,1,'2024-11-30 05:02:03','2024-11-30 05:02:03'),(73,18,4,1,1,1,1,'2024-11-30 05:02:24','2024-11-30 05:02:24'),(74,19,4,1,1,1,1,'2024-11-30 05:02:46','2024-11-30 05:02:46'),(75,20,4,1,1,1,1,'2024-11-30 05:03:25','2024-11-30 05:03:25'),(109,21,4,1,1,1,1,'2024-12-01 05:29:43','2024-12-01 05:29:43'),(267,23,4,1,1,1,1,'2024-12-06 16:01:59','2024-12-06 16:01:59'),(268,24,4,1,1,1,1,'2024-12-06 16:04:55','2024-12-06 16:04:55'),(269,25,4,1,1,1,1,'2024-12-06 16:18:53','2024-12-06 16:18:53'),(270,26,4,1,1,1,1,'2024-12-06 16:20:39','2024-12-06 16:20:39'),(271,10,1,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(272,10,2,1,1,1,1,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(273,10,3,0,0,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(274,11,1,0,1,1,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(275,11,2,1,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(276,11,3,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(277,12,1,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(278,12,2,1,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(279,12,3,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(280,13,1,0,0,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(281,13,2,0,0,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(282,13,3,0,0,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(283,14,1,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(284,14,2,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(285,14,3,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(286,15,1,0,1,1,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(287,15,2,0,1,1,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(288,15,3,0,1,1,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(289,16,1,0,0,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(290,16,2,0,0,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(291,16,3,0,0,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(292,17,1,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(293,17,2,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(294,17,3,0,0,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(295,18,1,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(296,18,2,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(297,18,3,0,0,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(298,19,1,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(299,19,2,1,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(300,19,3,0,1,1,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(301,20,1,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(302,20,2,1,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(303,20,3,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(304,21,1,0,1,1,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(305,21,2,1,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(306,21,3,0,0,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(307,23,1,0,1,0,0,'2024-12-06 17:29:46','2024-12-06 17:29:46'),(308,23,2,0,1,1,0,'2024-12-06 17:29:47','2024-12-06 17:29:47'),(309,23,3,0,0,0,0,'2024-12-06 17:29:47','2024-12-06 17:29:47'),(310,24,1,0,0,0,0,'2024-12-06 17:29:47','2024-12-06 17:29:47'),(311,24,2,0,0,0,0,'2024-12-06 17:29:47','2024-12-06 17:29:47'),(312,24,3,0,0,0,0,'2024-12-06 17:29:47','2024-12-06 17:29:47'),(313,25,1,1,1,1,0,'2024-12-06 17:29:47','2024-12-06 17:29:47'),(314,25,2,1,1,1,0,'2024-12-06 17:29:47','2024-12-06 17:29:47'),(315,25,3,0,1,1,0,'2024-12-06 17:29:47','2024-12-06 17:29:47'),(316,26,1,0,0,0,0,'2024-12-06 17:29:47','2024-12-06 17:29:47'),(317,26,2,0,0,0,0,'2024-12-06 17:29:47','2024-12-06 17:29:47'),(318,26,3,0,0,0,0,'2024-12-06 17:29:47','2024-12-06 17:29:47');
/*!40000 ALTER TABLE `FeatureMapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Logs`
--

DROP TABLE IF EXISTS `Logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Logs` (
  `logId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `actionType` enum('Create','Update','Delete') NOT NULL,
  `entityType` enum('Appointment','Patient','Department','MedicalRecord','Billing','Room','Payment','DoctorPatientAssignment','NurseDoctorAssignment','TechnicianPatientAssignment','TechnicianDepartmentAssignment') NOT NULL,
  `entityId` int NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `details` json DEFAULT NULL,
  PRIMARY KEY (`logId`),
  KEY `idx_user_action` (`userId`,`actionType`),
  KEY `idx_entity` (`entityType`,`entityId`),
  KEY `idx_timestamp` (`timestamp`),
  CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Logs`
--

LOCK TABLES `Logs` WRITE;
/*!40000 ALTER TABLE `Logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MedicalRecord`
--

DROP TABLE IF EXISTS `MedicalRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MedicalRecord` (
  `recordId` int NOT NULL AUTO_INCREMENT,
  `patientId` int NOT NULL,
  `doctorId` int NOT NULL,
  `visitDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `diagnosis` text,
  `treatment` text,
  `prescriptions` text,
  `notes` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`recordId`),
  KEY `idx_patient` (`patientId`),
  KEY `idx_doctor` (`doctorId`),
  KEY `idx_visit_date` (`visitDate`),
  CONSTRAINT `medicalrecord_ibfk_1` FOREIGN KEY (`patientId`) REFERENCES `Patient` (`patientId`) ON DELETE CASCADE,
  CONSTRAINT `medicalrecord_ibfk_2` FOREIGN KEY (`doctorId`) REFERENCES `User` (`userId`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MedicalRecord`
--

LOCK TABLES `MedicalRecord` WRITE;
/*!40000 ALTER TABLE `MedicalRecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `MedicalRecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NurseDoctorAssignment`
--

DROP TABLE IF EXISTS `NurseDoctorAssignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NurseDoctorAssignment` (
  `assignmentId` int NOT NULL AUTO_INCREMENT,
  `nurseUserId` int NOT NULL,
  `doctorUserId` int NOT NULL,
  `assignedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Active','Inactive','Temporary','On Leave') NOT NULL DEFAULT 'Active',
  `shiftType` enum('Morning','Afternoon','Night','All Day') NOT NULL,
  `notes` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`assignmentId`),
  UNIQUE KEY `unique_active_nurse_doctor` (`nurseUserId`,`doctorUserId`,`status`,`shiftType`),
  KEY `idx_nurse_assignments` (`nurseUserId`),
  KEY `idx_doctor_nurse_assignments` (`doctorUserId`),
  KEY `idx_assignment_status` (`status`),
  CONSTRAINT `nursedoctorassignment_ibfk_1` FOREIGN KEY (`nurseUserId`) REFERENCES `User` (`userId`) ON DELETE RESTRICT,
  CONSTRAINT `nursedoctorassignment_ibfk_2` FOREIGN KEY (`doctorUserId`) REFERENCES `User` (`userId`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NurseDoctorAssignment`
--

LOCK TABLES `NurseDoctorAssignment` WRITE;
/*!40000 ALTER TABLE `NurseDoctorAssignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `NurseDoctorAssignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient`
--

DROP TABLE IF EXISTS `Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient` (
  `patientId` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `gender` varchar(10) NOT NULL,
  `contactNumber` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text,
  `emergencyContact` varchar(15) DEFAULT NULL,
  `medicalHistory` text,
  PRIMARY KEY (`patientId`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient`
--

LOCK TABLES `Patient` WRITE;
/*!40000 ALTER TABLE `Patient` DISABLE KEYS */;
INSERT INTO `Patient` VALUES (7,'Alice','Taylor','1985-04-12','Female','1234567891','alice.taylor@example.com','123 Rosewood Ave, City','9876543210','Diabetes'),(8,'Robert','Moore','1990-07-22','Male','1234567892','robert.moore@example.com','456 Elmwood Rd, Town','9876543211','Asthma'),(9,'Isabella','Anderson','1995-02-19','Female','1234567893','isabella.anderson@example.com','789 Pine Dr, Village','9876543212','None'),(10,'James','Thomas','1988-11-03','Male','1234567894','james.thomas@example.com','321 Oak Ln, City','9876543213','Hypertension'),(11,'Sophia','Jackson','1992-06-17','Female','1234567895','sophia.jackson@example.com','654 Cedar Blvd, Town','9876543214','Anemia'),(12,'Liam','White','1999-08-05','Male','1234567896','liam.white@example.com','246 Maple Ct, Village','9876543215','None'),(13,'Mia','Harris','1980-09-15','Female','1234567897','mia.harris@example.com','135 Willow St, Hamlet','9876543216','Heart Disease'),(14,'Noah','Martin','1987-01-25','Male','1234567898','noah.martin@example.com','369 Fir Ave, City','9876543217','Allergies'),(15,'Charlotte','Thompson','1996-03-09','Female','1234567899','charlotte.thompson@example.com','789 Aspen Dr, Town','9876543218','None'),(16,'Ethan','Garcia','1993-12-12','Male','1234567800','ethan.garcia@example.com','987 Birch Blvd, Village','9876543219','High Cholesterol'),(17,'Olivia','Martinez','1981-04-18','Female','1234567811','olivia.martinez@example.com','741 Cypress Rd, City','9876543220','Asthma'),(18,'Aiden','Lopez','1989-09-30','Male','1234567812','aiden.lopez@example.com','258 Redwood Ln, Town','9876543221','Migraines'),(19,'Emma','Young','1998-05-21','Female','1234567813','emma.young@example.com','369 Oakwood St, Hamlet','9876543222','None'),(20,'Benjamin','Hall','1983-07-14','Male','1234567814','benjamin.hall@example.com','951 Walnut Ave, City','9876543223','Diabetes'),(21,'Amelia','Allen','1991-02-28','Female','1234567815','amelia.allen@example.com','654 Juniper Blvd, Village','9876543224','Allergies'),(22,'Lucas','Scott','1994-10-10','Male','1234567816','lucas.scott@example.com','456 Magnolia Ln, Town','9876543225','None'),(23,'Ella','Hill','1986-11-22','Female','1234567817','ella.hill@example.com','123 Hawthorn St, Hamlet','9876543226','Hypertension'),(24,'Jack','Green','1984-08-08','Male','1234567818','jack.green@example.com','987 Chestnut Dr, City','9876543227','Heart Disease'),(25,'Abigail','Adams','1997-06-13','Female','1234567819','abigail.adams@example.com','741 Mulberry Ln, Village','9876543228','None'),(26,'Matthew','Perez','1992-03-03','Male','1234567820','matthew.perez@example.com','369 Spruce Blvd, Town','9876543229','High Cholesterol');
/*!40000 ALTER TABLE `Patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `paymentId` int NOT NULL AUTO_INCREMENT,
  `billId` int NOT NULL,
  `patientId` int NOT NULL,
  `paymentMethod` enum('Credit Card','Cash','Insurance','Debit Card','Bank Transfer') NOT NULL,
  `amountPaid` decimal(10,2) NOT NULL,
  `paymentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `transactionReference` varchar(100) DEFAULT NULL,
  `paymentStatus` enum('Success','Failed','Pending') NOT NULL DEFAULT 'Pending',
  `remarks` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`paymentId`),
  KEY `idx_bill_payment` (`billId`),
  KEY `idx_patient_payment` (`patientId`),
  KEY `idx_payment_date` (`paymentDate`),
  KEY `idx_payment_status` (`paymentStatus`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`billId`) REFERENCES `Billing` (`billId`) ON DELETE RESTRICT,
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`patientId`) REFERENCES `Patient` (`patientId`) ON DELETE RESTRICT,
  CONSTRAINT `chk_amountPaid` CHECK ((`amountPaid` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payment`
--

LOCK TABLES `Payment` WRITE;
/*!40000 ALTER TABLE `Payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_billing_after_payment` AFTER INSERT ON `payment` FOR EACH ROW BEGIN
    DECLARE total_paid DECIMAL(10,2);
    DECLARE bill_total DECIMAL(10,2);
    
    -- Calculate total amount paid for this bill
    SELECT SUM(amountPaid), b.totalAmount 
    INTO total_paid, bill_total
    FROM Payment p
    JOIN Billing b ON b.billId = p.billId
    WHERE p.billId = NEW.billId
    AND p.paymentStatus = 'Success'
    GROUP BY b.billId;
    
    -- Update billing status if fully paid
    IF total_paid >= bill_total THEN
        UPDATE Billing 
        SET paymentStatus = 'Paid',
            paymentDate = CURRENT_TIMESTAMP
        WHERE billId = NEW.billId;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Reports`
--

DROP TABLE IF EXISTS `Reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reports` (
  `reportId` int NOT NULL AUTO_INCREMENT,
  `patientId` int NOT NULL,
  `diagnosis` text NOT NULL,
  `treatment` text NOT NULL,
  `reportDate` date NOT NULL,
  PRIMARY KEY (`reportId`),
  KEY `patientId` (`patientId`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`patientId`) REFERENCES `Patient` (`patientId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reports`
--

LOCK TABLES `Reports` WRITE;
/*!40000 ALTER TABLE `Reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Room`
--

DROP TABLE IF EXISTS `Room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Room` (
  `roomId` int NOT NULL AUTO_INCREMENT,
  `roomNumber` varchar(10) NOT NULL,
  `roomType` enum('ICU','General','VIP') NOT NULL,
  `availabilityStatus` enum('Available','Occupied','Maintenance') NOT NULL DEFAULT 'Available',
  `assignedPatientId` int DEFAULT NULL,
  `floorNumber` int NOT NULL,
  `departmentId` int DEFAULT NULL,
  `lastCleanedAt` datetime DEFAULT NULL,
  `dailyRate` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`roomId`),
  UNIQUE KEY `roomNumber` (`roomNumber`),
  KEY `departmentId` (`departmentId`),
  KEY `idx_room_status` (`availabilityStatus`),
  KEY `idx_room_type` (`roomType`),
  KEY `idx_assigned_patient` (`assignedPatientId`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`assignedPatientId`) REFERENCES `Patient` (`patientId`) ON DELETE SET NULL,
  CONSTRAINT `room_ibfk_2` FOREIGN KEY (`departmentId`) REFERENCES `Department` (`departmentId`) ON DELETE SET NULL,
  CONSTRAINT `chk_dailyRate` CHECK ((`dailyRate` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Room`
--

LOCK TABLES `Room` WRITE;
/*!40000 ALTER TABLE `Room` DISABLE KEYS */;
INSERT INTO `Room` VALUES (4,'R-101','ICU','Occupied',NULL,1,3,'2024-12-06 00:00:00',55.00),(5,'R-102','ICU','Available',NULL,1,2,'2024-12-06 00:00:00',55.00),(6,'R-201','General','Available',NULL,2,4,'2024-12-06 00:00:00',35.00),(7,'R-202','General','Available',NULL,2,4,'2024-12-06 00:00:00',35.00),(8,'R-301','VIP','Available',NULL,3,1,'2024-12-06 00:00:00',105.00);
/*!40000 ALTER TABLE `Room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TechnicianDepartmentAssignment`
--

DROP TABLE IF EXISTS `TechnicianDepartmentAssignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TechnicianDepartmentAssignment` (
  `assignmentId` int NOT NULL AUTO_INCREMENT,
  `technicianUserId` int NOT NULL,
  `departmentId` int NOT NULL,
  `assignedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Active','Inactive','Temporary','On Leave') NOT NULL DEFAULT 'Active',
  `workShift` enum('Morning','Afternoon','Night','Rotational') NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `notes` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`assignmentId`),
  KEY `idx_technician_dept_assignments` (`technicianUserId`),
  KEY `idx_department_tech_assignments` (`departmentId`),
  KEY `idx_assignment_status` (`status`),
  CONSTRAINT `techniciandepartmentassignment_ibfk_1` FOREIGN KEY (`technicianUserId`) REFERENCES `User` (`userId`) ON DELETE RESTRICT,
  CONSTRAINT `techniciandepartmentassignment_ibfk_2` FOREIGN KEY (`departmentId`) REFERENCES `Department` (`departmentId`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TechnicianDepartmentAssignment`
--

LOCK TABLES `TechnicianDepartmentAssignment` WRITE;
/*!40000 ALTER TABLE `TechnicianDepartmentAssignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `TechnicianDepartmentAssignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TechnicianPatientAssignment`
--

DROP TABLE IF EXISTS `TechnicianPatientAssignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TechnicianPatientAssignment` (
  `assignmentId` int NOT NULL AUTO_INCREMENT,
  `technicianUserId` int NOT NULL,
  `patientId` int NOT NULL,
  `assignedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serviceType` enum('Lab','Radiology','Cardiology','Neurology','Respiratory') NOT NULL,
  `status` enum('Scheduled','In Progress','Completed','Cancelled') NOT NULL DEFAULT 'Scheduled',
  `scheduledDateTime` datetime NOT NULL,
  `completedDateTime` datetime DEFAULT NULL,
  `notes` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`assignmentId`),
  KEY `idx_technician_assignments` (`technicianUserId`),
  KEY `idx_patient_tech_assignments` (`patientId`),
  KEY `idx_service_type` (`serviceType`),
  KEY `idx_assignment_status` (`status`),
  KEY `idx_scheduled_datetime` (`scheduledDateTime`),
  CONSTRAINT `technicianpatientassignment_ibfk_1` FOREIGN KEY (`patientId`) REFERENCES `Patient` (`patientId`) ON DELETE RESTRICT,
  CONSTRAINT `technicianpatientassignment_ibfk_2` FOREIGN KEY (`technicianUserId`) REFERENCES `User` (`userId`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TechnicianPatientAssignment`
--

LOCK TABLES `TechnicianPatientAssignment` WRITE;
/*!40000 ALTER TABLE `TechnicianPatientAssignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `TechnicianPatientAssignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `roleId` int NOT NULL,
  `contactNumber` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `departmentId` int DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email` (`email`),
  KEY `roleId` (`roleId`),
  KEY `departmentId` (`departmentId`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `UserRole` (`roleId`) ON DELETE CASCADE,
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`departmentId`) REFERENCES `Department` (`departmentId`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'Admin','User','admin@example.com','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',4,'123-456-7890','123 Admin St',NULL),(31,'Suminda','Dissanayaka','suminda@hms.com','126b214f63450c40b8e21766ed9eeb9bf28c1fabcbe0c7eeb033c445d567c7a8',1,'123456789','Mississauga',1),(32,'Aditya','Sharma','aditya@hms.com','265719f4e7ee032fe4a0c5ed5735a0530545e4f35c8648155dc5450330327e2a',3,'123456789','Brampton',2),(33,'Sandeep','Kaur','sandeep@hms.com','3916284aafcf7adac206d7ea999696b1f22df2e0bb168e3c5896246fb8495485',2,'123456789','Brampton',1),(34,'Sneha','Pillai','sneha@hms.com','d743dbca8fb5f00186bf3d8a678d686c27ba4f5a7014e55404a6ac9886bee837',2,'123456789','Toronto',3),(35,'Mit','Kotak','mit@hms.com','78198e7ab262449ad56e4ca48e10a36f98dda6fd5a377875dd7425afcca2312b',3,'123456789','Brampton',3);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserRole`
--

DROP TABLE IF EXISTS `UserRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserRole` (
  `roleId` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(50) NOT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRole`
--

LOCK TABLES `UserRole` WRITE;
/*!40000 ALTER TABLE `UserRole` DISABLE KEYS */;
INSERT INTO `UserRole` VALUES (1,'Doctor'),(2,'Nurse'),(3,'Technician'),(4,'Admin');
/*!40000 ALTER TABLE `UserRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hms'
--

--
-- Dumping routines for database 'hms'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-06 12:37:37
