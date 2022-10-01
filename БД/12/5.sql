

create procedure subject_report @p char(50)
as
begin
	declare @count int = 0;
	declare @all varchar(200), @value varchar(10);
	declare cur cursor local static for
	select SUBJECT from SUBJECT where PULPIT = @p;
end

go

alter procedure subject_report @p char(10)
as begin
	declare @count int = 0;
	declare @all varchar(200), @value varchar(10);
	declare cur cursor local static for
	select SUBJECT from SUBJECT where PULPIT = @p;

	open cur;
	fetch cur into @value;
	if @value = null or @value = ''
		raiserror('Ошибка, на кафедре нет дисциплин', 11, 1);
	set @all = 'Предметы на кафедре '+ rtrim(@p) + ':  ';
	while @@FETCH_STATUS = 0
	begin
		set @count = @count + 1;
		set @all = @all + rtrim(@value) + ', ';
		fetch cur into @value;
	end
	close cur;
	print @all;
	return @count;
end;

declare @a int;
exec @a = subject_report @p = 'ИСиТ';
print 'Количество предметов: ' + cast(@a as varchar);