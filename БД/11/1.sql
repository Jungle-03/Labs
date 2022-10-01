
set implicit_transactions on
--drop table FirstTask;

create table FirstTask(x int);
insert FirstTask values(1),(2),(3);
declare @res varchar = (select count(*) from FirstTask);
print @res;

if 1=0 commit
else rollback;

set implicit_transactions off


if  exists (select * from  SYS.OBJECTS      
	            where OBJECT_ID= object_id(N'DBO.FirstTask') )
print 'Таблица есть';
else print 'Таблицы нет';

