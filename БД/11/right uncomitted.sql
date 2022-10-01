
begin transaction

update teacher set TEACHER_NAME = 'TRANSACTION' where teacher = 'tran';
delete teacher where teacher = 'tran';


insert teacher values ('tran', 'transaction','ИСиТ', 'м');

commit transaction

rollback transaction


select * from teacher;




