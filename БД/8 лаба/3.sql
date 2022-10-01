

print 'число обработанных строк: ' + cast(@@ROWCOUNT as varchar);
print 'версия SQL Server: ' + @@VERSION;
print 'число обработанных строк: ' + cast(@@SPID as varchar);
print 'код последней ошибки: ' + cast(@@ERROR as varchar);
print 'имя сервера: ' + @@SERVERNAME ;
print 'уровень вложенности транзакции: ' + cast(@@TRANCOUNT as varchar);
print 'проверка результата считывания строк результирующего набора: ' + cast(@@FETCH_STATUS as varchar);
print 'уровень вложенности текущей процедуры: ' + cast(@@NESTLEVEL as varchar);