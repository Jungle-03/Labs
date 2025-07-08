-- �������� ������� Vehicles
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    LicensePlate VARCHAR(50),
    Model VARCHAR(50),
    Capacity DECIMAL(10, 2)
);

-- �������� ������� Drivers
CREATE TABLE Drivers (
    LicensePlate VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ExperienceYears INT,
    PassportNumber VARCHAR(20)
);

-- �������� ������� Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

-- �������� ������� Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    VehicleID INT REFERENCES Vehicles(VehicleID),
    Status VARCHAR(255),
    TotalCost DECIMAL(10, 2)
);

-- �������� ������� Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT REFERENCES Orders(OrderID),
    Amount DECIMAL(10, 2),
    PaymentDate DATE
);

-- �������� ������� VehicleRentals
CREATE TABLE VehicleRentals (
    RentalID INT PRIMARY KEY,
    VehicleID INT REFERENCES Vehicles(VehicleID),
    DriverID VARCHAR(50) REFERENCES Drivers(LicensePlate),
    StartDate DATE,
    EndDate DATE
);

-- �������� ������� Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(50),
    BonusPoints INT
);
-- �������� ������� Vehicle
CREATE TABLE Vehicle (
    VehicleID INT,
    LicensePlate VARCHAR(15),
    Model VARCHAR(50),
    Year INT,
    Capacity decimal(10,2)
);




-- ���������� ����������� �������� � ������� Vehicles
ALTER TABLE Vehicles
ADD Year INT;

-- ���������� ����������� �������� � ������� Drivers
ALTER TABLE Drivers
ADD DriverID INT IDENTITY(1,1) PRIMARY KEY;

-- ���������� ����������� �������� � ������� Customers
ALTER TABLE Customers
ADD PassportNumber VARCHAR(20),
    Address VARCHAR(255);

-- ���������� ����������� �������� � ������� VehicleRentals


-- ���������� ����������� �������� � ������� Orders
ALTER TABLE Orders
ADD OrderDate DATE,
    
    Route VARCHAR(255),
    DeliveryAddress VARCHAR(255),
  
    UserID INT;

-- ���������� ������� ������ � ������� Orders
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Vehicles
FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Drivers
FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID);

-- ���������� ����������� �������� � ������� Payments
ALTER TABLE Payments
ADD PaymentDate DATE,
    Amount DECIMAL(10, 2);

-- ���������� ����������� �������� � ������� Users
ALTER TABLE Users
ADD Role VARCHAR(20),
    BonusPoints DECIMAL(18, 2);

-- �������� ������� Vehicle (���� ��� ����������)
CREATE TABLE Vehicle (
    VehicleID INT,
    LicensePlate VARCHAR(15),
    Model VARCHAR(50),
    Year INT,
    Capacity DECIMAL(10, 2)
);