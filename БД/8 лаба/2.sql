
--============== 2 ==============--

declare @counter int = (select sum(AUDITORIUM_CAPACITY) from AUDITORIUM)

if @counter > 200
begin
declare @first float,
		@second float,
		@third float,
		@fourth float;

	set @first = (select count(*) from AUDITORIUM)
	set @second = (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM)
	set @third = (select count(*) from
	(select AUDITORIUM from AUDITORIUM where
	AUDITORIUM_CAPACITY < (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM)) t1);
	set @fourth = @third / @first * 100;

	select 'Кол-во аудиторий', @first
	union all
	select 'Средняя вместимость аудиторий', @second
	union all
	select 'Кол-во аудиторий, где вместимость меньше средней', @third
	union all
	select 'Процент этих аудиторий', @fourth;

end
else print 'Общая вместимость аудиторий: ' + cast(@counter as varchar);