CREATE DATABASE TransComp;

USE TransComp;

-- ������� ������������ �������
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    LicensePlate VARCHAR(15) NOT NULL,
    Model VARCHAR(50),
    Year INT,
    Capacity DECIMAL(10, 2)
);

-- ������� ���������, ��������� ���������� ������
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    LicenseNumber VARCHAR(20),
    ExperienceYears INT,
    PassportNumber VARCHAR(20) -- ��������� ���������� ������
);

-- ������� ���������� (Customer), ���������� ���������� ������
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PassportNumber VARCHAR(20), -- ��������� ���������� ������ ���������
    Address VARCHAR(255) -- ����� ���������
);

-- ������� �������, ��������� ����� �������� � ������ �� ���������� ������ ���������
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID), -- ����� � �������� Customers
    VehicleID INT FOREIGN KEY REFERENCES Vehicles(VehicleID), -- ����� � �������� Vehicles
    DriverID INT FOREIGN KEY REFERENCES Drivers(DriverID), -- ����� � �������� Drivers
    OrderDate DATE,
    Status VARCHAR(20),
    Route VARCHAR(255), -- �������
    DeliveryAddress VARCHAR(255), -- ����� ��������
    TotalCost DECIMAL(10, 2)
);

-- ������� ��������
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID), -- ����� � �������� Orders
    PaymentDate DATE,
    Amount DECIMAL(10, 2)
);
