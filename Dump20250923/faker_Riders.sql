-- MySQL dump 10.13  Distrib 8.0.32, for macos13 (x86_64)
--
-- Host: localhost    Database: faker
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `Riders`
--

DROP TABLE IF EXISTS `Riders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Riders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `vehicleType` varchar(255) DEFAULT NULL,
  `courierId` int DEFAULT NULL,
  `age` int DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Riders`
--

LOCK TABLES `Riders` WRITE;
/*!40000 ALTER TABLE `Riders` DISABLE KEYS */;
INSERT INTO `Riders` VALUES (1,'Ward','Gusikowski','Motorcycle',1,60,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(2,'Llewellyn','Lubowitz','Bike',1,50,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(3,'Kaitlin','Jacobi','Motorcycle',3,24,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(4,'Kariane','Weber','Trike',2,43,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(5,'Jairo','Friesen','Car',2,52,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(6,'Emilio','Buckridge','Bike',2,22,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(7,'Marlen','Kunze','Motorbike',3,53,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(8,'Evelyn','Bashirian','Bike',3,22,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(9,'Abigail','Auer','Car',2,31,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(10,'Cydney','Heaney','Bike',2,23,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(11,'Kenneth','Hoppe','Bike',1,47,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(12,'Dianna','Shields','Motorcycle',2,38,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(13,'Bertrand','Hilpert','Motorcycle',2,41,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(14,'Adonis','Wunsch','Trike',3,29,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(15,'Treva','Ebert','Bike',1,40,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(16,'Oda','Rutherford-Dach','Motorcycle',3,40,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(17,'Betty','Schinner','Motorbike',2,30,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(18,'Pete','Simonis','Motorbike',3,36,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(19,'Julie','Altenwerth','Bike',1,30,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(20,'Russell','Von','Motorcycle',2,44,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(21,'Celine','Cremin','Motorcycle',1,45,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(22,'Lucile','Howell','Car',3,50,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(23,'Markus','Nolan','Motorbike',2,34,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(24,'Lucinda','Hammes','Motorbike',3,58,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(25,'Alexanne','Goldner','Motorcycle',3,44,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(26,'Garrison','Schneider','Car',3,52,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(27,'Jakayla','Crist','Motorbike',3,51,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(28,'Haylie','Bauch','Motorbike',1,43,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(29,'Kevin','Halvorson','Motorcycle',3,38,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(30,'Eryn','Barton','Motorbike',3,56,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(31,'Lempi','Runte','Bike',1,34,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(32,'Yolanda','Johnston','Car',3,48,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(33,'Brook','Botsford','Motorbike',1,50,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(34,'Emmett','Kulas-Lemke','Trike',2,26,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(35,'Chadd','Keeling','Motorbike',1,52,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(36,'Jaqueline','Toy','Motorcycle',1,43,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(37,'Tyrel','Hyatt','Motorbike',1,39,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(38,'Chandler','Bechtelar','Trike',2,36,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(39,'Fabiola','Roob','Trike',3,33,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(40,'Scot','Hackett','Trike',1,58,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(41,'Buford','Monahan','Motorcycle',3,37,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(42,'Fletcher','Stoltenberg-Hickle','Bicycle',2,27,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(43,'Mireille','Herzog','Bike',2,60,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(44,'Pauline','Gorczany','Car',1,56,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(45,'Raquel','Kovacek','Car',2,18,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(46,'Raphael','Homenick','Motorbike',1,52,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(47,'Garnett','Schimmel-Hoeger','Car',3,40,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(48,'Chadd','Wehner','Motorbike',2,45,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(49,'Gage','Medhurst','Motorbike',1,51,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(50,'Waino','Strosin','Bike',1,39,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(51,'Paul','Anderson','Car',2,52,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(52,'Zaria','Langosh','Bike',1,33,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(53,'Grant','Jacobs','Trike',2,41,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(54,'Landen','Kassulke','Motorcycle',2,53,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(55,'Curtis','Gutkowski','Bike',3,38,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(56,'Belle','McDermott-Rohan','Trike',1,40,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(57,'Noelia','Schoen','Motorbike',2,27,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(58,'Peggie','Larson','Motorbike',1,38,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(59,'Amira','Hackett','Motorbike',2,19,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(60,'Albin','Krajcik','Bicycle',2,24,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(61,'Carmine','Bogan','Bicycle',2,31,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(62,'Nicklaus','Bahringer','Trike',3,26,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(63,'Kailey','Schuppe','Trike',3,36,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(64,'Brisa','Jenkins','Car',1,43,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(65,'Flossie','Gleason','Motorbike',3,43,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(66,'Khalil','Senger','Bicycle',3,55,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(67,'Jed','Turner','Bicycle',3,22,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(68,'Dario','Mann','Motorbike',2,42,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(69,'Jaycee','Klocko-Kub','Motorbike',2,41,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(70,'Tyrese','Frami','Car',3,52,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(71,'Nathen','Towne','Bicycle',1,53,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(72,'Eugene','Stiedemann','Bike',2,37,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(73,'Nyah','Marks','Bicycle',3,19,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(74,'Ahmed','Wisoky','Car',1,54,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(75,'Timothy','Orn','Bicycle',2,60,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(76,'Nayeli','Ritchie','Motorcycle',3,51,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(77,'Matilde','Bauch','Trike',2,51,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(78,'Haskell','Collier','Motorbike',1,20,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(79,'Xander','Bahringer','Motorbike',2,36,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(80,'Elyse','Fahey','Car',1,32,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(81,'Eldridge','Dare','Bike',1,52,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(82,'Lonzo','Davis','Bike',3,24,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(83,'Aletha','Torp','Bike',3,54,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(84,'Issac','Gusikowski','Trike',3,45,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(85,'Lukas','Mayer','Bike',2,23,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(86,'Dorris','Funk','Trike',1,32,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(87,'Timothy','Grimes','Motorbike',1,34,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(88,'Jaime','Haag','Motorbike',3,45,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(89,'Alvena','Kulas','Motorcycle',2,26,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(90,'Jerrod','Fadel-Kunze','Car',1,53,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(91,'Carmen','Bruen','Bicycle',2,20,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(92,'Kiana','Goldner','Trike',1,33,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(93,'Hank','McCullough','Bicycle',2,52,'F','2025-09-22 16:56:36','2025-09-22 16:56:36'),(94,'Carmelo','Olson','Motorcycle',2,31,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(95,'Milan','Crona','Motorbike',2,29,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(96,'Gregg','Kiehn','Motorbike',3,59,'Male','2025-09-22 16:56:36','2025-09-22 16:56:36'),(97,'Gregorio','Hermiston','Motorcycle',1,36,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36'),(98,'Lewis','Abernathy','Car',3,54,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(99,'Jada','O\'Connell','Bicycle',3,47,'M','2025-09-22 16:56:36','2025-09-22 16:56:36'),(100,'Alvina','Smitham-Mann','Bicycle',3,41,'Female','2025-09-22 16:56:36','2025-09-22 16:56:36');
/*!40000 ALTER TABLE `Riders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-23  1:06:18
