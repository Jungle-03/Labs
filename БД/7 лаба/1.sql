drop view[Преподаватель]
go



---------task 1
create view [Преподаватель]
as select	TEACHER[Сокращение], TEACHER_NAME[Имя преподавателя], GENDER[Пол], PULPIT[Кафедра] from TEACHER

go

select * from [Преподаватель]
go

--------task 2

create view [Количество кафедр]
as select FACULTY,count(PULPIT)[Количество кафедр] from PULPIT
group by FACULTY

go 
select * from [Количество кафедр]
go

--task 3-4

create view [Аудитории]
as select AUDITORIUM, AUDITORIUM_CAPACITY, AUDITORIUM_NAME, AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM_TYPE like 'ЛК'
with check option;
go 
select * from [Аудитории]
go

insert [Аудитории] values ('200-3a',120,'200-3a','ЛК')
go
insert [Аудитории] values ('314-1',10,'314-1','ЛБ-К') -- ошибка из-за ограничения with chek options

delete from [Аудитории] where AUDITORIUM = '200-3a'

update [Аудитории] set AUDITORIUM = '200-4' where AUDITORIUM = '236-1'


--task 5

create view [Дисциплины]
as select top(150) * from SUBJECT
order by SUBJECT_NAME
go
select * from [Дисциплины]
go

--task 6

create view [Количество кафедр 2.0]
as select FACULTY,count(PULPIT)[Количество кафедр] from PULPIT
group by FACULTY

go 
select * from [Количество кафедр 2.0]
go
 --начало выполнения задания

alter view [Количество кафедр 2.0] with schemabinding
as select FACULTY, count(*)[Кол-во] 
from dbo.PULPIT
group by FACULTY;
go
 
