select isnull(TEACHER.TEACHER_NAME, 'На кафедре нет преподаватель')[Преподаватель],
PULPIT.PULPIT[Кафедра]
from TEACHER Left Outer Join PULPIT --ПОМЕНЯЛИ МЕСТАМИ
on PULPIT.PULPIT = TEACHER.PULPIT
-- в кафедре нет null (full)

select isnull(TEACHER.TEACHER_NAME, 'На кафедре нет преподавателя')[Преподаватель],
PULPIT.PULPIT[Кафедра]
from TEACHER Right Outer Join PULPIT
on PULPIT.PULPIT = TEACHER.PULPIT