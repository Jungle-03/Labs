
go

/*
drop trigger InsertTriggerTeacher;
drop trigger DeleteTriggerTeacher;
drop trigger UpdateTriggerTeacher;
drop trigger TriggerTeacher;
drop trigger TriggerINS1;
drop trigger TriggerINS2;
drop trigger TriggerINS3;
drop trigger InsteadFacultyTrigger
drop trigger TriggerTransIns*/

create trigger InsertTriggerTeacher
on TEACHER after insert 
as
	declare @var1 varchar(20), @var2 varchar(50), @var3 varchar(20), @var4 varchar(20), @ALL varchar (200)
	--set @var1 = (select TEACHER from inserted);
	set @var2 = (select TEACHER_NAME from inserted);
	set @var3 = (select GENDER from inserted);
	set @var4 = (select PULPIT from inserted);
	
	set @ALL = '���: '+@var2 + '  ���: ' + @var3 + '  �������: ' + @var4;

	print '������������ ������� ������ � ������� TEACHER';
	insert into TR_AUDIT values('insert', 'InsertTriggerTeacher', @ALL);
return
go

set nocount on;
insert into TEACHER values('���','��� ��������� �������', '�', '����');
go

select *  from TR_AUDIT;