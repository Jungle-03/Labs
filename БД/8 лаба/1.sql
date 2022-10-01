declare @i int = (select count(*) from PROGRESS),
		@ch char(5) = 'Чар',
		@vch varchar(10) = 'Варчар',
		@date datetime = (select getdate()),
		@num numeric (12,5) = (select cast(avg(NOTE)as numeric(12,5))
		from PROGRESS),
		@t time =(select CAST( getdate()as time)),
		@si smallint,
		@ti tinyint	

set @si = 10;
--set @ti = 50;

select @i, @ch, @vch, @date;
print cast(@num as varchar);
print cast(@t as varchar);
print cast(@si as varchar);
print cast (@ti as varchar);