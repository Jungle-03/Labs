-- ������������� ��� ���� �������� �������
Create VIEW ActiveOrders AS
SELECT o.OrderID, c.FirstName, c.LastName, d.FirstName AS DriverFirstName, o.Status, o.TotalCost
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Drivers d ON o.DriverID = d.DriverID
WHERE o.Status = '� ��������';

-- ������������� ��� ���� �������� � �������� ������
CREATE VIEW PaymentDetails AS
SELECT p.PaymentID, o.OrderID, p.PaymentDate, p.Amount, c.FirstName AS CustomerFirstName
FROM Payments p
JOIN Orders o ON p.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID;



select * from ActiveOrders;

select * from PaymentDetails;





-- ������ �� ���� CustomerID � ������� Orders
CREATE INDEX idx_orders_customer ON Orders(CustomerID);

-- ������ �� ���� DriverID � ������� VehicleRentals
CREATE INDEX idx_rentals_driver ON VehicleRentals(DriverID);

-- ������ �� ���� LicensePlate � ������� Vehicles
CREATE INDEX idx_vehicles_license_plate ON Vehicles(LicensePlate);


SELECT 
    OBJECT_NAME(object_id) AS TableName,
    name AS IndexName,
    type_desc AS IndexType,
    is_unique AS IsUnique,
    is_primary_key AS IsPrimaryKey
FROM 
    sys.indexes
WHERE 
    OBJECT_NAME(object_id) IN ('Orders', 'VehicleRentals', 'Vehicles');

-- ������������������ ��� ��������� ��������������� �������
CREATE SEQUENCE seq_order_id
START WITH 1
INCREMENT BY 1;

-- ������������������ ��� ��������� ��������������� ��������
CREATE SEQUENCE seq_customer_id
START WITH 1
INCREMENT BY 1;

-- ������������������ ��� ��������� ��������������� ���������
CREATE SEQUENCE seq_driver_id
START WITH 1
INCREMENT BY 1;

-- ������������������ ��� ��������� ��������������� ��������
CREATE SEQUENCE seq_payment_id
START WITH 1
INCREMENT BY 1;

-- ������������������ ��� ��������� ��������������� ������
CREATE SEQUENCE seq_rental_id
START WITH 1
INCREMENT BY 1;

-- ������������������ ��� ��������� ��������������� �������������
CREATE SEQUENCE seq_user_id
START WITH 1
INCREMENT BY 1;

-- ������������������ ��� ��������� ��������������� �����������
CREATE SEQUENCE seq_vehicle_id
START WITH 1
INCREMENT BY 1;


SELECT 
    name AS SequenceName,
    start_value AS StartValue,
    increment AS IncrementValue,
    current_value AS CurrentValue,
    minimum_value AS MinimumValue,
    maximum_value AS MaximumValue,
    is_cycling AS IsCycling
FROM 
    sys.sequences;