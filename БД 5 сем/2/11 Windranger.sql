--выполнять от Windranger

create table Windranger_11
  (x number(3), 
  y varchar(10));
  
insert into Windranger_11 values (1, 'one');
insert into Windranger_11 values (2, 'two');
insert into Windranger_11 values (3, 'three');

tablespace Radzivil_QDATA
select * from Windranger_11;

--

create table Windranger_22
  (x number(3), 
  y varchar(10));
  
insert into Windranger_22 values (1, 'one');
insert into Windranger_22 values (2, 'two');
insert into Windranger_22 values (3, 'three');
tablespace Radzivil_QDATA
select * from Windranger_22;


create table Windranger_223
  (x number(3), 
  y varchar(10));
  
insert into Windranger_223 values (1, 'one');
insert into Windranger_223 values (2, 'two');

tablespace TS_RDU123
select * from Windranger_223;