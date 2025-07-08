CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    PassportNumber NVARCHAR(50),
    LastName NVARCHAR(255)
);

CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LicenseNumber NVARCHAR(50) NOT NULL,
    ExperienceYears INT,
    PassportNumber NVARCHAR(50) NOT NULL
);

CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    LicensePlate NVARCHAR(50) NOT NULL,
    Model NVARCHAR(100),
    Year INT,
    Capacity DECIMAL(10, 2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    VehicleID INT NOT NULL,
    DriverID INT NOT NULL,
    Status NVARCHAR(20),
    Route NVARCHAR(255),
    TotalCost DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username NVARCHAR(255) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20),
    BonusPoints DECIMAL(10, 2)
);

CREATE TABLE VehicleRentals (
    RentalID INT PRIMARY KEY,
    DriverID INT NOT NULL,
    VehicleID INT NOT NULL,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);

