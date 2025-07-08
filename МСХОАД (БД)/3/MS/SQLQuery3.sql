//1. Добавление столбца иерархического типа в таблицу

ALTER TABLE Customers
ADD HierarchyNode HIERARCHYID;


SELECT 
    COLUMN_NAME, 
    DATA_TYPE 
FROM 
    INFORMATION_SCHEMA.COLUMNS 
WHERE 
    TABLE_NAME = 'Customers';

//2. Процедура для отображения всех подчиненных узлов с указанием уровня иерархии

CREATE PROCEDURE GetSubordinates
    @Node HIERARCHYID
AS
BEGIN
    SELECT 
        HierarchyNode.GetAncestor(HierarchyNode.GetLevel()) AS ParentNode,
        HierarchyNode.ToString() AS CurrentNode,
        HierarchyNode.GetLevel() AS HierarchyLevel
    FROM Customers
    WHERE HierarchyNode.IsDescendantOf(@Node) = 1;
END;


SELECT 
    CustomerID, 
    FirstName, 
    LastName, 
    PassportNumber, 
    HierarchyNode.ToString() AS HierarchyNode
FROM 
    Customers;

//3. Процедура для добавления подчиненного узла

CREATE PROCEDURE AddSubordinate
    @ParentNode HIERARCHYID,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(255),
    @PassportNumber NVARCHAR(50)
AS
BEGIN
    DECLARE @NewNode HIERARCHYID = @ParentNode.GetDescendant(NULL, NULL);
    
    INSERT INTO Customers (FirstName, LastName, PassportNumber, HierarchyNode)
    VALUES (@FirstName, @LastName, @PassportNumber, @NewNode);
END;



DECLARE @Node HIERARCHYID;  
SET @Node = (SELECT HierarchyNode FROM Customers WHERE CustomerID = 1);  

EXEC GetSubordinates @Node;
//4. Процедура для перемещения подчиненной ветки

CREATE PROCEDURE MoveSubtree
    @SourceNode HIERARCHYID,
    @TargetNode HIERARCHYID
AS
BEGIN
    DECLARE @NewParent HIERARCHYID = @TargetNode.GetDescendant(NULL, NULL);

    UPDATE Customers
    SET HierarchyNode = @NewParent
    WHERE HierarchyNode.IsDescendantOf(@SourceNode) = 1;
END;



SELECT 
    CustomerID, 
    FirstName, 
    LastName, 
    PassportNumber, 
    HierarchyNode.ToString() AS HierarchyNode
FROM 
    Customers;


--1. Вызов процедуры для добавления подчиненного узла




DECLARE @ParentNode HIERARCHYID;  -- Замените на фактический идентификатор родительского узла
SET @ParentNode = (SELECT HierarchyNode FROM Customers WHERE CustomerID = 1);  -- Замените 1 на нужный CustomerID

EXEC AddSubordinate 
    @ParentNode = @ParentNode,
    @FirstName = 'John',
    @LastName = 'Doe',
    @PassportNumber = '123456';
--2. Вызов процедуры для отображения всех подчиненных узлов


DECLARE @Node HIERARCHYID;  -- Замените на фактический узел
SET @Node = (SELECT HierarchyNode FROM Customers WHERE CustomerID = 1);  -- Замените 1 на нужный CustomerID

EXEC GetSubordinates @Node;
--3. Вызов процедуры для перемещения подчиненной ветки


DECLARE @SourceNode HIERARCHYID;  -- Замените на фактический исходный узел
DECLARE @TargetNode HIERARCHYID;  -- Замените на фактический целевой узел

SET @SourceNode = (SELECT HierarchyNode FROM Customers WHERE CustomerID = 1);  -- Замените 1 на нужный CustomerID
SET @TargetNode = (SELECT HierarchyNode FROM Customers WHERE CustomerID = 2);  -- Замените 2 на нужный CustomerID

EXEC MoveSubtree @SourceNode, @TargetNode;