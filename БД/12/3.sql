create table #SUBJECT_TIME
(
	subject char(10) primary key,
	subject_name varchar(100),
	pulpit char(20)
);
go



ALTER procedure [dbo].[pSubject] @p varchar(20)
as
begin
	select s.SUBJECT, s.SUBJECT_NAME, s.PULPIT from SUBJECT s
	where s.PULPIT = @p;

	declare @a int = (select count(*) from SUBJECT);
	return @a;
end
go


insert #SUBJECT_TIME exec pSubject @p = 'ศั่า';

select * from #SUBJECT_TIME;