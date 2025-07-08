select distinct S1.name, S1.EMPL_NUM
from SALESREPS S1
where S1.EMPL_NUM in (select distinct S2.manager from SALESREPS S2 where S2.manager is not null);




select S2.*
from SALESREPS S1
join SALESREPS S2 on S1.EMPL_NUM = S2.manager
where S1.name = 'Paul Cruz';



select *
from SALESREPS
where manager = (select EMPL_NUM from SALESREPS where name = 'Bob Smith')
   or manager in (select EMPL_NUM from SALESREPS where manager = (select EMPL_NUM from SALESREPS where name = 'Bob Smith'));
   