select PULPIT.PULPIT as �������, ISNULL(TEACHER.TEACHER_NAME,'��� �������������') as �������������
from PULPIT left outer join TEACHER
on PULPIT.PULPIT = TEACHER.PULPIT
