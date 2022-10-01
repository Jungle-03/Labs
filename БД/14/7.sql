use Univer3;
go

create trigger TriggerTransIns
on FACULTY after delete, insert, update
as 
declare @count int = (select count(*) from FACULTY);

if @count >= 7 
begin
	raiserror('Факультетов должно быть ровно 7! Изменения, удаления, вставки запрещены', 10, 1);
	rollback;
end;

return;
go

insert into FACULTY values('МС','Микрон Савелий');
