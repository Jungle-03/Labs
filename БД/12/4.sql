
go

create procedure pAudInsert 
	as begin declare @a char(20), @n varchar(50), @c int = 0, @t char(10)


end;
go


alter procedure pAudInsert @a char(20), @n varchar(50), @c int = 0, @t char(10)
as
begin

begin try
		insert into AUDITORIUM values(@a,@t,@c,@n);
		return 1;
end try
begin catch
	print '����� ������: ' + cast(error_number() as varchar);
	print '���������: ' + error_message();
	print '�������: ' + cast(error_severity() as varchar);
	print '�����: ' + cast(error_state() as varchar);
	print '����� ������: ' + cast(error_line() as varchar);
	if ERROR_PROCEDURE() is not null
	print '��� ���������: ' + ERROR_PROCEDURE();
	return -1;
end catch

end

declare @res1 int, @res2 int;
exec @res1 = pAudInsert @a='350-1',@t='��',@c=30,@n='350-1';
exec @res2 = pAudInsert @a='351-1',@t='��',@c=30,@n='351-1';

print @res1;
print @res2;
