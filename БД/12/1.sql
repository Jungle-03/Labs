
go
--drop procedure pSubject;
--============== 1 ==============--

create procedure pSubject
as
	begin
		declare @a int = (select count(*) [first] from SUBJECT)
		select * from SUBJECT
		return @a
	end;

	go


alter procedure pSubject as 
begin
	declare @a int = (select count(*)[second] from SUBJECT)
	select s.SUBJECT, s.SUBJECT_NAME, s.PULPIT from SUBJECT s;
	return @a;
end
go

declare @res1 int;
exec @res1 = pSubject
print @res1;
go


