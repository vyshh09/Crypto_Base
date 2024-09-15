DROP DATABASE crypto;
CREATE DATABASE crypto;
USE crypto;
CREATE TABLE `Cryptocoin` (
  `Coin_Name` varchar(255) PRIMARY KEY,
  `Abbreviation` varchar(255),
  `Current_Price` float,
  `Symbol` BLOB,
  `Total_Supply` integer,
  `Avg_Conversion_Rate` integer,
  `Website_URL` varchar(255)
);

CREATE TABLE `Coin_Details` (
  `Coin_Name` varchar(255) PRIMARY KEY,
  `All_Time_High` integer,
  `Market_Cap` integer
);

CREATE TABLE `Transaction` (
  `Hash_Value` varchar(255) PRIMARY KEY,
  `Exchanged_Cryptocoin_name` varchar(255),
  `Sender_Wallet` varchar(255),
  `Receiver_Wallet` varchar(255),
  `Transacted_Amount` integer,
  `Time_Stamp` timestamp,
  `Involved_MM` integer
);

CREATE TABLE `Crypto_User` (
  `User_id` integer PRIMARY KEY AUTO_INCREMENT,
  `Username` varchar(255),
  `Avatar` BLOB,
  `Mail_Address` varchar(255),
  `Creation_Time` timestamp,
  `No_of_Wallets` integer
);

CREATE TABLE `Mining_Machine` (
  `Machine_ID` integer PRIMARY KEY AUTO_INCREMENT,
  `Coordinates_Latitude` float,
  `Coordinates_Longitude` float,
  `Model` varchar(255),
  `Operational_Time` integer,
  `Operating_Status` ENUM('Active', 'Inactive', 'Zombie'),
  `Associated_Wallet` varchar(255),
  `owner_machine` integer
);

CREATE TABLE `Model_MM` (
  `Model` varchar(255) PRIMARY KEY,
  `Energy_Consumption` float,
  `Computational_Power` float
);

CREATE TABLE `Crypto_Exchange` (
  `Exchange_ID` integer PRIMARY KEY AUTO_INCREMENT,
  `Exchange_Name` varchar(255),
  `Website_URL` varchar(255),
  `Flat_Currency` Boolean,
  `Rating` float
);

CREATE TABLE `NFT_Token` (
  `Token_ID` varchar(255) PRIMARY KEY,
  `Date_of_Creation` timestamp,
  `Current_Owner` integer,
  `Description` varchar(255),
  `Creator` integer,
  `Token_Rating` float
);

CREATE TABLE `NFT_Creator` (
  `creator_id` integer PRIMARY KEY,
  `royalty` float
);

CREATE TABLE `Wallet` (
  `Wallet_Address` varchar(255) PRIMARY KEY,
  `Balance` float,
  `Public_Key` varchar(255),
  `Creation_Time` timestamp,
  `owner_wallet` integer,
  `Security_Feature` ENUM("Timelock", "Multi-factor", "Biometric", "Authenticator"),
  `Wallet_Status` ENUM("Active", "Inactive", "Hold")
);

CREATE TABLE `User_Activity_Log` (
  `Wallet_Used` varchar(255),
  `user_id` integer,
  `Transacted_Amount` float,
  `Price_Data_Time_Stamp` timestamp,
  `transaction_type` ENUM("Credit", "Debit")
);

CREATE TABLE `Price_Data` (
  `coin` varchar(255),
  `Time_Stamp` timestamp,
  `Price_at_That_Time` float,
  `Percentage_in_ATH` float,
  PRIMARY KEY (`coin`, `Time_Stamp`)
);

CREATE TABLE `Trading_Pairs` (
  `Cryptocoin_1` varchar(255),
  `Cryptocoin_2` varchar(255),
  `Conversion_Fee` float,
  `Exchange_Ratio` float,
  `Crypto_Exchange_ID` integer,
  PRIMARY KEY (`Cryptocoin_1`, `Cryptocoin_2`, `Crypto_Exchange_ID`)
);

CREATE TABLE `Transaction_Users` (
  `Transaction_Hash` varchar(255) PRIMARY KEY,
  `Inv_CrypCoin` varchar(255),
  `sender_id` integer,
  `receiver_id` integer
);

CREATE TABLE `Invest_Coins` (
  `coin` varchar(255),
  `Time_Stamp` timestamp,
  `user_id` integer,
  PRIMARY KEY (`coin`, `Time_Stamp`)
);

CREATE TABLE `Coin_Types_Wallet` (
  `Wallet_Address` varchar(255),
  `coin` varchar(255),
  PRIMARY KEY (`coin`, `Wallet_Address`)
);

CREATE TABLE `MUC_User` (
  `coin` varchar(255),
  `user_id` integer,
  PRIMARY KEY (`coin`, `user_id`)
);

CREATE TABLE `Supported_Coins` (
  `coin` varchar(255),
  `Exchange_ID` integer,
  PRIMARY KEY (`coin`, `Exchange_ID`)
);

-- Modify each foreign key to include explicit CONSTRAINT with ON DELETE CASCADE
ALTER TABLE `Mining_Machine` ADD CONSTRAINT `FK_Mining_Machine_Model` FOREIGN KEY (`Model`) REFERENCES `Model_MM` (`Model`) ON DELETE CASCADE;

ALTER TABLE `NFT_Token` ADD CONSTRAINT `FK_NFT_Token_Creator` FOREIGN KEY (`Creator`) REFERENCES `NFT_Creator` (`creator_id`) ON DELETE CASCADE;

ALTER TABLE `Coin_Details` ADD CONSTRAINT `FK_Coin_Details_Coin_Name` FOREIGN KEY (`Coin_Name`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE;

ALTER TABLE `Supported_Coins` ADD CONSTRAINT `FK_Supported_Coins_Coin` FOREIGN KEY (`coin`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE;

ALTER TABLE `Supported_Coins` ADD CONSTRAINT `FK_Supported_Coins_Exchange_ID` FOREIGN KEY (`Exchange_ID`) REFERENCES `Crypto_Exchange` (`Exchange_ID`) ON DELETE CASCADE;

ALTER TABLE `MUC_User` ADD CONSTRAINT `FK_MUC_User_Coin` FOREIGN KEY (`coin`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE;

ALTER TABLE `MUC_User` ADD CONSTRAINT `FK_MUC_User_User_id` FOREIGN KEY (`user_id`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE;

ALTER TABLE `Coin_Types_Wallet` ADD CONSTRAINT `FK_Coin_Types_Wallet_Coin` FOREIGN KEY (`coin`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE;

ALTER TABLE `Coin_Types_Wallet` ADD CONSTRAINT `FK_Coin_Types_Wallet_Wallet_Address` FOREIGN KEY (`Wallet_Address`) REFERENCES `Wallet` (`Wallet_Address`) ON DELETE CASCADE;

ALTER TABLE `Invest_Coins` ADD CONSTRAINT `FK_Invest_Coins_User_id` FOREIGN KEY (`user_id`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE;

ALTER TABLE `Transaction` ADD CONSTRAINT `FK_Transaction_Hash_Value` FOREIGN KEY (`Hash_Value`) REFERENCES `Transaction_Users` (`Transaction_Hash`);

ALTER TABLE `Transaction_Users` ADD CONSTRAINT `FK_Transaction_Users_Inv_CrypCoin` FOREIGN KEY (`Inv_CrypCoin`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE;

ALTER TABLE `Transaction_Users` ADD CONSTRAINT `FK_Transaction_Users_Sender_id` FOREIGN KEY (`sender_id`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE;

ALTER TABLE `Transaction_Users` ADD CONSTRAINT `FK_Transaction_Users_Receiver_id` FOREIGN KEY (`receiver_id`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE;

ALTER TABLE `Price_Data` ADD CONSTRAINT `FK_Price_Data_coin_Time_Stamp` FOREIGN KEY (`coin`, `Time_Stamp`) REFERENCES `Invest_Coins` (`coin`, `Time_Stamp`) ON DELETE CASCADE;

ALTER TABLE `User_Activity_Log` ADD CONSTRAINT `FK_User_Activity_Log_user_id` FOREIGN KEY (`user_id`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE;

ALTER TABLE `Transaction` ADD CONSTRAINT `FK_Transaction_Exchanged_Cryptocoin_name` FOREIGN KEY (`Exchanged_Cryptocoin_name`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE SET NULL;

ALTER TABLE `Transaction` ADD CONSTRAINT `FK_Transaction_Sender_Wallet` FOREIGN KEY (`Sender_Wallet`) REFERENCES `Wallet` (`Wallet_Address`) ON DELETE SET NULL;

ALTER TABLE `Transaction` ADD CONSTRAINT `FK_Transaction_Receiver_Wallet` FOREIGN KEY (`Receiver_Wallet`) REFERENCES `Wallet` (`Wallet_Address`) ON DELETE SET NULL;

ALTER TABLE `Wallet` ADD CONSTRAINT `FK_Wallet_owner_wallet` FOREIGN KEY (`owner_wallet`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE;

ALTER TABLE `Mining_Machine` ADD CONSTRAINT `FK_Mining_Machine_owner_machine` FOREIGN KEY (`owner_machine`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE;

ALTER TABLE `User_Activity_Log` ADD CONSTRAINT `FK_User_Activity_Log_Wallet_Used` FOREIGN KEY (`Wallet_Used`) REFERENCES `Wallet` (`Wallet_Address`) ON DELETE CASCADE;

ALTER TABLE `Trading_Pairs` ADD CONSTRAINT `FK_Trading_Pairs_Crypto_Exchange_ID` FOREIGN KEY (`Crypto_Exchange_ID`) REFERENCES `Crypto_Exchange` (`Exchange_ID`) ON DELETE CASCADE;

ALTER TABLE `Trading_Pairs` ADD CONSTRAINT `FK_Trading_Pairs_Cryptocoin_1` FOREIGN KEY (`Cryptocoin_1`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE;

ALTER TABLE `Trading_Pairs` ADD CONSTRAINT `FK_Trading_Pairs_Cryptocoin_2` FOREIGN KEY (`Cryptocoin_2`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE;

ALTER TABLE `Price_Data` ADD CONSTRAINT `FK_Price_Data_coin` FOREIGN KEY (`coin`) REFERENCES `Cryptocoin` (`Coin_Name`) ON DELETE CASCADE;

ALTER TABLE `NFT_Token` ADD CONSTRAINT `FK_NFT_Token_Creator2` FOREIGN KEY (`Creator`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE;

ALTER TABLE `NFT_Token` ADD CONSTRAINT `FK_NFT_Token_Current_Owner` FOREIGN KEY (`Current_Owner`) REFERENCES `Crypto_User` (`User_id`) ON DELETE CASCADE;

ALTER TABLE `Transaction` ADD CONSTRAINT `FK_Transaction_Involved_MM` FOREIGN KEY (`Involved_MM`) REFERENCES `Mining_Machine` (`Machine_ID`) ON DELETE SET NULL;




-- Populate Model_MM table
INSERT INTO Model_MM (Model, Energy_Consumption, Computational_Power)
VALUES
  ('Antminer S19', 1500, 100),
  ('AvalonMiner 1246', 1200, 80),
  ('ASIC Miner X8', 1800, 120),
  ('GPU Miner 3070', 900, 60),
  ('ASIC Miner Z11', 1600, 110);

-- Populate Crypto_Exchange table
INSERT INTO Crypto_Exchange (Exchange_ID, Exchange_Name, Website_URL, Flat_Currency, Rating)
VALUES
  (1, 'Binance', 'https://www.binance.com/', TRUE, 4.5),
  (2, 'Coinbase', 'https://www.coinbase.com/', TRUE, 4.8),
  (3, 'Kraken', 'https://www.kraken.com/', TRUE, 4.2),
  (4, 'Gemini', 'https://gemini.com/', TRUE, 4.0),
  (5, 'Bitstamp', 'https://www.bitstamp.net/', TRUE, 3.8);

-- Populate NFT_Creator table
INSERT INTO NFT_Creator (creator_id, royalty)
VALUES
  (1, 0.05),
  (2, 0.08),
  (3, 0.1),
  (4, 0.07),
  (5, 0.12);

-- Populate Crypto_User table
INSERT INTO Crypto_User (User_id, Username, Avatar, Mail_Address, Creation_Time, No_of_Wallets)
VALUES
  (1, 'user1', NULL, 'user1@example.com', NOW(), 2),
  (2, 'user2', NULL, 'user2@example.com', NOW(), 1),
  (3, 'user3', NULL, 'user3@example.com', NOW(), 1),
  (4, 'user4', NULL, 'user4@example.com', NOW(), 1),
  (5, 'user5', NULL, 'user5@example.com', NOW(), 0);

-- Populate Wallet table
INSERT INTO Wallet (Wallet_Address, Balance, Public_Key, Creation_Time, owner_wallet, Security_Feature, Wallet_Status)
VALUES
  ('uG6oZ4lT3k', 10000, 'mQ8tL4yZ9a', NOW(), 1, 'Multi-factor', 'Active'),
  ('pN7iX2jV9f', 5000, 'uN3vE7iW1l', NOW(), 1, 'Timelock', 'Active'),
  ('rK2xP7tE4z', 2000, 'aX5sG1wY9q', NOW(), 2, 'Biometric', 'Active'),
  ('oD6vU1sQ8y', 8000, 'sH9yV7jL6z', NOW(), 3, 'Multi-factor', 'Active'),
  ('mX5lV2nR4u', 3000, 'eC4gV9wX2z', NOW(), 4, 'Timelock', 'Active');

-- Populate Mining_Machine table
INSERT INTO Mining_Machine (Machine_ID, Coordinates_Latitude, Coordinates_Longitude, Model, Operational_Time, Operating_Status, Associated_Wallet, owner_machine)
VALUES
  (1, 37.7749, -122.4194, 'Antminer S19', 600, 'Active', 'uG6oZ4lT3k', 1),
  (2, 40.7128, -74.0060, 'AvalonMiner 1246', 480, 'Inactive', 'pN7iX2jV9f', 2),
  (3, 34.0522, -118.2437, 'ASIC Miner X8', 720, 'Active', 'rK2xP7tE4z', 3),
  (4, 41.8781, -87.6298, 'GPU Miner 3070', 540, 'Inactive', 'oD6vU1sQ8y', 4),
  (5, 51.5099, -0.1337, 'ASIC Miner Z11', 660, 'Active', 'mX5lV2nR4u', 5);

-- Now, Populate tables with dependencies

-- Populate Cryptocoin table
INSERT INTO Cryptocoin (Coin_Name, Abbreviation, Current_Price, Symbol, Total_Supply, Avg_Conversion_Rate, Website_URL)
VALUES
  ('Bitcoin', 'BTC', 50000, NULL, 21000000, 49000, 'https://bitcoin.org/'),
  ('Ethereum', 'ETH', 4000, NULL, 115000000, 3900, 'https://ethereum.org/'),
  ('Binance Coin', 'BNB', 300, NULL, 170000000, 290, 'https://www.binance.com/'),
  ('Ripple', 'XRP', 0.75, NULL, 4500000, 0.65, 'https://ripple.com/'),
  ('Litecoin', 'LTC', 150, NULL, 84000000, 140, 'https://litecoin.org/');

-- Populate Coin_Details table
INSERT INTO Coin_Details (Coin_Name, All_Time_High, Market_Cap)
VALUES
  ('Bitcoin', 60000, 950000000),
  ('Ethereum', 4200, 450000000),
  ('Binance Coin', 320, 50000000),
  ('Ripple', 1.2, 280000000),
  ('Litecoin', 300, 8000000);

-- Populate NFT_Token table
INSERT INTO NFT_Token (Token_ID, Date_of_Creation, Current_Owner, Description, Creator, Token_Rating)
VALUES
  ('iW3pL6aX9o', NOW(), 1, 'Digital Artwork', 4, 4.2),
  ('bU7sQ2rM4g', NOW(), 2, 'Collectible Card', 1, 4.5),
  ('fJ2mR9kN8l', NOW(), 1, 'Virtual Real Estate', 4, 3.8),
  ('nR3vU7pM2o', NOW(), 3, 'NFT Music Album', 5, 4.0),
  ('gE4wK1yV8b', NOW(), 2, 'Interactive NFT Game', 2, 4.3);

-- Populate User_Activity_Log table
INSERT INTO User_Activity_Log (Wallet_Used, user_id, Transacted_Amount, Price_Data_Time_Stamp, transaction_type)
VALUES
  ('uG6oZ4lT3k', 1, 500, NOW(), 'Credit'),
  ('pN7iX2jV9f', 2, 200, NOW(), 'Credit'),
  ('uG6oZ4lT3k', 1, 300, NOW(), 'Debit'),
  ('rK2xP7tE4z', 3, 1000, NOW(), 'Credit'),
  ('oD6vU1sQ8y', 4, 400, NOW(), 'Debit');

-- Populate Invest_Coins table
INSERT INTO Invest_Coins (coin, Time_Stamp, user_id)
VALUES
  ('Bitcoin', NOW(), 1),
  ('Ethereum', NOW(), 2),
  ('Binance Coin', NOW(), 3),
  ('Ripple', NOW(), 4),
  ('Litecoin', NOW(), 5);

-- Populate Price_Data table
INSERT INTO Price_Data (coin, Time_Stamp, Price_at_That_Time, Percentage_in_ATH)
VALUES
  ('Bitcoin', NOW(), 50000, 5.0),
  ('Ethereum', NOW(), 4000, 3.0),
  ('Binance Coin', NOW(), 300, 2.0),
  ('Ripple', NOW(), 0.75, 10.0),
  ('Litecoin', NOW(), 150, 8.0);

-- Populate Trading_Pairs table
INSERT INTO Trading_Pairs (Cryptocoin_1, Cryptocoin_2, Conversion_Fee, Exchange_Ratio, Crypto_Exchange_ID)
VALUES
  ('Bitcoin', 'Ethereum', 0.02, 13.0, 1),
  ('Ethereum', 'Binance Coin', 0.01, 15.0, 2),
  ('Binance Coin', 'Ripple', 0.03, 8.0, 3),
  ('Ripple', 'Litecoin', 0.02, 12.0, 4),
  ('Litecoin', 'Bitcoin', 0.01, 18.0, 5),
  ('Bitcoin', 'Ethereum', 0.02, 7.0, 2);

-- Populate Transaction_Users table
INSERT INTO Transaction_Users (Transaction_Hash, Inv_CrypCoin, sender_id, receiver_id)
VALUES
  ('sN6kV2cF9g', 'Bitcoin', 1, 2),
  ('tK1oV4mH8z', 'Ethereum', 2, 1),
  ('iS3hY9tC6v', 'Binance Coin', 3, 4),
  ('qU6yZ4vH3j', 'Ripple', 4, 5),
  ('zJ7xN1bR5l', 'Litecoin', 5, 1);

-- Populate Coin_Types_Wallet table
INSERT INTO Coin_Types_Wallet (Wallet_Address, coin)
VALUES
  ('uG6oZ4lT3k', 'Bitcoin'),
  ('uG6oZ4lT3k', 'Ethereum'),
  ('uG6oZ4lT3k', 'Litecoin'),
  ('pN7iX2jV9f', 'Ethereum'),
  ('rK2xP7tE4z', 'Binance Coin'),
  ('rK2xP7tE4z', 'Litecoin'),
  ('oD6vU1sQ8y', 'Ripple'),
  ('oD6vU1sQ8y', 'Bitcoin'),
  ('mX5lV2nR4u', 'Litecoin');

-- Populate MUC_User table
INSERT INTO MUC_User (coin, user_id)
VALUES
  ('Bitcoin', 1),
  ('Ethereum', 2),
  ('Binance Coin', 3),
  ('Ripple', 4),
  ('Litecoin', 5);

-- Populate Supported_Coins table
INSERT INTO Supported_Coins (coin, Exchange_ID)
VALUES
  ('Bitcoin', 1),
  ('Ethereum', 2),
  ('Binance Coin', 3),
  ('Ripple', 4),
  ('Litecoin', 5);

-- Populate Transaction table
INSERT INTO Transaction (Hash_Value, Exchanged_Cryptocoin_name, Sender_Wallet, Receiver_Wallet, Transacted_Amount, Time_Stamp, Involved_MM)
VALUES
  ('sN6kV2cF9g', 'Bitcoin', 'uG6oZ4lT3k', 'pN7iX2jV9f', 200, NOW(), 1),
  ('tK1oV4mH8z', 'Ethereum', 'pN7iX2jV9f', 'uG6oZ4lT3k', 50, NOW(), 2),
  ('iS3hY9tC6v', 'Binance Coin', 'rK2xP7tE4z', 'oD6vU1sQ8y', 100, NOW(), 3),
  ('qU6yZ4vH3j', 'Ripple', 'oD6vU1sQ8y', 'mX5lV2nR4u', 20, NOW(), 4),
  ('zJ7xN1bR5l', 'Litecoin', 'mX5lV2nR4u', 'uG6oZ4lT3k', 80, NOW(), 5);
