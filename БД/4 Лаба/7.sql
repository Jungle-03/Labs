select isnull(TEACHER.TEACHER_NAME, '�� ������� ��� �������������')[�������������],
PULPIT.PULPIT[�������]
from TEACHER Left Outer Join PULPIT --�������� �������
on PULPIT.PULPIT = TEACHER.PULPIT
-- � ������� ��� null (full)

select isnull(TEACHER.TEACHER_NAME, '�� ������� ��� �������������')[�������������],
PULPIT.PULPIT[�������]
from TEACHER Right Outer Join PULPIT
on PULPIT.PULPIT = TEACHER.PULPIT