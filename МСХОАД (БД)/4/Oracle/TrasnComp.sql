-- ���������� ��������
INSERT INTO customers (
    customerid,
    firstname,
    lastname,
    passportnumber
) VALUES (
    1,
    '����',
    '������',
    '1234567890'
);

INSERT INTO customers (
    customerid,
    firstname,
    lastname,
    passportnumber
) VALUES (
    2,
    '�����',
    '�������',
    '0987654321'
);

INSERT INTO customers (
    customerid,
    firstname,
    lastname,
    passportnumber
) VALUES (
    3,
    '�������',
    '�������',
    '1122334455'
);

-- ���������� ���������
INSERT INTO drivers (
    driverid,
    firstname,
    licensenumber,
    experienceyears,
    passportnumber
) VALUES (
    1,
    '������',
    'A1234567',
    5,
    '1234567890'
);

INSERT INTO drivers (
    driverid,
    firstname,
    licensenumber,
    experienceyears,
    passportnumber
) VALUES (
    2,
    '�����',
    'B7654321',
    3,
    '0987654321'
);

-- ���������� ������������ �������
INSERT INTO vehicles (
    vehicleid,
    licenseplate,
    model,
    year,
    capacity
) VALUES (
    1,
    'A123BC',
    'Toyota',
    2020,
    5
);

INSERT INTO vehicles (
    vehicleid,
    licenseplate,
    model,
    year,
    capacity
) VALUES (
    2,
    'B456CD',
    'Honda',
    2019,
    4
);

-- ���������� �������
INSERT INTO orders (
    orderid,
    customerid,
    vehicleid,
    driverid,
    status,
    route,
    totalcost
) VALUES (
    1,
    1,
    1,
    1,
    '��������',
    '������ - �����-���������',
    5000
);

INSERT INTO orders (
    orderid,
    customerid,
    vehicleid,
    driverid,
    status,
    route,
    totalcost
) VALUES (
    2,
    2,
    2,
    2,
    '��������',
    '������ - ������ ��������',
    3000
);

-- ���������� ��������
INSERT INTO payments (
    paymentid,
    orderid,
    paymentdate,
    amount
) VALUES (
    1,
    1,
    sysdate,
    5000
);

INSERT INTO payments (
    paymentid,
    orderid,
    paymentdate,
    amount
) VALUES (
    2,
    2,
    sysdate,
    3000
);



--2 ���������� ������ ��������������� ����� ���������, �� �������, �� �������, �� ���

SELECT
    month,
    SUM(totalamount)                      AS totalamount,
    SUM(SUM(totalamount))
    OVER(PARTITION BY trunc(month, 'Q'))  AS quarterlytotal,
    SUM(SUM(totalamount))
    OVER(PARTITION BY trunc(month, 'YY')) AS yearlytotal
FROM
    (
        SELECT
            trunc(paymentdate, 'MM') AS month,
            amount                   AS totalamount
        FROM
            payments
    )
GROUP BY
    month
ORDER BY
    month;


--3. ���������� ������ ��������������� ����� �� ������������ ������
WITH totalservices AS (
    SELECT
        SUM(amount) AS total
    FROM
        payments
), periodservices AS (
    SELECT
        SUM(amount) AS periodtotal
    FROM
        payments
    WHERE
        paymentdate BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2025-12-31', 'YYYY-MM-DD')
)
SELECT
    periodtotal,
    ( periodtotal / (
        SELECT
            total
        FROM
            totalservices
    ) * 100 ) AS percentageoftotal,
    ( periodtotal / (
        SELECT
            MAX(amount)
        FROM
            payments
    ) * 100 ) AS percentageofmax
FROM
    periodservices;

--4. ���������� ������� ������������ ROW_NUMBER() ��� ��������� ����������� �� ��������

-- ������������ ������������� ROW_NUMBER() ��� ������������� ������
-- ������������ ������������� ROW_NUMBER() ��� ������������� ������
WITH rankedcustomers AS (
    SELECT
        customerid,
        firstname,
        lastname,
        passportnumber,
        ROW_NUMBER()
        OVER(
            ORDER BY
                customerid
        ) AS rownum
    FROM
        customers
)
SELECT
    customerid,
    firstname,
    lastname,
    passportnumber
FROM
    rankedcustomers
WHERE
    ROWNUM BETWEEN :startrow AND :endrow;

--5. ���������� ������� ������������ ROW_NUMBER() ��� �������� ����������

DELETE FROM orders
WHERE
    orderid IN (
        SELECT
            orderid
        FROM
            (
                SELECT
                    orderid, ROW_NUMBER()
                             OVER(
                        ORDER BY
                            orderid
                             ) AS rownum
                FROM
                    orders
            )
        WHERE
            ROWNUM BETWEEN 1 AND 20  -- ������� �������� ��� ��������
    );


--6. ������� ��� ������� ������� ����������� ��������� 6 �������


SELECT CustomerID, Route
FROM (
    SELECT ( customerid,
                                          route,
ROW_NUMBER()
OVER(PARTITION BY customerid
     ORDER BY
         orderid DESC
) AS rownum )
    FROM Orders
) RankedResults
WHERE RowNum <= 6;  -- ������� ���������� �������


--7. ���������� ������������ �������� ��� ������������� ���� �����������


SELECT Route, VehicleID, COUNT(*) AS Popularity
FROM Orders
GROUP BY Route, VehicleID
ORDER BY Popularity DESC;