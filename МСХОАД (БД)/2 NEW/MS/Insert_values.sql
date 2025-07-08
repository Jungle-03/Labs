INSERT INTO Vehicles (VehicleID, LicensePlate, Model, Capacity) VALUES
(1, 'ABC123', 'Toyota Camry', 5.00),
(2, 'XYZ789', 'Honda Accord', 5.00),
(3, 'LMN456', 'Ford Explorer', 7.00);



INSERT INTO Drivers (LicensePlate, FirstName, LastName, ExperienceYears, PassportNumber) VALUES
('ABC123', 'Ivan', 'Petrov', 5, 'AB1234567'),
('XYZ789', 'Maria', 'Ivanova', 3, 'CD7654321'),
('LMN456', 'Pavel', 'Sidorov', 7, 'EF9876543');




INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES
(1, 'Alex', 'Smith', 'alex.smith@example.com'),
(2, 'Daria', 'Johnson', 'daria.johnson@example.com'),
(3, 'Mikhail', 'Brown', 'mikhail.brown@example.com');


INSERT INTO Orders (OrderID, CustomerID, VehicleID, Status, TotalCost) VALUES
(1, 1, 1, 'Completed', 150.00),
(2, 2, 2, 'Pending', 200.00),
(3, 3, 3, 'Cancelled', 100.00);



INSERT INTO Payments (PaymentID, OrderID, Amount, PaymentDate) VALUES
(1, 1, 150.00, '2023-01-15'),
(2, 2, 200.00, '2023-02-01'),
(3, 3, 100.00, '2023-01-20');


INSERT INTO VehicleRentals (RentalID, VehicleID, DriverID, StartDate, EndDate) VALUES
(1, 1, 'ABC123', '2023-03-01', '2023-03-05'),
(2, 2, 'XYZ789', '2023-03-02', '2023-03-06'),
(3, 3, 'LMN456', '2023-03-03', '2023-03-07');


INSERT INTO Users (UserID, Username, Password, BonusPoints) VALUES
(1, 'admin', 'admin123', 100),
(2, 'user1', 'password1', 50),
(3, 'user2', 'password2', 75);


INSERT INTO Vehicle (VehicleID, LicensePlate, Model, Year, Capacity) VALUES
(1, 'ABC123', 'Toyota Camry', 2020, 5.00),
(2, 'XYZ789', 'Honda Accord', 2019, 5.00),
(3, 'LMN456', 'Ford Explorer', 2021, 7.00);