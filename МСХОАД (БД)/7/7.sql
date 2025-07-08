--1. Запрос для планирования стоимости перевозок с учетом роста затрат на 10%



SELECT CUSTOMERID, 
       MONTH, 
       TOTALCOST,
       NEWCOST
FROM (
    SELECT CUSTOMERID, 
           EXTRACT(MONTH FROM ORDERDATE) AS MONTH,
           SUM(TOTALCOST) AS TOTALCOST
    FROM Orders
    WHERE EXTRACT(YEAR FROM ORDERDATE) = EXTRACT(YEAR FROM SYSDATE) - 1
    AND STATUS = 'Completed'
    GROUP BY CUSTOMERID, EXTRACT(MONTH FROM ORDERDATE)
)
MODEL
    DIMENSION BY (CUSTOMERID, MONTH)
    MEASURES (TOTALCOST, 0 AS NEWCOST) -- Определяем NEWCOST с начальным значением
    RULES (
        NEWCOST[ANY, ANY] = TOTALCOST[CV(CUSTOMERID), CV(MONTH)] * 1.10
    )
ORDER BY CUSTOMERID, MONTH;


--Рост, падение, рост предоставления для каждого вида услуг

SELECT CUSTOMERID,
Rise1_Date, Rise1_Cost,
Fall_Date, Fall_Cost,
Rise2_Date, Rise2_Cost
FROM Orders
MATCH_RECOGNIZE (
PARTITION BY CUSTOMERID
ORDER BY ORDERDATE
MEASURES
    FIRST(ORDERDATE) AS Rise1_Date,
    FIRST(TOTALCOST) AS Rise1_Cost,
    LAST(ORDERDATE) AS Fall_Date,
    LAST(TOTALCOST) AS Fall_Cost,
    FIRST(ORDERDATE) AS Rise2_Date,
    FIRST(TOTALCOST) AS Rise2_Cost
PATTERN (rise1 fall rise2)
DEFINE
rise1 AS TOTALCOST > PREV(TOTALCOST),
fall AS TOTALCOST < PREV(TOTALCOST),
rise2 AS TOTALCOST > PREV(TOTALCOST)
)
ORDER BY CUSTOMERID, Rise1_Date;

