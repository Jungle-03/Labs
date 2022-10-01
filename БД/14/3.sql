
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
	set @ALL_INS = 'После изменения — Код: ' + @ins1 + '  Имя: '+ @ins2 + '  Пол: ' + @ins3 + '  Кафедра: ' + @ins4;

	set @del1 = (select TEACHER from deleted);
	set @del2 = (select TEACHER_NAME from deleted);
	set @del3 = (select GENDER from deleted);
	set @del4 = (select PULPIT from deleted);
	set @ALL_DEL = 'До изменения — Код: ' + @del1 + '  Имя: '+@del2 + '  Пол: ' + @del3 + '  Кафедра: ' + @del4;

	print 'Пользователь обновил строку в таблице TEACHER';
	insert into TR_AUDIT values('update', 'UpdateTriggerTeacher', concat(@ALL_DEL, @ALL_INS));
return
go

set nocount on;
insert into TEACHER values('ВНА','1','м','ИСиТ');
update TEACHER set TEACHER = '9999w8881' where TEACHER = 'ЧЧЧ';
go

select *  from TR_AUDIT;
--truncate table TR_AUDIT;