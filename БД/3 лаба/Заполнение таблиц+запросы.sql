use Radzivil_3_lab
create table ТОВАРЫ
(Имя_товара nvarchar(50) primary key,
Цена money unique not null,
Количество_на_складе int

);

create table КЛИЕНТЫ
(Фамилия_клиента nvarchar(50) primary key,
Телефон int not null,
Адрес_клиента nvarchar(50)
);

create table ЗАКАЗЫ
(Номер_заказа int primary key,
Товар nvarchar(50) foreign key  references ТОВАРЫ (Имя_товара),
Цена_продажи money,
Количество int,
Дата_поставки date,
Клиент nvarchar(50) foreign key references КЛИЕНТЫ (Фамилия_клиента)
);
Alter table ТОВАРЫ add Дата_поступления date;

Alter table ТОВАРЫ drop Column Дата_поступления;

Insert into ТОВАРЫ (Имя_товара, Цена, Количество_на_складе)
	Values('Яблоко',5,100),
	('Лимон',7,60);

Insert into КЛИЕНТЫ (Фамилия_клиента,Телефон,Адрес_клиента)
	values ('Радивил',4637436,'Минск'),
	('Врублевский',23232,'Гродно'),
	('Калистратов',74364,'Могилев');

Insert into ЗАКАЗЫ (Номер_заказа,Товар,Цена_продажи,Количество,Дата_поставки,Клиент)
values (1,'Лимон',10,2,'2021-01-01','Калистратов'),
(2,'Лимон',10,4,'2021-02-01','Врублевский'),
(3,'Яблоко',6,5,'2020-01-01','Радивил');
		
select * from ТОВАРЫ;
select Количество, Клиент, Цена_продажи, Товар FROM ЗАКАЗЫ;
select count(*) from ТОВАРЫ;
select Номер_заказа [Малая_партия] from ЗАКАЗЫ where Количество <5;
select distinct Дата_поставки, Номер_заказа, Товар from ЗАКАЗЫ where Дата_поставки between '2019-01-01' and '2022-01-01';
select distinct top(2) Фамилия_клиента from КЛИЕНТЫ;
select Имя_товара [Товары по убыванию], Цена from ТОВАРЫ 
	order by Цена desc;

UPDATE ТОВАРЫ set Количество_на_складе = 1;
UPDATE ТОВАРЫ set Цена = Цена+10 where Имя_товара = 'Яблоко';

Insert into КЛИЕНТЫ (Фамилия_клиента,Телефон,Адрес_клиента)
	values ('Удалить',4637736,'Минск');
	delete from КЛИЕНТЫ where Фамилия_клиента = 'Удалить';

select distinct Товар[Товары, которые заказал Радивил] from ЗАКАЗЫ where Клиент = 'Радивил';

select distinct Товар from ЗАКАЗЫ where Товар Like 'Я%'
select distinct Имя_товара from Товары where Цена In(5,7);





-----------------------------------------------------------------------------------------
use master  
create database UNIVER on primary
( name = N'UNIVER_mdf', filename = N'C:\Users\User\Desktop\БД\3 лаба\UNIVER_mdf.mdf', 
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'UNIVER_ndf', filename = N'C:\Users\User\Desktop\БД\3 лаба\UNIVER_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),

filegroup FG1
( name = N'UNIVER_fg1_1', filename =  N'C:\Users\User\Desktop\БД\3 лаба\UNIVER_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'UNIVER_fg1_2', filename = N'C:\Users\User\Desktop\БД\3 лаба\UNIVER_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'UNIVER_log', filename= N'C:\Users\User\Desktop\БД\3 лаба\UNIVER_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%)

   CREATE TABLE AUDITORIUM 
          (     AUDITORIUM   char(20)  primary key,              
      AUDITORIUM_TYPE  char(10) foreign key references  
                                                 AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
                AUDITORIUM_CAPACITY  int default 1  
                                            check  (AUDITORIUM_CAPACITY between 1 and 300),  
                AUDITORIUM_NAME  varchar(50)                                     
          ) on FG1;
