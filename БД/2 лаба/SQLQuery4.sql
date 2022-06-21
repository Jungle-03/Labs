use master  
create database UNIVER 
on primary
( name = N'UNIVER_mdf', filename = N'C:\ад2\UNIVER_mdf.mdf', 
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'UNIVER_ndf', filename = N'C:\ад2\UNIVER_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),

filegroup FG1
( name = N'UNIVER_fg1_1', filename = N'C:\ад2\UNIVER_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'UNIVER_fg1_2', filename = N'C:\ад2\UNIVER_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'UNIVER_log', filename=N'C:\ад2\UNIVER_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%)

   CREATE TABLE AUDITORIUM 
          (     AUDITORIUM   char(20)  primary key,              
      AUDITORIUM_TYPE  char(10) foreign key references  
                                                 AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
                AUDITORIUM_CAPACITY  int default 1  
                                            check  (AUDITORIUM_CAPACITY between 1 and 300),  
                AUDITORIUM_NAME  varchar(50)                                     
          ) on FG1;
