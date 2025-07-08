-- ������������� ��� ���� �������� �������
CREATE VIEW ActiveOrders AS
SELECT o.OrderID, c.FirstName, c.LastName, d.FirstName AS DriverFirstName, o.Status, o.TotalCost
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Drivers d ON o.DriverID = d.DriverID
WHERE o.Status = 'Active';

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





SELECT INDEX_NAME, TABLE_NAME
FROM USER_INDEXES;


SELECT INDEX_NAME, TABLE_NAME, OWNER
FROM ALL_INDEXES;


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



SELECT SEQUENCE_NAME
FROM USER_SEQUENCES;



