-- �������� ������������������� ��� �������������� ��������� ���������������
CREATE SEQUENCE seq_VehicleID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_CustomerID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_OrderID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_PaymentID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_RentalID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_UserID START WITH 1 INCREMENT BY 1;

-- �������� �������� ��� ��������� ������������������
CREATE INDEX idx_Vehicles_LicensePlate ON Vehicles(LicensePlate);
CREATE INDEX idx_Drivers_PassportNumber ON Drivers(PassportNumber);

CREATE INDEX idx_Orders_CustomerID ON Orders(CustomerID);
CREATE INDEX idx_Orders_VehicleID ON Orders(VehicleID);
CREATE INDEX idx_Payments_OrderID ON Payments(OrderID);
CREATE INDEX idx_VehicleRentals_VehicleID ON VehicleRentals(VehicleID);
CREATE INDEX idx_VehicleRentals_DriverID ON VehicleRentals(DriverID);
CREATE INDEX idx_Users_Username ON Users(Username);

-- �������� ������������� (������)
CREATE VIEW vw_ActiveRentals AS
SELECT vr.RentalID, d.FirstName AS DriverFirstName, d.LastName AS DriverLastName,
       v.Model AS VehicleModel, v.LicensePlate, vr.StartDate, vr.EndDate
FROM VehicleRentals vr
JOIN Drivers d ON vr.DriverID = d.LicensePlate
JOIN Vehicles v ON vr.VehicleID = v.VehicleID
WHERE vr.EndDate > GETDATE();



--�������� �������������������

SELECT *
FROM sys.sequences;


--�������� ��������

SELECT *
FROM sys.indexes
WHERE object_id = OBJECT_ID('Vehicle'); -- �������� �� ������ ��� �������


--�������� ���� �������� ��� ���� ������

SELECT t.name AS TableName, i.name AS IndexName
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
WHERE t.is_ms_shipped = 0;  -- ��������� ��������� �������


--�������� �������������

SELECT *
FROM sys.views;


select * from vw_ActiveRentals;

--�������� ���� �������� � ���� ������

SELECT 
    o.type_desc AS ObjectType, 
    o.name AS ObjectName
FROM sys.objects o
WHERE o.is_ms_shipped = 0;  -- ��������� ��������� �������