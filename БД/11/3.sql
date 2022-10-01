

declare @point varchar(20) = 'point 0';

begin try
	begin tran
	insert КОТИКИ values ('Абдул', 1)
	
	set @point = 'point 1'; save tran @point;

	insert КОТИКИ values('Джотаро', 1);
	set @point = 'point 2'; save tran @point;

	print 1/0;
	commit tran
end try
begin catch
	print 'Неизвестная ошибка: ' + error_message();

	print 'Контрольная точка: ' + @point;

	if(@point!='point 0')
	begin
		rollback tran @point;
		commit tran;
	end
	else rollback
	
end catch




--delete КОТИКИ where КОТИКИ.Имя = 'Абдул' or КОТИКИ.Имя = 'Джотаро';

