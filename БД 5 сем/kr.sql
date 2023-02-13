--ѕолучить список всех  табличных пространств
 


--получить список привелегий дл€ роли sys


select * from DBA_ROLE_PRIVS where grantee like 'SYS'


--ѕолучить список всех объектов принадлежащих пользователю

select * from DBA_OBJECTS where OWNER like 'SYS'



select * from dictionary where TABLE_NAME like 'objects'