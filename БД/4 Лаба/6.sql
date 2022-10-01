select PULPIT.PULPIT as Кафедра, ISNULL(TEACHER.TEACHER_NAME,'Нет преподавателя') as Преподователь
from PULPIT left outer join TEACHER
on PULPIT.PULPIT = TEACHER.PULPIT
