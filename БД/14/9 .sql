use Univer3;
go

alter trigger DDL_DB_UNIVER on database 
                          for DDL_DATABASE_LEVEL_EVENTS  as   
  begin
       raiserror( N'операции с таблицами запрещены', 16, 1);  
       rollback;    
   end;
return;
	

create table test(a int);
drop table КОТИКИ;
alter table TR_AUDIT drop column COM;


drop trigger DDL_DB_UNIVER;

