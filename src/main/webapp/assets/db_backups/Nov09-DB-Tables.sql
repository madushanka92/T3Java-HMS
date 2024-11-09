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
  `type` enum('Meeting','In-Person') NOT NULL,
  PRIMARY KEY (`appointmentId`),
  KEY `patientId` (`patientId`),
  KEY `doctorId` (`doctorId`),
  KEY `departmentId` (`departmentId`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`patientId`) REFERENCES `Patient` (`patientId`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`doctorId`) REFERENCES `User` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`departmentId`) REFERENCES `Department` (`departmentId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Appointment`
--

LOCK TABLES `Appointment` WRITE;
/*!40000 ALTER TABLE `Appointment` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (1,'Surgical',NULL),(2,'ICU',NULL),(3,'ETU',NULL),(4,'OPD',NULL),(5,'Lab',NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DoctorPatientAssignment`
--

LOCK TABLES `DoctorPatientAssignment` WRITE;
/*!40000 ALTER TABLE `DoctorPatientAssignment` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feature`
--

LOCK TABLES `Feature` WRITE;
/*!40000 ALTER TABLE `Feature` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FeatureMapping`
--

LOCK TABLES `FeatureMapping` WRITE;
/*!40000 ALTER TABLE `FeatureMapping` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient`
--

LOCK TABLES `Patient` WRITE;
/*!40000 ALTER TABLE `Patient` DISABLE KEYS */;
INSERT INTO `Patient` VALUES (1,'suminda','dissanayaka','2024-10-31','Female','1234567','e@e.com','Mississauga','12345','none'),(2,'new','sdf','2024-11-07','Male','1234567','e@e.com','sdfg','sdfg','sdfg'),(3,'sdf','dsfgdfg','2024-11-07','Male','12345','e@e.com','2345\r\n','2456','63456ty'),(4,'sdfg','dfg','2024-11-22','Male','dfdgf34','e@e.com','dfg','dfgh','dfgh'),(5,'adi','adi','2024-11-23','Male','12345','e@e.com','sdfg','dfg','dfg'),(6,'new ','new','2024-11-07','Male','1234','p2@e.com','sdf','234','34');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Room`
--

LOCK TABLES `Room` WRITE;
/*!40000 ALTER TABLE `Room` DISABLE KEYS */;
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
  `isPrimary` tinyint(1) NOT NULL DEFAULT '1',
  `workShift` enum('Morning','Afternoon','Night','Rotational') NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `notes` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`assignmentId`),
  UNIQUE KEY `unique_active_primary_dept` (`technicianUserId`,`isPrimary`,`status`),
  KEY `idx_technician_dept_assignments` (`technicianUserId`),
  KEY `idx_department_tech_assignments` (`departmentId`),
  KEY `idx_assignment_status` (`status`),
  CONSTRAINT `techniciandepartmentassignment_ibfk_1` FOREIGN KEY (`technicianUserId`) REFERENCES `User` (`userId`) ON DELETE RESTRICT,
  CONSTRAINT `techniciandepartmentassignment_ibfk_2` FOREIGN KEY (`departmentId`) REFERENCES `Department` (`departmentId`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'Admin','User','admin@example.com','admin',4,'123-456-7890','123 Admin St',NULL),(2,'test','name','e@e.com','12345',1,'12345','sdfgh',1),(8,'test','new','e2@e.com','12345',1,'1234','sdfg',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRole`
--

LOCK TABLES `UserRole` WRITE;
/*!40000 ALTER TABLE `UserRole` DISABLE KEYS */;
INSERT INTO `UserRole` VALUES (1,'Doctor New'),(2,'Nurse'),(3,'Technician'),(4,'Admin');
/*!40000 ALTER TABLE `UserRole` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-09  0:21:14
