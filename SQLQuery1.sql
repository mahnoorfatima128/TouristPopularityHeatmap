USE TouristPopularityHeatmap;
GO
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Admin Table
CREATE TABLE Admin (
    AdminID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT UNIQUE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

-- Visitor Table
CREATE TABLE Visitor (
    VisitorID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT UNIQUE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

-- TouristPlace Table
CREATE TABLE TouristPlace (
    PlaceID INT IDENTITY(1,1) PRIMARY KEY,
    PlaceName VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Category VARCHAR(50),
    Description VARCHAR(255),
    Location VARCHAR(100)
);
GO

-- VisitRecord Table
CREATE TABLE VisitRecord (
    VisitID INT IDENTITY(1,1) PRIMARY KEY,
    VisitorID INT NOT NULL,
    PlaceID INT NOT NULL,
    VisitDate DATETIME,
    VisitorCount INT,
    FOREIGN KEY (VisitorID) REFERENCES Visitor(VisitorID),
    FOREIGN KEY (PlaceID) REFERENCES TouristPlace(PlaceID)
);
GO

-- Review Table
CREATE TABLE Review (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    VisitorID INT NOT NULL,
    PlaceID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment VARCHAR(255),
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (VisitorID) REFERENCES Visitor(VisitorID),
    FOREIGN KEY (PlaceID) REFERENCES TouristPlace(PlaceID)
);
GO

-- PopularityAnalysis Table
CREATE TABLE PopularityAnalysis (
    AnalysisID INT IDENTITY(1,1) PRIMARY KEY,
    PlaceID INT UNIQUE NOT NULL,
    PopularityScore FLOAT,
    PeakTime VARCHAR(50),
    FOREIGN KEY (PlaceID) REFERENCES TouristPlace(PlaceID)
);
GO

-- Users (Mahnoor = Admin, Khadija + others = Visitors)
INSERT INTO Users (FullName, Email, PasswordHash, Role)
VALUES
('Mahnoor Fatima', 'mahnoor@gmail.com', 'pass123', 'Admin'),
('Khadija Tahira', 'khadija@gmail.com', 'pass123', 'Visitor'),
('Haseeb Ali', 'haseeb@gmail.com', 'pass123', 'Visitor'),
('Hussain Khalid', 'hussain@gmail.com', 'pass123', 'Visitor'),
('Tayyab Ali', 'tayyab@gmail.com', 'pass123', 'Visitor'),
('Irtaza Masood', 'irtaza@gmail.com', 'pass123', 'Visitor');
GO

-- Admin (Mahnoor only)
INSERT INTO Admin (UserID)
VALUES (1);
GO

-- Visitor (Khadija + others)
INSERT INTO Visitor (UserID)
VALUES (2), (3), (4), (5), (6);
GO

-- Tourist Places
INSERT INTO TouristPlace (PlaceName, City, Category, Description, Location)
VALUES
('Badshahi Mosque','Lahore','Historical','Mughal mosque','Lahore'),
('Hunza Valley','Hunza','Nature','Beautiful valley','Gilgit'),
('Faisal Mosque','Islamabad','Religious','Famous mosque','Islamabad'),
('Murree Hills','Murree','Nature','Hill station','Murree'),
('Lahore Fort','Lahore','Historical','Historic fort','Lahore'),
('Shalimar Gardens','Lahore','Historical','Mughal gardens','Lahore');
GO

-- Visit Records
INSERT INTO VisitRecord (VisitorID, PlaceID, VisitDate, VisitorCount)
VALUES
(1,1,'2025-12-01',50),
(2,2,'2025-12-02',60),
(3,3,'2025-12-03',40),
(4,4,'2025-12-04',70),
(1,5,'2025-12-05',30),
(2,6,'2025-12-06',20);
GO

-- Reviews
INSERT INTO Review (VisitorID, PlaceID, Rating, Comment)
VALUES
(1,1,5,'Amazing place'),
(2,2,4,'Beautiful valley'),
(3,3,5,'Very peaceful'),
(4,4,4,'Nice weather'),
(1,5,5,'Very historic'),
(2,6,4,'Lovely gardens');
GO

-- Popularity Analysis
INSERT INTO PopularityAnalysis (PlaceID, PopularityScore, PeakTime)
VALUES
(1,95.5,'Evening'),
(2,90.0,'Morning'),
(3,92.0,'Noon'),
(4,88.0,'Afternoon'),
(5,94.0,'Evening'),
(6,89.0,'Morning');
GO

SELECT * FROM Users;
SELECT * FROM Admin;
SELECT * FROM Visitor;
SELECT * FROM TouristPlace;
SELECT * FROM VisitRecord;
SELECT * FROM Review;
SELECT * FROM PopularityAnalysis;
GO



