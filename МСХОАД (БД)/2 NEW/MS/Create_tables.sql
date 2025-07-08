-- Создание таблицы Vehicles
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    LicensePlate VARCHAR(50),
    Model VARCHAR(50),
    Capacity DECIMAL(10, 2)
);

-- Создание таблицы Drivers
CREATE TABLE Drivers (
    LicensePlate VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ExperienceYears INT,
    PassportNumber VARCHAR(20)
);

-- Создание таблицы Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

-- Создание таблицы Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    VehicleID INT REFERENCES Vehicles(VehicleID),
    Status VARCHAR(255),
    TotalCost DECIMAL(10, 2)
);

-- Создание таблицы Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT REFERENCES Orders(OrderID),
    Amount DECIMAL(10, 2),
    PaymentDate DATE
);

-- Создание таблицы VehicleRentals
CREATE TABLE VehicleRentals (
    RentalID INT PRIMARY KEY,
    VehicleID INT REFERENCES Vehicles(VehicleID),
    DriverID VARCHAR(50) REFERENCES Drivers(LicensePlate),
    StartDate DATE,
    EndDate DATE
);

-- Создание таблицы Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(50),
    BonusPoints INT
);
-- Создание таблицы Vehicle
CREATE TABLE Vehicle (
    VehicleID INT,
    LicensePlate VARCHAR(15),
    Model VARCHAR(50),
    Year INT,
    Capacity decimal(10,2)
);




-- Добавление недостающих столбцов в таблицу Vehicles
ALTER TABLE Vehicles
ADD Year INT;

-- Добавление недостающих столбцов в таблицу Drivers
ALTER TABLE Drivers
ADD DriverID INT IDENTITY(1,1) PRIMARY KEY;

-- Добавление недостающих столбцов в таблицу Customers
ALTER TABLE Customers
ADD PassportNumber VARCHAR(20),
    Address VARCHAR(255);

-- Добавление недостающих столбцов в таблицу VehicleRentals


-- Добавление недостающих столбцов в таблицу Orders
ALTER TABLE Orders
ADD OrderDate DATE,
    
    Route VARCHAR(255),
    DeliveryAddress VARCHAR(255),
  
    UserID INT;

-- Добавление внешних ключей в таблицу Orders
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Vehicles
FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Drivers
FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID);

-- Добавление недостающих столбцов в таблицу Payments
ALTER TABLE Payments
ADD PaymentDate DATE,
    Amount DECIMAL(10, 2);

-- Добавление недостающих столбцов в таблицу Users
ALTER TABLE Users
ADD Role VARCHAR(20),
    BonusPoints DECIMAL(18, 2);

-- Создание таблицы Vehicle (если она необходима)
CREATE TABLE Vehicle (
    VehicleID INT,
    LicensePlate VARCHAR(15),
    Model VARCHAR(50),
    Year INT,
    Capacity DECIMAL(10, 2)
);