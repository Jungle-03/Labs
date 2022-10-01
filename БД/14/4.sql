
go

create trigger TriggerTeacher
on TEACHER after insert,delete,update
as
	declare @del_Count int = (select count(*) from deleted);
	declare @ins_Count int = (select count(*) from inserted);

	if @ins_Count > 0 and @del_Count = 0
	begin
		declare @var1 varchar(20), @var2 varchar(50), @var3 varchar(20), @var4 varchar(20), @ALL varchar (200)
		--set @var1 = (select TEACHER from inserted);
		set @var2 = (select TEACHER_NAME from inserted);
		set @var3 = (select GENDER from inserted);
		set @var4 = (select PULPIT from inserted);
	
		set @ALL = 'Имя: '+@var2 + '  Пол: ' + @var3 + '  Кафедра: ' + @var4;

		print 'Пользователь добавил строку в таблицу TEACHER';
		insert into TR_AUDIT values('insert', 'TriggerTeacher', @ALL);
	end;

	if @del_Count > 0 and @ins_Count = 0
	begin
		set @var2 = (select TEACHER_NAME from deleted);
		set @var3 = (select GENDER from deleted);
		set @var4 = (select PULPIT from deleted);
	
		set @ALL = 'Имя: '+@var2 + '  Пол: ' + @var3 + '  Кафедра: ' + @var4;

		print 'Пользователь удалил строку из таблицы TEACHER';
		insert into TR_AUDIT values('delete', 'TriggerTeacher', @ALL);
	end;

	if @del_Count > 0 and @ins_Count > 0
	begin
		set @var1 = (select TEACHER from deleted);
		set @var2 = (select TEACHER_NAME from deleted);
		set @var3 = (select GENDER from deleted);
		set @var4 = (select PULPIT from deleted);
		set @ALL = 'До изменения — Код: ' + @var1 + '  Имя: '+@var2 + '  Пол: ' + @var3 + '  Кафедра: ' + @var4;

		set @var1 = (select TEACHER from inserted);
		set @var2 = (select TEACHER_NAME from inserted);
		set @var3 = (select GENDER from inserted);
		set @var4 = (select PULPIT from inserted);
		set @ALL = @ALL + '     После изменения — Код: ' + @var1 + '  Имя: '+ @var2 + '  Пол: ' + @var3 + '  Кафедра: ' + @var4;

		print 'Пользователь обновил стркоу в таблице Teacher';
		insert into TR_AUDIT values('update', 'TriggerTeacher', @ALL);
	end;
return
go

set nocount on;
insert into TEACHER values('ВНА','Врублевский Никита Андреевич', 'м', 'ИСиТ');
delete from TEACHER where TEACHER = 'ВНА';
update TEACHER set TEACHER = 'Nikawak' where TEACHER = 'Nik';
go

select *  from TR_AUDIT;

truncate table TR_AUDIT;

select * from TEACHER;