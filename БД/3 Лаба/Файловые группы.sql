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

create database ��������

CREATE table �������
(	
	id int primary key ,
	��������_�������� nvarchar(20) unique,
	������� int,
	���������_������ money not null,
	��������_�����_��������� nvarchar(20) 
	 
);
CREATE table ���������
(
	id int primary key,	
	����������_��������� nvarchar(50) unique,
	����������_���� nvarchar(20)
	
);

CREATE table ������
(	id_������� int foreign key references �������(id),
	id_�������� int foreign key references ���������(id),
	���_������� nvarchar(20),
	���� date,
	������������_�_������� int,
	
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