-- Создание последовательностей для автоматической генерации идентификаторов
CREATE SEQUENCE seq_VehicleID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_DriverID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_CustomerID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_OrderID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_PaymentID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_UserID START WITH 1 INCREMENT BY 1;

-- Создание индексов для повышения производительности
CREATE INDEX idx_Vehicles_LicensePlate ON Vehicles(LicensePlate);
CREATE INDEX idx_Drivers_LicenseNumber ON Drivers(LicenseNumber);
CREATE INDEX idx_Customers_PassportNumber ON Customers(PassportNumber);
CREATE INDEX idx_VehicleRentals_VehicleID ON VehicleRentals(VehicleID);
CREATE INDEX idx_Orders_CustomerID ON Orders(CustomerID);
CREATE INDEX idx_Orders_VehicleID ON Orders(VehicleID);
CREATE INDEX idx_Payments_OrderID ON Payments(OrderID);
CREATE INDEX idx_Users_Username ON Users(Username);

-- Создание представлений (пример)
CREATE VIEW vw_ActiveRentals AS
SELECT vr.RentalID, d.FirstName AS DriverFirstName, d.LastName AS DriverLastName,
       v.Model AS VehicleModel, v.LicensePlate, vr.StartDate, vr.EndDate
FROM VehicleRentals vr
JOIN Drivers d ON vr.DriverID = d.DriverID
JOIN Vehicles v ON vr.VehicleID = v.VehicleID
WHERE vr.EndDate > SYSDATE;



--Просмотр последовательностей

SELECT *
FROM vw_ActiveRentals;


--Просмотр индексов

SELECT *
FROM user_indexes;

--Просмотр представлений

SELECT *
FROM user_views;

select * from VW_ACTIVERENTALS;
--Просмотр всех объектов в базе данных

SELECT object_type, object_name
FROM user_objects;