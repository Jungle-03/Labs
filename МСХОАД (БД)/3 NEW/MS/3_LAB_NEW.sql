ALTER TABLE VehicleRentals
ADD HierarchyNode hierarchyid;


------2.	Создать процедуру, которая отобразит все подчиненные узлы с указанием уровня иерархии (параметр – значение узла).


CREATE PROCEDURE GetSubordinates
    @RootNode hierarchyid
AS
BEGIN
    SET NOCOUNT ON;

    -- Отображаем корневой узел
    PRINT 'Корневой узел:';
    SELECT 
        RentalID,
        DriverID,
        VehicleID,
        StartDate,
        EndDate,
        HierarchyNode.ToString() AS HierarchyNode
    FROM VehicleRentals
    WHERE HierarchyNode = @RootNode;

    -- Отображаем подчинённые узлы
    PRINT 'Подчиненные узлы:';
    SELECT 
        RentalID,
        DriverID,
        VehicleID,
        StartDate,
        EndDate,
        HierarchyNode.ToString() AS HierarchyNode,
        CASE 
            WHEN HierarchyNode.IsDescendantOf(@RootNode) = 1 THEN 'Подчинен узлу с RentalID: ' + CAST((SELECT RentalID FROM VehicleRentals WHERE HierarchyNode = @RootNode) AS VARCHAR(10))
            ELSE 'Не является подчинённым'
        END AS Relationship,
        HierarchyNode.GetLevel() AS Level
    FROM VehicleRentals
    WHERE HierarchyNode.IsDescendantOf(@RootNode) = 1;
END;


DECLARE @RootNode hierarchyid;
SET @RootNode = hierarchyid::Parse('/1/1/');  -- Пример корневого узла

EXEC GetSubordinates @RootNode;




select * from VehicleRentals



--3.	Создать процедуру, которая добавит подчиненный узел (параметр – значение узла).


CREATE PROCEDURE AddSubordinateNode2
    @RentalID INT,      -- Укажите значение для RentalID
    @ParentRentalID INT,
    @DriverID INT,
    @VehicleID INT,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    DECLARE @NewHierarchyNode hierarchyid;
    DECLARE @ParentNode hierarchyid;

    -- Получаем текущий узел родителя
    SELECT @ParentNode = HierarchyNode FROM VehicleRentals WHERE RentalID = @ParentRentalID;

    -- Генерируем новый узел подчиненного
    SET @NewHierarchyNode = @ParentNode.GetDescendant(NULL, NULL); 

    -- Проверка на уникальность
    WHILE EXISTS (SELECT 1 FROM VehicleRentals WHERE HierarchyNode = @NewHierarchyNode)
    BEGIN
        SET @NewHierarchyNode = @NewHierarchyNode.GetDescendant(NULL, NULL);
    END

    -- Вставляем новый узел в таблицу
    INSERT INTO VehicleRentals (RentalID, DriverID, VehicleID, StartDate, EndDate, HierarchyNode)
    VALUES (@RentalID, @DriverID, @VehicleID, @StartDate, @EndDate, @NewHierarchyNode);

    -- Возвращаем ID нового узла
    SELECT @RentalID AS NewRentalID;
END;


EXEC AddSubordinateNode2 
    @RentalID = 12,      -- Укажите значение для RentalID
    @ParentRentalID = 1, 
    @DriverID = 2, 
    @VehicleID = 3, 
    @StartDate = '2023-01-22', 
    @EndDate = '2023-02-10';




	--4.	Создать процедуру, которая переместит всю подчиненную ветку 
	--(первый параметр – значение верхнего перемещаемого узла, второй параметр – значение узла, в который происходит перемещение).


create PROCEDURE MoveSubtree
    @SourceNode hierarchyid,  -- Узел, который нужно переместить
    @TargetNode hierarchyid    -- Узел, в который перемещаем
AS
BEGIN
    SET NOCOUNT ON;

    -- Получаем все узлы поддерева, которое нужно переместить
    DECLARE @SubtreeNodes TABLE (RentalID INT, HierarchyNode hierarchyid);

    INSERT INTO @SubtreeNodes (RentalID, HierarchyNode)
    SELECT RentalID, HierarchyNode
    FROM VehicleRentals
    WHERE HierarchyNode.IsDescendantOf(@SourceNode) = 1 OR HierarchyNode = @SourceNode;

    -- Перемещаем каждый узел поддерева
    DECLARE @RentalID INT;
    DECLARE @CurrentNode hierarchyid;

    DECLARE Cur CURSOR FOR
    SELECT RentalID, HierarchyNode FROM @SubtreeNodes;

    OPEN Cur;
    FETCH NEXT FROM Cur INTO @RentalID, @CurrentNode;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Вычисляем новый узел
        DECLARE @NewNode hierarchyid;
        SET @NewNode = @TargetNode.GetDescendant(NULL, NULL);

        -- Проверка на уникальность
        WHILE EXISTS (SELECT 1 FROM VehicleRentals WHERE HierarchyNode = @NewNode)
        BEGIN
            SET @NewNode = @NewNode.GetDescendant(NULL, NULL);
        END

        -- Обновляем узел
        UPDATE VehicleRentals
        SET HierarchyNode = @NewNode
        WHERE RentalID = @RentalID;

        FETCH NEXT FROM Cur INTO @RentalID, @CurrentNode;
    END

    CLOSE Cur;
    DEALLOCATE Cur;
END;




DECLARE @SourceNode hierarchyid;
DECLARE @TargetNode hierarchyid;

SET @SourceNode = hierarchyid::Parse('/1/1/');  -- Узел, который нужно переместить
SET @TargetNode = hierarchyid::Parse('/1/');  -- Узел, в который перемещаем

EXEC MoveSubtree @SourceNode, @TargetNode;


select * from VehicleRentals

