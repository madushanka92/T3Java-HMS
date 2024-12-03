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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admissions`
--

LOCK TABLES `Admissions` WRITE;
/*!40000 ALTER TABLE `Admissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Admissions` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DoctorPatientAssignment`
--

LOCK TABLES `DoctorPatientAssignment` WRITE;
/*!40000 ALTER TABLE `DoctorPatientAssignment` DISABLE KEYS */;
INSERT INTO `DoctorPatientAssignment` VALUES (1,20,8,'2024-11-22 18:35:56','Active',1,'','2024-11-22 23:35:56','2024-11-22 23:35:56');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feature`
--

LOCK TABLES `Feature` WRITE;
/*!40000 ALTER TABLE `Feature` DISABLE KEYS */;
INSERT INTO `Feature` VALUES (10,'Admissions','Admissions Management',1,'2024-11-23 03:38:11','2024-11-23 03:43:04'),(11,'Assignment','Assignment Management',1,'2024-11-23 03:38:28','2024-11-23 03:38:58'),(12,'Patient','Patient Management',1,'2024-11-23 03:38:48','2024-11-23 03:38:48'),(13,'User','User Management',1,'2024-11-23 03:39:21','2024-11-23 03:39:21'),(14,'Department','Department Management',1,'2024-11-23 03:39:57','2024-11-23 03:39:57'),(15,'UserProfile','User Profile Management',1,'2024-11-23 03:43:44','2024-11-23 03:43:44'),(16,'Feature','Feature Management',1,'2024-11-23 03:44:10','2024-11-23 03:44:10');
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
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FeatureMapping`
--

LOCK TABLES `FeatureMapping` WRITE;
/*!40000 ALTER TABLE `FeatureMapping` DISABLE KEYS */;
INSERT INTO `FeatureMapping` VALUES (65,10,4,1,1,1,1,'2024-11-23 03:38:11','2024-11-23 03:38:11'),(66,11,4,1,1,1,1,'2024-11-23 03:38:28','2024-11-23 03:38:28'),(67,12,4,1,1,1,1,'2024-11-23 03:38:48','2024-11-23 03:38:48'),(68,13,4,1,1,1,1,'2024-11-23 03:39:21','2024-11-23 03:39:21'),(69,14,4,1,1,1,1,'2024-11-23 03:39:57','2024-11-23 03:39:57'),(70,15,4,1,1,1,1,'2024-11-23 03:43:44','2024-11-23 03:43:44'),(71,16,4,1,1,1,1,'2024-11-23 03:44:10','2024-11-23 03:44:10');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NurseDoctorAssignment`
--

LOCK TABLES `NurseDoctorAssignment` WRITE;
/*!40000 ALTER TABLE `NurseDoctorAssignment` DISABLE KEYS */;
INSERT INTO `NurseDoctorAssignment` VALUES (1,21,26,'2024-11-22 19:41:20','Active','Afternoon','Follow up','2024-11-23 00:41:20','2024-11-23 00:41:20');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
INSERT INTO `TechnicianDepartmentAssignment` VALUES (1,25,1,'2024-11-22 19:59:37','Active','Afternoon','2024-11-24',NULL,'','2024-11-23 00:59:36','2024-11-23 00:59:36');
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
INSERT INTO `TechnicianPatientAssignment` VALUES (1,22,7,'2024-11-22 19:58:12','Radiology','Scheduled','2024-11-23 00:00:00',NULL,'urgent','2024-11-23 00:58:11','2024-11-23 00:58:11');
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'Admin','User','admin@example.com','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',4,'123-456-7890','123 Admin St',NULL),(20,'John','Doe','john.doe@example.com','a8cfcd74832004951b4408cdb0a5dbcd8c7e52d43f7fe244bf720582e05241da',1,'1234567890','123 Main St, City',1),(21,'Jane','Smith','jane.smith@example.com','4f23798d92708359b734a18172c9c864f1d48044a754115a0d4b843bca3a5332',2,'9876543210','456 Elm St, Town',2),(22,'Michael','Brown','michael.brown@example.com','ea95e638f7bcb94d97328386714ee4f03a63bb8c72cd62b0f735a5aa5fad775d',3,'5556667777','789 Maple St, Village',3),(23,'Emily','Johnson','emily.johnson@example.com','b02c2a09919ce7efb6d68d6d3f039f76d8c58aa5692b7a2a4be4ebeb84a29d7d',1,'3332221111','321 Oak St, City',4),(24,'David','Williams','david.williams@example.com','a6b54c20a7b96eeac1a911e6da3124a560fe6dc042ebf270e3676e7095b95652',2,'7778889999','987 Pine St, Hamlet',1),(25,'Sarah','Jones','sarah.jones@example.com','7e8c729e4e4ecc320cb411c4d1419bf5fbad733212d4e9491b7630aaef0b8b1c',3,'2223334444','654 Cedar St, Town',2),(26,'Chris','Lee','chris.lee@example.com','9ae4bc0e32db0e3484cd398459d20f9b4f79cce36667428181bf037131a3c987',1,'4445556666','246 Birch St, Village',3),(27,'Sophia','Garcia','sophia.garcia@example.com','f1908a7c45aa1249ba4e6e6ac0b380630e90ff67fa27235b4ed69e6f79c0df28',2,'8887776665','135 Willow St, City',4),(28,'Daniel','Martinez','daniel.martinez@example.com','7297db81c2f7916e25b9593f8c8785e1aa1487fa9f3961c50b7cc5f1a541bc82',3,'1112223334','789 Aspen St, Town',1),(29,'Olivia','Hernandez','olivia.hernandez@example.com','5e884898da28047151d0e56f8dc62927',2,'9998887774','369 Fir St, Hamlet',2);
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
INSERT INTO `UserRole` VALUES (1,'Doctor'),(2,'Nurse'),(3,'Technician'),(4,'Admin');
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

-- Dump completed on 2024-11-22 23:06:41
