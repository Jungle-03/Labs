

-- task 1

select count(*) [���������� ���������], max(AUDITORIUM.AUDITORIUM_CAPACITY)[������������ ���������������],
min(AUDITORIUM.AUDITORIUM_CAPACITY)[����������� ���������������],sum(AUDITORIUM.AUDITORIUM_CAPACITY)[�������� ���������������]
from AUDITORIUM

--task 2

select  at1.AUDITORIUM_TYPE[��� ���������],count(*)[���������� ���������],
max(at1.AUDITORIUM_CAPACITY)[������������ �����������],min(at1.AUDITORIUM_CAPACITY)[����������� �����������],
sum(at1.AUDITORIUM_CAPACITY)[�������� �����������]    
from AUDITORIUM at1 group by at1.AUDITORIUM_TYPE

--task 3

select * 
from 
(
select case 
when NOTE = 10 then '������'
when NOTE = 8 or NOTE = 9 then '������-������'
when NOTE = 6 or NOTE = 7 then '�����-����'
when NOTE = 4 or NOTE = 5 then '������-����'
else '���� ������'
end[������], COUNT(*)[���-��]

from PROGRESS group by case 
when NOTE = 10 then '������'
when NOTE = 8 or NOTE = 9 then '������-������'
when NOTE = 6 or NOTE = 7 then '�����-����'
when NOTE = 4 or NOTE = 5 then '������-����' 
else '���� ������'
end) as T

order by case[������]
when '������' then 1
when '������-������' then 2
when '�����-����'  then 3
when '������-����' then 4 
else 5
end ;


--============= 4.1 =============-- 

select f.FACULTY, g.PROFESSION, (2014 - g.YEAR_FIRST)[����],
round(avg(cast(p.NOTE as float(4))),2)[������� ������] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT
group by f.FACULTY,
	     g.PROFESSION,
		 g.YEAR_FIRST
order by [������� ������] desc;

--============= 4.2 =============-- 

select f.FACULTY, g.PROFESSION, p.SUBJECT,(2014 - g.YEAR_FIRST)[����],
round(avg(cast(p.NOTE as float(4))),2)[������� ������] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT
where p.SUBJECT in( '����','����')
group by f.FACULTY,
	     g.PROFESSION,
		 g.YEAR_FIRST,
		 p.SUBJECT
order by [������� ������] desc;

--============= 5 =============-- 
	
select f.FACULTY, g.PROFESSION, p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[������� ������] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT

group by rollup (f.FACULTY,
				 g.PROFESSION,
				 p.SUBJECT);

--============= 6 =============-- 

select f.FACULTY, g.PROFESSION, p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[������� ������] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT

group by cube (f.FACULTY,
			   g.PROFESSION,
			   p.SUBJECT);

--============= 7 =============-- 

select f.FACULTY, g.PROFESSION, p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[������� ������] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT

where g.FACULTY = '����'
group by f.FACULTY, g.PROFESSION, p.SUBJECT

UNION -- ��� ��� ����������
--UNION ALL -- ���
--INTERSECT -- �����
--EXCEPT --  ���� � ������ �� ��� �� ������

select f.FACULTY, g.PROFESSION, p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[������� ������] 

from FACULTY f
inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT s on g.IDGROUP = s.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT

where g.FACULTY = '����'
group by f.FACULTY, g.PROFESSION, p.SUBJECT

--============= 10 =============-- 

select p.SUBJECT,p.NOTE, (
select count(*) from PROGRESS pp
where pp.NOTE = p.NOTE)[���-��]
from PROGRESS p
group by p.SUBJECT, p.NOTE
having p.NOTE in (8,9);

