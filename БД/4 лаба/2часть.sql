

USE UNIVER;
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT )
                       values  ('����',    '���������� ������� ��������',  '��������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',     '�������� ����� ����������',   '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',   '������� ������� ����������', '����'); 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT )
                       values  ('����',    '������ �������� �������������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',    '������ ����� ��������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                      values  ('���',     '������� ���� ����������',  '���');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',    '����� ������ ���������', '������');
go
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('��',     '������������� ������ � ������������ ��������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('����',     '�������������� �������������� ������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('����',    '���������������� ������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('q',    '���������� ������������','��������');     
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('w',   '������� ���������� ������ ������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('e',    '���������� ��������� �������','��������'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('r', '������������� ������','����');
go
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )        values ('��',            '����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         values ('��-�',          '������������ �����');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         values ('��-�',          '���������� � ���. ����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          values  ('��-X',          '���������� �����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        values  ('��-��',   '����. ������������ �����');
go
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('301-1',   '301-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('304-4',   '304-4', '��-�', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('313-1',   '313-1', '��-�',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('314-4',   '314-4', '��-�', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('320-4',   '320-4', '��-�', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('324-1',   '324-1', '��-�',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
 values  ('413-1',   '413-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY ) 
values  ('423-1',   '423-1', '��-�', 90);
GO
USE UNIVER;
INSERT into GROUPS
         VALUES ('���','1-75 02 01', 2011),
                ( '���','1-89 02 02', 2012),
				( '���','1-89 02 02', 2011),
				( '����','1-36 06 01', 2013),
                ( '����','1-36 06 01', 2012),
                ( '����','1-46 01 01', 2012),--27 ��
				( '���','1-48 01 02', 2013), 
                ( '���','1-48 01 02', 2012),     
                ( '���','1-48 01 02', 2010),
                ( '���','1-48 01 02', 2013),
                ( '���','1-54 01 03', 2012); 
---32 ��

insert into STUDENT (IDGROUP,NAME, BDAY)
    values (23, '����� ������ ����������',         '12.01.1996'),
           (23, '������ ������� ��������',    '19.07.1996'),
           (23, '������ ����� ����������',     '22.05.1996'),
           (24, '������ ������ ��������',        '08.12.1996'),
           (25, '������ ������ ����������', '11.11.1995'),
           (26, '������ ������� ����������',       '24.08.1996'),
           (27, '����� ���� �������������',         '15.09.1996'),
           (28, '������ ���� ��������',      '16.10.1996')

insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values  ('��', 1000,  '12.01.2014',4),
           ('����', 1001,  '19.01.2014',5),
           ('����', 1003,  '08.01.2014',9);
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values   ('��', 1006,  '11.01.2014',8),
           ('����', 1007,  '15.01.2014',4);
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values   ('����', 1005,  '16.01.2014',7),
           ('����', 1004,  '27.01.2014',6);