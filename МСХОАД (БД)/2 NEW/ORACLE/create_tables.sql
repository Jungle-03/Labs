-- Создание таблицы Vehicles
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    LicensePlate VARCHAR(50),
    Model VARCHAR(50),
    Year INT,
    Capacity DECIMAL(10, 2)
);

-- Создание таблицы Drivers
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    LicenseNumber VARCHAR(20),
    ExperienceYears INT,
    PassportNumber VARCHAR(20)
);

-- Создание таблицы Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PassportNumber VARCHAR(20),
    Address VARCHAR(255)
);




-- Создание таблицы VehicleRentals
CREATE TABLE VehicleRentals (
  RentalID INT,
  DriverID INT,
  VehicleID INT,
  StartDate DATE,
  EndDate DATE
);



-- Создание таблицы Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    VehicleID INT REFERENCES Vehicles(VehicleID),
    DriverIDINT REFERENCES Drivers(DriverID),
    OrderDate DATE,
    Status VARCHAR(255),
    Route VARCHAR(255),
    DeliveryAddress VARCHAR(255),
    TotalCost DECIMAL(10, 2),
    UserID INT
);

-- Создание таблицы Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT REFERENCES Orders(OrderID),
    PaymentDate DATE,
    Amount DECIMAL(10, 2)
    
);



-- Создание таблицы Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(50),
    Role Varchar(20),
    BonusPoints decimal(18,2)
);



CREATE TABLE Vehicle (
    VehicleID INT,
    LicensePlate VARCHAR(15),
    Model VARCHAR(50),
    Year INT,
    Capacity decimal(10,2)
);