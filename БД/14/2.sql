
go

create trigger DeleteTriggerTeacher
on TEACHER after delete 
as
	declare @var1 varchar(20), @var2 varchar(50), @var3 varchar(20), @var4 varchar(20), @ALL varchar (200)
	--set @var1 = (select TEACHER from deleted);
	set @var2 = (select TEACHER_NAME from deleted);
	set @var3 = (select GENDER from deleted);
	set @var4 = (select PULPIT from deleted);
	
	set @ALL = '���: '+@var2 + '  ���: ' + @var3 + '  �������: ' + @var4;

	print '������������ ������ ������ �� ������� TEACHER';
	insert into TR_AUDIT values('delete', 'DeleteTriggerTeacher', @ALL);
return
go

set nocount on;
delete from TEACHER where TEACHER = '���';
go

select *  from TR_AUDIT;