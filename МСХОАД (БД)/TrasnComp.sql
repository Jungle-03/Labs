create TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    PassportNumber VARCHAR2(50),
    LastName VARCHAR2(255)
);


CREATE TABLE Drivers (
    DriverID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50) NOT NULL,
    LicenseNumber VARCHAR2(50) NOT NULL,
    ExperienceYears NUMBER,
    PassportNumber VARCHAR2(50) NOT NULL
);


CREATE TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER NOT NULL,
    VehicleID NUMBER NOT NULL,
    DriverID NUMBER NOT NULL,
    Status VARCHAR2(20),
    Route VARCHAR2(255),
    TotalCost NUMBER,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);


CREATE TABLE Payments (
    PaymentID NUMBER PRIMARY KEY,
    OrderID NUMBER NOT NULL,
    PaymentDate DATE,
    Amount NUMBER(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


CREATE TABLE Users (
    UserID NUMBER PRIMARY KEY,
    Username VARCHAR2(255) NOT NULL,
    Password VARCHAR2(255) NOT NULL,
    Role VARCHAR2(20),
    BonusPoints NUMBER(10, 2)
);


CREATE TABLE VehicleRentals (
    RentalID NUMBER PRIMARY KEY,
    DriverID NUMBER NOT NULL,
    VehicleID NUMBER NOT NULL,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);


CREATE TABLE Vehicles (
    VehicleID NUMBER PRIMARY KEY,
    LicensePlate VARCHAR2(50) NOT NULL,
    Model VARCHAR2(100),
    Year NUMBER(4),
    Capacity NUMBER(10, 2)
);