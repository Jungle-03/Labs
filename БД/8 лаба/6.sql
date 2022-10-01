select case 
	when NOTE = 4 then 'Минимальная оценка'
	when NOTE between 5 and 6 then 'Выше минимального'
	when NOTE between 7 and 8 then 'Средний уровень'
	when NOTE between 9 and 10 then 'Хороший уровень'
		else 'Пересдача'
	end Оценка, count(*)[Кол-во]	
from PROGRESS
group by case
	when NOTE = 4 then 'Минимальная оценка'
	when NOTE between 5 and 6 then 'Выше минимального'
	when NOTE between 7 and 8 then 'Средний уровень'
	when NOTE between 9 and 10 then 'Хороший уровень'
		else 'Пересдача'
	end;