--=================   READ UNCOMMITTED   ===================--



set transaction isolation level read uncommitted
begin transaction

    select count(*) from teacher;

commit transaction


--=================   READ COMMITTED   ===================--



set transaction isolation level read committed
begin transaction

    --first read
    select count(*) from teacher;
    
    --second read
    select count(*) from teacher;

commit transaction



--=================   REPEATABLE READ   ===================--



set transaction isolation level repeatable read
begin transaction

    --first read
    select count(*) from teacher;
    
    --second read
    select count(*) from teacher;

commit transaction


--=================   SERIALIZABLE   ===================--


set transaction isolation level serializable
begin transaction

    --first read
    select count(*) from teacher;
    
    --second read
    select count(*) from teacher;

commit transaction