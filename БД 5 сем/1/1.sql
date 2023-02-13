
create table jcxz (q number (3), f varchar (50) primary key );


create table jzxc (x varchar (3), y varchar (50), primary key(y), foreign key (x) references jcxz );

insert into jzxc (x,y)
  values('qw','qwewqeqw');
  
  insert into jcxz(q,f)
    values(2,'qw');
    
    
  select * from jzxc;