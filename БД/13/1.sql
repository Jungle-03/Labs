
go

--============== 1 ==============--

create function counter_students (@faculty varchar(20)) returns int
as begin
	declare @counter int = 0;
	set @counter = 
	(select count(*) from STUDENT
	inner join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP
	inner join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY
	where FACULTY.FACULTY = @faculty )
return @counter;
end;
go

select dbo.counter_students('ИДиП');
go

--============== 2 ==============--

alter function Function2 (@p varchar(30)) returns varchar(400)
as begin
	declare @FullResult varchar(300) = 'Дисциплины: ';
	declare @res varchar(20);
	declare cur cursor local
	for select SUBJECT_NAME from SUBJECT
	where SUBJECT.PULPIT = @p;
	open cur;
	fetch cur into @res;

	while @@FETCH_STATUS = 0
	begin
		set @FullResult = @FullResult + ', ' + rtrim(@res);
		fetch cur into @res;
	end;

return @FullResult;
end;
go

select PULPIT, dbo.Function2(PULPIT) from PULPIT;
go

--============== 3 ==============--

alter function Function4 (@f varchar(20),@p varchar(20)) returns table
as return
select f.FACULTY, p.PULPIT from
FACULTY f left join pulpit p
on f.FACULTY = p.FACULTY
where f.FACULTY = isnull(@f,f.FACULTY)
and p.PULPIT = isnull(@p,p.PULPIT)
go

select * from dbo.Function4(null, null);

select * from dbo.Function4('ИТ', null);

select * from dbo.Function4(null, 'БФ');

select * from dbo.Function4('ЛХФ', 'ЛВ');

--============== 4 ==============--

alter function Function3 (@pulpit varchar(20)) returns int
as begin
	declare @counter int;
	
	set @counter = 
		(select count(*) from TEACHER
		where PULPIT = isnull(@pulpit,PULPIT))
		return @counter;
end;
go

select PULPIT, dbo.Function3(PULPIT)[Кол-во] from PULPIT
go

select dbo.Function3(null)[Кол-во];
go
--============== 5 ==============--

alter function counter_pulpit(@faculty varchar(20)) returns int
as begin
	declare @counter int;
		set @counter = 
		(select count(*) from PULPIT
		inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
		where FACULTY.FACULTY = @faculty);
	return @counter;
end;
go

create function counter_groups(@faculty varchar(20)) returns int
as begin
	declare @counter int;
		set @counter = 
		(select count(*) from GROUPS
		inner join FACULTY on FACULTY.FACULTY = GROUPS.FACULTY
		where FACULTY.FACULTY = @faculty);
	return @counter;
end;
go

create function counter_profession(@faculty varchar(20)) returns int
as begin
	declare @counter int;
		set @counter = 
		(select count(*) from PROFESSION
		inner join FACULTY on FACULTY.FACULTY = PROFESSION.FACULTY
		where FACULTY.FACULTY = @faculty);
	return @counter;
end;
go

select dbo.counter_pulpit('ИДиП');
go
select dbo.counter_groups('ИДиП');
go
select dbo.counter_profession('ИДиП');
go


alter function FACULTY_REPORT(@c int) returns @fr table
( [Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int, 
[Количество студентов] int, [Количество специальностей] int )
	as begin 
           declare cc CURSOR local static for 
	       select FACULTY from FACULTY 
		   where dbo.counter_students(FACULTY) > @c; 
	       declare @f varchar(30);
	       open cc;  
                 fetch cc into @f;

	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,
				dbo.counter_pulpit(@f),
	            dbo.counter_groups(@f),
				dbo.counter_students(@f),
	            dbo.counter_profession(@f) ); 
	            fetch cc into @f;  
	       end;   
                 return; 
	end;
go

select * from dbo.FACULTY_REPORT(-1);
go