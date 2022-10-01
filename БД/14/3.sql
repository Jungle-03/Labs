
go

create trigger UpdateTriggerTeacher
on TEACHER after update 
as
	declare @ins1 varchar(20), @ins2 varchar(50), @ins3 varchar(20), @ins4 varchar(20), @ALL_INS varchar (200);
	declare @del1 varchar(20), @del2 varchar(50), @del3 varchar(20), @del4 varchar(20), @ALL_DEL varchar (200);
	set @ins1 = (select TEACHER from inserted);
	set @ins2 = (select TEACHER_NAME from inserted);
	set @ins3 = (select GENDER from inserted);
	set @ins4 = (select PULPIT from inserted);
	set @ALL_INS = '����� ��������� � ���: ' + @ins1 + '  ���: '+ @ins2 + '  ���: ' + @ins3 + '  �������: ' + @ins4;

	set @del1 = (select TEACHER from deleted);
	set @del2 = (select TEACHER_NAME from deleted);
	set @del3 = (select GENDER from deleted);
	set @del4 = (select PULPIT from deleted);
	set @ALL_DEL = '�� ��������� � ���: ' + @del1 + '  ���: '+@del2 + '  ���: ' + @del3 + '  �������: ' + @del4;

	print '������������ ������� ������ � ������� TEACHER';
	insert into TR_AUDIT values('update', 'UpdateTriggerTeacher', concat(@ALL_DEL, @ALL_INS));
return
go

set nocount on;
insert into TEACHER values('���','1','�','����');
update TEACHER set TEACHER = '9999w8881' where TEACHER = '���';
go

select *  from TR_AUDIT;
--truncate table TR_AUDIT;