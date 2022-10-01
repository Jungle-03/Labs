CREATE table РЕКЛАМА
(	
	id int primary key ,
	Название_передачи nvarchar(20) unique,
	Рейтинг int,
	Стоимость_минуты money not null,
	Название_фирмы_заказчика nvarchar(20) 
	 
);
CREATE table ЗАКАЗЧИКИ
(
	id int primary key,	
	Банковские_реквизиты nvarchar(50) unique,
	Контактное_лицо nvarchar(20)
	
);

CREATE table ЗАКАЗЫ
(	id_рекламы int foreign key references РЕКЛАМА(id),
	id_человека int foreign key references ЗАКАЗЧИКИ(id),
	Вид_рекламы nvarchar(20),
	Дата date,
	Длительность_в_минутах int,
	
);
