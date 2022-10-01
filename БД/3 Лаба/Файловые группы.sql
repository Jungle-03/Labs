use master

create database univer
on primary
(name=N'univer_mdf', filename=N'D:\univer\univer_mdf.mdf',
size = 10240Kb, maxsize=unlimited, filegrowth=1024Kb),
filegroup fg1
(name=N'univer_ndf', filename=N'D:\univer\univer_ndf.ndf',
size = 10240Kb, maxsize=1Gb, filegrowth=2048Kb)
log on
(name=N'univer_ldf', filename=N'D:\univer\univer_ldf.ldf',
size = 10240Kb, maxsize=unlimited, filegrowth=1024Kb)

go

create database Агенство

CREATE table РЕКЛАМА
(	
	id int primary key ,
	Название_передачи nvarchar(20) unique,
	Рейтинг int,
	Стоимость_минуты money not null,
	Название_фирмы_заказчика nvarchar(20) 
	 
);
CREATE table ЗАКАЗЧИКИ
(
	id int primary key,	
	Банковские_реквизиты nvarchar(50) unique,
	Контактное_лицо nvarchar(20)
	
);

CREATE table ЗАКАЗЫ
(	id_рекламы int foreign key references РЕКЛАМА(id),
	id_человека int foreign key references ЗАКАЗЧИКИ(id),
	Вид_рекламы nvarchar(20),
	Дата date,
	Длительность_в_минутах int,
	
);




--ALTER DATABASE [3lab]
--ADD FILEGROUP FG_Prim;  


--GO  
--ALTER DATABASE [3lab]  
--ADD FILE   

--(  
--    NAME = 'faffa name',  
--    FILENAME = 'D:\qwe\qwe_ndf.ndf',  
--    SIZE = 10MB,  
--    MAXSIZE = 100MB,  
--    FILEGROWTH = 5% 
--)  to filegroup FG_Prim;


--ALTER DATABASE [3lab]
--modify filegroup FG_Prim default;  

--ALTER DATABASE [3lab]  
--ADD FILE   
--(  
--    NAME = 'Random name',  
--    FILENAME = 'D:\qwe\qwe_mdf.mdf',  
--    SIZE = 10MB,  
--    MAXSIZE = 100MB,  
--    FILEGROWTH = 5%  
--)   
--on primary;  



alter database [3lab] add filegroup FG_11;
alter database [3lab] add file 
(name = N'FG_11', filename = 'D:\FG_11\FG_11_ndf.ndf', size = 3072KB, maxsize = unlimited, filegrowth = 1024KB)
to filegroup FG_11;

alter database [3lab] modify filegroup FG_11 default;

create table  zxc(name nvarchar(50), chislo int)on FG_11;