
go


--=========== 1 ===========--


select * from TEACHER
where PULPIT like 'ИСиТ'
for xml raw('Препод'), root('Преподы_ИСиТ'), elements;


--=========== 2 ===========--


select auditorium.AUDITORIUM_NAME, auditorium_type.AUDITORIUM_TYPENAME,auditorium.AUDITORIUM_CAPACITY
from AUDITORIUM inner join AUDITORIUM_TYPE
on auditorium_type.AUDITORIUM_TYPE = auditorium.AUDITORIUM_TYPE
where auditorium_type.AUDITORIUM_TYPE like 'ЛК'
for xml auto, root('Лекционные_аудитории');


--=========== 3 ===========--


declare @h int = 0;
declare @xml varchar(500) = 
	   '<?xml version="1.0" encoding="windows-1251" ?>
       <SUBJECT> 
			<S SUBJECT="3д_макс" SUBJECT_NAME="3д_максим" PULPIT="ЛУ" /> 
			<S SUBJECT="Блн" SUBJECT_NAME="Блендер" PULPIT="ЛУ" /> 
			<S SUBJECT="Макс" SUBJECT_NAME="Миксер" PULPIT="ЛУ"  />  
       </SUBJECT>';

exec sp_xml_preparedocument @h output, @xml;

insert SUBJECT select * from openxml(@h, '/SUBJECT/S', 0)
with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20));

exec sp_xml_removedocument @h;

select * from SUBJECT;


--=========== 4 ===========--


declare @info xml = 
	'<студент>
		<паспорт серия="MP" номер="47638283" дата="11.04.2016"/>
		<телефон>7392836</телефон>
		<адрес>
			<страна>РБ</страна>
			<город>Минск</город>
			<улица>Свердлова</улица>
			<дом>9</дом>
			<квартира>null</квартира>
		</адрес>
	</студент>';

--delete STUDENT where INFO.query('/студент') is not null;
insert STUDENT values(1,'Врублевский Никита Андреевич', null, null, @info, null);

select STUDENT.NAME,
INFO.value('(/студент/паспорт/@серия)[1]','varchar(10)')[Серия_паспорта],
INFO.value('(/студент/паспорт/@номер)[1]','varchar(10)')[Номер_паспорта],
INFO.value('(/студент/паспорт/@дата)[1]','varchar(10)')[Дата_выдачи],
INFO.query('/студент/адрес')[Адрес]
from STUDENT
order by STUDENT.IDSTUDENT desc


--=========== 5 ===========--

--drop xml schema collection student;

create xml schema collection student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="студент">  
       <xs:complexType><xs:sequence>
       <xs:element name="паспорт" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="серия" type="xs:string" use="required" />
       <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="дата"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
   <xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" />
   <xs:element name="город" type="xs:string" />
   <xs:element name="улица" type="xs:string" />
   <xs:element name="дом" type="xs:string" />
   <xs:element name="квартира" type="xs:string" />
   </xs:sequence></xs:complexType>  </xs:element>
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';


alter table student alter column info xml(Student)




--не верный
declare @info2 xml = 
	'<студент>
		<паспорт серия="MP" номер="47638283" дата="11.04.2016"/>
		<телефон>7392836</телефон>
		<адрес>
			<страна>РБ</страна>
			<город>Минск</город>
		</адрес>
	</студент>';

--delete STUDENT where INFO.query('/студент') is not null;
insert STUDENT values(1, 'Алексей алексеевич', null, null, @info2, null);




--верный
declare @info3 xml = 
	'<студент>
		<паспорт серия="MP" номер="47638283" дата="11.04.2016"/>
		<телефон>7392836</телефон>
		<адрес>
			<страна>РБ</страна>
			<город>Минск</город>
			<улица>Свердлова</улица>
			<дом>9</дом>
			<квартира>null</квартира>
		</адрес>
	</студент>';

--delete STUDENT where INFO.query('/студент') is not null;
insert STUDENT values(1, 'Максим Максимович', null, null, @info3, null);
