create user user1_pdb identified by 12345;
grant create session to user1_pdb;
select * from dba_users where username = 'USER1_PDB';
--Jungle
grant create session to c##Radzivil2
alter pluggable database all open;
select * from DBA_PDBS 
select * from v$pdbs;
select * from v$session