use Óíèâåð
--task 1
select PULPIT.PULPIT_NAME, FACULTY.FACULTY from
PULPIT, FACULTY
where FACULTY.FACULTY = PULPIT.FACULTY
and FACULTY.FACULTY in
(select PROFESSION.FACULTY from PROFESSION where(PROFESSION_NAME Like '%òåõíîëîã%'));

-- task 2

select PULPIT.PULPIT_NAME, FACULTY.FACULTY from PULPIT inner join FACULTY
 on FACULTY.FACULTY = PULPIT.FACULTY
  where FACULTY.FACULTY in
					(select PROFESSION.FACULTY from PROFESSION where (PROFESSION.PROFESSION_NAME like '%òåõíîëîã%'))

-- task 3

select distinct PULPIT.PULPIT_NAME, FACULTY.FACULTY from PULPIT 
inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
where PROFESSION_NAME Like '%òåõíîëîã%';

--task 4

select au1.AUDITORIUM_TYPE, au1.AUDITORIUM_CAPACITY, au1.AUDITORIUM_NAME from AUDITORIUM AU1
	where au1.AUDITORIUM = (select top(1) au2.AUDITORIUM from AUDITORIUM au2
	where au1.AUDITORIUM = au2.AUDITORIUM
	order by au2.AUDITORIUM_CAPACITY desc)
	order by au1.AUDITORIUM_CAPACITY ;

--task 5

select FACULTY.FACULTY, FACULTY.FACULTY_NAME from FACULTY
	where not exists (select * from PULPIT		where PULPIT.FACULTY = FACULTY.FACULTY)

--task 6


select top (1)
	(select avg(NOTE) from PROGRESS where SUBJECT like '%ÎÀèÏ%') as ÎÀèÏ,
	(select avg(NOTE) from PROGRESS where SUBJECT like '%ÁÄ%') as ÁÄ,
	(select avg(NOTE) from PROGRESS where SUBJECT like '%ÑÓÁÄ%') as ÑÓÁÄ;

-- task 7 

select NAME, IDGROUP from STUDENT
	where IDGROUP >= all (select IDGROUP from STUDENT where NAME like 'Ñ%')

--task 8

select NAME, IDGROUP from STUDENT
	where IDGROUP > any (select IDGROUP from STUDENT where NAME like 'Ñ%')

