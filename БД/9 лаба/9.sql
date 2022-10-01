
--------------1
--drop table #Lab9task1
exec sp_helpindex 'AUDITORIUM';

create table #Lab9task1
(
	indexx int,
	field varchar(100)
);

set nocount on;
declare @i int = 0;
while @i < 1000
begin
	insert #Lab9task1 values
	(rand()*10000, REPLICATE('?????????',10))
	set @i = @i +1;
end;

select * from #Lab9task1 
	where indexx between 4000 and 5000 order by indexx;

checkpoint; --фиксация бд
dbcc DROPCLEANBUFFERS ;-- очистить буферный кеш

create clustered index #Lindex on #Lab9task1(indexx asc)

--drop index #Lindex on #Lab9task1

-------------------2

CREATE table #LOCALTABLE2
(    my_key int, 
     my_int int identity(1, 1),
     my_varchar varchar(100)
);

--drop table #LOCALTABLE2;

set nocount on;           
declare @a int = 0;
while   @a < 20000       -- добавление в таблицу 20000 строк
	begin
		INSERT #LOCALTABLE2(my_key, my_varchar) values
	    (25000*RAND(), replicate('zxc', 10));
        set @a = @a + 1; 
	end;
  
SELECT count(*)[количество строк] from #LOCALTABLE2;
SELECT * from #LOCALTABLE2;

--drop index #SECOND_COMPOUNF_INDEX on #LOCALTABLE2

checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш

create index #SECOND_COMPOUND_INDEX on #LOCALTABLE2(my_key, my_int);

select * from #LOCALTABLE2 where my_key between 1000 and 2000 and my_int > 1500;

select * from #LOCALTABLE2 where my_key > 10000 and my_int = 1000;


--============= 3 =============--


CREATE table #LOCALTABLE3
(    my_key int, 
     my_int int identity(1, 1),
     my_varchar varchar(100)
);

--drop table #LOCALTABLE3;

set nocount on;           
declare @b int = 0;
while   @b < 20000       -- добавление в таблицу 20000 строк
	begin
		INSERT #LOCALTABLE3(my_key, my_varchar) values
	    (25000*RAND(), replicate('безумие...', 10));
        set @b = @b + 1; 
end;

checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш

SELECT my_int from #LOCALTABLE3 where my_key>15000;

CREATE index #THIRD_INCLUDE_INDEX on #LOCALTABLE3(my_key) INCLUDE (my_int);

SELECT my_int from #LOCALTABLE3 where my_key>15000;


--============= 4 =============--


CREATE table #LOCALTABLE4
(    my_key int, 
     my_int int identity(1, 1),
     my_varchar varchar(100)
);

--drop table #LOCALTABLE4;

set nocount on;           
declare @c int = 0;
while   @c < 20000       -- добавление в таблицу 20000 строк
	begin
		INSERT #LOCALTABLE4(my_key, my_varchar) values
	    (25000*RAND(), replicate('безумие...', 10));
        set @c = @c + 1; 
end;


checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш

SELECT my_int from #LOCALTABLE4 where my_int>15000 and my_int < 20000;

CREATE index #EX_WHERE on #LOCALTABLE4(my_int) where (my_int > 15000 and my_int < 20000);  

SELECT my_int from #LOCALTABLE4 where my_int>15000 and my_int < 20000;
SELECT my_int from #LOCALTABLE4 where my_int>10000 and my_int < 15000;


--============= 5 =============--


CREATE table #LOCALTABLE5
(    my_key int, 
     my_int int identity(1, 1),
     my_varchar varchar(100)
);

--drop table #LOCALTABLE5;

CREATE index #INDEX_5 ON #LOCALTABLE5(my_key); 

set nocount on;           
declare @d int = 0;
while   @d < 100000       -- добавление в таблицу 20000 строк
	begin
		INSERT #LOCALTABLE5(my_key, my_varchar) values
	    (25000*RAND(), replicate('безумие...', 10));
        set @d = @d + 1; 
end;


SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#LOCALTABLE5'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
		WHERE name is not null;

alter index #INDEX_5 on #LOCALTABLE5 reorganize;

alter index #INDEX_5 on #LOCALTABLE5 rebuild with (online = off);


--============= 6 =============--

CREATE table #LOCALTABLE6
(    my_key int, 
     my_int int identity(1, 1),
     my_varchar varchar(100)
);

--drop table #LOCALTABLE6;

set nocount on;           
declare @e int = 0;
while   @e < 100000       -- добавление в таблицу 20000 строк
	begin
		INSERT #LOCALTABLE5(my_key, my_varchar) values
	    (25000*RAND(), replicate('безумие...', 10));
        set @e = @e + 1; 
end;

CREATE index #INDEX_6 on #LOCALTABLE6(my_key) with (fillfactor = 65);

SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#LOCALTABLE6'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
		WHERE name is not null;
