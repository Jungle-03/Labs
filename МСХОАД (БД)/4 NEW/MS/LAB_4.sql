--1. Итоги предоставленных услуг помесячно, за квартал, за полгода, за год


WITH AggregatedData AS (
    SELECT
        DATEPART(YEAR, OrderDate) AS order_year,
        CONCAT('Q', DATEPART(QUARTER, OrderDate)) AS period,
        SUM(TotalCost) AS total_revenue,
        COUNT(OrderID) AS total_orders
    FROM Orders
    GROUP BY DATEPART(YEAR, OrderDate), DATEPART(QUARTER, OrderDate)
    
    UNION ALL
    
    SELECT
        DATEPART(YEAR, OrderDate) AS order_year,
        CASE 
            WHEN MONTH(OrderDate) <= 6 THEN 'Первое полугодие'
            ELSE 'Второе полугодие'
        END AS period,
        SUM(TotalCost) AS total_revenue,
        COUNT(OrderID) AS total_orders
    FROM Orders
    GROUP BY DATEPART(YEAR, OrderDate),
        CASE 
            WHEN MONTH(OrderDate) <= 6 THEN 'Первое полугодие'
            ELSE 'Второе полугодие'
        END
    
    UNION ALL
    
    SELECT
        DATEPART(YEAR, OrderDate) AS order_year,
        'Итоги за год' AS period,
        SUM(TotalCost) AS total_revenue,
        COUNT(OrderID) AS total_orders
    FROM Orders
    GROUP BY DATEPART(YEAR, OrderDate)
)
SELECT
    order_year,
    period,
    total_orders,
    total_revenue
FROM AggregatedData
ORDER BY order_year, 
         CASE 
            WHEN period LIKE 'Q%' THEN 1 
            WHEN period = 'Первое полугодие' THEN 2 
            WHEN period = 'Второе полугодие' THEN 3 
            ELSE 4 
         END;


-------------------------

--DECLARE @i INT = 0
--WHILE @i < 12
--BEGIN
--    INSERT INTO Orders (OrderID, CustomerID, VehicleID, Status, TotalCost, OrderDate, Route, DeliveryAddress, UserID, DriverID)
--    VALUES (
--        14 + @i, -- OrderID начиная с 14
--        (@i % 3) + 1, -- CustomerID в пределах от 1 до 3
--        (@i % 3) + 1, -- VehicleID в пределах от 1 до 3
--        'Completed', -- Статус заказа
--        100 + (@i * 20), -- Стоимость заказа
--        DATEFROMPARTS(2024, @i + 1, 15), -- Дата заказа в середине месяца
--        CONCAT('Route ', @i + 1), -- Маршрут
--        CONCAT('Address ', @i + 1), -- Адрес доставки
--        (@i % 3) + 1, -- UserID в пределах от 1 до 3
--        (@i % 6) + 1 -- DriverID остается в пределах от 1 до 6
--    );
--    SET @i = @i + 1
--END


----select * from Orders

	/*Вычисление итогов предоставленных услуг за определенный период:
• объем услуг;
• сравнение их с общим объемом услуг (в %);
• сравнение с максимальным объемом услуг (в %).*/
WITH ServiceVolumes AS (
    SELECT
        YEAR(OrderDate) AS order_year,
        SUM(TotalCost) AS total_revenue,
        COUNT(OrderID) AS total_orders
    FROM Orders
    GROUP BY YEAR(OrderDate)
),
MaxVolume AS (
    SELECT MAX(total_orders) AS max_orders FROM ServiceVolumes
)
SELECT
    sv.order_year,
    sv.total_orders,
    sv.total_revenue,
    ROUND((CAST(sv.total_orders AS FLOAT) / (SELECT SUM(total_orders) FROM ServiceVolumes)) * 100, 2) AS percentage_of_total,
    ROUND((CAST(sv.total_orders AS FLOAT) / (SELECT max_orders FROM MaxVolume)) * 100, 2) AS percentage_of_max
FROM ServiceVolumes sv
ORDER BY sv.order_year;



	--Применение функции ROW_NUMBER() для разбиения на страницы

--	select * from orders


	DECLARE @PageNumber INT = 1;  --  номер страницы
DECLARE @RowsPerPage INT = 20;  -- Количество строк на странице

WITH PaginatedResults AS (
    SELECT 
        OrderID,
        CustomerID,
        VehicleID,
        Status,
        TotalCost,
        OrderDate,
        ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNum
    FROM 
        Orders
)

SELECT 
    *
FROM 
    PaginatedResults
WHERE 
    RowNum BETWEEN (@PageNumber - 1) * @RowsPerPage + 1 AND @PageNumber * @RowsPerPage
ORDER BY 
    RowNum;



	-- Применение функции ROW_NUMBER() для удаления дубликатов
WITH Duplicates AS (
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
        DriverID,
        ROW_NUMBER() OVER (
            PARTITION BY CustomerID, VehicleID, Status, TotalCost, OrderDate, Route, DeliveryAddress, UserID, DriverID 
            ORDER BY OrderID
        ) AS RowNum
    FROM Orders
)
DELETE FROM Orders
WHERE OrderID IN (
    SELECT OrderID FROM Duplicates WHERE RowNum > 1
);


select * from orders



--Добавление дублекатов

INSERT INTO Orders (OrderID, CustomerID, VehicleID, Status, TotalCost, OrderDate, Route, DeliveryAddress, UserID, DriverID)
VALUES (1001, 1, 1, 'Completed', 150.00, '2023-10-01', 'Route A', 'Address 1', 1, NULL);

INSERT INTO Orders (OrderID, CustomerID, VehicleID, Status, TotalCost, OrderDate, Route, DeliveryAddress, UserID, DriverID)
VALUES (1002, 1, 1, 'Completed', 150.00, '2023-10-01', 'Route A', 'Address 1', 1, NULL);




--Вернуть для каждого клиента направления последних 6 заказов.

WITH LastSixOrders AS (
    SELECT 
        OrderID,
        CustomerID,
        VehicleID,
        Status,
        TotalCost,
        OrderDate,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS RowNum
    FROM 
        Orders
)

SELECT 
    OrderID,
    CustomerID,
    VehicleID,
    Status,
    TotalCost,
    OrderDate
FROM 
    LastSixOrders
WHERE 
    RowNum <= 6
ORDER BY 
    CustomerID, OrderDate DESC;



	--Какой маршрут пользовался наибольшей популярностью для определенного типа автомобилей? Вернуть для всех типов.

	WITH RoutePopularity AS (
    SELECT 
        VehicleID,
        Route,  -- Предполагается, что у вас есть столбец 'Route'
        COUNT(OrderID) AS OrderCount,
        ROW_NUMBER() OVER (PARTITION BY VehicleID ORDER BY COUNT(OrderID) DESC) AS Rank
    FROM 
        Orders
    GROUP BY 
        VehicleID, Route
)

SELECT 
    VehicleID,
    Route,
    OrderCount
FROM 
    RoutePopularity
WHERE 
    Rank = 1
ORDER BY 
    VehicleID;