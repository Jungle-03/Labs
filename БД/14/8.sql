use Univer3;
go

create trigger InsteadFacultyTrigger
on FACULTY instead of delete
as
	raiserror(N'Нельзя удалять факультеты', 10, 1);
return;

delete from FACULTY where FACULTY = 'ФИТ';
