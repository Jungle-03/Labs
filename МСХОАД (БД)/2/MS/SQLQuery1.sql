-- ������� ������ � ������� Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, PassportNumber) VALUES
(1, '����', '������', '1234567890'),
(2, '����', '������', '0987654321'),
(3, '��������', '��������', '1122334455'),
(4, '������', '�������', '2233445566'),
(5, '�����', '��������', '3344556677');

-- ������� ������ � ������� Drivers
INSERT INTO Drivers (DriverID, FirstName, LicenseNumber, ExperienceYears, PassportNumber) VALUES
(1, '�������', 'DL123456', 5, '1234567890'),
(2, '�����', 'DL987654', 3, '0987654321'),
(3, '���������', 'DL456789', 7, '1122334455'),
(4, '���������', 'DL654321', 2, '2233445566'),
(5, '������', 'DL321654', 4, '3344556677');

-- ������� ������ � ������� Vehicles
INSERT INTO Vehicles (VehicleID, LicensePlate, Model, Year, Capacity) VALUES
(1, 'ABC1234', 'Toyota Camry', 2020, 5.00),
(2, 'XYZ5678', 'Honda Accord', 2019, 5.00),
(3, 'JKL9101', 'Ford Focus', 2021, 5.00),
(4, 'MNO1122', 'Nissan Altima', 2022, 5.00),
(5, 'PQR3344', 'Chevrolet Malibu', 2023, 5.00);

-- ������� ������ � ������� Orders
INSERT INTO Orders (OrderID, CustomerID, VehicleID, DriverID, Status, Route, TotalCost) VALUES
(1, 1, 1, 1, '��������', '������ - �����-���������', 5000.00),
(2, 2, 2, 2, '� ��������', '������ - ������', 4000.00),
(3, 3, 3, 3, '��������', '�����-��������� - ������ ��������', 4500.00),
(4, 4, 4, 4, '�������', '������ - ���', 3000.00),
(5, 5, 5, 5, '��������', '������ �������� - ���������', 5500.00);

-- ������� ������ � ������� Payments
INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount) VALUES
(1, 1, '2023-01-10', 5000.00),
(2, 2, '2023-01-11', 4000.00),
(3, 3, '2023-01-12', 4500.00),
(4, 4, '2023-01-13', 3000.00),
(5, 5, '2023-01-14', 5500.00);

-- ������� ������ � ������� Users
INSERT INTO Users (UserID, Username, Password, Role, BonusPoints) VALUES
(1, 'admin', 'admin123', 'admin', 100.00),
(2, 'user1', 'pass123', 'user', 50.00),
(3, 'user2', 'pass456', 'user', 30.00),
(4, 'user3', 'pass789', 'user', 20.00),
(5, 'manager', 'manager123', 'manager', 80.00);

-- ������� ������ � ������� VehicleRentals
INSERT INTO VehicleRentals (RentalID, DriverID, VehicleID, StartDate, EndDate) VALUES
(1, 1, 1, '2023-01-01', '2023-01-10'),
(2, 2, 2, '2023-01-05', '2023-01-15'),
(3, 3, 3, '2023-01-02', '2023-01-12'),
(4, 4, 4, '2023-01-03', '2023-01-13'),
(5, 5, 5, '2023-01-04', '2023-01-14');


select * from Orders