drop view[�������������]
go



---------task 1
create view [�������������]
as select	TEACHER[����������], TEACHER_NAME[��� �������������], GENDER[���], PULPIT[�������] from TEACHER

go

select * from [�������������]
go

--------task 2

create view [���������� ������]
as select FACULTY,count(PULPIT)[���������� ������] from PULPIT
group by FACULTY

go 
select * from [���������� ������]
go

--task 3-4

create view [���������]
as select AUDITORIUM, AUDITORIUM_CAPACITY, AUDITORIUM_NAME, AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM_TYPE like '��'
with check option;
go 
select * from [���������]
go

insert [���������] values ('200-3a',120,'200-3a','��')
go
insert [���������] values ('314-1',10,'314-1','��-�') -- ������ ��-�� ����������� with chek options

delete from [���������] where AUDITORIUM = '200-3a'

update [���������] set AUDITORIUM = '200-4' where AUDITORIUM = '236-1'


--task 5

create view [����������]
as select top(150) * from SUBJECT
order by SUBJECT_NAME
go
select * from [����������]
go

--task 6

create view [���������� ������ 2.0]
as select FACULTY,count(PULPIT)[���������� ������] from PULPIT
group by FACULTY

go 
select * from [���������� ������ 2.0]
go
 --������ ���������� �������

alter view [���������� ������ 2.0] with schemabinding
as select FACULTY, count(*)[���-��] 
from dbo.PULPIT
group by FACULTY;
go
 
