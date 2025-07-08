 SELECT * FROM orders
 --2. Добавление данных в таблицы

INSERT INTO vehicles (name, type) VALUES ('Truck 1', 'Truck');
INSERT INTO vehicles (name, type) VALUES ('Van 1', 'Van');

INSERT INTO drivers (name, license_number) VALUES ('John Doe', 'ABC123');
INSERT INTO drivers (name, license_number) VALUES ('Jane Smith', 'XYZ456');

INSERT INTO orders (vehicle_id, driver_id, customer_name, order_date) VALUES (1, 1, 'Customer A', '2024-03-02');
INSERT INTO orders (vehicle_id, driver_id, customer_name, order_date) VALUES (2, 2, 'Customer B', '2024-02-02');



-------

--3. Обновление, добавление и удаление данных с учетом внешних ключей

BEGIN TRANSACTION;

-- Добавление нового заказа
INSERT INTO orders (vehicle_id, driver_id, customer_name, order_date) VALUES (1, 2, 'Customer C', '2024-02-03');

-- Обновление существующего заказа
UPDATE orders SET customer_name = 'Updated Customer A' WHERE id = 1;

-- Удаление заказа
DELETE FROM orders WHERE id = 2;

COMMIT;

--------
select * from orders


--------
--4. Создание представления
-- представление, которое объединяет заказы с информацией о водителях и транспортных средствах

CREATE VIEW order_details AS
SELECT o.id, o.customer_name, o.order_date, v.name AS vehicle_name, d.name AS driver_name
FROM orders o
JOIN vehicles v ON o.vehicle_id = v.id
JOIN drivers d ON o.driver_id = d.id;


select * from order_details;




--5. Создание индексов


CREATE INDEX idx_orders_customer ON orders (customer_name);
CREATE INDEX idx_orders_date ON orders (order_date);



PRAGMA index_list('orders');

--6. Создание триггера
--триггер, который будет добавлять запись в лог каждый раз, когда создается новый заказ:

CREATE TABLE order_log (
    log_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    action TEXT,
    action_date TEXT
);

CREATE TRIGGER log_order_creation
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_log (order_id, action, action_date) VALUES (NEW.id, 'Created', datetime('now'));
END;



--7. Проверка созданных объектов

-- Получение данных из представления
SELECT * FROM order_details;

-- Проверка триггера
INSERT INTO orders (vehicle_id, driver_id, customer_name, order_date) VALUES (2, 2, 'Customer D', '2024-02-04');
SELECT * FROM order_log;  -- Проверка записи в журнале


-- Проверка индексов

PRAGMA index_list('orders');


