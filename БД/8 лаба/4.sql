
-----task 4.1

declare @x int =0,
		@y int =50,
		@z float;

while @x<100
begin

if(@x>@y)
	set @z = power(sin(@x),2)

if(@x<@y)
	set @z = 4 * (@y+@x)

if (@x=@y)
	set @z = 1 - exp(@x-2)

print 'x =	' + cast(@x as varchar)
print 'z =	' + cast (@z as varchar)
print '-------------------------'

set @x = @x+1
end;

------- task 4.2




declare @little varchar(20),
		@full varchar (50) = '����� ������� ����������';

set @little = SUBSTRING(@full,0,CHARINDEX(' ',@full))+' '; 

set @little = @little + SUBSTRING(@full,CHARINDEX(' ',@full)+1,1)+ '. '

set @little = @little + SUBSTRING(@full,CHARINDEX(' ',@full,CHARINDEX(' ',@full)+1)+1,1)+ '. '


print @little;




--task 4.3

select NAME, BDAY from STUDENT
where MONTH(DATEADD(m,1,getdate())) = MONTH(BDAY)

--task 4.4

select IDGROUP, NAME, SUBJECT,
case DATEPART (DW,PDATE)
when 7 then '�����������'
when 1 then '�����������'
when 2 then '�������'
when 3 then '�����'
when 4 then '�������'
when 5 then '�������'
when 6 then '�������'
end [���� ������]
from STUDENT inner join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where PROGRESS.SUBJECT like '����'

