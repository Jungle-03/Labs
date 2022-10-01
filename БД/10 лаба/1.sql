

--=============== 1 ===============--

declare @subCur char(20), @subRes char(300) = '';
declare cur1 cursor local for
select SUBJECT from SUBJECT where pulpit like 'ИСиТ';

open cur1;
fetch cur1 into @subCur;
print 'Предметы кафедры ИСиТ: ';

while @@fetch_status = 0
begin
	set @subRes = rtrim(@subCur) + ', ' + @subRes;
	fetch cur1 into @subCur;
end;

print @subRes;
close cur1;

--=============== 2 ===============--

--2.1

declare cur2_1 cursor local for
select AUDITORIUM_TYPE from AUDITORIUM;
open cur2_1;
fetch cur2_1
go

fetch cur2_1
go


--close cur2_1
--deallocate cur2_1

--2.2

declare cur2_2 cursor global for
select AUDITORIUM_TYPE from AUDITORIUM;
open cur2_2;
fetch from cur2_2;
go
fetch cur2_2;
go

close cur2_2;
deallocate cur2_2;

--=============== 3 ===============--

declare @cur char(30), @res char(120)='';

declare cur3_1 cursor local static for
select AUDITORIUM from AUDITORIUM where AUDITORIUM_TYPE like 'ЛК';

open cur3_1;

insert into AUDITORIUM values('000-1', 'ЛК', 200, 'lol');
--delete from AUDITORIUM where AUDITORIUM_CAPACITY = 200;

fetch cur3_1 into @cur;

while @@FETCH_STATUS = 0
begin
	set @res = rtrim(@cur) + ',  ' + @res;
	fetch cur3_1 into @cur;
end;


print @res;

--=============== 4 ===============--

select count(*) from AUDITORIUM;



declare @num int, @string char(20);
declare cur4 cursor local static scroll
for select row_number() over(order by Auditorium) num, AUDITORIUM from AUDITORIUM;

open cur4;
fetch absolute -7 from cur4 into @num, @string 
print 'absolute -7 номер строки: ' + cast(@num as varchar) + '    ' + @string;

fetch relative 2 from cur4 into @num, @string
print 'relative 2 номер строки: ' + cast(@num as varchar) + '    ' + @string;

fetch first from cur4 into @num, @string
print 'first номер строки: ' + cast(@num as varchar) + '    ' + @string;

fetch last from cur4 into @num, @string
print 'last номер строки: ' + cast(@num as varchar) + '    ' + @string;

fetch prior from cur4 into @num, @string
print 'prior номер строки: ' + cast(@num as varchar) + '    ' + @string;

fetch next from cur4 into @num, @string
print 'next номер строки: ' + cast(@num as varchar) + '    ' + @string;

--=============== 5 ===============--

select * from AUDITORIUM;

declare @aud char(20);
declare cur5 cursor local dynamic scroll for
select AUDITORIUM from AUDITORIUM for update;

open cur5;
fetch next from cur5 into @aud;

while @@FETCH_STATUS = 0
begin
	if @aud like '000-1'
		delete AUDITORIUM where current of cur5;
	else update AUDITORIUM set AUDITORIUM_CAPACITY = AUDITORIUM_CAPACITY + 1 where current of cur5

	fetch next from cur5 into @aud;
end

close cur5;

select * from AUDITORIUM;

--=============== 6.1 ===============--

select * from PROGRESS;

declare @delID int = 0;
declare @id int, @note int;
declare cur6 cursor local dynamic scroll for
select IDSTUDENT,NOTE from PROGRESS for update;

open cur6;
fetch next from cur6 into @id, @note

while @@FETCH_STATUS = 0
begin
	if @delID = @id
	begin
		delete from PROGRESS where current of cur6;
		fetch next from cur6 into @id, @note
		if @@FETCH_STATUS = -1
		begin
			fetch first from cur6 into @id, @note;
			set @delID = 0;
		end;
		continue;
	end;

	if @note<4
	begin
		delete from PROGRESS where current of cur6;
		set @delID = @id;
		fetch first from cur6 into @id, @note;
	end;

	fetch next from cur6 into @id, @note;
end;

select * from PROGRESS where note < 5;

--=============== 6.2 ===============--
insert into PROGRESS values ('СУБД', 1000, getdate(), 3)

select * from PROGRESS where IDSTUDENT = 1000;

declare @_note int;
declare cur7 cursor local for
select NOTE from PROGRESS where IDSTUDENT = 1000 for update;

open cur7;
fetch cur7 into @_note

while @@FETCH_STATUS = 0
begin
	update PROGRESS set NOTE = NOTE - 1 where current of cur7;
	fetch cur7 into @_note;
end;

