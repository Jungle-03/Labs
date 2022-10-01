use univer;

set nocount on
	if  exists (select * from  SYS.OBJECTS        -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           -- commit() или rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции
	CREATE table X(K int );                         -- начало транзакции 
		INSERT X values (1),(2),(3);
		set @c = (select count(*) from X);
		print 'количество строк в таблице X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;       -- завершение транзакции: фиксация 
	          else   rollback;            -- завершение транзакции: откат  
      SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции
	
	if  exists (select * from  SYS.OBJECTS       -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )
	print 'таблица X есть';  
      else print 'таблицы X нет'
----2
begin try
	  begin tran --начало явной транзакции
	  delete PROGRESS where PROGRESS.NOTE =4;
	  insert PULPIT values ('ИСиТ', 'Информационных систем и технологий ', 'ИТ' );
	  commit tran --фиксация
	  end try
	  begin catch
	  print 'ошибка: ' + case
	  when error_number()=2627 and patindex('%PULPIT_PK%',error_message())>0 --PATINDEX определяетвстроке позицию первого символа
	                                                                         --подстроки заданную шаблоном
	  then 'дублирование факультета'
	  else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	  end;
	  if @@TRANCOUNT>0 rollback tran; --@@TRANCOUNT возвращает уровень вложенности транзакции. 
	  end catch;

set nocount on
 declare @point varchar(32);
begin try
begin tran
delete PROGRESS where PROGRESS.NOTE =5;
set @point ='p1'; save tran @point; --контрольная точка 1 для того если транзакция сост из нескольких незави блоков операторов
insert PULPIT values ('ИСиТ', 'Информационных систем и технологий ', 'ИТ' );
set @point = 'p2'; save tran @point; --контр точка 2
 insert PULPIT values ('НКННЗ', 'Наука которую никто не знает', 'ХЗ')
	  commit tran --фиксация
	  end try
	  begin catch
	  print 'ошибка: ' + case
	  when error_number()=2627 and patindex('%PULPIT_PK%',error_message())>0
	  then 'дублирование товара'
	  else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	  end;
	  if @@TRANCOUNT>0 rollback tran;
	  begin
	  print 'контрольная точка:' + @point;
	  end
	  end catch;

	  --task4
		--A-- явная транзакция с уровнем изолированности READ UNCOMMITED, Чтение незафиксированных данных
		DELETE FACULTY WHERE FACULTY_NAME = 'ghj' 

		use univer;
		
set transaction isolation level read uncommitted
begin transaction
select @@SPID, 'insert faculty' 'result', * from FACULTY --@@SPID возвращает системный идентификатор процесса, назначенный сервером текущему подключению
WHERE FACULTY = 'ghjj';
select @@SPID, 'insert faculty' 'result', PULPIT.FACULTY FROM PULPIT
WHERE FACULTY = 'ghjj';
commit;
--B-- явную транзакцию с уровнем изолированности READ COMMITED  Чтение зафиксированных данных
begin transaction
select @@SPID --возвращает системный идентификатор процесса, назначенный сервером текущему подключению.
insert FACULTY values ('gh', 'gh')
update PULPIT set PULPIT.FACULTY = 'gh'
where PULPIT.FACULTY = 'gh'
commit;

		--task5
		-- уровень READ COMMITED не допускает неподтвержденного чтения, но при этом возможно неповторяющееся и фантомное чтение. 
		--Две последовательные операции чтения могут получать различные значения, т. к. дополнительные строки, называемые фантомными, 
		--могут добавляться другими транзакциями.
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
	 commit; --данные почит в главной тр дважды по разному
	-------------------------- t1 --------------------
    ROLLBACK TRANSACTION;
		 --update PULPIT set PULPIT = 'ПиАХП' 
                                       --where PULPIT = 'ПиАХП' 
    commit; 
		  --TASK6
select * from FACULTY
DELETE FROM AUDITORIUM WHERE AUDITORIUM = '133-4'
DELETE FROM AUDITORIUM WHERE AUDITORIUM = '131-4'

		  set transaction isolation level  REPEATABLE READ 
	begin transaction 
	insert into auditorium values('133-4','ЛБ-К',15,'133-4')
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
	insert into auditorium values('131-4','ЛБ-К',15,'133-4')
          commit; 

		  --TASK7--
select * from PROGRESS
--a
set transaction isolation level SERIALIZABLE
begin transaction
select count(*) from AUDITORIUM
-------------------------------t1
commit;

--b—
set transaction isolation level READ COMMITTED
begin transaction
insert into auditorium values('131-4','ЛБ-К',15,'131-4')
DELETE FROM AUDITORIUM WHERE AUDITORIUM = '131-4'
commit;
      -------------------------- t2 --------------------

	  --task8
	
delete from progress where NOTE = 10
begin transaction

insert into PROGRESS values ('СУБД', 15, '2013-12-01', 9);

begin transaction
update PROGRESS set SUBJECT='ОАиП' where NOTE=8;
insert into PROGRESS values ('КГ', 21, '2013-05-06', 9);
commit;

select * from PROGRESS where NOTE=9;

if @@trancount > 0 rollback;
select * from PROGRESS where NOTE=9;
