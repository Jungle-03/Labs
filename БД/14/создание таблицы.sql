
create table TR_AUDIT
(
	ID int identity,
	STMT varchar (20)
		check(STMT in('insert','update','delete')),
	TR_NAME varchar(20),
	COM varchar(300)
);

