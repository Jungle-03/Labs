-- 1. ���������� ���-�� �������, �������� ������������ ������� ����� � ������������� �� �������� ���������� �������� ���� �������
SELECT OFFICE, COUNT(*)[����������� �������] FROM OFFICES
INNER JOIN SALESREPS 
ON OFFICE = REP_OFFICE

INNER JOIN ORDERS 
ON EMPL_NUM =REP

GROUP BY OFFICE
ORDER BY [����������� �������]DESC;
--2. ����� �����, � �������� ���� ������ � ������ � 01.01.2007 �� 01.01.2008

SELECT DISTINCT OFFICE, CITY, TARGET FROM OFFICES 
INNER JOIN SALESREPS  
ON REP_OFFICE = OFFICE

INNER JOIN ORDERS  
ON EMPL_NUM = REP
WHERE  ORDER_DATE BETWEEN '2007-1-1' AND '2008-1-1'





--3


--4
SELECT OFFICE, CITY, TARGET FROM OFFICES
INNER JOIN CUSTOMERS ON  CREDIT_LIM = 

