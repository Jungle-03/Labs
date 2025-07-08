ALTER TABLE VehicleRentals
ADD HierarchyNode hierarchyid;


------2.	������� ���������, ������� ��������� ��� ����������� ���� � ��������� ������ �������� (�������� � �������� ����).


CREATE PROCEDURE GetSubordinates
    @RootNode hierarchyid
AS
BEGIN
    SET NOCOUNT ON;

    -- ���������� �������� ����
    PRINT '�������� ����:';
    SELECT 
        RentalID,
        DriverID,
        VehicleID,
        StartDate,
        EndDate,
        HierarchyNode.ToString() AS HierarchyNode
    FROM VehicleRentals
    WHERE HierarchyNode = @RootNode;

    -- ���������� ���������� ����
    PRINT '����������� ����:';
    SELECT 
        RentalID,
        DriverID,
        VehicleID,
        StartDate,
        EndDate,
        HierarchyNode.ToString() AS HierarchyNode,
        CASE 
            WHEN HierarchyNode.IsDescendantOf(@RootNode) = 1 THEN '�������� ���� � RentalID: ' + CAST((SELECT RentalID FROM VehicleRentals WHERE HierarchyNode = @RootNode) AS VARCHAR(10))
            ELSE '�� �������� ����������'
        END AS Relationship,
        HierarchyNode.GetLevel() AS Level
    FROM VehicleRentals
    WHERE HierarchyNode.IsDescendantOf(@RootNode) = 1;
END;


DECLARE @RootNode hierarchyid;
SET @RootNode = hierarchyid::Parse('/1/1/');  -- ������ ��������� ����

EXEC GetSubordinates @RootNode;




select * from VehicleRentals



--3.	������� ���������, ������� ������� ����������� ���� (�������� � �������� ����).


CREATE PROCEDURE AddSubordinateNode2
    @RentalID INT,      -- ������� �������� ��� RentalID
    @ParentRentalID INT,
    @DriverID INT,
    @VehicleID INT,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    DECLARE @NewHierarchyNode hierarchyid;
    DECLARE @ParentNode hierarchyid;

    -- �������� ������� ���� ��������
    SELECT @ParentNode = HierarchyNode FROM VehicleRentals WHERE RentalID = @ParentRentalID;

    -- ���������� ����� ���� ������������
    SET @NewHierarchyNode = @ParentNode.GetDescendant(NULL, NULL); 

    -- �������� �� ������������
    WHILE EXISTS (SELECT 1 FROM VehicleRentals WHERE HierarchyNode = @NewHierarchyNode)
    BEGIN
        SET @NewHierarchyNode = @NewHierarchyNode.GetDescendant(NULL, NULL);
    END

    -- ��������� ����� ���� � �������
    INSERT INTO VehicleRentals (RentalID, DriverID, VehicleID, StartDate, EndDate, HierarchyNode)
    VALUES (@RentalID, @DriverID, @VehicleID, @StartDate, @EndDate, @NewHierarchyNode);

    -- ���������� ID ������ ����
    SELECT @RentalID AS NewRentalID;
END;


EXEC AddSubordinateNode2 
    @RentalID = 12,      -- ������� �������� ��� RentalID
    @ParentRentalID = 1, 
    @DriverID = 2, 
    @VehicleID = 3, 
    @StartDate = '2023-01-22', 
    @EndDate = '2023-02-10';




	--4.	������� ���������, ������� ���������� ��� ����������� ����� 
	--(������ �������� � �������� �������� ������������� ����, ������ �������� � �������� ����, � ������� ���������� �����������).


create PROCEDURE MoveSubtree
    @SourceNode hierarchyid,  -- ����, ������� ����� �����������
    @TargetNode hierarchyid    -- ����, � ������� ����������
AS
BEGIN
    SET NOCOUNT ON;

    -- �������� ��� ���� ���������, ������� ����� �����������
    DECLARE @SubtreeNodes TABLE (RentalID INT, HierarchyNode hierarchyid);

    INSERT INTO @SubtreeNodes (RentalID, HierarchyNode)
    SELECT RentalID, HierarchyNode
    FROM VehicleRentals
    WHERE HierarchyNode.IsDescendantOf(@SourceNode) = 1 OR HierarchyNode = @SourceNode;

    -- ���������� ������ ���� ���������
    DECLARE @RentalID INT;
    DECLARE @CurrentNode hierarchyid;

    DECLARE Cur CURSOR FOR
    SELECT RentalID, HierarchyNode FROM @SubtreeNodes;

    OPEN Cur;
    FETCH NEXT FROM Cur INTO @RentalID, @CurrentNode;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- ��������� ����� ����
        DECLARE @NewNode hierarchyid;
        SET @NewNode = @TargetNode.GetDescendant(NULL, NULL);

        -- �������� �� ������������
        WHILE EXISTS (SELECT 1 FROM VehicleRentals WHERE HierarchyNode = @NewNode)
        BEGIN
            SET @NewNode = @NewNode.GetDescendant(NULL, NULL);
        END

        -- ��������� ����
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

SET @SourceNode = hierarchyid::Parse('/1/1/');  -- ����, ������� ����� �����������
SET @TargetNode = hierarchyid::Parse('/1/');  -- ����, � ������� ����������

EXEC MoveSubtree @SourceNode, @TargetNode;


select * from VehicleRentals

