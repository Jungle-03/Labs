
--2.	Создать процедуру, которая отобразит все подчиненные узлы с указанием уровня иерархии (параметр – значение узла).

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
    v_hierarchy HierarchyTable := HierarchyTable(); -- Инициализация коллекции

    v_processed_ids SYS.ODCINumberList := SYS.ODCINumberList(); -- Для отслеживания обработанных RentalID
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
        -- Проверка, был ли узел уже обработан
        IF IsProcessed(p_rental_id) THEN
            RETURN;
        END IF;

        -- Добавляем в список обработанных
        v_processed_ids.EXTEND;
        v_processed_ids(v_processed_ids.COUNT) := p_rental_id;

        -- Получаем ID транспортного средства
        BEGIN
            SELECT VehicleID INTO v_vehicle_id 
            FROM VehicleRentals 
            WHERE RentalID = p_rental_id
            FETCH FIRST 1 ROWS ONLY; -- Гарантируем, что вернется только одна строка
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN
                RETURN; -- Если нет данных, выход
        END;

        FOR r IN (
            SELECT RentalID, DriverID, VehicleID, StartDate
            FROM VehicleRentals
            WHERE VehicleID = v_vehicle_id 
              AND RentalID <> p_rental_id  -- Исключаем самого себя
            ORDER BY StartDate
        ) LOOP
            -- Проверяем, был ли уже обработан этот RentalID
            IF IsProcessed(r.RentalID) THEN
                CONTINUE;
            END IF;

            v_hierarchy.EXTEND;
            v_hierarchy(v_hierarchy.COUNT) := HierarchyRecord(r.RentalID, r.DriverID, r.VehicleID, p_current_level + 1);

            DBMS_OUTPUT.PUT_LINE('Подчиненный узел: RentalID: ' || r.RentalID || 
                                 ', DriverID: ' || r.DriverID || 
                                 ', VehicleID: ' || r.VehicleID || 
                                 ' (подчинен узлу с RentalID: ' || p_rental_id || ')');

            -- Рекурсивный вызов для следующего уровня
            GetHierarchy(r.RentalID, p_current_level + 1);
        END LOOP;
    END;

BEGIN
    -- Запуск рекурсивной процедуры
    DBMS_OUTPUT.PUT_LINE('Корневой узел: RentalID: ' || p_rental_id);
    GetHierarchy(p_rental_id, v_level);
END DisplayHierarchy;




BEGIN
    DisplayHierarchy(1); -- Замените 1 на нужный RentalID для начала
END;


/*Подчиненный узел: RentalID: 2 появляется, потому что аренда с
RentalID: 2 использует тот же транспорт, что и аренда с RentalID: 1.*/

select * from vehiclerentals






--3.	Создать процедуру, которая добавит подчиненный узел (параметр – значение узла).



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

    -- Подтверждаем транзакцию
    COMMIT;

    -- Проверяем, что данные добавлены
    DBMS_OUTPUT.PUT_LINE('Подчиненный узел добавлен: RentalID = ' || p_rental_id || 
                         ', DriverID = ' || p_driver_id || 
                         ', VehicleID = ' || p_parent_vehicle_id);

    -- Печатаем все данные из таблицы VehicleRentals для проверки
    FOR r IN (SELECT * FROM VehicleRentals WHERE RentalID = p_rental_id) LOOP
        DBMS_OUTPUT.PUT_LINE('Текущий RentalID: ' || r.RentalID || ', VehicleID: ' || r.VehicleID);
    END LOOP;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: RentalID уже существует.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
END;




SELECT * FROM VehicleRentals
------------------------------------------------------

--4.	Создать процедуру, которая переместит всю подчиненную ветку (первый параметр – значение верхнего перемещаемого узла, 
--второй параметр – значение узла, в который происходит перемещение).


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
            -- Перемещение узлов
            UPDATE VehicleRentals
            SET VehicleID = p_target_vehicle_id
            WHERE RentalID = r.RentalID;

            -- Вывод информации о перемещенных узлах
            DBMS_OUTPUT.PUT_LINE('Перемещен: RentalID = ' || r.RentalID || 
                                 ', DriverID = ' || r.DriverID || 
                                 ' в VehicleID = ' || p_target_vehicle_id);

            -- Рекурсивный вызов для подчиненных узлов
            MoveNodes(r.VehicleID); -- Здесь используем r.VehicleID для рекурсивного вызова
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


EXEC MoveSubTree(2, 1);
EXEC MoveSubTree(1, 2);



BEGIN
    DisplayHierarchy(2); -- Замените 1 на нужный RentalID для начала
END;


EXEC AddSubNode(2, 3, 22, TO_DATE('2025-02-01', 'YYYY-MM-DD'), TO_DATE('2025-02-10', 'YYYY-MM-DD'));
COMMIT;



-- Вызов процедуры для перемещения подчиненной ветки
EXEC MoveSubTree(2, 1);



-- После вызова процедуры
SELECT RentalID, DriverID, VehicleID, StartDate, EndDate
FROM VehicleRentals
ORDER BY VehicleID, StartDate;

