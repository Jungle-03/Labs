//1. ���������� ������� �������������� ���� � �������

ALTER TABLE Customers
ADD HierarchyNode HIERARCHYID;


SELECT 
    COLUMN_NAME, 
    DATA_TYPE 
FROM 
    INFORMATION_SCHEMA.COLUMNS 
WHERE 
    TABLE_NAME = 'Customers';

//2. ��������� ��� ����������� ���� ����������� ����� � ��������� ������ ��������

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

//3. ��������� ��� ���������� ������������ ����

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
//4. ��������� ��� ����������� ����������� �����

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


--1. ����� ��������� ��� ���������� ������������ ����




DECLARE @ParentNode HIERARCHYID;  -- �������� �� ����������� ������������� ������������� ����
SET @ParentNode = (SELECT HierarchyNode FROM Customers WHERE CustomerID = 1);  -- �������� 1 �� ������ CustomerID

EXEC AddSubordinate 
    @ParentNode = @ParentNode,
    @FirstName = 'John',
    @LastName = 'Doe',
    @PassportNumber = '123456';
--2. ����� ��������� ��� ����������� ���� ����������� �����


DECLARE @Node HIERARCHYID;  -- �������� �� ����������� ����
SET @Node = (SELECT HierarchyNode FROM Customers WHERE CustomerID = 1);  -- �������� 1 �� ������ CustomerID

EXEC GetSubordinates @Node;
--3. ����� ��������� ��� ����������� ����������� �����


DECLARE @SourceNode HIERARCHYID;  -- �������� �� ����������� �������� ����
DECLARE @TargetNode HIERARCHYID;  -- �������� �� ����������� ������� ����

SET @SourceNode = (SELECT HierarchyNode FROM Customers WHERE CustomerID = 1);  -- �������� 1 �� ������ CustomerID
SET @TargetNode = (SELECT HierarchyNode FROM Customers WHERE CustomerID = 2);  -- �������� 2 �� ������ CustomerID

EXEC MoveSubtree @SourceNode, @TargetNode;