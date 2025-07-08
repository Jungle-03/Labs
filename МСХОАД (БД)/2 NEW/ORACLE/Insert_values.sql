INSERT INTO Drivers (DriverID, FirstName, LastName, LicenseNumber, ExperienceYears, PassportNumber) VALUES
(1, 'Ivan', 'Petrov', 'DL1234567', 5, 'AB1234567');

INSERT INTO Drivers (DriverID, FirstName, LastName, LicenseNumber, ExperienceYears, PassportNumber) VALUES
(2, 'Maria', 'Ivanova', 'DL2345678', 3, 'CD7654321');

INSERT INTO Drivers (DriverID, FirstName, LastName, LicenseNumber, ExperienceYears, PassportNumber) VALUES
(3, 'Pavel', 'Sidorov', 'DL3456789', 7, 'EF9876543');







INSERT INTO Vehicles (VehicleID, LicensePlate, Model, Year, Capacity) VALUES
(1, 'ABC123', 'Toyota Camry', 2020, 5.00);

INSERT INTO Vehicles (VehicleID, LicensePlate, Model, Year, Capacity) VALUES
(2, 'XYZ789', 'Honda Accord', 2019, 5.00);

INSERT INTO Vehicles (VehicleID, LicensePlate, Model, Year, Capacity) VALUES
(3, 'LMN456', 'Ford Explorer', 2021, 7.00);







INSERT INTO Customers (CustomerID, FirstName, LastName, PassportNumber, Address) VALUES
(1, 'Alex', 'Smith', 'P1234567', '123 Main St, City A');

INSERT INTO Customers (CustomerID, FirstName, LastName, PassportNumber, Address) VALUES
(2, 'Daria', 'Johnson', 'P2345678', '456 Elm St, City B');

INSERT INTO Customers (CustomerID, FirstName, LastName, PassportNumber, Address) VALUES
(3, 'Mikhail', 'Brown', 'P3456789', '789 Oak St, City C');







INSERT INTO VehicleRentals (RentalID, DriverID, VehicleID, StartDate, EndDate) VALUES
(1, 1, 1, TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-03-05', 'YYYY-MM-DD'));

INSERT INTO VehicleRentals (RentalID, DriverID, VehicleID, StartDate, EndDate) VALUES
(2, 2, 2, TO_DATE('2023-03-02', 'YYYY-MM-DD'), TO_DATE('2023-03-06', 'YYYY-MM-DD'));

INSERT INTO VehicleRentals (RentalID, DriverID, VehicleID, StartDate, EndDate) VALUES
(3, 3, 3, TO_DATE('2023-03-03', 'YYYY-MM-DD'), TO_DATE('2023-03-07', 'YYYY-MM-DD'));








INSERT INTO Orders (OrderID, CustomerID, VehicleID, DriverID, OrderDate, Status, Route, DeliveryAddress, TotalCost, UserID) VALUES
(1, 1, 1, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'Completed', 'Route A', '123 Main St, City A', 150.00, 1);

INSERT INTO Orders (OrderID, CustomerID, VehicleID, DriverID, OrderDate, Status, Route, DeliveryAddress, TotalCost, UserID) VALUES
(2, 2, 2, 2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'Pending', 'Route B', '456 Elm St, City B', 200.00, 2);

INSERT INTO Orders (OrderID, CustomerID, VehicleID, DriverID, OrderDate, Status, Route, DeliveryAddress, TotalCost, UserID) VALUES
(3, 3, 3, 3, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'Cancelled', 'Route C', '789 Oak St, City C', 100.00, 3);






INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount) VALUES
(1, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 150.00);

INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount) VALUES
(2, 2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 200.00);

INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount) VALUES
(3, 3, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 100.00);







INSERT INTO Users (UserID, Username, Password, Role, BonusPoints) VALUES
(1, 'admin', 'admin123', 'administrator', 100.00);

INSERT INTO Users (UserID, Username, Password, Role, BonusPoints) VALUES
(2, 'user1', 'password1', 'customer', 50.00);

INSERT INTO Users (UserID, Username, Password, Role, BonusPoints) VALUES
(3, 'user2', 'password2', 'customer', 75.00);







INSERT INTO Vehicle (VehicleID, LicensePlate, Model, Year, Capacity) VALUES
(1, 'ABC123', 'Toyota Camry', 2020, 5.00);

INSERT INTO Vehicles (VehicleID, LicensePlate, Model, Year, Capacity) VALUES
(2, 'XYZ789', 'Honda Accord', 2019, 5.00);

INSERT INTO Vehicles (VehicleID, LicensePlate, Model, Year, Capacity) VALUES
(3, 'LMN456', 'Ford Explorer', 2021, 7.00);






-- Вставка данных в таблицу Orders без DriverID
INSERT INTO Orders (OrderID, CustomerID, VehicleID, OrderDate, Status, Route, DeliveryAddress, TotalCost, UserID) VALUES
(1, 1, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'Completed', 'Route A', '123 Main St, City A', 150.00, 1);

INSERT INTO Orders (OrderID, CustomerID, VehicleID, OrderDate, Status, Route, DeliveryAddress, TotalCost, UserID) VALUES
(2, 2, 2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'Pending', 'Route B', '456 Elm St, City B', 200.00, 2);

INSERT INTO Orders (OrderID, CustomerID, VehicleID, OrderDate, Status, Route, DeliveryAddress, TotalCost, UserID) VALUES
(3, 3, 3, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'Cancelled', 'Route C', '789 Oak St, City C', 100.00, 3);





-- Вставка данных в таблицу Payments
INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount) VALUES
(1, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 150.00);

INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount) VALUES
(2, 2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 200.00);

INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount) VALUES
(3, 3, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 100.00);




select * from orders;