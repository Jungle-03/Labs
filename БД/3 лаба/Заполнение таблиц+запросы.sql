use Radzivil_3_lab
create table ������
(���_������ nvarchar(50) primary key,
���� money unique not null,
����������_��_������ int

);

create table �������
(�������_������� nvarchar(50) primary key,
������� int not null,
�����_������� nvarchar(50)
);

create table ������
(�����_������ int primary key,
����� nvarchar(50) foreign key  references ������ (���_������),
����_������� money,
���������� int,
����_�������� date,
������ nvarchar(50) foreign key references ������� (�������_�������)
);
Alter table ������ add ����_����������� date;

Alter table ������ drop Column ����_�����������;

Insert into ������ (���_������, ����, ����������_��_������)
	Values('������',5,100),
	('�����',7,60);

Insert into ������� (�������_�������,�������,�����_�������)
	values ('�������',4637436,'�����'),
	('�����������',23232,'������'),
	('�����������',74364,'�������');

Insert into ������ (�����_������,�����,����_�������,����������,����_��������,������)
values (1,'�����',10,2,'2021-01-01','�����������'),
(2,'�����',10,4,'2021-02-01','�����������'),
(3,'������',6,5,'2020-01-01','�������');
		
select * from ������;
select ����������, ������, ����_�������, ����� FROM ������;
select count(*) from ������;
select �����_������ [�����_������] from ������ where ���������� <5;
select distinct ����_��������, �����_������, ����� from ������ where ����_�������� between '2019-01-01' and '2022-01-01';
select distinct top(2) �������_������� from �������;
select ���_������ [������ �� ��������], ���� from ������ 
	order by ���� desc;

UPDATE ������ set ����������_��_������ = 1;
UPDATE ������ set ���� = ����+10 where ���_������ = '������';

Insert into ������� (�������_�������,�������,�����_�������)
	values ('�������',4637736,'�����');
	delete from ������� where �������_������� = '�������';

select distinct �����[������, ������� ������� �������] from ������ where ������ = '�������';

select distinct ����� from ������ where ����� Like '�%'
select distinct ���_������ from ������ where ���� In(5,7);





-----------------------------------------------------------------------------------------
use master  
create database UNIVER on primary
( name = N'UNIVER_mdf', filename = N'C:\Users\User\Desktop\��\3 ����\UNIVER_mdf.mdf', 
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'UNIVER_ndf', filename = N'C:\Users\User\Desktop\��\3 ����\UNIVER_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),

filegroup FG1
( name = N'UNIVER_fg1_1', filename =  N'C:\Users\User\Desktop\��\3 ����\UNIVER_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'UNIVER_fg1_2', filename = N'C:\Users\User\Desktop\��\3 ����\UNIVER_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'UNIVER_log', filename= N'C:\Users\User\Desktop\��\3 ����\UNIVER_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%)

   CREATE TABLE AUDITORIUM 
          (     AUDITORIUM   char(20)  primary key,              
      AUDITORIUM_TYPE  char(10) foreign key references  
                                                 AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
                AUDITORIUM_CAPACITY  int default 1  
                                            check  (AUDITORIUM_CAPACITY between 1 and 300),  
                AUDITORIUM_NAME  varchar(50)                                     
          ) on FG1;
