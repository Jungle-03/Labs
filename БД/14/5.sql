use Univer3;

--alter table TEACHER add constraint Количество check (Количество > 10)
go

update TEACHER set GENDER = 'муж.' where GENDER = 'м';

select * from TR_AUDIT;
truncate table TR_AUDIT;
