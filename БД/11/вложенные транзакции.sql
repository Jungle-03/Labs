create table #temp(i int);


begin tran

    insert #temp values(1);
    begin tran 
        insert #temp values(2);
    commit tran 
    rollback tran 

commit tran
rollback tran

select * from #temp;

print @@trancount;