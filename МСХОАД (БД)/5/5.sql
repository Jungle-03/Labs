

CREATE TABLE spatial_data5 (
    id INT PRIMARY KEY IDENTITY(1,1),  -- Уникальный идентификатор
    name VARCHAR(255),                  -- Имя точки
    description VARCHAR(255),           -- Описание
    geom GEOMETRY                       -- Геометрия (тип геометрии)
);


INSERT INTO spatial_data5 (name, description, geom) VALUES
('Point A2', 'Описание точки A5', geometry::STGeomFromText('POINT(1615917 -807141)', 0)),
('Point B2', 'Описание точки B5', geometry::STGeomFromText('POINT(1272170 -235991)', 0)),
('Point C2', 'Описание точки C5', geometry::STGeomFromText('POINT(1987870 -366439)', 0)),
('Point D2', 'Описание точки D5', geometry::STGeomFromText('POINT(1721686 16090)', 0)),
('Point E2', 'Описание точки E5', geometry::STGeomFromText('POINT(1072972 -35031)', 0));



--6.	Определите тип пространственных данных во всех таблицах.


SELECT 
    t.name AS table_name,
    c.name AS geometry_column,
    type_name(user_type_id) AS geometry_type
FROM 
    sys.tables AS t
JOIN 
    sys.columns AS c ON t.object_id = c.object_id
WHERE 
    c.system_type_id = 240;  -- 240 - это ID для типа GEOMETRY



	--7.	Определите SRID.



SELECT 
    geom.STSrid AS srid
FROM 
    spatial_data5
WHERE 
    geom IS NOT NULL;  -- Убедитесь, что есть данные в столбце geom

	--SRID это привязка к системе коардинат у меня был 0
	--('Point A2', 'Описание точки A5', geometry::STGeomFromText('POINT(1615917 -807141)', 0)),


	CREATE TABLE spatial_data6 (
    id INT PRIMARY KEY IDENTITY(1,1),  -- Уникальный идентификатор
    name VARCHAR(255),                  -- Имя точки
    description VARCHAR(255),           -- Описание
    geom GEOMETRY                       -- Геометрия (тип геометрии)
);



INSERT INTO spatial_data6 (name, description, geom) VALUES
('Point A2', 'Описание точки A6', geometry::STGeomFromText('POINT(-4.491 16.131)', 3857)),
('Point B2', 'Описание точки B6', geometry::STGeomFromText('POINT(-2.784 13.518)', 3857)),
('Point C2', 'Описание точки C6', geometry::STGeomFromText('POINT(1.221 12.046)', 3857)),
('Point D2', 'Описание точки D6', geometry::STGeomFromText('POINT(-0.045 18.617)', 3857)),
('Point E2', 'Описание точки E6', geometry::STGeomFromText('POINT(-5.910 17.050)', 3857));


SELECT 
    geom.STSrid AS srid
FROM 
    spatial_data6
WHERE 
    geom IS NOT NULL;  


--8.	Определите атрибутивные столбцы.

	SELECT 
    c.name AS column_name, 
    ty.name AS data_type
FROM 
    sys.columns AS c
JOIN 
    sys.types AS ty ON c.user_type_id = ty.user_type_id
WHERE 
    c.object_id = OBJECT_ID('spatial_data5');

	--9.	Верните описания пространственных объектов в формате WKT.

	SELECT 
    id, 
    name, 
    description,
    geom.STAsText() AS geom_wkt
FROM 
    spatial_data5
WHERE 
    geom IS NOT NULL;  -- Убедитесь, что геометрия не пустая
