create table �������_���
(
��� int primary key identity(1,1),
��������_�������� nvarchar(50)
);


create table ����
(
��� int primary key identity (1,1),
��������_���� nvarchar(50) unique,
���_�������� int foreign key references �������_���(���) 

);

insert into �������_���
values
('Steam'),
('Epic Games'),
('Battle Net');


insert into ����
values ('Dota 2',1),
('Counter Strike',Null),
('Everlasting Summer',2);



-- left & right 

select ����.��������_����, �������_���.��� from ���� left join �������_���
	ON ����.���_�������� = �������_���.���;

select ����.��������_����, �������_���.��� from ���� right join �������_���
	ON ����.���_�������� = �������_���.���;

select ����.��������_����, �������_���.��� from ���� full join �������_���
	ON ����.���_�������� = �������_���.���;


--��������������

select ����.��������_����, �������_���.��� from �������_��� full join ����
	ON ����.���_�������� = �������_���.���;

-- ��������� � ���� inner join

select ����.��������_����, �������_���.��� from ���� full join �������_���
	ON ����.���_�������� = �������_���.���
	where ����.��������_���� is not null and �������_���.��� is null;

select ����.��������_����, �������_���.��� from ���� inner join �������_���
on ����.���_�������� = �������_���.���


--���������, ��� ������ ������� �� ����� ��������
select ����.��������_����, �������_���.��� from ���� full join �������_���
on ����.���_�������� = �������_���.���
where �������_���.��� is null

--���������, ��� ����� ������� �� ����� ��������
select ����.��������_����, �������_���.��� from ���� full join �������_���
on ����.���_�������� = �������_���.���
where ����.��������_���� is null

--���������, � ������� ��� ������� ����� ������� 
select ����.��������_����, �������_���.��� from ���� full join �������_���
on ����.���_�������� = �������_���.���
where ����.��������_���� is not null and �������_���.��� is not null;