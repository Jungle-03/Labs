

create procedure  pAudDoubleInsert
as begin 
declare @a char(20), @n varchar(50), @c int = 0, @t char(10), @tn char(50)
end
go


alter procedure pAudDoubleInsert @a char(20), @n varchar(50), @c int = 0, @t char(10), @tn char(50)
as 
begin try
	if not exists (select AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = @t)
		insert into AUDITORIUM_TYPE values(@t, @tn);
	exec pAudInsert @a, @t, @c, @n;
	return 1;
end try
begin catch
	print 'Номер ошибки: ' + cast(error_number() as varchar);
	print 'Сообщение: ' + error_message();
	print 'Уровень: ' + cast(error_severity() as varchar);
	print 'Метка: ' + cast(error_state() as varchar);
	print 'Номер строки: ' + cast(error_line() as varchar);
	if ERROR_PROCEDURE() is not null
	print 'Имя процедуры: ' + ERROR_PROCEDURE();
	return -1;
end catch


declare @res int
exec @res = pAudDoubleInsert @a='515-1',@n='515-1',@c=30,@t='БД', @tn = 'Большой Додик';

select * from AUDITORIUM;
select * from AUDITORIUM_TYPE;
