select case 
	when NOTE = 4 then '����������� ������'
	when NOTE between 5 and 6 then '���� ������������'
	when NOTE between 7 and 8 then '������� �������'
	when NOTE between 9 and 10 then '������� �������'
		else '���������'
	end ������, count(*)[���-��]	
from PROGRESS
group by case
	when NOTE = 4 then '����������� ������'
	when NOTE between 5 and 6 then '���� ������������'
	when NOTE between 7 and 8 then '������� �������'
	when NOTE between 9 and 10 then '������� �������'
		else '���������'
	end;