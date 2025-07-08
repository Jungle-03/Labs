/*2.	������� ��������� ���� ������ �� ������ ��������, ����������:
a.	�������������� �����������;
b.	����� ��������� ���� MAP ��� ORDER;
c.	����� ���������� �������;
d.	����� ���������� ���������.*/



---
CREATE OR REPLACE TYPE OrderType AS OBJECT (
    ORDERID NUMBER(22),
    CUSTOMERID NUMBER(22),
    VEHICLEID NUMBER(22),
    DRIVERIDINT NUMBER(22),
    ORDERDATE DATE,
    STATUS VARCHAR2(255),
    ROUTE VARCHAR2(255),
    DELIVERYADDRESS VARCHAR2(255),
    TOTALCOST NUMBER(22),
    USERID NUMBER(22),
    
    -- �������� �����������
    CONSTRUCTOR FUNCTION OrderType (
        p_ORDERID NUMBER,
        p_CUSTOMERID NUMBER,
        p_VEHICLEID NUMBER,
        p_DRIVERIDINT NUMBER,
        p_ORDERDATE DATE,
        p_STATUS VARCHAR2,
        p_ROUTE VARCHAR2,
        p_DELIVERYADDRESS VARCHAR2,
        p_TOTALCOST NUMBER,
        p_USERID NUMBER
    ) RETURN SELF AS RESULT,

    -- �������������� �����������
    CONSTRUCTOR FUNCTION OrderType (
        p_ORDERID NUMBER,
        p_CUSTOMERID NUMBER,
        p_VEHICLEID NUMBER,
        p_DRIVERIDINT NUMBER
    ) RETURN SELF AS RESULT,

    -- ����� ��������� ����� MAP
    MAP MEMBER FUNCTION compare RETURN NUMBER,

    -- ����� ���������� (�������)
    MEMBER FUNCTION getOrderInfo RETURN VARCHAR2,
    
    -- ����� ���������� (���������)
    MEMBER PROCEDURE updateOrderStatus (newStatus IN VARCHAR2)
);




--



CREATE OR REPLACE TYPE BODY OrderType AS

    -- �������� �����������
    CONSTRUCTOR FUNCTION OrderType (
        p_ORDERID NUMBER,
        p_CUSTOMERID NUMBER,
        p_VEHICLEID NUMBER,
        p_DRIVERIDINT NUMBER,
        p_ORDERDATE DATE,
        p_STATUS VARCHAR2,
        p_ROUTE VARCHAR2,
        p_DELIVERYADDRESS VARCHAR2,
        p_TOTALCOST NUMBER,
        p_USERID NUMBER
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.ORDERID := p_ORDERID;
        SELF.CUSTOMERID := p_CUSTOMERID;
        SELF.VEHICLEID := p_VEHICLEID;
        SELF.DRIVERIDINT := p_DRIVERIDINT;
        SELF.ORDERDATE := p_ORDERDATE;
        SELF.STATUS := p_STATUS;
        SELF.ROUTE := p_ROUTE;
        SELF.DELIVERYADDRESS := p_DELIVERYADDRESS;
        SELF.TOTALCOST := p_TOTALCOST;
        SELF.USERID := p_USERID;
        RETURN;
    END;

    -- �������������� �����������
    CONSTRUCTOR FUNCTION OrderType (
        p_ORDERID NUMBER,
        p_CUSTOMERID NUMBER,
        p_VEHICLEID NUMBER,
        p_DRIVERIDINT NUMBER
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.ORDERID := p_ORDERID;
        SELF.CUSTOMERID := p_CUSTOMERID;
        SELF.VEHICLEID := p_VEHICLEID;
        SELF.DRIVERIDINT := p_DRIVERIDINT;
        
        -- �������� �� ���������
        SELF.ORDERDATE := SYSDATE;
        SELF.STATUS := 'New';
        SELF.ROUTE := 'Not specified';
        SELF.DELIVERYADDRESS := 'Not specified';
        SELF.TOTALCOST := 0;
        SELF.USERID := 0;
        
        RETURN;
    END;

    -- ����� ��������� (MAP)
    MAP MEMBER FUNCTION compare RETURN NUMBER IS
    BEGIN
        RETURN SELF.ORDERID;
    END;

    -- ����� ���������� (�������)
    MEMBER FUNCTION getOrderInfo RETURN VARCHAR2 IS
    BEGIN
        RETURN 'Order ID: ' || SELF.ORDERID || ', Customer ID: ' || SELF.CUSTOMERID || 
               ', Vehicle ID: ' || SELF.VEHICLEID || ', Driver ID: ' || SELF.DRIVERIDINT || 
               ', Status: ' || SELF.STATUS || ', Route: ' || SELF.ROUTE || ', Delivery Address: ' ||
               SELF.DELIVERYADDRESS || ', Total Cost: ' || SELF.TOTALCOST || ', User ID: ' || SELF.USERID;
    END;

    -- ����� ���������� (���������)
    MEMBER PROCEDURE updateOrderStatus (newStatus IN VARCHAR2) IS
    BEGIN
        SELF.STATUS := newStatus;
    END;

END;




---�
DECLARE
    order2 OrderType;
BEGIN
    order2 := OrderType(3, 102, 203, 304);  -- ������ ������������ ���������
    DBMS_OUTPUT.PUT_LINE('OrderID: ' || order2.ORDERID);
    DBMS_OUTPUT.PUT_LINE('OrderDate: ' || order2.ORDERDATE);
END;



--------�




DECLARE
    order1 OrderType;
    order2 OrderType;
BEGIN
    order1 := OrderType(1, 101, 201, 301);
    order2 := OrderType(2, 102, 202, 302);

    IF order1 < order2 THEN
        DBMS_OUTPUT.PUT_LINE('order1 ������ order2');
    ELSIF order1 > order2 THEN
        DBMS_OUTPUT.PUT_LINE('order1 ������ order2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('order1 ����� order2');
    END IF;
END;




--�

--���� ����� ����� ���������� ������ � ��������� ����������� � ������.

DECLARE
    order1 OrderType;
BEGIN
    -- ������� ������ � �������������� �������������
    order1 := OrderType(1, 102, 203, 304);  -- ������ ������������ ���������
    
    -- �������� ���������� � ������ � ������� ������ getOrderInfo
    DBMS_OUTPUT.PUT_LINE(order1.getOrderInfo);
END;




--------�

--��� ���������, ������� ��������� �������� newStatus � ��������� ������ ������� OrderType.


DECLARE
    order1 OrderType;
BEGIN
    -- ������� ������ � �������������� �������������
    order1 := OrderType(3, 102, 203, 304);  -- ������ ������������ ���������
    
    -- ������� �������� ���������� � ������
    DBMS_OUTPUT.PUT_LINE('Before Update: ' || order1.getOrderInfo);
    
    -- ��������� ������ ������
    order1.updateOrderStatus('Completed');
    
    -- ������� ����������� ���������� � ������
    DBMS_OUTPUT.PUT_LINE('After Update: ' || order1.getOrderInfo);
END;




--------------------------------------------------------------

---����������� ������ �� ����������� ������ � ���������


CREATE OR REPLACE TYPE CustomerType AS OBJECT (
    CUSTOMERID NUMBER(22),
    FIRSTNAME VARCHAR2(50),
    LASTNAME VARCHAR2(50),
    PASSPORTNUMBER VARCHAR2(20),
    ADDRESS VARCHAR2(255),
    
    -- �����, ������������ ������ ����� �����
    MEMBER FUNCTION getFirstLetter RETURN VARCHAR2
);



CREATE TABLE CustomerObjectTable OF CustomerType;



INSERT INTO CustomerObjectTable
SELECT CustomerType(CUSTOMERID, FIRSTNAME, LASTNAME, PASSPORTNUMBER, ADDRESS)
FROM CUSTOMERS;


select * from CustomerObjectTable;





----.	������������������ ���������� ��������� �������������


CREATE OR REPLACE VIEW CustomerObjectView OF CustomerType  
WITH OBJECT IDENTIFIER (CUSTOMERID)  
AS  
SELECT CUSTOMERID, FIRSTNAME, LASTNAME, PASSPORTNUMBER, ADDRESS  
FROM CUSTOMERS;



SELECT * FROM CustomerObjectView;







-----   5.	������������������ ���������� �������� ��� �������������� �� �������� � �� ������ � ��������� �������.



CREATE OR REPLACE TYPE VehicleType AS OBJECT (
    VEHICLEID NUMBER(22),
    LICENSEPLATE VARCHAR2(15),
    MODEL VARCHAR2(50),
    YEAR NUMBER(4),
    CAPACITY NUMBER(22),
    
    -- ��������� ����� � ������������
    MEMBER FUNCTION getVehicleInfo RETURN VARCHAR2
);




CREATE OR REPLACE TYPE BODY VehicleType AS
    MEMBER FUNCTION getVehicleInfo RETURN VARCHAR2 IS
    BEGIN
        RETURN 'Vehicle ' || LICENSEPLATE || ' - ' || MODEL || ' (' || YEAR || ')';
    END;
END;



CREATE TABLE VehicleObjectTable OF VehicleType;

CREATE INDEX idx_licenseplate ON VehicleObjectTable (LICENSEPLATE);








-- ��������� ������
INSERT INTO VehicleObjectTable VALUES (1, 'ABC123', 'Toyota', 2020, 5);
INSERT INTO VehicleObjectTable VALUES (2, 'XYZ789', 'Ford', 2018, 5);
INSERT INTO VehicleObjectTable VALUES (3, 'LMN456', 'Honda', 2022, 7);

-- ���������� ������ �� ��������
SELECT * FROM VehicleObjectTable WHERE LICENSEPLATE = 'XYZ789';

-- ���������� ������ �� ������
SELECT VEHICLEID, v.getVehicleInfo()
FROM VehicleObjectTable v
WHERE v.VEHICLEID = 1;

