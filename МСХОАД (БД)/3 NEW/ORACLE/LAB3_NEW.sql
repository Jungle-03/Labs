
--2.	������� ���������, ������� ��������� ��� ����������� ���� � ��������� ������ �������� (�������� � �������� ����).

CREATE OR REPLACE PROCEDURE DisplayHierarchy (
    p_rental_id INT
) AS
    TYPE HierarchyRecord IS RECORD (
        RentalID INT,
        DriverID INT,
        VehicleID INT,
        Level INT
    );

    TYPE HierarchyTable IS TABLE OF HierarchyRecord;
    v_hierarchy HierarchyTable := HierarchyTable(); -- ������������� ���������

    v_processed_ids SYS.ODCINumberList := SYS.ODCINumberList(); -- ��� ������������ ������������ RentalID
    v_level INT := 0;

    FUNCTION IsProcessed(p_id INT) RETURN BOOLEAN IS
    BEGIN
        FOR i IN 1 .. v_processed_ids.COUNT LOOP
            IF v_processed_ids(i) = p_id THEN
                RETURN TRUE;
            END IF;
        END LOOP;
        RETURN FALSE;
    END IsProcessed;

    PROCEDURE GetHierarchy(p_rental_id INT, p_current_level INT) IS
        v_vehicle_id INT;
    BEGIN
        -- ��������, ��� �� ���� ��� ���������
        IF IsProcessed(p_rental_id) THEN
            RETURN;
        END IF;

        -- ��������� � ������ ������������
        v_processed_ids.EXTEND;
        v_processed_ids(v_processed_ids.COUNT) := p_rental_id;

        -- �������� ID ������������� ��������
        BEGIN
            SELECT VehicleID INTO v_vehicle_id 
            FROM VehicleRentals 
            WHERE RentalID = p_rental_id
            FETCH FIRST 1 ROWS ONLY; -- �����������, ��� �������� ������ ���� ������
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN
                RETURN; -- ���� ��� ������, �����
        END;

        FOR r IN (
            SELECT RentalID, DriverID, VehicleID, StartDate
            FROM VehicleRentals
            WHERE VehicleID = v_vehicle_id 
              AND RentalID <> p_rental_id  -- ��������� ������ ����
            ORDER BY StartDate
        ) LOOP
            -- ���������, ��� �� ��� ��������� ���� RentalID
            IF IsProcessed(r.RentalID) THEN
                CONTINUE;
            END IF;

            v_hierarchy.EXTEND;
            v_hierarchy(v_hierarchy.COUNT) := HierarchyRecord(r.RentalID, r.DriverID, r.VehicleID, p_current_level + 1);

            DBMS_OUTPUT.PUT_LINE('����������� ����: RentalID: ' || r.RentalID || 
                                 ', DriverID: ' || r.DriverID || 
                                 ', VehicleID: ' || r.VehicleID || 
                                 ' (�������� ���� � RentalID: ' || p_rental_id || ')');

            -- ����������� ����� ��� ���������� ������
            GetHierarchy(r.RentalID, p_current_level + 1);
        END LOOP;
    END;

BEGIN
    -- ������ ����������� ���������
    DBMS_OUTPUT.PUT_LINE('�������� ����: RentalID: ' || p_rental_id);
    GetHierarchy(p_rental_id, v_level);
END DisplayHierarchy;




BEGIN
    DisplayHierarchy(1); -- �������� 1 �� ������ RentalID ��� ������
END;


/*����������� ����: RentalID: 2 ����������, ������ ��� ������ �
RentalID: 2 ���������� ��� �� ���������, ��� � ������ � RentalID: 1.*/

select * from vehiclerentals






--3.	������� ���������, ������� ������� ����������� ���� (�������� � �������� ����).



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

    -- ������������ ����������
    COMMIT;

    -- ���������, ��� ������ ���������
    DBMS_OUTPUT.PUT_LINE('����������� ���� ��������: RentalID = ' || p_rental_id || 
                         ', DriverID = ' || p_driver_id || 
                         ', VehicleID = ' || p_parent_vehicle_id);

    -- �������� ��� ������ �� ������� VehicleRentals ��� ��������
    FOR r IN (SELECT * FROM VehicleRentals WHERE RentalID = p_rental_id) LOOP
        DBMS_OUTPUT.PUT_LINE('������� RentalID: ' || r.RentalID || ', VehicleID: ' || r.VehicleID);
    END LOOP;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('������: RentalID ��� ����������.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('������: ' || SQLERRM);
END;




SELECT * FROM VehicleRentals
------------------------------------------------------

--4.	������� ���������, ������� ���������� ��� ����������� ����� (������ �������� � �������� �������� ������������� ����, 
--������ �������� � �������� ����, � ������� ���������� �����������).


CREATE OR REPLACE PROCEDURE MoveSubTree (
    p_source_vehicle_id INT,
    p_target_vehicle_id INT
) AS
    PROCEDURE MoveNodes(p_current_vehicle_id INT) IS
    BEGIN
        FOR r IN (
            SELECT RentalID, DriverID, VehicleID
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
            MoveNodes(r.VehicleID); -- ����� ���������� r.VehicleID ��� ������������ ������
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


EXEC MoveSubTree(2, 1);
EXEC MoveSubTree(1, 2);



BEGIN
    DisplayHierarchy(2); -- �������� 1 �� ������ RentalID ��� ������
END;


EXEC AddSubNode(2, 3, 22, TO_DATE('2025-02-01', 'YYYY-MM-DD'), TO_DATE('2025-02-10', 'YYYY-MM-DD'));
COMMIT;



-- ����� ��������� ��� ����������� ����������� �����
EXEC MoveSubTree(2, 1);



-- ����� ������ ���������
SELECT RentalID, DriverID, VehicleID, StartDate, EndDate
FROM VehicleRentals
ORDER BY VehicleID, StartDate;

