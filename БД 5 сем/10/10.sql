--1


begin 
null;
end;


--2

declare 
mass varchar(20):= 'Hello world!';
begin 
dbms_output.put_line(mass);
end;


--3

declare 
a number(20) := 2;
b number(20) := 0;
ab number(10,1);
begin
dbms_output.put_line('a = '||a||', b = '||b);
ab :=a/b;
exception
when others
then dbms_output.put_line('err sqlcode = '||sqlcode||', err sqlerrm = '||sqlerrm);
end;