CREATE DATABASE CSCI387Group5;

USE CSCI387Group5;

CREATE TABLE Settings (
    SettingsID INT AUTO_INCREMENT PRIMARY KEY
    -- Add other settings fields here if needed
);

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    SettingsID INT,
    Username VARCHAR(30) NOT NULL UNIQUE,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Bio VARCHAR(255),
    ProfilePhoto VARCHAR(255),
    Location VARCHAR(100),
    ReviewScore FLOAT DEFAULT 0,
    ReviewAmount FLOAT DEFAULT 0,
    JoinDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    IsAdmin BOOLEAN DEFAULT FALSE,
    IsSeller BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (SettingsID) REFERENCES Settings(SettingsID)
);

CREATE TABLE Listings (
    ListingID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Name VARCHAR(30) NOT NULL,
    Description VARCHAR(255),
    Image VARCHAR(255),
    Price FLOAT NOT NULL,
    Location VARCHAR(100),
    Latitude FLOAT,
    Longitude FLOAT,
    DateCreated DATETIME DEFAULT CURRENT_TIMESTAMP,
    ExpirationDate TIMESTAMP,
    IsSold BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Offers (
    OfferID INT AUTO_INCREMENT PRIMARY KEY,
    ListingID INT,
    SellerID INT,
    BuyerID INT,
    OfferAmount INT NOT NULL,
    FOREIGN KEY (ListingID) REFERENCES Listings(ListingID),
    FOREIGN KEY (SellerID) REFERENCES Users(UserID),
    FOREIGN KEY (BuyerID) REFERENCES Users(UserID)
);

CREATE TABLE ActiveTransactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    ListingID INT,
    SellerID INT,
    BuyerID INT,
    Amount FLOAT,
    FOREIGN KEY (ListingID) REFERENCES Listings(ListingID),
    FOREIGN KEY (SellerID) REFERENCES Users(UserID),
    FOREIGN KEY (BuyerID) REFERENCES Users(UserID)
    -- Messages field can be added later
);

CREATE TABLE PastTransactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    ListingID INT,
    SellerID INT,
    BuyerID INT,
    Amount FLOAT,
    DateSold DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ListingID) REFERENCES Listings(ListingID),
    FOREIGN KEY (SellerID) REFERENCES Users(UserID),
    FOREIGN KEY (BuyerID) REFERENCES Users(UserID)
);

CREATE TABLE Favorites (
    UserID INT NOT NULL,
    ListingID INT NOT NULL,
    PRIMARY KEY (UserID, ListingID),
    FOREIGN KEY (UserID) REFERENCES  Users(UserID),
    FOREIGN KEY (ListingID) REFERENCES Listings(ListingID)
);

CREATE TABLE Messages (
  MessageID INT AUTO_INCREMENT PRIMARY KEY,
  TransactionID INT,
  SenderID INT,
  Content TEXT,
  IsOffer BOOLEAN DEFAULT FALSE,
  OfferAmount FLOAT DEFAULT 0,
  Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (TransactionID) REFERENCES ActiveTransactions(TransactionID),
  FOREIGN KEY (SenderID) REFERENCES Users(UserID)
);