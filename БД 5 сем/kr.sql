--�������� ������ ����  ��������� �����������
 


--�������� ������ ���������� ��� ���� sys


select * from DBA_ROLE_PRIVS where grantee like 'SYS'


--�������� ������ ���� �������� ������������� ������������

select * from DBA_OBJECTS where OWNER like 'SYS'



select * from dictionary where TABLE_NAME like 'objects'