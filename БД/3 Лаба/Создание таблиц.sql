CREATE table �������
(	
	id int primary key ,
	��������_�������� nvarchar(20) unique,
	������� int,
	���������_������ money not null,
	��������_�����_��������� nvarchar(20) 
	 
);
CREATE table ���������
(
	id int primary key,	
	����������_��������� nvarchar(50) unique,
	����������_���� nvarchar(20)
	
);

CREATE table ������
(	id_������� int foreign key references �������(id),
	id_�������� int foreign key references ���������(id),
	���_������� nvarchar(20),
	���� date,
	������������_�_������� int,
	
);
