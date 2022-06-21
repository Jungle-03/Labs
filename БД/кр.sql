-- 1. ондявхрюрэ йнк-бн рнбюпнб, гюйюгюмш янрпсдмхйюлх йюфднцн нтхяю х нрянпрхпнбюрэ он сашбюмхч ясллюпмнцн гмювемхъ бяеу гюйюгнб
SELECT OFFICE, COUNT(*)[йнккхвеярбн гюйюгнб] FROM OFFICES
INNER JOIN SALESREPS 
ON OFFICE = REP_OFFICE

INNER JOIN ORDERS 
ON EMPL_NUM =REP

GROUP BY OFFICE
ORDER BY [йнккхвеярбн гюйюгнб]DESC;
--2. мюирх нтхяш, б йнрнпшиу ашкх гюйюгш б оепхнд я 01.01.2007 он 01.01.2008

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

