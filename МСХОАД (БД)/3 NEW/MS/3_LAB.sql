--1. ���������� ������� ������ �������������� ����

ALTER TABLE Vehicles
ADD HierarchyNode HIERARCHYID;


--2. ��������� ��� ����������� ���� ����������� ����� � ��������� ������ ��������

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


--3. ��������� ��� ���������� ������������ ����

CREATE PROCEDURE AddSubordinateNode
    @ParentNode HIERARCHYID,
    @LicensePlate VARCHAR(50),
    @Model VARCHAR(50),
    @Capacity INT
AS
BEGIN
    -- ���������� ������ ���� � ������� Vehicles � ���������� �������������� HIERARCHYID
    INSERT INTO dbo.Vehicles (LicensePlate, Model, Capacity, HierarchyNode)
    VALUES (@LicensePlate, @Model, @Capacity, @ParentNode.GetDescendant(NULL, NULL));
END



--4. ��������� ��� ����������� ����������� �����

CREATE PROCEDURE MoveSubtree
    @SourceNode HIERARCHYID,
    @TargetNode HIERARCHYID
AS
BEGIN
    -- ���������� ��� ����������� ����, �������� �� ������������� ��������
    UPDATE Vehicles
    SET HierarchyNode = @TargetNode.GetDescendant(NULL, NULL)
    WHERE HierarchyNode.IsDescendantOf(@SourceNode) = 1;
END;



--1. ���������� ������ � �������

SELECT * FROM Vehicles;


INSERT INTO Vehicles (VehicleID, LicensePlate, Model, Capacity, HierarchyNode)
VALUES (6, 'ABC124', 'Car Model A', 4, HIERARCHYID::GetRoot());


--2. ����� ��������� ��� ����������� ���� ����������� �����

DECLARE @Node HIERARCHYID;
SET @Node = HIERARCHYID::GetRoot();

EXEC GetSubordinateNodes @Node;


--3. ���������� ������������ ����
EXEC AddSubordinateNode 
    @ParentNode = HIERARCHYID::GetRoot(),
    @LicensePlate = 'XYZ789',
    @Model = 'Car Model B',
    @Capacity = 5;


--4. �������� ����������� ����� ����� ����������

-- ���������� ���������� ��� ����
DECLARE @Node HIERARCHYID;
SET @Node = HIERARCHYID::GetRoot(); -- ��������� ��������� ����

-- ����� ��������� ��� ��������� ����������� �����
EXEC GetSubordinateNodes @Node = @Node;


--5. ����������� ����������� �����


-- 1. ���������� ������������ ����
EXEC AddSubordinateNode 
    @ParentNode = HIERARCHYID::GetRoot(),
    @LicensePlate = 'LMN456',
    @Model = 'Car Model C',
    @Capacity = 2;

-- 2. �������� ������������� ����
SELECT * 
FROM Vehicles 
WHERE HierarchyNode = HIERARCHYID::GetRoot().GetDescendant(0, 0);

-- 3. ����������� ���������
EXEC MoveSubtree 
    @SourceNode = HIERARCHYID::GetRoot().GetDescendant(0, 0),  -- ������� ������ ����
    @TargetNode = HIERARCHYID::GetRoot().GetDescendant(1, 0);  -- ������� ������� ����