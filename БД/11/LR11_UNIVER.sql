use univer;

set nocount on
	if  exists (select * from  SYS.OBJECTS        -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           -- commit() ��� rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������
	CREATE table X(K int );                         -- ������ ���������� 
		INSERT X values (1),(2),(3);
		set @c = (select count(*) from X);
		print '���������� ����� � ������� X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;       -- ���������� ����������: �������� 
	          else   rollback;            -- ���������� ����������: �����  
      SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������
	
	if  exists (select * from  SYS.OBJECTS       -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X') )
	print '������� X ����';  
      else print '������� X ���'
----2
begin try
	  begin tran --������ ����� ����������
	  delete PROGRESS where PROGRESS.NOTE =4;
	  insert PULPIT values ('����', '�������������� ������ � ���������� ', '��' );
	  commit tran --��������
	  end try
	  begin catch
	  print '������: ' + case
	  when error_number()=2627 and patindex('%PULPIT_PK%',error_message())>0 --PATINDEX ����������������� ������� ������� �������
	                                                                         --��������� �������� ��������
	  then '������������ ����������'
	  else '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
	  end;
	  if @@TRANCOUNT>0 rollback tran; --@@TRANCOUNT ���������� ������� ����������� ����������. 
	  end catch;

set nocount on
 declare @point varchar(32);
begin try
begin tran
delete PROGRESS where PROGRESS.NOTE =5;
set @point ='p1'; save tran @point; --����������� ����� 1 ��� ���� ���� ���������� ���� �� ���������� ������ ������ ����������
insert PULPIT values ('����', '�������������� ������ � ���������� ', '��' );
set @point = 'p2'; save tran @point; --����� ����� 2
 insert PULPIT values ('�����', '����� ������� ����� �� �����', '��')
	  commit tran --��������
	  end try
	  begin catch
	  print '������: ' + case
	  when error_number()=2627 and patindex('%PULPIT_PK%',error_message())>0
	  then '������������ ������'
	  else '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
	  end;
	  if @@TRANCOUNT>0 rollback tran;
	  begin
	  print '����������� �����:' + @point;
	  end
	  end catch;

	  --task4
		--A-- ����� ���������� � ������� ��������������� READ UNCOMMITED, ������ ����������������� ������
		DELETE FACULTY WHERE FACULTY_NAME = 'ghj' 

		use univer;
		
set transaction isolation level read uncommitted
begin transaction
select @@SPID, 'insert faculty' 'result', * from FACULTY --@@SPID ���������� ��������� ������������� ��������, ����������� �������� �������� �����������
WHERE FACULTY = 'ghjj';
select @@SPID, 'insert faculty' 'result', PULPIT.FACULTY FROM PULPIT
WHERE FACULTY = 'ghjj';
commit;
--B-- ����� ���������� � ������� ��������������� READ COMMITED  ������ ��������������� ������
begin transaction
select @@SPID --���������� ��������� ������������� ��������, ����������� �������� �������� �����������.
insert FACULTY values ('gh', 'gh')
update PULPIT set PULPIT.FACULTY = 'gh'
where PULPIT.FACULTY = 'gh'
commit;

		--task5
		-- ������� READ COMMITED �� ��������� ����������������� ������, �� ��� ���� �������� ��������������� � ��������� ������. 
		--��� ���������������� �������� ������ ����� �������� ��������� ��������, �.��. �������������� ������, ���������� ����������, 
		--����� ����������� ������� ������������.
select * from AUDITORIUM
			set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from AUDITORIUM 	
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  * from AUDITORIUM 	WHERE AUDITORIUM = '132-4'
	commit; 

	--- B ---	
	begin transaction 	  
	DELETE FROM AUDITORIUM WHERE AUDITORIUM = '132-4'
	 commit; --������ ����� � ������� �� ������ �� �������
	-------------------------- t1 --------------------
    ROLLBACK TRANSACTION;
		 --update PULPIT set PULPIT = '�����' 
                                       --where PULPIT = '�����' 
    commit; 
		  --TASK6
select * from FACULTY
DELETE FROM AUDITORIUM WHERE AUDITORIUM = '133-4'
DELETE FROM AUDITORIUM WHERE AUDITORIUM = '131-4'

		  set transaction isolation level  REPEATABLE READ 
	begin transaction 
	insert into auditorium values('133-4','��-�',15,'133-4')
	select count(*) from AUDITORIUM
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------	
	select count(*) from AUDITORIUM
	commit; 

	--- B ---	
	begin transaction 	
	DELETE FROM AUDITORIUM WHERE AUDITORIUM = '133-4'  
	-------------------------- t1 --------------------
	begin transaction 	
	insert into auditorium values('131-4','��-�',15,'133-4')
          commit; 

		  --TASK7--
select * from PROGRESS
--a
set transaction isolation level SERIALIZABLE
begin transaction
select count(*) from AUDITORIUM
-------------------------------t1
commit;

--b�
set transaction isolation level READ COMMITTED
begin transaction
insert into auditorium values('131-4','��-�',15,'131-4')
DELETE FROM AUDITORIUM WHERE AUDITORIUM = '131-4'
commit;
      -------------------------- t2 --------------------

	  --task8
	
delete from progress where NOTE = 10
begin transaction

insert into PROGRESS values ('����', 15, '2013-12-01', 9);

begin transaction
update PROGRESS set SUBJECT='����' where NOTE=8;
insert into PROGRESS values ('��', 21, '2013-05-06', 9);
commit;

select * from PROGRESS where NOTE=9;

if @@trancount > 0 rollback;
select * from PROGRESS where NOTE=9;
