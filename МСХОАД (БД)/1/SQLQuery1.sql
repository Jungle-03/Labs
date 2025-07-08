CREATE DATABASE TransComp;

USE TransComp;

-- Таблица Транспортных средств
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    LicensePlate VARCHAR(15) NOT NULL,
    Model VARCHAR(50),
    Year INT,
    Capacity DECIMAL(10, 2)
);

-- Таблица Водителей, добавляем паспортные данные
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    LicenseNumber VARCHAR(20),
    ExperienceYears INT,
    PassportNumber VARCHAR(20) -- Добавляем паспортные данные
);

-- Таблица Заказчиков (Customer), включающая паспортные данные
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PassportNumber VARCHAR(20), -- Добавляем паспортные данные заказчика
    Address VARCHAR(255) -- Адрес заказчика
);

-- Таблица Заказов, добавляем адрес доставки и ссылку на паспортные данные заказчика
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID), -- Связь с таблицей Customers
    VehicleID INT FOREIGN KEY REFERENCES Vehicles(VehicleID), -- Связь с таблицей Vehicles
    DriverID INT FOREIGN KEY REFERENCES Drivers(DriverID), -- Связь с таблицей Drivers
    OrderDate DATE,
    Status VARCHAR(20),
    Route VARCHAR(255), -- Маршрут
    DeliveryAddress VARCHAR(255), -- Адрес доставки
    TotalCost DECIMAL(10, 2)
);

-- Таблица Платежей
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID), -- Связь с таблицей Orders
    PaymentDate DATE,
    Amount DECIMAL(10, 2)
);
