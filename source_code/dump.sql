-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: crypto
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.23.10.1

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
-- Current Database: `crypto`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `crypto` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `crypto`;

--
-- Table structure for table `Coin_Details`
--

DROP TABLE IF EXISTS `Coin_Details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Coin_Details` (
  `Coin_Name` varchar(255) NOT NULL,
  `All_Time_High` int DEFAULT NULL,
  `Market_Cap` int DEFAULT NULL,
  PRIMARY KEY (`Coin_Name`),
  CONSTRAINT `FK_Coin_Details_Coin_Name` FOREIGN KEY (`Coin_Name`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Coin_Details`
--

LOCK TABLES `Coin_Details` WRITE;
/*!40000 ALTER TABLE `Coin_Details` DISABLE KEYS */;
INSERT INTO `Coin_Details` VALUES ('Binance Coin',320,50000000),('Bitcoin',60000,950000000),('Ethereum',4200,450000000),('Litecoin',300,8000000),('Ripple',1,280000000);
/*!40000 ALTER TABLE `Coin_Details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Coin_Types_Wallet`
--

DROP TABLE IF EXISTS `Coin_Types_Wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Coin_Types_Wallet` (
  `Wallet_Address` varchar(255) NOT NULL,
  `coin` varchar(255) NOT NULL,
  PRIMARY KEY (`coin`,`Wallet_Address`),
  KEY `FK_Coin_Types_Wallet_Wallet_Address` (`Wallet_Address`),
  CONSTRAINT `FK_Coin_Types_Wallet_Coin` FOREIGN KEY (`coin`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE,
  CONSTRAINT `FK_Coin_Types_Wallet_Wallet_Address` FOREIGN KEY (`Wallet_Address`) REFERENCES `Wallet` (`Wallet_Address`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Coin_Types_Wallet`
--

LOCK TABLES `Coin_Types_Wallet` WRITE;
/*!40000 ALTER TABLE `Coin_Types_Wallet` DISABLE KEYS */;
INSERT INTO `Coin_Types_Wallet` VALUES ('oD6vU1sQ8y','Bitcoin'),('oD6vU1sQ8y','Ripple'),('pN7iX2jV9f','Ethereum'),('rK2xP7tE4z','Binance Coin'),('rK2xP7tE4z','Litecoin'),('uG6oZ4lT3k','Bitcoin'),('uG6oZ4lT3k','Ethereum'),('uG6oZ4lT3k','Litecoin');
/*!40000 ALTER TABLE `Coin_Types_Wallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Crypto_Exchange`
--

DROP TABLE IF EXISTS `Crypto_Exchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Crypto_Exchange` (
  `Exchange_ID` int NOT NULL AUTO_INCREMENT,
  `Exchange_Name` varchar(255) DEFAULT NULL,
  `Website_URL` varchar(255) DEFAULT NULL,
  `Flat_Currency` tinyint(1) DEFAULT NULL,
  `Rating` float DEFAULT NULL,
  PRIMARY KEY (`Exchange_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Crypto_Exchange`
--

LOCK TABLES `Crypto_Exchange` WRITE;
/*!40000 ALTER TABLE `Crypto_Exchange` DISABLE KEYS */;
INSERT INTO `Crypto_Exchange` VALUES (1,'Binance','https://www.binance.com/',1,4.5),(2,'Coinbase','https://www.coinbase.com/',1,4.8),(3,'Kraken','https://www.kraken.com/',1,4.2),(4,'Gemini','https://gemini.com/',1,4),(5,'Bitstamp','https://www.bitstamp.net/',1,3.8);
/*!40000 ALTER TABLE `Crypto_Exchange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Crypto_User`
--

DROP TABLE IF EXISTS `Crypto_User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Crypto_User` (
  `User_id` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) DEFAULT NULL,
  `Avatar` blob,
  `Mail_Address` varchar(255) DEFAULT NULL,
  `Creation_Time` timestamp NULL DEFAULT NULL,
  `No_of_Wallets` int DEFAULT NULL,
  PRIMARY KEY (`User_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Crypto_User`
--

LOCK TABLES `Crypto_User` WRITE;
/*!40000 ALTER TABLE `Crypto_User` DISABLE KEYS */;
INSERT INTO `Crypto_User` VALUES (1,'user1',NULL,'user1@example.com','2023-12-02 23:45:23',2),(2,'bunny',NULL,'user2@example.com','2023-12-02 23:45:23',1),(3,'user3',NULL,'user3@example.com','2023-12-02 23:45:23',1),(4,'user4',NULL,'user4@example.com','2023-12-02 23:45:23',0),(5,'user5',NULL,'user5@example.com','2023-12-02 23:45:23',0);
/*!40000 ALTER TABLE `Crypto_User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cryptocoin`
--

DROP TABLE IF EXISTS `Cryptocoin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cryptocoin` (
  `Coin_Name` varchar(255) NOT NULL,
  `Abbreviation` varchar(255) DEFAULT NULL,
  `Current_Price` float DEFAULT NULL,
  `Symbol` blob,
  `Total_Supply` int DEFAULT NULL,
  `Avg_Conversion_Rate` int DEFAULT NULL,
  `Website_URL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Coin_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cryptocoin`
--

LOCK TABLES `Cryptocoin` WRITE;
/*!40000 ALTER TABLE `Cryptocoin` DISABLE KEYS */;
INSERT INTO `Cryptocoin` VALUES ('Binance Coin','BNB',300,NULL,170000000,290,'https://www.binance.com/'),('Bitcoin','BTC',900001,NULL,21000000,49000,'https://bitcoin.org/'),('Ethereum','ETH',4000,NULL,115000000,3900,'https://ethereum.org/'),('Litecoin','LTC',150,NULL,84000000,140,'https://litecoin.org/'),('Ripple','XRP',0.75,NULL,4500000,1,'https://ripple.com/');
/*!40000 ALTER TABLE `Cryptocoin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Invest_Coins`
--

DROP TABLE IF EXISTS `Invest_Coins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Invest_Coins` (
  `coin` varchar(255) NOT NULL,
  `Time_Stamp` timestamp NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`coin`,`Time_Stamp`),
  KEY `FK_Invest_Coins_User_id` (`user_id`),
  CONSTRAINT `FK_Invest_Coins_User_id` FOREIGN KEY (`user_id`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Invest_Coins`
--

LOCK TABLES `Invest_Coins` WRITE;
/*!40000 ALTER TABLE `Invest_Coins` DISABLE KEYS */;
INSERT INTO `Invest_Coins` VALUES ('Bitcoin','2023-12-02 23:45:23',1),('Ethereum','2023-12-02 23:45:23',2),('Binance Coin','2023-12-02 23:45:23',3),('Ripple','2023-12-02 23:45:23',4),('Litecoin','2023-12-02 23:45:23',5);
/*!40000 ALTER TABLE `Invest_Coins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MUC_User`
--

DROP TABLE IF EXISTS `MUC_User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MUC_User` (
  `coin` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`coin`,`user_id`),
  KEY `FK_MUC_User_User_id` (`user_id`),
  CONSTRAINT `FK_MUC_User_Coin` FOREIGN KEY (`coin`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE,
  CONSTRAINT `FK_MUC_User_User_id` FOREIGN KEY (`user_id`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MUC_User`
--

LOCK TABLES `MUC_User` WRITE;
/*!40000 ALTER TABLE `MUC_User` DISABLE KEYS */;
INSERT INTO `MUC_User` VALUES ('Bitcoin',1),('Ethereum',2),('Binance Coin',3),('Ripple',4),('Litecoin',5);
/*!40000 ALTER TABLE `MUC_User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mining_Machine`
--

DROP TABLE IF EXISTS `Mining_Machine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mining_Machine` (
  `Machine_ID` int NOT NULL AUTO_INCREMENT,
  `Coordinates_Latitude` float DEFAULT NULL,
  `Coordinates_Longitude` float DEFAULT NULL,
  `Model` varchar(255) DEFAULT NULL,
  `Operational_Time` int DEFAULT NULL,
  `Operating_Status` enum('Active','Inactive','Zombie') DEFAULT NULL,
  `Associated_Wallet` varchar(255) DEFAULT NULL,
  `owner_machine` int DEFAULT NULL,
  PRIMARY KEY (`Machine_ID`),
  KEY `FK_Mining_Machine_Model` (`Model`),
  KEY `FK_Mining_Machine_owner_machine` (`owner_machine`),
  CONSTRAINT `FK_Mining_Machine_Model` FOREIGN KEY (`Model`) REFERENCES `Model_MM` (`Model`) ON DELETE CASCADE,
  CONSTRAINT `FK_Mining_Machine_owner_machine` FOREIGN KEY (`owner_machine`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mining_Machine`
--

LOCK TABLES `Mining_Machine` WRITE;
/*!40000 ALTER TABLE `Mining_Machine` DISABLE KEYS */;
INSERT INTO `Mining_Machine` VALUES (1,37.7749,-122.419,'Antminer S19',600,'Active','uG6oZ4lT3k',1),(2,40.7128,-74.006,'AvalonMiner 1246',480,'Inactive','pN7iX2jV9f',2),(3,34.0522,-118.244,'ASIC Miner X8',720,'Active','rK2xP7tE4z',3),(4,41.8781,-87.6298,'GPU Miner 3070',540,'Inactive','oD6vU1sQ8y',4),(5,51.5099,-0.1337,'ASIC Miner Z11',660,'Active','mX5lV2nR4u',5),(6,90.2,98.2,'ASIC Miner X8',12,'Active','mX5lV2nR4u',4);
/*!40000 ALTER TABLE `Mining_Machine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Model_MM`
--

DROP TABLE IF EXISTS `Model_MM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Model_MM` (
  `Model` varchar(255) NOT NULL,
  `Energy_Consumption` float DEFAULT NULL,
  `Computational_Power` float DEFAULT NULL,
  PRIMARY KEY (`Model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Model_MM`
--

LOCK TABLES `Model_MM` WRITE;
/*!40000 ALTER TABLE `Model_MM` DISABLE KEYS */;
INSERT INTO `Model_MM` VALUES ('Antminer S19',1500,100),('ASIC Miner X8',1800,120),('ASIC Miner Z11',1600,110),('AvalonMiner 1246',1200,80),('GPU Miner 3070',900,60);
/*!40000 ALTER TABLE `Model_MM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NFT_Creator`
--

DROP TABLE IF EXISTS `NFT_Creator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NFT_Creator` (
  `creator_id` int NOT NULL,
  `royalty` float DEFAULT NULL,
  PRIMARY KEY (`creator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NFT_Creator`
--

LOCK TABLES `NFT_Creator` WRITE;
/*!40000 ALTER TABLE `NFT_Creator` DISABLE KEYS */;
INSERT INTO `NFT_Creator` VALUES (1,0.05),(2,0.08),(3,0.1),(4,0.07),(5,0.12);
/*!40000 ALTER TABLE `NFT_Creator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NFT_Token`
--

DROP TABLE IF EXISTS `NFT_Token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NFT_Token` (
  `Token_ID` varchar(255) NOT NULL,
  `Date_of_Creation` timestamp NULL DEFAULT NULL,
  `Current_Owner` int DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Creator` int DEFAULT NULL,
  `Token_Rating` float DEFAULT NULL,
  PRIMARY KEY (`Token_ID`),
  KEY `FK_NFT_Token_Creator2` (`Creator`),
  KEY `FK_NFT_Token_Current_Owner` (`Current_Owner`),
  CONSTRAINT `FK_NFT_Token_Creator` FOREIGN KEY (`Creator`) REFERENCES `NFT_Creator` (`creator_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_NFT_Token_Creator2` FOREIGN KEY (`Creator`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_NFT_Token_Current_Owner` FOREIGN KEY (`Current_Owner`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NFT_Token`
--

LOCK TABLES `NFT_Token` WRITE;
/*!40000 ALTER TABLE `NFT_Token` DISABLE KEYS */;
INSERT INTO `NFT_Token` VALUES ('bU7sQ2rM4g','2023-12-02 23:45:23',2,'Collectible Card',1,4.5),('fJ2mR9kN8l','2023-12-02 23:45:23',1,'Virtual Real Estate',4,3.8),('gE4wK1yV8b','2023-12-02 23:45:23',2,'Interactive NFT Game',2,4.3),('iW3pL6aX9o','2023-12-02 23:45:23',1,'Digital Artwork',4,4.2),('nR3vU7pM2o','2023-12-02 23:45:23',3,'NFT Music Album',5,4);
/*!40000 ALTER TABLE `NFT_Token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Price_Data`
--

DROP TABLE IF EXISTS `Price_Data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Price_Data` (
  `coin` varchar(255) NOT NULL,
  `Time_Stamp` timestamp NOT NULL,
  `Price_at_That_Time` float DEFAULT NULL,
  `Percentage_in_ATH` float DEFAULT NULL,
  PRIMARY KEY (`coin`,`Time_Stamp`),
  CONSTRAINT `FK_Price_Data_coin` FOREIGN KEY (`coin`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE,
  CONSTRAINT `FK_Price_Data_coin_Time_Stamp` FOREIGN KEY (`coin`, `Time_Stamp`) REFERENCES `Invest_Coins` (`coin`, `Time_Stamp`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Price_Data`
--

LOCK TABLES `Price_Data` WRITE;
/*!40000 ALTER TABLE `Price_Data` DISABLE KEYS */;
INSERT INTO `Price_Data` VALUES ('Binance Coin','2023-12-02 23:45:23',300,2),('Bitcoin','2023-12-02 23:45:23',50000,5),('Ethereum','2023-12-02 23:45:23',4000,3),('Litecoin','2023-12-02 23:45:23',150,8),('Ripple','2023-12-02 23:45:23',0.75,10);
/*!40000 ALTER TABLE `Price_Data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Supported_Coins`
--

DROP TABLE IF EXISTS `Supported_Coins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Supported_Coins` (
  `coin` varchar(255) NOT NULL,
  `Exchange_ID` int NOT NULL,
  PRIMARY KEY (`coin`,`Exchange_ID`),
  KEY `FK_Supported_Coins_Exchange_ID` (`Exchange_ID`),
  CONSTRAINT `FK_Supported_Coins_Coin` FOREIGN KEY (`coin`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE,
  CONSTRAINT `FK_Supported_Coins_Exchange_ID` FOREIGN KEY (`Exchange_ID`) REFERENCES `Crypto_Exchange` (`Exchange_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supported_Coins`
--

LOCK TABLES `Supported_Coins` WRITE;
/*!40000 ALTER TABLE `Supported_Coins` DISABLE KEYS */;
INSERT INTO `Supported_Coins` VALUES ('Bitcoin',1),('Ethereum',2),('Binance Coin',3),('Ripple',4),('Litecoin',5);
/*!40000 ALTER TABLE `Supported_Coins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Trading_Pairs`
--

DROP TABLE IF EXISTS `Trading_Pairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Trading_Pairs` (
  `Cryptocoin_1` varchar(255) NOT NULL,
  `Cryptocoin_2` varchar(255) NOT NULL,
  `Conversion_Fee` float DEFAULT NULL,
  `Exchange_Ratio` float DEFAULT NULL,
  `Crypto_Exchange_ID` int NOT NULL,
  PRIMARY KEY (`Cryptocoin_1`,`Cryptocoin_2`,`Crypto_Exchange_ID`),
  KEY `FK_Trading_Pairs_Crypto_Exchange_ID` (`Crypto_Exchange_ID`),
  KEY `FK_Trading_Pairs_Cryptocoin_2` (`Cryptocoin_2`),
  CONSTRAINT `FK_Trading_Pairs_Crypto_Exchange_ID` FOREIGN KEY (`Crypto_Exchange_ID`) REFERENCES `Crypto_Exchange` (`Exchange_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Trading_Pairs_Cryptocoin_1` FOREIGN KEY (`Cryptocoin_1`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE,
  CONSTRAINT `FK_Trading_Pairs_Cryptocoin_2` FOREIGN KEY (`Cryptocoin_2`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Trading_Pairs`
--

LOCK TABLES `Trading_Pairs` WRITE;
/*!40000 ALTER TABLE `Trading_Pairs` DISABLE KEYS */;
INSERT INTO `Trading_Pairs` VALUES ('Binance Coin','Ripple',0.03,8,3),('Bitcoin','Ethereum',0.02,13,1),('Bitcoin','Ethereum',0.02,7,2),('Ethereum','Binance Coin',0.01,15,2),('Litecoin','Bitcoin',0.01,18,5),('Ripple','Litecoin',0.02,12,4);
/*!40000 ALTER TABLE `Trading_Pairs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transaction`
--

DROP TABLE IF EXISTS `Transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transaction` (
  `Hash_Value` varchar(255) NOT NULL,
  `Exchanged_Cryptocoin_name` varchar(255) DEFAULT NULL,
  `Sender_Wallet` varchar(255) DEFAULT NULL,
  `Receiver_Wallet` varchar(255) DEFAULT NULL,
  `Transacted_Amount` int DEFAULT NULL,
  `Time_Stamp` timestamp NULL DEFAULT NULL,
  `Involved_MM` int DEFAULT NULL,
  PRIMARY KEY (`Hash_Value`),
  KEY `FK_Transaction_Exchanged_Cryptocoin_name` (`Exchanged_Cryptocoin_name`),
  KEY `FK_Transaction_Sender_Wallet` (`Sender_Wallet`),
  KEY `FK_Transaction_Receiver_Wallet` (`Receiver_Wallet`),
  KEY `FK_Transaction_Involved_MM` (`Involved_MM`),
  CONSTRAINT `FK_Transaction_Exchanged_Cryptocoin_name` FOREIGN KEY (`Exchanged_Cryptocoin_name`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE SET NULL,
  CONSTRAINT `FK_Transaction_Hash_Value` FOREIGN KEY (`Hash_Value`) REFERENCES `Transaction_Users` (`Transaction_Hash`),
  CONSTRAINT `FK_Transaction_Involved_MM` FOREIGN KEY (`Involved_MM`) REFERENCES `Mining_Machine` (`Machine_ID`) ON DELETE SET NULL,
  CONSTRAINT `FK_Transaction_Receiver_Wallet` FOREIGN KEY (`Receiver_Wallet`) REFERENCES `Wallet` (`Wallet_Address`) ON DELETE SET NULL,
  CONSTRAINT `FK_Transaction_Sender_Wallet` FOREIGN KEY (`Sender_Wallet`) REFERENCES `Wallet` (`Wallet_Address`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction`
--

LOCK TABLES `Transaction` WRITE;
/*!40000 ALTER TABLE `Transaction` DISABLE KEYS */;
INSERT INTO `Transaction` VALUES ('iS3hY9tC6v','Binance Coin','rK2xP7tE4z','oD6vU1sQ8y',100,'2023-12-02 23:45:23',3),('qU6yZ4vH3j','Ripple','oD6vU1sQ8y',NULL,20,'2023-12-02 23:45:23',4),('sN6kV2cF9g','Bitcoin','uG6oZ4lT3k','pN7iX2jV9f',200,'2023-12-02 23:45:23',1),('tK1oV4mH8z','Ethereum','pN7iX2jV9f','uG6oZ4lT3k',50,'2023-12-02 23:45:23',2),('zJ7xN1bR5l','Litecoin',NULL,'uG6oZ4lT3k',80,'2023-12-02 23:45:23',5);
/*!40000 ALTER TABLE `Transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transaction_Users`
--

DROP TABLE IF EXISTS `Transaction_Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transaction_Users` (
  `Transaction_Hash` varchar(255) NOT NULL,
  `Inv_CrypCoin` varchar(255) DEFAULT NULL,
  `sender_id` int DEFAULT NULL,
  `receiver_id` int DEFAULT NULL,
  PRIMARY KEY (`Transaction_Hash`),
  KEY `FK_Transaction_Users_Inv_CrypCoin` (`Inv_CrypCoin`),
  KEY `FK_Transaction_Users_Sender_id` (`sender_id`),
  KEY `FK_Transaction_Users_Receiver_id` (`receiver_id`),
  CONSTRAINT `FK_Transaction_Users_Inv_CrypCoin` FOREIGN KEY (`Inv_CrypCoin`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE,
  CONSTRAINT `FK_Transaction_Users_Receiver_id` FOREIGN KEY (`receiver_id`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Transaction_Users_Sender_id` FOREIGN KEY (`sender_id`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction_Users`
--

LOCK TABLES `Transaction_Users` WRITE;
/*!40000 ALTER TABLE `Transaction_Users` DISABLE KEYS */;
INSERT INTO `Transaction_Users` VALUES ('iS3hY9tC6v','Binance Coin',3,4),('qU6yZ4vH3j','Ripple',4,5),('sN6kV2cF9g','Bitcoin',1,2),('tK1oV4mH8z','Ethereum',2,1),('zJ7xN1bR5l','Litecoin',5,1);
/*!40000 ALTER TABLE `Transaction_Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_Activity_Log`
--

DROP TABLE IF EXISTS `User_Activity_Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Activity_Log` (
  `Wallet_Used` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `Transacted_Amount` float DEFAULT NULL,
  `Price_Data_Time_Stamp` timestamp NULL DEFAULT NULL,
  `transaction_type` enum('Credit','Debit') DEFAULT NULL,
  KEY `FK_User_Activity_Log_user_id` (`user_id`),
  KEY `FK_User_Activity_Log_Wallet_Used` (`Wallet_Used`),
  CONSTRAINT `FK_User_Activity_Log_user_id` FOREIGN KEY (`user_id`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_User_Activity_Log_Wallet_Used` FOREIGN KEY (`Wallet_Used`) REFERENCES `Wallet` (`Wallet_Address`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Activity_Log`
--

LOCK TABLES `User_Activity_Log` WRITE;
/*!40000 ALTER TABLE `User_Activity_Log` DISABLE KEYS */;
INSERT INTO `User_Activity_Log` VALUES ('uG6oZ4lT3k',1,500,'2023-12-02 23:45:23','Credit'),('pN7iX2jV9f',2,200,'2023-12-02 23:45:23','Credit'),('uG6oZ4lT3k',1,300,'2023-12-02 23:45:23','Debit'),('rK2xP7tE4z',3,1000,'2023-12-02 23:45:23','Credit'),('oD6vU1sQ8y',4,400,'2023-12-02 23:45:23','Debit');
/*!40000 ALTER TABLE `User_Activity_Log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Wallet`
--

DROP TABLE IF EXISTS `Wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Wallet` (
  `Wallet_Address` varchar(255) NOT NULL,
  `Balance` float DEFAULT NULL,
  `Public_Key` varchar(255) DEFAULT NULL,
  `Creation_Time` timestamp NULL DEFAULT NULL,
  `owner_wallet` int DEFAULT NULL,
  `Security_Feature` enum('Timelock','Multi-factor','Biometric','Authenticator') DEFAULT NULL,
  `Wallet_Status` enum('Active','Inactive','Hold') DEFAULT NULL,
  PRIMARY KEY (`Wallet_Address`),
  KEY `FK_Wallet_owner_wallet` (`owner_wallet`),
  CONSTRAINT `FK_Wallet_owner_wallet` FOREIGN KEY (`owner_wallet`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Wallet`
--

LOCK TABLES `Wallet` WRITE;
/*!40000 ALTER TABLE `Wallet` DISABLE KEYS */;
INSERT INTO `Wallet` VALUES ('oD6vU1sQ8y',8000,'sH9yV7jL6z','2023-12-02 23:45:23',3,'Multi-factor','Active'),('pN7iX2jV9f',5000,'uN3vE7iW1l','2023-12-02 23:45:23',1,'Timelock','Active'),('rK2xP7tE4z',2000,'aX5sG1wY9q','2023-12-02 23:45:23',2,'Biometric','Active'),('uG6oZ4lT3k',10000,'mQ8tL4yZ9a','2023-12-02 23:45:23',1,'Multi-factor','Active');
/*!40000 ALTER TABLE `Wallet` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-03  5:37:28
