drop TABLE Vehicles (
    VehicleID NUMBER PRIMARY KEY,
    LicensePlate VARCHAR2(15) NOT NULL,
    Model VARCHAR2(50),
    Year NUMBER,
    Capacity NUMBER(10, 2)
);

drop TABLE Drivers (
    DriverID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    LicenseNumber VARCHAR2(20),
    ExperienceYears NUMBER
);

drop  TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    VehicleID NUMBER,
    DriverID NUMBER,
    OrderDate DATE,
    Status VARCHAR2(20),
    Route VARCHAR2(255),
    TotalCost NUMBER(10, 2)
);

drop  TABLE Payments (
    PaymentID NUMBER PRIMARY KEY,
    OrderID NUMBER,
    PaymentDate DATE,
    Amount NUMBER(10, 2)
);
