
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[pSubject] @p varchar(20), @c int output
as
begin
	select s.SUBJECT, s.SUBJECT_NAME, s.PULPIT from SUBJECT s
	where s.PULPIT = @p;
	set @c = @@ROWCOUNT;

	declare @a int = (select count(*) from SUBJECT);
	return @a;
end


declare @count1 int = 0, @count2 int = 0;
exec @count1 = pSubject @p = 'ИСиТ', @c = @count2 output;
print 'В рез. таблице '+cast(@count2 as varchar)+' строк - 1 способ';
print 'В таблице subject '+cast(@count1 as varchar)+' строк - 2 способ';

