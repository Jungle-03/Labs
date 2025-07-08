-- Создание таблицы пользователей
CREATE TABLE USERS (
    UserID INTEGER PRIMARY KEY AUTOINCREMENT,
    Username TEXT NOT NULL,
    Password TEXT NOT NULL,
    Role TEXT NOT NULL
);

-- Создание таблицы клиентов
CREATE TABLE CUSTOMERS (
    CustomerID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Email TEXT,
    Phone TEXT
);

-- Создание таблицы водителей
CREATE TABLE DRIVERS (
    DriverID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    LicenseNumber TEXT NOT NULL,
    Experience INTEGER
);

-- Создание таблицы транспортных средств
CREATE TABLE VEHICLES (
    VehicleID INTEGER PRIMARY KEY AUTOINCREMENT,
    LicensePlate TEXT UNIQUE NOT NULL,
    Model TEXT NOT NULL,
    Year INTEGER,
    Capacity REAL
);

-- Создание таблицы заказов
CREATE TABLE ORDERS (
    OrderID INTEGER PRIMARY KEY AUTOINCREMENT,
    CustomerID INTEGER,
    VehicleID INTEGER,
    DriverID INTEGER,
    Status TEXT DEFAULT 'Pending',
    TotalCost REAL,
    OrderDate TEXT DEFAULT CURRENT_TIMESTAMP,
    Route TEXT,
    DeliveryAddress TEXT,
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID) ON DELETE SET NULL,
    FOREIGN KEY (VehicleID) REFERENCES VEHICLES(VehicleID) ON DELETE SET NULL,
    FOREIGN KEY (DriverID) REFERENCES DRIVERS(DriverID) ON DELETE SET NULL
);

-- Создание таблицы платежей
CREATE TABLE PAYMENTS (
    PaymentID INTEGER PRIMARY KEY AUTOINCREMENT,
    OrderID INTEGER,
    Amount REAL NOT NULL,
    PaymentDate TEXT DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod TEXT,
    FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID) ON DELETE CASCADE
);

-- Создание таблицы аренды транспортных средств
CREATE TABLE VEHICLERENTALS (
    RentalID INTEGER PRIMARY KEY AUTOINCREMENT,
    VehicleID INTEGER,
    CustomerID INTEGER,
    RentalStart TEXT DEFAULT CURRENT_TIMESTAMP,
    RentalEnd TEXT,
    Cost REAL,
    FOREIGN KEY (VehicleID) REFERENCES VEHICLES(VehicleID) ON DELETE SET NULL,
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID) ON DELETE SET NULL
);



--доп

CREATE TABLE SERVICE_RECORDS (
    RECORD_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    VEHICLE_ID INTEGER,
    SERVICE_DATE TEXT NOT NULL,
    SERVICE_TYPE TEXT NOT NULL,
    COST REAL,
    COMMENTS TEXT,
    FOREIGN KEY (VEHICLE_ID) REFERENCES VEHICLES(VEHICLEID) ON DELETE CASCADE
);








-- Вставка данных в USERS (20 записей)
INSERT INTO USERS (Username, Password, Role) VALUES
('user1', 'pass1', 'admin'),
('user2', 'pass2', 'user'),
('user3', 'pass3', 'user'),
('user4', 'pass4', 'user'),
('user5', 'pass5', 'user'),
('user6', 'pass6', 'user'),
('user7', 'pass7', 'user'),
('user8', 'pass8', 'user'),
('user9', 'pass9', 'user'),
('user10', 'pass10', 'user'),
('user11', 'pass11', 'user'),
('user12', 'pass12', 'user'),
('user13', 'pass13', 'user'),
('user14', 'pass14', 'user'),
('user15', 'pass15', 'user'),
('user16', 'pass16', 'user'),
('user17', 'pass17', 'user'),
('user18', 'pass18', 'user'),
('user19', 'pass19', 'user'),
('user20', 'pass20', 'user');



-- Вставка данных в CUSTOMERS (20 записей)
INSERT INTO CUSTOMERS (FirstName, LastName, Email, Phone) VALUES
('John', 'Doe', 'john@example.com', '1234567890'),
('Jane', 'Smith', 'jane@example.com', '2345678901'),
('Mike', 'Brown', 'mike@example.com', '3456789012'),
('Sarah', 'Johnson', 'sarah@example.com', '4567890123'),
('Chris', 'Davis', 'chris@example.com', '5678901234'),
('Emma', 'Wilson', 'emma@example.com', '6789012345'),
('David', 'Anderson', 'david@example.com', '7890123456'),
('Laura', 'Martinez', 'laura@example.com', '8901234567'),
('Daniel', 'Taylor', 'daniel@example.com', '9012345678'),
('Olivia', 'Thomas', 'olivia@example.com', '0123456789'),
('Ethan', 'Harris', 'ethan@example.com', '1123456789'),
('Sophia', 'Clark', 'sophia@example.com', '1223456789'),
('James', 'Lewis', 'james@example.com', '1323456789'),
('Ava', 'Walker', 'ava@example.com', '1423456789'),
('Benjamin', 'Allen', 'benjamin@example.com', '1523456789'),
('Charlotte', 'Young', 'charlotte@example.com', '1623456789'),
('William', 'King', 'william@example.com', '1723456789'),
('Mia', 'Wright', 'mia@example.com', '1823456789'),
('Alexander', 'Lopez', 'alex@example.com', '1923456789'),
('Emily', 'Hill', 'emily@example.com', '2023456789');

-- Создание таблицы водителей


-- Вставка данных в DRIVERS (20 записей)
INSERT INTO DRIVERS (FirstName, LastName, LicenseNumber, Experience) VALUES
('John', 'Doe', 'L123456', 5),
('Jane', 'Smith', 'L234567', 7),
('Mike', 'Brown', 'L345678', 10),
('Sarah', 'Johnson', 'L456789', 3),
('Chris', 'Davis', 'L567890', 8),
('Emma', 'Wilson', 'L678901', 6),
('David', 'Anderson', 'L789012', 4),
('Laura', 'Martinez', 'L890123', 12),
('Daniel', 'Taylor', 'L901234', 9),
('Olivia', 'Thomas', 'L012345', 11),
('Ethan', 'Harris', 'L112345', 7),
('Sophia', 'Clark', 'L122345', 5),
('James', 'Lewis', 'L132345', 6),
('Ava', 'Walker', 'L142345', 3),
('Benjamin', 'Allen', 'L152345', 4),
('Charlotte', 'Young', 'L162345', 10),
('William', 'King', 'L172345', 8),
('Mia', 'Wright', 'L182345', 6),
('Alexander', 'Lopez', 'L192345', 5),
('Emily', 'Hill', 'L202345', 9);




-- Вставка данных в VEHICLES (20 записей)
INSERT INTO VEHICLES (LicensePlate, Model, Year, Capacity) VALUES
('ABC123', 'Toyota Camry', 2020, 5),
('XYZ789', 'Ford Focus', 2018, 5),
('LMN456', 'Honda Accord', 2022, 5),
('QWE321', 'Chevrolet Malibu', 2019, 5),
('RTY654', 'Nissan Altima', 2021, 5),
('UIO987', 'Hyundai Sonata', 2020, 5),
('PAS852', 'Kia Optima', 2017, 5),
('MNB963', 'Volkswagen Passat', 2016, 5),
('LKJ753', 'Subaru Legacy', 2015, 5),
('POI147', 'Mazda 6', 2014, 5),
('YUI258', 'Tesla Model 3', 2021, 5),
('ASD369', 'Mercedes C-Class', 2018, 5),
('DFG741', 'BMW 3 Series', 2017, 5),
('HJK852', 'Audi A4', 2016, 5),
('VBN963', 'Lexus ES', 2020, 5),
('WER789', 'Jaguar XE', 2019, 5),
('XCV147', 'Cadillac CTS', 2015, 5),
('BNM258', 'Infiniti Q50', 2014, 5),
('PLM963', 'Volvo S60', 2022, 5),
('OIP753', 'Acura TLX', 2023, 5);
    


-- Вставка данных в ORDERS (20 записей)
INSERT INTO ORDERS (CustomerID, VehicleID, DriverID, Status, TotalCost, Route, DeliveryAddress) VALUES
(1, 1, 1, 'Pending', 100.50, 'Route A', 'Address 1'),
(2, 2, 2, 'Completed', 200.75, 'Route B', 'Address 2'),
(3, 3, 3, 'Pending', 150.00, 'Route C', 'Address 3'),
(4, 4, 4, 'Cancelled', 120.00, 'Route D', 'Address 4'),
(5, 5, 5, 'Pending', 180.25, 'Route E', 'Address 5'),
(6, 6, 6, 'Completed', 250.00, 'Route F', 'Address 6'),
(7, 7, 7, 'Pending', 300.00, 'Route G', 'Address 7'),
(8, 8, 8, 'Completed', 90.00, 'Route H', 'Address 8'),
(9, 9, 9, 'Pending', 110.50, 'Route I', 'Address 9'),
(10, 10, 10, 'Completed', 220.00, 'Route J', 'Address 10'),
(11, 11, 11, 'Pending', 99.99, 'Route K', 'Address 11'),
(12, 12, 12, 'Completed', 135.50, 'Route L', 'Address 12'),
(13, 13, 13, 'Pending', 250.00, 'Route M', 'Address 13'),
(14, 14, 14, 'Completed', 300.00, 'Route N', 'Address 14'),
(15, 15, 15, 'Pending', 175.00, 'Route O', 'Address 15'),
(16, 16, 16, 'Completed', 145.00, 'Route P', 'Address 16'),
(17, 17, 17, 'Pending', 80.00, 'Route Q', 'Address 17'),
(18, 18, 18, 'Completed', 95.00, 'Route R', 'Address 18'),
(19, 19, 19, 'Pending', 120.00, 'Route S', 'Address 19'),
(20, 20, 20, 'Completed', 210.00, 'Route T', 'Address 20');




INSERT INTO PAYMENTS (OrderID, Amount, PaymentMethod) VALUES
(1, 100.50, 'Credit Card'),
(2, 200.75, 'Cash'),
(3, 150.00, 'PayPal'),
(4, 120.00, 'Credit Card'),
(5, 180.25, 'Cash'),
(6, 250.00, 'Credit Card'),
(7, 300.00, 'PayPal'),
(8, 90.00, 'Cash'),
(9, 110.50, 'Credit Card'),
(10, 220.00, 'PayPal'),
(11, 99.99, 'Cash'),
(12, 135.50, 'Credit Card'),
(13, 250.00, 'PayPal'),
(14, 300.00, 'Credit Card'),
(15, 175.00, 'Cash'),
(16, 145.00, 'PayPal'),
(17, 80.00, 'Credit Card'),
(18, 95.00, 'Cash'),
(19, 120.00, 'PayPal'),
(20, 210.00, 'Credit Card');




INSERT INTO VEHICLERENTALS (VehicleID, CustomerID, RentalStart, RentalEnd, Cost) VALUES
(1, 1, '2023-01-01', '2023-01-10', 300.00),
(2, 2, '2023-01-02', '2023-01-12', 350.00),
(3, 3, '2023-01-03', '2023-01-13', 400.00),
(4, 4, '2023-01-04', '2023-01-14', 450.00),
(5, 5, '2023-01-05', '2023-01-15', 500.00),
(6, 6, '2023-01-06', '2023-01-16', 550.00),
(7, 7, '2023-01-07', '2023-01-17', 600.00),
(8, 8, '2023-01-08', '2023-01-18', 650.00),
(9, 9, '2023-01-09', '2023-01-19', 700.00),
(10, 10, '2023-01-10', '2023-01-20', 750.00),
(11, 11, '2023-01-11', '2023-01-21', 800.00),
(12, 12, '2023-01-12', '2023-01-22', 850.00),
(13, 13, '2023-01-13', '2023-01-23', 900.00),
(14, 14, '2023-01-14', '2023-01-24', 950.00),
(15, 15, '2023-01-15', '2023-01-25', 1000.00),
(16, 16, '2023-01-16', '2023-01-26', 1050.00),
(17, 17, '2023-01-17', '2023-01-27', 1100.00),
(18, 18, '2023-01-18', '2023-01-28', 1150.00),
(19, 19, '2023-01-19', '2023-01-29', 1200.00),
(20, 20, '2023-01-20', '2023-01-30', 1250.00);





INSERT INTO SERVICE_RECORDS (VEHICLE_ID, SERVICE_DATE, SERVICE_TYPE, COST, COMMENTS) VALUES
(1, '2023-01-01', 'Oil Change', 50.00, 'Changed oil and filter.'),
(2, '2023-01-02', 'Tire Rotation', 30.00, 'Rotated tires.'),
(3, '2023-01-03', 'Brake Inspection', 40.00, 'Checked brake pads.'),
(4, '2023-01-04', 'Battery Check', 20.00, 'Checked battery health.'),
(5, '2023-01-05', 'Fluid Check', 15.00, 'Checked all fluid levels.'),
(6, '2023-01-06', 'Engine Tune-up', 100.00, 'Performed tune-up.'),
(7, '2023-01-07', 'Transmission Service', 200.00, 'Serviced transmission.'),
(8, '2023-01-08', 'Alignment', 75.00, 'Performed wheel alignment.'),
(9, '2023-01-09', 'Filter Replacement', 25.00, 'Replaced air filter.'),
(10, '2023-01-10', 'Coolant Flush', 60.00, 'Flushed and replaced coolant.'),
(11, '2023-01-11', 'Timing Belt Replacement', 300.00, 'Replaced timing belt.'),
(12, '2023-01-12', 'Exhaust Inspection', 40.00, 'Inspected exhaust system.'),
(13, '2023-01-13', 'Suspension Check', 50.00, 'Checked suspension components.'),
(14, '2023-01-14', 'Fuel System Cleaning', 80.00, 'Cleaned fuel system.'),
(15, '2023-01-15', 'AC Service', 100.00, 'Serviced air conditioning.'),
(16, '2023-01-16', 'Wiper Replacement', 20.00, 'Replaced wipers.'),
(17, '2023-01-17', 'Headlight Restoration', 30.00, 'Restored headlights.'),
(18, '2023-01-18', 'Detailing', 150.00, 'Full detailing service.'),
(19, '2023-01-19', 'Transmission Fluid Change', 90.00, 'Changed transmission fluid.'),
(20, '2023-01-20', 'Safety Inspection', 45.00, 'Performed safety inspection.');













----------------------------------4.	Продемонстрировать обновление, добавление и удаление данных в подчиненной таблице базы данных SQLite.
-- Обработка должна демонстрировать особенности применения внешних ключей в базе данных SQLite и использовать транзакции. 


-- Включаем поддержку внешних ключей (актуально для SQLite)
PRAGMA foreign_keys = ON;

--Добавление новых клиентов в таблицу CUSTOMERS

BEGIN TRANSACTION;

INSERT INTO CUSTOMERS (FirstName, LastName, Email, Phone) VALUES
('Danila', 'Radzivil', 'Radzivil@example.com', '1112223333'),
('Danila2', 'Radzivil2', 'Radzivil2@example.com', '4445556666');

COMMIT;



--2. Добавление заказов для новых клиентов в таблицу ORDERS

BEGIN TRANSACTION;

INSERT INTO ORDERS (CustomerID, TotalCost) VALUES
((SELECT CustomerID FROM CUSTOMERS WHERE FirstName = 'Danila' AND LastName = 'Radzivil'), 300.00),
((SELECT CustomerID FROM CUSTOMERS WHERE FirstName = 'Danila2' AND LastName = 'Radzivil2'), 150.00);

COMMIT;



--3. Обновление стоимости заказа в таблице ORDERS
BEGIN TRANSACTION;

UPDATE ORDERS
SET TotalCost = 350.00
WHERE OrderID = (SELECT OrderID FROM ORDERS WHERE CustomerID = (SELECT CustomerID FROM CUSTOMERS WHERE FirstName = 'Danila' AND LastName = 'Radzivil'));

COMMIT;



--4. Удаление клиента и демонстрация каскадного удаления заказов

BEGIN TRANSACTION;

DELETE FROM CUSTOMERS
WHERE FirstName = 'Danila2' AND LastName = 'Radzivil2';

COMMIT;




select * from Customers;
select * from Orders;


DELETE FROM ORDERS
WHERE CustomerID IS NULL;






-----5.	Создать представление в базе данных SQLite. 


CREATE VIEW CustomerOrders AS
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.TotalCost,
    o.OrderDate
FROM
    CUSTOMERS c
LEFT JOIN
    ORDERS o ON c.CustomerID = o.CustomerID;
    



SELECT * FROM CustomerOrders;








-----6.	Создать необходимые индексы в базе данных SQLite.


--Индексы для таблицы USERS
CREATE INDEX idx_users_username ON USERS (Username);

--Индексы для таблицы CUSTOMERS
CREATE INDEX idx_customers_email ON CUSTOMERS (Email);
CREATE INDEX idx_customers_lastname ON CUSTOMERS (LastName);
CREATE INDEX idx_customers_phone ON CUSTOMERS (Phone);

--Индексы для таблицы DRIVERS
CREATE INDEX idx_drivers_license ON DRIVERS (LicenseNumber);
CREATE INDEX idx_drivers_lastname ON DRIVERS (LastName);

--Индексы для таблицы VEHICLES
CREATE INDEX idx_vehicles_licenseplate ON VEHICLES (LicensePlate);
CREATE INDEX idx_vehicles_model ON VEHICLES (Model);

--Индексы для таблицы ORDERS
CREATE INDEX idx_orders_customerid ON ORDERS (CustomerID);
CREATE INDEX idx_orders_vehicleid ON ORDERS (VehicleID);
CREATE INDEX idx_orders_driverid ON ORDERS (DriverID);
CREATE INDEX idx_orders_orderdate ON ORDERS (OrderDate);

--Индексы для таблицы PAYMENTS
CREATE INDEX idx_payments_orderid ON PAYMENTS (OrderID);
CREATE INDEX idx_payments_paymentdate ON PAYMENTS (PaymentDate);

--Индексы для таблицы VEHICLERENTALS
CREATE INDEX idx_rentals_vehicleid ON VEHICLERENTALS (VehicleID);
CREATE INDEX idx_rentals_customerid ON VEHICLERENTALS (CustomerID);

--Индексы для таблицы SERVICE_RECORDS
CREATE INDEX idx_service_vehicleid ON SERVICE_RECORDS (VEHICLE_ID);
CREATE INDEX idx_service_service_date ON SERVICE_RECORDS (SERVICE_DATE);







--7.	Создать триггер в базе данных SQLite.

CREATE TABLE CHANGE_LOGS (
    LogID INTEGER PRIMARY KEY AUTOINCREMENT,
    TableName TEXT NOT NULL,
    ChangedColumn TEXT NOT NULL,
    OldValue TEXT,
    NewValue TEXT,
    ChangeDate TEXT DEFAULT CURRENT_TIMESTAMP
);





CREATE TRIGGER log_order_changes
AFTER UPDATE ON ORDERS
FOR EACH ROW
BEGIN
    INSERT INTO CHANGE_LOGS (TableName, ChangedColumn, OldValue, NewValue)
    SELECT 'ORDERS', 'Status', OLD.Status, NEW.Status
    WHERE OLD.Status != NEW.Status;

    INSERT INTO CHANGE_LOGS (TableName, ChangedColumn, OldValue, NewValue)
    SELECT 'ORDERS', 'TotalCost', OLD.TotalCost, NEW.TotalCost
    WHERE OLD.TotalCost != NEW.TotalCost;

    
END;



SELECT * FROM CHANGE_LOGS;

select * from orders

UPDATE ORDERS SET Status = 'Completed', TotalCost = 120.00 WHERE OrderID = 23;

INSERT INTO ORDERS (Status, TotalCost) VALUES ('Pending', 1120.00);



-----8.	Продемонстрировать использование созданных объектов в приложении.

--использование триггера показано в прошлом задании


DROP INDEX IF EXISTS idx_status;
DROP INDEX IF EXISTS idx_totalcost;

-- Запрос для поиска без индексов
SELECT * FROM ORDERS WHERE Status = 'Completed';

CREATE INDEX idx_status ON ORDERS (Status);
CREATE INDEX idx_totalcost ON ORDERS (TotalCost);


-- Запрос для поиска с индексами
SELECT * FROM ORDERS WHERE Status = 'Completed';


