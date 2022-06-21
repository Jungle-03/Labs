
--������� 1(����������� SELECT-������, ����������� ������������, ����������� � ������� ����������� ���������,
--��������� ���-�������� ���� ��������� � ����� ������-���� ���������. )
select  
min (AUDITORIUM_CAPACITY)[����������� �����������],
max (AUDITORIUM_CAPACITY)[������������� �����������],
count (AUDITORIUM)[���������� ���������],
sum  (AUDITORIUM_CAPACITY)[����� �����������]
from AUDITORIUM

--������� 2 (����������� ������, ����������� ��� ���-���� ���� ��������� ������������, ����-�������, ������� ����������� ���������, 
--��������� ����������� ���� ��������� � ����� ���������� ��������� ������� ����. )       
select A.AUDITORIUM_TYPE, 
count(*) [����� ���������� ���������],
max(AUDITORIUM_CAPACITY)[������������ �����������],
min(AUDITORIUM_CAPACITY)[����������� �����������],
sum(AUDITORIUM_CAPACITY)[����� �����������]
from AUDITORIUM AA inner join AUDITORIUM_TYPE A
on A.AUDITORIUM_TYPE = A.AUDITORIUM_TYPE and A.AUDITORIUM_TYPE like('��%')
group by A.AUDITORIUM_TYPE;

--������� 3(����������� ������ �� ������ ������� PROGRESS, ������� �������� ���������� ��������������� ������ � �������� �����-����.
--��� ���� ������, ��� ���������� ����� ������ �������������� � �������, �������� �������� ������; 
--����� �������� � ������� ���������� ������ ���� ����� ���������� ����� � ������� PROGRESS. )
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

--������� 4
--����������� SELECT-������� �� ������ ������ FACULTY, GROUPS, STUDENT � PROGRESS, 
--������� �������� ������� ��������������� ������ ��� ������� ���-�� ������ �������������. 
--������ �������-������ � ������� �������� ������� ������
select
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[������� ������]

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
round(avg(cast(PROGRESS.NOTE as float(3))),2)[������� ������]

from FACULTY inner join GROUPS
on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where SUBJECT.SUBJECT = '��' or SUBJECT.SUBJECT = '����'
group by 
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT



--������� 5
--�� ������ ������ FACULTY, GROUPS, STUDENT � PROGRESS ����������� SE-LECT-������, 
--� ������� ��������� �����-��������, ���������� � ������� ������ ��� ����� ��������� �� ���������� ���. 
--������������ ����������� �� ����� FACULTY, PROFESSION, SUBJECT.
 --�������� � ������ ����������� ROLLUP � ���������������� ���������. 
 select
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[������� ������]

from FACULTY inner join GROUPS
on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where GROUPS.FACULTY = '���'
group by rollup(
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT);

 --������� 6
 --��������� �������� SELECT-������ �.5 � �������������� CUBE-�����������. ���-������������� ���������.
  select
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[������� ������]

from FACULTY inner join GROUPS
on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where GROUPS.FACULTY = '���'
group by cube(
FACULTY.FACULTY_NAME,
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT);


 --������� 7
 --�� ������ ������ GROUPS, STUDENT � PROGRESS ����������� SELECT-������, � ������� ������������ ���������� ����� ���������.	
 --� ������� ������ ���������� ��������-�����, ����������, ������� ������ ������-��� �� ���������� ���.
--�������� ����������� ������, � ������� ������������ ���������� ����� ��������� �� ���������� ����.
--���������� ���������� ���� �������� � �������������� ���������� UNION � UN-ION ALL. ��������� ����������. 
 select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[������� ������]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = '���'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT
UNION All
 select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[������� ������]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = '����'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT
--������� 8
--�������� ����������� ���� �������� �����, ��������� � ���������� ���������� �������� ������ 8. ��������� ���������.
--������������ �������� INTERSECT.
select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[������� ������]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = '���'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT
INTERSECT
 select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[������� ������]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = '����'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT


--�������� 9
--�������� ������� ����� ���������� �����, ��������� � ���������� �������� ������ 8.
 --��������� ���������. 
--������������ �������� EXCEPT.

select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[������� ������]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = '���'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT
EXCEPT
 select
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT,
round(avg(cast(PROGRESS.NOTE as float(3))),2)[������� ������]
from GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join SUBJECT
on PROGRESS.SUBJECT = SUBJECT.SUBJECT
where  GROUPS.FACULTY = '���'
group by 
GROUPS.PROFESSION,
STUDENT.IDSTUDENT,
SUBJECT.SUBJECT

--������� 10
--�� ������ ������� PROGRESS ���������� ��� ������ ���������� ���������� ���-������, ���������� ������ 8 � 9. 
--������������ �����������, ������ HAVING, ����������. 
select
a1.IDSTUDENT,
a1.SUBJECT,
(select COUNT(*) from PROGRESS a2
where  a2.IDSTUDENT = a1.IDSTUDENT and a2.NOTE = a1.NOTE)[KOLVO]
from PROGRESS a1
group by a1.IDSTUDENT, a1.NOTE, a1.SUBJECT
having NOTE = '8' or NOTE = '9'



