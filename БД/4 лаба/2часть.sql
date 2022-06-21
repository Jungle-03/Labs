

USE UNIVER;
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT )
                       values  ('ПРКП',    'Прокопенко Николай Иванович',  'ТНХСиППМ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('МРЗВ',     'Морозова Елена Степановна',   'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('РМНВ',   'Романов Дмитрий Михайлович', 'ИСиТ'); 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT )
                       values  ('СМЛВ',    'Смелов Владимир Владиславович',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('КРЛВ',    'Крылов Павел Павлович',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                      values  ('ЧРН',     'Чернова Анна Викторовна',  'ХПД');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('МХВ',    'Мохов Михаил Сергеевич', 'ПОиСОИ');
go
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('БД',     'Представление знаний в компьютерных системах', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ОАиП',     'Проектирование информационных систем', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('СУБД',    'Программирование сетевых приложений', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('q',    'Прикладная электрохимия','ХТЭПиМЭЕ');     
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('w',   'Системы управления базами данных', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('e',    'Технология резиновых изделий','ТНХСиППМ'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('r', 'Экономическая теория','ЭТиМ');
go
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )        values ('ЛК',            'Лекционная');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         values ('ЛБ-К',          'Компьютерный класс');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         values ('ЛК-К',          'Лекционная с уст. проектором');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          values  ('ЛБ-X',          'Химическая лаборатория');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        values  ('ЛБ-СК',   'Спец. компьютерный класс');
go
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('301-1',   '301-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('304-4',   '304-4', 'ЛБ-К', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('313-1',   '313-1', 'ЛК-К',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('314-4',   '314-4', 'ЛБ-К', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('320-4',   '320-4', 'ЛБ-К', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('324-1',   '324-1', 'ЛК-К',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
 values  ('413-1',   '413-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY ) 
values  ('423-1',   '423-1', 'ЛБ-К', 90);
GO
USE UNIVER;
INSERT into GROUPS
         VALUES ('ЛХФ','1-75 02 01', 2011),
                ( 'ЛХФ','1-89 02 02', 2012),
				( 'ЛХФ','1-89 02 02', 2011),
				( 'ИДиП','1-36 06 01', 2013),
                ( 'ИДиП','1-36 06 01', 2012),
                ( 'ТТЛП','1-46 01 01', 2012),--27 гр
				( 'ТОВ','1-48 01 02', 2013), 
                ( 'ТОВ','1-48 01 02', 2012),     
                ( 'ТОВ','1-48 01 02', 2010),
                ( 'ТОВ','1-48 01 02', 2013),
                ( 'ТОВ','1-54 01 03', 2012); 
---32 гр

insert into STUDENT (IDGROUP,NAME, BDAY)
    values (23, 'Пугач Михаил Трофимович',         '12.01.1996'),
           (23, 'Авдеев Николай Иванович',    '19.07.1996'),
           (23, 'Белова Елена Степановна',     '22.05.1996'),
           (24, 'Вилков Андрей Петрович',        '08.12.1996'),
           (25, 'Грушин Леонид Николаевич', '11.11.1995'),
           (26, 'Дунаев Дмитрий Михайлович',       '24.08.1996'),
           (27, 'Клуни Иван Владиславович',         '15.09.1996'),
           (28, 'Крылов Олег Павлович',      '16.10.1996')

insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values  ('БД', 1000,  '12.01.2014',4),
           ('ОАиП', 1001,  '19.01.2014',5),
           ('СУБД', 1003,  '08.01.2014',9);
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values   ('БД', 1006,  '11.01.2014',8),
           ('ОАиП', 1007,  '15.01.2014',4);
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values   ('СУБД', 1005,  '16.01.2014',7),
           ('СУБД', 1004,  '27.01.2014',6);