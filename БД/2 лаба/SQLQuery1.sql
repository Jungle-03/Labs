
use Jungle3
create table ������
(
������������ nvarchar(50)  primary key,
���� real unique not null,
���������� int
);

create table ���������
(
������������_�����  nvarchar(50) primary key, 
����� nvarchar(50),
���������_���� nvarchar(20) 
);

create table ������
(
�����_������  int primary key, 
������������_������ nvarchar(50) foreign key references ������(������������) ,
����_������� real,
���������� int,
����_�������� date,
�������� nvarchar(50) foreign key references ���������(������������_�����)

);