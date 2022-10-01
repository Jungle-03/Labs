
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

	select '���-�� ���������', @first
	union all
	select '������� ����������� ���������', @second
	union all
	select '���-�� ���������, ��� ����������� ������ �������', @third
	union all
	select '������� ���� ���������', @fourth;

end
else print '����� ����������� ���������: ' + cast(@counter as varchar);