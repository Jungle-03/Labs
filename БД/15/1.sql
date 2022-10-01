
go


--=========== 1 ===========--


select * from TEACHER
where PULPIT like '����'
for xml raw('������'), root('�������_����'), elements;


--=========== 2 ===========--


select auditorium.AUDITORIUM_NAME, auditorium_type.AUDITORIUM_TYPENAME,auditorium.AUDITORIUM_CAPACITY
from AUDITORIUM inner join AUDITORIUM_TYPE
on auditorium_type.AUDITORIUM_TYPE = auditorium.AUDITORIUM_TYPE
where auditorium_type.AUDITORIUM_TYPE like '��'
for xml auto, root('����������_���������');


--=========== 3 ===========--


declare @h int = 0;
declare @xml varchar(500) = 
	   '<?xml version="1.0" encoding="windows-1251" ?>
       <SUBJECT> 
			<S SUBJECT="3�_����" SUBJECT_NAME="3�_������" PULPIT="��" /> 
			<S SUBJECT="���" SUBJECT_NAME="�������" PULPIT="��" /> 
			<S SUBJECT="����" SUBJECT_NAME="������" PULPIT="��"  />  
       </SUBJECT>';

exec sp_xml_preparedocument @h output, @xml;

insert SUBJECT select * from openxml(@h, '/SUBJECT/S', 0)
with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20));

exec sp_xml_removedocument @h;

select * from SUBJECT;


--=========== 4 ===========--


declare @info xml = 
	'<�������>
		<������� �����="MP" �����="47638283" ����="11.04.2016"/>
		<�������>7392836</�������>
		<�����>
			<������>��</������>
			<�����>�����</�����>
			<�����>���������</�����>
			<���>9</���>
			<��������>null</��������>
		</�����>
	</�������>';

--delete STUDENT where INFO.query('/�������') is not null;
insert STUDENT values(1,'����������� ������ ���������', null, null, @info, null);

select STUDENT.NAME,
INFO.value('(/�������/�������/@�����)[1]','varchar(10)')[�����_��������],
INFO.value('(/�������/�������/@�����)[1]','varchar(10)')[�����_��������],
INFO.value('(/�������/�������/@����)[1]','varchar(10)')[����_������],
INFO.query('/�������/�����')[�����]
from STUDENT
order by STUDENT.IDSTUDENT desc


--=========== 5 ===========--

--drop xml schema collection student;

create xml schema collection student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="�������">  
       <xs:complexType><xs:sequence>
       <xs:element name="�������" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="�����" type="xs:string" use="required" />
       <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="����"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
   <xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   <xs:element name="��������" type="xs:string" />
   </xs:sequence></xs:complexType>  </xs:element>
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';


alter table student alter column info xml(Student)




--�� ������
declare @info2 xml = 
	'<�������>
		<������� �����="MP" �����="47638283" ����="11.04.2016"/>
		<�������>7392836</�������>
		<�����>
			<������>��</������>
			<�����>�����</�����>
		</�����>
	</�������>';

--delete STUDENT where INFO.query('/�������') is not null;
insert STUDENT values(1, '������� ����������', null, null, @info2, null);




--������
declare @info3 xml = 
	'<�������>
		<������� �����="MP" �����="47638283" ����="11.04.2016"/>
		<�������>7392836</�������>
		<�����>
			<������>��</������>
			<�����>�����</�����>
			<�����>���������</�����>
			<���>9</���>
			<��������>null</��������>
		</�����>
	</�������>';

--delete STUDENT where INFO.query('/�������') is not null;
insert STUDENT values(1, '������ ����������', null, null, @info3, null);
