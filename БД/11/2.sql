create table ������ (zxc char(50),��� int)
drop table ������


set nocount on
begin try
	begin tran
		delete ������ where ��� = 11;
		insert ������ values('�������', 1);
		print '�������� ������ �������'; 
	commit tran;
end try
begin catch
	print '����������� ������';
	rollback tran;
end catch

select * from ������;