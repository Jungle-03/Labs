

-- task 1

select count(*) [Количество аудиторий], max(AUDITORIUM.AUDITORIUM_CAPACITY)[Максимальная вместительность],
min(AUDITORIUM.AUDITORIUM_CAPACITY)[Минимальная вместительность],sum(AUDITORIUM.AUDITORIUM_CAPACITY)[Сумарная вместительность]
from AUDITORIUM

--task 2

select  at1.AUDITORIUM_TYPE[Тип аудитории],count(*)[Количество аудиторий],
max(at1.AUDITORIUM_CAPACITY)[Максимальная вместимость],min(at1.AUDITORIUM_CAPACITY)[Минимальная вместимость],
sum(at1.AUDITORIUM_CAPACITY)[Сумарная вместимость]    
from AUDITORIUM at1 group by at1.AUDITORIUM_TYPE

--task 3

select * 
from 
(
select case 
when NOTE = 10 then 'десять'
when NOTE = 8 or NOTE = 9 then 'восемь-девять'
when NOTE = 6 or NOTE = 7 then 'шесть-семь'
when NOTE = 4 or NOTE = 5 then 'четыре-пять'
else 'ниже четырёх'
end[Оценки], COUNT(*)[Кол-во]

from PROGRESS group by case 
when NOTE = 10 then 'десять'
when NOTE = 8 or NOTE = 9 then 'восемь-девять'
when NOTE = 6 or NOTE = 7 then 'шесть-семь'
when NOTE = 4 or NOTE = 5 then 'четыре-пять' 
else 'ниже четырёх'
end) as T

order by case[Оценки]
when 'десять' then 1
when 'восемь-девять' then 2
when 'шесть-семь'  then 3
when 'четыре-пять' then 4 
else 5
end ;


--============= 4.1 =============-- 

select f.FACULTY, g.PROFESSION, (2014 - g.YEAR_FIRST)[Курс],
round(avg(cast(p.NOTE as float(4))),2)[Средняя оценка] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT
group by f.FACULTY,
	     g.PROFESSION,
		 g.YEAR_FIRST
order by [Средняя оценка] desc;

--============= 4.2 =============-- 

select f.FACULTY, g.PROFESSION, p.SUBJECT,(2014 - g.YEAR_FIRST)[Курс],
round(avg(cast(p.NOTE as float(4))),2)[Средняя оценка] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT
where p.SUBJECT in( 'ОАиП','СУБД')
group by f.FACULTY,
	     g.PROFESSION,
		 g.YEAR_FIRST,
		 p.SUBJECT
order by [Средняя оценка] desc;

--============= 5 =============-- 
	
select f.FACULTY, g.PROFESSION, p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[Средняя оценка] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT

group by rollup (f.FACULTY,
				 g.PROFESSION,
				 p.SUBJECT);

--============= 6 =============-- 

select f.FACULTY, g.PROFESSION, p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[Средняя оценка] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT

group by cube (f.FACULTY,
			   g.PROFESSION,
			   p.SUBJECT);

--============= 7 =============-- 

select f.FACULTY, g.PROFESSION, p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[Средняя оценка] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT

where g.FACULTY = 'ИДиП'
group by f.FACULTY, g.PROFESSION, p.SUBJECT

UNION -- все без повторений
--UNION ALL -- все
--INTERSECT -- общие
--EXCEPT --  есть в первом но нет во втором

select f.FACULTY, g.PROFESSION, p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[Средняя оценка] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT

where g.FACULTY = 'ХТиТ'
group by f.FACULTY, g.PROFESSION, p.SUBJECT

--============= 10 =============-- 

select p.SUBJECT,p.NOTE, (
select count(*) from PROGRESS pp
where pp.NOTE = p.NOTE)[Кол-во]
from PROGRESS p
group by p.SUBJECT, p.NOTE
having p.NOTE in (8,9);

