--1. Итоги предоставленных услуг помесячно, за квартал, за полгода, за год

   WITH aggregated_data AS (
    SELECT
        EXTRACT(YEAR FROM OrderDate) AS order_year,
        'Q' || TO_CHAR(OrderDate, 'Q') AS period,
        SUM(TotalCost) AS total_revenue,
        COUNT(OrderID) AS total_orders
    FROM Orders
    GROUP BY EXTRACT(YEAR FROM OrderDate), TO_CHAR(OrderDate, 'Q')
    
    UNION ALL
    
    SELECT
        EXTRACT(YEAR FROM OrderDate) AS order_year,
        CASE 
            WHEN EXTRACT(MONTH FROM OrderDate) <= 6 THEN 'Первое полугодие'
            ELSE 'Второе полугодие'
        END AS period,
        SUM(TotalCost) AS total_revenue,
        COUNT(OrderID) AS total_orders
    FROM Orders
    GROUP BY EXTRACT(YEAR FROM OrderDate),
        CASE 
            WHEN EXTRACT(MONTH FROM OrderDate) <= 6 THEN 'Первое полугодие'
            ELSE 'Второе полугодие'
        END
    
    UNION ALL
    
    SELECT
        EXTRACT(YEAR FROM OrderDate) AS order_year,
        'Итоги за год' AS period,
        SUM(TotalCost) AS total_revenue,
        COUNT(OrderID) AS total_orders
    FROM Orders
    GROUP BY EXTRACT(YEAR FROM OrderDate)
)
SELECT
    order_year,
    period,
    total_orders,
    total_revenue
FROM aggregated_data
ORDER BY order_year, 
         CASE 
            WHEN period LIKE 'Q%' THEN 1 
            WHEN period = 'Первое полугодие' THEN 2 
            WHEN period = 'Второе полугодие' THEN 3 
            ELSE 4 
         END;
 
    
select * from orders


    --2. Итоги предоставленных услуг за определенный период
    


    
    INSERT INTO Orders (OrderID, CustomerID, VehicleID, DriverIDINT, OrderDate, Status, Route, DeliveryAddress, TotalCost, UserID)
VALUES
(42, 1, 3, NULL, TO_DATE('2024-05-20', 'YYYY-MM-DD'), 'Completed', 'Route B', '789 Oak St, City Minsk', 245.00, 1);
(6, 3, 1, 2, '2023-01-19', 'Completed', 'Route F', '123 Birch St, City F', 350, 2),
(7, 1, 2, 3, '2023-01-20', 'Cancelled', 'Route G', '321 Cedar St, City G', 400, 3),
(8, 4, 1, NULL, '2023-01-21', 'In Progress', 'Route H', '654 Maple St, City H', 220, 1);
     
 //select * from orders  
       
WITH ServiceVolumes AS (
    SELECT
        EXTRACT(YEAR FROM OrderDate) AS order_year,
        SUM(TotalCost) AS total_revenue,
        COUNT(OrderID) AS total_orders
    FROM Orders
    GROUP BY EXTRACT(YEAR FROM OrderDate)
),
MaxVolume AS (
    SELECT MAX(total_orders) AS max_orders FROM ServiceVolumes
)
SELECT
    sv.order_year,
    sv.total_orders,
    sv.total_revenue,
    ROUND((sv.total_orders / (SELECT SUM(total_orders) FROM ServiceVolumes)) * 100, 2) AS percentage_of_total,
    ROUND((sv.total_orders / (SELECT max_orders FROM MaxVolume)) * 100, 2) AS percentage_of_max
FROM ServiceVolumes sv
ORDER BY sv.order_year;

 --   3. Ранжирование ROW_NUMBER() для разбиения на страницы


WITH OrderedOrders AS (
    SELECT 
        OrderID,
        CustomerID,
        VehicleID,
        Status,
        TotalCost,
        OrderDate,
        Route,
        DeliveryAddress,
        UserID,
        DriverIDINT,
        ROW_NUMBER() OVER (ORDER BY OrderDate) AS row_num
    FROM Orders
)
SELECT *
FROM OrderedOrders
WHERE row_num BETWEEN ((:page_num - 1) * 20 + 1) AND (:page_num * 20);

    
    
    --4. Ранжирование ROW_NUMBER() для удаления дубликатов
    

-- Добавление дубликатов в Vehicles


-- Добавление дубликатов
INSERT INTO Orders (ORDERID, CUSTOMERID, VEHICLEID, DRIVERIDINT, ORDERDATE, STATUS, ROUTE, DELIVERYADDRESS, TOTALCOST, USERID)
VALUES 
(101, 2, 3, NULL, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'Cancelled', 'Route C', '789 Oak St, City C', 100, 3);

select * from orders


DELETE FROM Orders 
WHERE ORDERID IN (
    SELECT ORDERID
    FROM (
        SELECT ORDERID,
               ROW_NUMBER() OVER (
                   PARTITION BY CUSTOMERID, VEHICLEID, STATUS, TOTALCOST, ORDERDATE, ROUTE, DELIVERYADDRESS, USERID, DRIVERIDINT 
                   ORDER BY ORDERID
               ) AS rn
        FROM Orders
    ) 
    WHERE rn > 1
);


    --5. Последние 6 заказов для каждого клиента
    
    
   WITH last_orders AS (
    SELECT 
        CustomerID,
        OrderID,
        Deliveryaddress,  -- добавляем направление
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS rn
    FROM 
        Orders
)
SELECT 
    CustomerID,
    OrderID,
    Deliveryaddress  
FROM 
    last_orders
WHERE 
    rn <= 6;

    
    --6. Наиболее популярные маршруты для определенного типа автомобилей
    
    SELECT 
    v.Model,
    o.Route,
    COUNT(*) AS popularity
FROM 
    Orders o
JOIN 
    Vehicles v ON o.VehicleID = v.VehicleID
GROUP BY 
    v.Model, o.Route
ORDER BY 
    COUNT(*) DESC;