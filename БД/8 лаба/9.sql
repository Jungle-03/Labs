begin try
declare @number int = 666;
print 'number: ' + @number;
end try
begin catch
print 'ERROR_NUMBER: '+cast(ERROR_NUMBER()as varchar)
print 'ERROR_MESSAGE: '+cast(ERROR_MESSAGE()as varchar)
print 'ERROR_LINE: '  + cast(ERROR_LINE()as varchar)
print 'ERROR_PROCEDURE: '+cast(ERROR_PROCEDURE()as varchar)
print 'ERROR_SEVERITY: '+cast(ERROR_SEVERITY()as varchar)
print 'ERROR_STATE: '+cast(ERROR_STATE()as varchar)
end catch