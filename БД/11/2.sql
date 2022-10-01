create table КОТИКИ (zxc char(50),Код int)
drop table КОТИКИ


set nocount on
begin try
	begin tran
		delete КОТИКИ where Код = 11;
		insert КОТИКИ values('Магомед', 1);
		print 'Операции прошли успешно'; 
	commit tran;
end try
begin catch
	print 'Неизвестная ошибка';
	rollback tran;
end catch

select * from КОТИКИ;