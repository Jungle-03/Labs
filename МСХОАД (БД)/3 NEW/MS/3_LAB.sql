--1. Добавление столбца данных иерархического типа

ALTER TABLE Vehicles
ADD HierarchyNode HIERARCHYID;


--2. Процедура для отображения всех подчиненных узлов с указанием уровня иерархии

CREATE PROCEDURE GetSubordinateNodes
    @Node HIERARCHYID
AS
BEGIN
    SELECT 
        HierarchyNode.ToString() AS Node,
        HierarchyNode.GetLevel() AS Level
    FROM Vehicles
    WHERE HierarchyNode.IsDescendantOf(@Node) = 1;
END;


--3. Процедура для добавления подчиненного узла

CREATE PROCEDURE AddSubordinateNode
    @ParentNode HIERARCHYID,
    @LicensePlate VARCHAR(50),
    @Model VARCHAR(50),
    @Capacity INT
AS
BEGIN
    -- Добавление нового узла в таблицу Vehicles с корректным использованием HIERARCHYID
    INSERT INTO dbo.Vehicles (LicensePlate, Model, Capacity, HierarchyNode)
    VALUES (@LicensePlate, @Model, @Capacity, @ParentNode.GetDescendant(NULL, NULL));
END



--4. Процедура для перемещения подчиненной ветки

CREATE PROCEDURE MoveSubtree
    @SourceNode HIERARCHYID,
    @TargetNode HIERARCHYID
AS
BEGIN
    -- Перемещаем все подчиненные узлы, обновляя их иерархические значения
    UPDATE Vehicles
    SET HierarchyNode = @TargetNode.GetDescendant(NULL, NULL)
    WHERE HierarchyNode.IsDescendantOf(@SourceNode) = 1;
END;



--1. Добавление данных в таблицу

SELECT * FROM Vehicles;


INSERT INTO Vehicles (VehicleID, LicensePlate, Model, Capacity, HierarchyNode)
VALUES (6, 'ABC124', 'Car Model A', 4, HIERARCHYID::GetRoot());


--2. Вызов процедуры для отображения всех подчиненных узлов

DECLARE @Node HIERARCHYID;
SET @Node = HIERARCHYID::GetRoot();

EXEC GetSubordinateNodes @Node;


--3. Добавление подчиненного узла
EXEC AddSubordinateNode 
    @ParentNode = HIERARCHYID::GetRoot(),
    @LicensePlate = 'XYZ789',
    @Model = 'Car Model B',
    @Capacity = 5;


--4. Проверка подчиненных узлов после добавления

-- Объявление переменной для узла
DECLARE @Node HIERARCHYID;
SET @Node = HIERARCHYID::GetRoot(); -- Получение корневого узла

-- Вызов процедуры для получения подчиненных узлов
EXEC GetSubordinateNodes @Node = @Node;


--5. Перемещение подчиненной ветки


-- 1. Добавление подчиненного узла
EXEC AddSubordinateNode 
    @ParentNode = HIERARCHYID::GetRoot(),
    @LicensePlate = 'LMN456',
    @Model = 'Car Model C',
    @Capacity = 2;

-- 2. Проверка существования узла
SELECT * 
FROM Vehicles 
WHERE HierarchyNode = HIERARCHYID::GetRoot().GetDescendant(0, 0);

-- 3. Перемещение поддерева
EXEC MoveSubtree 
    @SourceNode = HIERARCHYID::GetRoot().GetDescendant(0, 0),  -- Укажите нужный узел
    @TargetNode = HIERARCHYID::GetRoot().GetDescendant(1, 0);  -- Укажите целевой узел