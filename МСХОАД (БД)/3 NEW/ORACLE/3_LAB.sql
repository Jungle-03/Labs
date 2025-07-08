--5. Решение для хранения иерархических данных в таблице базы данных

ALTER TABLE Vehicles
ADD ParentVehicleID INT;

-- Обновление таблицы для определения иерархии
-- Предположим, что 0 означает, что у узла нет родителя
UPDATE Vehicles
SET ParentVehicleID = 0;

--6. Процедуры для работы с иерархией в Oracle

--Процедура для отображения всех подчиненных узлов с указанием уровня иерархии

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
    v_processed_ids SYS.ODCINumberList := SYS.ODCINumberList(); -- для отслеживания обработанных DriverID

    PROCEDURE GetHierarchy(p_vehicle_id INT, p_current_level INT) IS
    BEGIN
        -- Проверка, был ли узел уже обработан
        IF p_vehicle_id IS NULL OR v_processed_ids.EXISTS(p_vehicle_id) THEN
            RETURN;
        END IF;

        -- Добавляем текущий узел в список обработанных
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
            -- Рекурсивный вызов для подчиненных узлов
            GetHierarchy(r.DriverID, p_current_level + 1);
        END LOOP;
    END;

BEGIN
    -- Инициализация коллекции
    v_hierarchy := HierarchyTable();

    -- Запуск рекурсивной процедуры
    GetHierarchy(p_node_value, v_level);

    -- Вывод результатов
    FOR i IN 1 .. v_hierarchy.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Level: ' || v_hierarchy(i).Level || 
                             ' - RentalID: ' || v_hierarchy(i).RentalID || 
                             ', DriverID: ' || v_hierarchy(i).DriverID || 
                             ', VehicleID: ' || v_hierarchy(i).VehicleID);
    END LOOP;
END;
/





EXEC DisplayHierarchy(2);

--Процедура для добавления подчиненного узла


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
    -- Вставка нового подчиненного узла в таблицу VehicleRentals
    INSERT INTO VehicleRentals (RentalID, DriverID, VehicleID, StartDate, EndDate)
    VALUES (p_rental_id, p_driver_id, p_parent_vehicle_id, p_start_date, p_end_date);

    DBMS_OUTPUT.PUT_LINE('Подчиненный узел добавлен: RentalID = ' || p_rental_id || 
                         ', DriverID = ' || p_driver_id || 
                         ', VehicleID = ' || p_parent_vehicle_id);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: RentalID уже существует.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
END;
/



EXEC AddSubNode(1, 2, 3, TO_DATE('2025-02-01', 'YYYY-MM-DD'), TO_DATE('2025-02-10', 'YYYY-MM-DD'));

--Процедура для перемещения подчиненной ветки


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
            -- Перемещение узлов
            UPDATE VehicleRentals
            SET VehicleID = p_target_vehicle_id
            WHERE RentalID = r.RentalID;

            -- Вывод информации о перемещенных узлах
            DBMS_OUTPUT.PUT_LINE('Перемещен: RentalID = ' || r.RentalID || 
                                 ', DriverID = ' || r.DriverID || 
                                 ' в VehicleID = ' || p_target_vehicle_id);

            -- Рекурсивный вызов для подчиненных узлов
            MoveNodes(r.DriverID);
        END LOOP;
    END;

BEGIN
    -- Перемещение корневого узла
    UPDATE VehicleRentals
    SET VehicleID = p_target_vehicle_id
    WHERE VehicleID = p_source_vehicle_id;

    -- Вывод информации о перемещенном корневом узле
    DBMS_OUTPUT.PUT_LINE('Перемещен корневой узел: VehicleID = ' || p_source_vehicle_id || 
                         ' в VehicleID = ' || p_target_vehicle_id);

    -- Перемещение всех подчиненных узлов
    MoveNodes(p_source_vehicle_id);

    DBMS_OUTPUT.PUT_LINE('Подчиненная ветка успешно перемещена.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
END;
/

EXEC MoveSubTree(1, 2);

-----

-- 5. Решение для хранения иерархических данных в таблице базы данных

ALTER TABLE Vehicles
ADD ParentVehicleID INT;

-- Обновление таблицы для определения иерархии
-- Предположим, что 0 означает, что у узла нет родителя
UPDATE Vehicles
SET ParentVehicleID = 0;

--2. Вызов процедуры для отображения всех подчиненных узлов
BEGIN
    GetSubordinateNodes(p_NodeID => 1);
END;
/



--3. Вызов процедуры для добавления подчиненного узла


BEGIN
    AddSubordinateNode(
        p_ParentVehicleID => 23,         -- ID родительского узла
        p_LicensePlate => 'X2YZ789',     -- Номерной знак
        p_Model => 'Car M2odel B',        -- Модель
        p_Capacity => 25                  -- Вместимость
    );
END;
/


--4. Вызов процедуры для перемещения подчиненной ветки

BEGIN
    MoveSubtree(
        p_SourceVehicleID => 2,          -- ID узла, который нужно переместить
        p_TargetVehicleID => 3           -- ID узла, в который нужно переместить
    );
END;
/