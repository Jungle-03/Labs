

declare @point varchar(20) = 'point 0';

begin try
	begin tran
	insert ������ values ('�����', 1)
	
	set @point = 'point 1'; save tran @point;

	insert ������ values('�������', 1);
	set @point = 'point 2'; save tran @point;

	print 1/0;
	commit tran
end try
begin catch
	print '����������� ������: ' + error_message();

	print '����������� �����: ' + @point;

	if(@point!='point 0')
	begin
		rollback tran @point;
		commit tran;
	end
	else rollback
	
end catch




--delete ������ where ������.��� = '�����' or ������.��� = '�������';

