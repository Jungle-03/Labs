create table #Lab8
(zxc int, chat varchar(50), random int);

declare @i int = 7;

while @i<30
begin 
	insert #Lab8 values
	(1000 - @i,replicate('s',@i),rand()*30)
	set @i = @i + 7
end;

select * from #Lab8

drop table #Lab8




-------8




declare @zxc int = 993;
print 'zxc1 = ' +cast (@zxc as varchar)
print 'zxc2 = '+cast (@zxc *10 as varchar)
return;
print 'zxc3 = '+ cast (@zxc *100 as varchar)