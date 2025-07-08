--5. ������� ��� �������� ������������� ������ � ������� ���� ������

ALTER TABLE Vehicles
ADD ParentVehicleID INT;

-- ���������� ������� ��� ����������� ��������
-- �����������, ��� 0 ��������, ��� � ���� ��� ��������
UPDATE Vehicles
SET ParentVehicleID = 0;

--6. ��������� ��� ������ � ��������� � Oracle

--��������� ��� ����������� ���� ����������� ����� � ��������� ������ ��������

CREATE OR REPLACE PROCEDURE GetSubordinateNodes (p_NodeID IN INT) IS
BEGIN
    FOR rec IN (
        SELECT VehicleID, LEVEL
        FROM Vehicles
        START WITH VehicleID = p_NodeID
        CONNECT BY PRIOR VehicleID = ParentVehicleID
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Node: ' || rec.VehicleID || ' Level: ' || rec.LEVEL);
    END LOOP;
END;




-------
CREATE OR REPLACE PROCEDURE DisplayHierarchy (
    p_node_value INT
) AS
    TYPE HierarchyRecord IS RECORD (
        RentalID INT,
        DriverID INT,
        VehicleID INT,
        Level INT
    );

    TYPE HierarchyTable IS TABLE OF HierarchyRecord;
    v_hierarchy HierarchyTable;

    v_level INT := 0;
    v_processed_ids SYS.ODCINumberList := SYS.ODCINumberList(); -- ��� ������������ ������������ DriverID

    PROCEDURE GetHierarchy(p_vehicle_id INT, p_current_level INT) IS
    BEGIN
        -- ��������, ��� �� ���� ��� ���������
        IF p_vehicle_id IS NULL OR v_processed_ids.EXISTS(p_vehicle_id) THEN
            RETURN;
        END IF;

        -- ��������� ������� ���� � ������ ������������
        v_processed_ids.EXTEND;
        v_processed_ids(v_processed_ids.COUNT) := p_vehicle_id;

        FOR r IN (
            SELECT 
                RentalID,
                DriverID,
                VehicleID
            FROM 
                VehicleRentals
            WHERE 
                VehicleID = p_vehicle_id
        ) LOOP
            v_hierarchy.EXTEND;
            v_hierarchy(v_hierarchy.COUNT) := HierarchyRecord(r.RentalID, r.DriverID, r.VehicleID, p_current_level);
            -- ����������� ����� ��� ����������� �����
            GetHierarchy(r.DriverID, p_current_level + 1);
        END LOOP;
    END;

BEGIN
    -- ������������� ���������
    v_hierarchy := HierarchyTable();

    -- ������ ����������� ���������
    GetHierarchy(p_node_value, v_level);

    -- ����� �����������
    FOR i IN 1 .. v_hierarchy.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Level: ' || v_hierarchy(i).Level || 
                             ' - RentalID: ' || v_hierarchy(i).RentalID || 
                             ', DriverID: ' || v_hierarchy(i).DriverID || 
                             ', VehicleID: ' || v_hierarchy(i).VehicleID);
    END LOOP;
END;
/





EXEC DisplayHierarchy(2);

--��������� ��� ���������� ������������ ����


CREATE OR REPLACE PROCEDURE AddSubordinateNode (
    p_ParentVehicleID IN INT,
    p_LicensePlate IN VARCHAR2,
    p_Model IN VARCHAR2,
    p_Capacity IN NUMBER
) IS
BEGIN
    INSERT INTO Vehicles (VehicleID, LicensePlate, Model, Capacity, ParentVehicleID)
    VALUES (seq_VehicleID.NEXTVAL, p_LicensePlate, p_Model, p_Capacity, p_ParentVehicleID);
END;


-----------------------


CREATE OR REPLACE PROCEDURE AddSubNode (
    p_parent_vehicle_id INT,
    p_driver_id INT,
    p_rental_id INT,
    p_start_date DATE,
    p_end_date DATE
) AS
BEGIN
    -- ������� ������ ������������ ���� � ������� VehicleRentals
    INSERT INTO VehicleRentals (RentalID, DriverID, VehicleID, StartDate, EndDate)
    VALUES (p_rental_id, p_driver_id, p_parent_vehicle_id, p_start_date, p_end_date);

    DBMS_OUTPUT.PUT_LINE('����������� ���� ��������: RentalID = ' || p_rental_id || 
                         ', DriverID = ' || p_driver_id || 
                         ', VehicleID = ' || p_parent_vehicle_id);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('������: RentalID ��� ����������.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('������: ' || SQLERRM);
END;
/



EXEC AddSubNode(1, 2, 3, TO_DATE('2025-02-01', 'YYYY-MM-DD'), TO_DATE('2025-02-10', 'YYYY-MM-DD'));

--��������� ��� ����������� ����������� �����


CREATE OR REPLACE PROCEDURE MoveSubTree (
    p_source_vehicle_id INT,
    p_target_vehicle_id INT
) AS
    PROCEDURE MoveNodes(p_current_vehicle_id INT) IS
    BEGIN
        FOR r IN (
            SELECT RentalID, DriverID
            FROM VehicleRentals
            WHERE VehicleID = p_current_vehicle_id
        ) LOOP
            -- ����������� �����
            UPDATE VehicleRentals
            SET VehicleID = p_target_vehicle_id
            WHERE RentalID = r.RentalID;

            -- ����� ���������� � ������������ �����
            DBMS_OUTPUT.PUT_LINE('���������: RentalID = ' || r.RentalID || 
                                 ', DriverID = ' || r.DriverID || 
                                 ' � VehicleID = ' || p_target_vehicle_id);

            -- ����������� ����� ��� ����������� �����
            MoveNodes(r.DriverID);
        END LOOP;
    END;

BEGIN
    -- ����������� ��������� ����
    UPDATE VehicleRentals
    SET VehicleID = p_target_vehicle_id
    WHERE VehicleID = p_source_vehicle_id;

    -- ����� ���������� � ������������ �������� ����
    DBMS_OUTPUT.PUT_LINE('��������� �������� ����: VehicleID = ' || p_source_vehicle_id || 
                         ' � VehicleID = ' || p_target_vehicle_id);

    -- ����������� ���� ����������� �����
    MoveNodes(p_source_vehicle_id);

    DBMS_OUTPUT.PUT_LINE('����������� ����� ������� ����������.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('������: ' || SQLERRM);
END;
/

EXEC MoveSubTree(1, 2);

-----

-- 5. ������� ��� �������� ������������� ������ � ������� ���� ������

ALTER TABLE Vehicles
ADD ParentVehicleID INT;

-- ���������� ������� ��� ����������� ��������
-- �����������, ��� 0 ��������, ��� � ���� ��� ��������
UPDATE Vehicles
SET ParentVehicleID = 0;

--2. ����� ��������� ��� ����������� ���� ����������� �����
BEGIN
    GetSubordinateNodes(p_NodeID => 1);
END;
/



--3. ����� ��������� ��� ���������� ������������ ����


BEGIN
    AddSubordinateNode(
        p_ParentVehicleID => 23,         -- ID ������������� ����
        p_LicensePlate => 'X2YZ789',     -- �������� ����
        p_Model => 'Car M2odel B',        -- ������
        p_Capacity => 25                  -- �����������
    );
END;
/


--4. ����� ��������� ��� ����������� ����������� �����

BEGIN
    MoveSubtree(
        p_SourceVehicleID => 2,          -- ID ����, ������� ����� �����������
        p_TargetVehicleID => 3           -- ID ����, � ������� ����� �����������
    );
END;
/