
--ЗАДАНИЕ 1(разработать SELECT-запрос, вычисляющий максимальную, минимальную и среднюю вместимость аудиторий,
--суммарную вме-стимость всех аудиторий и общее количе-ство аудиторий. )
select  
min (AUDITORIUM_CAPACITY)[Минимальная вмещаемость],
max (AUDITORIUM_CAPACITY)[Макстимальная вмещаемость],
count (AUDITORIUM)[Количество аудиторий],
sum  (AUDITORIUM_CAPACITY)[Общая вмещаемость]
from AUDITORIUM

--ЗАДАНИЕ 2 (разработать запрос, вычисляющий для каж-дого типа аудиторий максимальную, мини-мальную, среднюю вместимость аудиторий, 
--суммарную вместимость всех аудиторий и общее количество аудиторий данного типа. )       
select A.AUDITORIUM_TYPE, 
count(*) [Общее количество аудиторий],
max(AUDITORIUM_CAPACITY)[Максимальная вмещаемость],
min(AUDITORIUM_CAPACITY)[Минимальная вмещаемость],
sum(AUDITORIUM_CAPACITY)[Общая вмещаемость]
from AUDITORIUM AA inner join AUDITORIUM_TYPE A
on A.AUDITORIUM_TYPE = A.AUDITORIUM_TYPE and A.AUDITORIUM_TYPE like('ЛБ%')
group by A.AUDITORIUM_TYPE;

--ЗАДАНИЕ 3(Разработать запрос на основе таблицы PROGRESS, который содержит количество экзаменационных оценок в заданном интер-вале.
--При этом учесть, что сортировка строк должна осуществляться в порядке, обратном величине оценки; 
--сумма значений в столбце количество должна быть равна количеству строк в таблице PROGRESS. )
select *
from (select case when NOTE between 4 and 5 then '4-5'
				  when NOTE between 6 and 7 then '6-7'
				  when NOTE between 8 and 9 then '8-9'
				  else '10'
				  end [MARKS], count(*)[AMOUNT]
from PROGRESS group by case
				   when NOTE between 4 and 5 then '4-5'
				  when NOTE between 6 and 7 then '6-7'
				  when NOTE between 8 and 9 then '8-9'
				  else '10'
				  end) as A 
order by case [MARKS]
			      when '4-5' then 4
				  when '6-7' then 3
				  when '8-9' then 2
				  when '10' then 1
				  else 0
				  end

--ЗАДАНИЕ 4
--Разработать SELECT-запроса на основе таблиц FACULTY, GROUPS, STUDENT и PROGRESS, 
--который содержит среднюю экзаменационную оценку для каждого кур-са каждой специальности. 
--Строки отсорти-ровать в порядке убывания средней оценки
select
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[Средняя оценка]

from FACULTY inner join GROUPS
on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
group by
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT






select
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[Средняя оценка]

from FACULTY inner join GROUPS
on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where SUBJECT.SUBJECT = 'БД' or SUBJECT.SUBJECT = 'ОАиП'
group by 
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT



--ЗАДАНИЕ 5
--На основе таблиц FACULTY, GROUPS, STUDENT и PROGRESS разработать SE-LECT-запрос, 
--в котором выводятся специ-альность, дисциплины и средние оценки при сдаче экзаменов на факультете ТОВ. 
--Использовать группировку по полям FACULTY, PROFESSION, SUBJECT.
 --Добавить в запрос конструкцию ROLLUP и проанализировать результат. 
 select
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[Средняя оценка]

from FACULTY inner join GROUPS
on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where GROUPS.FACULTY = 'ЛХФ'
group by rollup(
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT);

 --ЗАДАНИЕ 6
 --Выполнить исходный SELECT-запрос п.5 с использованием CUBE-группировки. Про-анализировать результат.
  select
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[Средняя оценка]

from FACULTY inner join GROUPS
on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where GROUPS.FACULTY = 'ЛХФ'
group by cube(
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT);


 --ЗАДАНИЕ 7
 --На основе таблиц GROUPS, STUDENT и PROGRESS разработать SELECT-запрос, в котором определяются результаты сдачи экзаменов.	
 --В запросе должны отражаться специаль-ности, дисциплины, средние оценки студен-тов на факультете ТОВ.
--Отдельно разработать запрос, в котором определяются результаты сдачи экзаменов на факультете ХТиТ.
--Объединить результаты двух запросов с использованием операторов UNION и UN-ION ALL. Объяснить результаты. 
 select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[Средняя оценка]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = 'ЛХФ'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT
UNION All
 select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[Средняя оценка]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = 'ИДиП'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT
--ЗАДАНИЕ 8
--Получить пересечение двух множеств строк, созданных в результате выполнения запросов пункта 8. Объяснить результат.
--Использовать оператор INTERSECT.
select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[Средняя оценка]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = 'ЛХФ'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT
INTERSECT
 select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[Средняя оценка]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = 'ИДиП'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT


--ЗАДАННИЕ 9
--Получить разницу между множеством строк, созданных в результате запросов пункта 8.
 --Объяснить результат. 
--Использовать оператор EXCEPT.

select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[Средняя оценка]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = 'ЛХФ'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT
EXCEPT
 select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[Средняя оценка]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = 'ТОВ'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT

--ЗАДАНИЕ 10
--На основе таблицы PROGRESS определить для каждой дисциплины количество сту-дентов, получивших оценки 8 и 9. 
--Использовать группировку, секцию HAVING, сортировку. 
select
a1.IDSTUDENT,
a1.SUBJECT,
(select COUNT(*) from PROGRESS a2
where  a2.IDSTUDENT = a1.IDSTUDENT and a2.NOTE = a1.NOTE)[KOLVO]
from PROGRESS a1
group by a1.IDSTUDENT, a1.NOTE, a1.SUBJECT
having NOTE = '8' or NOTE = '9'



