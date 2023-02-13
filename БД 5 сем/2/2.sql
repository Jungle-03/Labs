--task 1

create tablespace TS_RDU123
  datafile 'D:\db\ts_PERM_Radzivil123.dbf'
  size 7m
  autoextend on next 5m
  maxsize 20m
  extent management local;
  
--drop tablespace TS_RDU

--task 2

create temporary tablespace ts_TEMP_RDU123
  tempfile 'D:\db\ts_TEMP_Radzivil123.dbf'
  size 5m
  autoextend on next 3m
  maxsize 30m
  extent management local;
  
  --drop tablespase ts_TEMP_RDU
  
  
--task 3

select tablespace_name from SYS.DBA_TABLESPACES;
  
--task 4
alter session set "_ORACLE_SCRIPT"=true;  

create role RL_Radzivil_CORE

select * from dba_roles where role like 'RL%'

grant create session,
create table, 
create view,
create procedure to RL_Radzivil_CORE;

--task 5

select * from dba_sys_privs where grantee = 'RL_Radzivil_CORE';
select * from dba_roles; 



--task 6

create profile PF_RadzivilCORE limit
password_life_time 180
sessions_per_user 3
failed_login_attempts 7
password_lock_time 1  
password_reuse_time 10
password_grace_time default
connect_time 180
idle_time 30 --минут простоя
  
  
  
--task 7

select * from dba_profiles where profile = 'PF_RadzivilCORE';
select * from dba_profiles where profile = 'DEFAULT';
select * from dba_profiles


--task 8

create user RadzivilCORE identified by 12345 
default tablespace TS_RDU123 quota unlimited on TS_RDU123
temporary tablespace  ts_TEMP_RDU123
profile PF_RadzivilCORE
account unlock
password expire

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
grant RL_Radzivil_CORE to RadzivilCORE

--delete users RadzivilCORE



--task 11

create tablespace Radzivil_QDATA
datafile 'D:\db\Radzivil_QDATA.dbf'
size 10m
autoextend on next 5 m
maxsize 20m
extent management local
offline;

alter tablespace Radzivil_QDATA online


select tablespace_name, status from sys.dba_tablespaces

select * from dba_profiles;
select * from dba_users;
--
create user Windranger identified by 12345 
--
alter user Windranger
 quota 2m on Radzivil_QDATA
 
 
 grant create session,
create table, 
create view,
create procedure to Windranger;



alter user Windranger default tablespace TS_RDU123 quota unlimited on TS_RDU123
