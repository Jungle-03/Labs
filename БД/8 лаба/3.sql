

print '����� ������������ �����: ' + cast(@@ROWCOUNT as varchar);
print '������ SQL Server: ' + @@VERSION;
print '����� ������������ �����: ' + cast(@@SPID as varchar);
print '��� ��������� ������: ' + cast(@@ERROR as varchar);
print '��� �������: ' + @@SERVERNAME ;
print '������� ����������� ����������: ' + cast(@@TRANCOUNT as varchar);
print '�������� ���������� ���������� ����� ��������������� ������: ' + cast(@@FETCH_STATUS as varchar);
print '������� ����������� ������� ���������: ' + cast(@@NESTLEVEL as varchar);