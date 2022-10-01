use Univer3;
go

select t.name, e.type_desc 
	from sys.triggers  t join  sys.trigger_events e  
	on t.object_id = e.object_id  
	where OBJECT_NAME(t.parent_id) = 'TEACHER' and 
	e.type_desc = 'INSERT' ;  
go

create trigger TriggerINS1 on TEACHER after insert
as print 'Сработал триггер №1';
return;
go

create trigger TriggerINS2 on TEACHER after insert
as print 'Сработал триггер №2';
return;
go

create trigger TriggerINS3 on TEACHER after insert
as print 'Сработал триггер №3';
return;
go

exec  SP_SETTRIGGERORDER @triggername = 'TriggerINS3', 
	                     @order = 'First', @stmttype = 'INSERT';

exec  SP_SETTRIGGERORDER @triggername = 'TriggerINS2', 
	                     @order = 'Last', @stmttype = 'INSERT';

insert into TEACHER values ('1','fr','м','ИСиТ');