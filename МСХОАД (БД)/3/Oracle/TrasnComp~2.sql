ALTER TABLE Customers ADD ParentID NUMBER;



//Процедура для отображения подчиненных узлов

CREATE OR REPLACE PROCEDURE MoveSubtree (
    p_SourceID IN NUMBER,
    p_TargetID IN NUMBER
) AS
BEGIN
    -- Обновляем родительский идентификатор для всех подчиненных узлов
    UPDATE Customers
    SET ParentID = p_TargetID
    WHERE ParentID = p_SourceID;  -- Обновляем всех потомков
END;






BEGIN
    MoveSubtree(p_SourceID => 1, p_TargetID => 2);
END;





//Процедура для добавления подчиненного узла


-- Создание последовательности
CREATE SEQUENCE Customers_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

-- Создание процедуры
CREATE OR REPLACE PROCEDURE AddSubordinate (
    p_ParentID IN NUMBER,
    p_FirstName IN VARCHAR2,
    p_LastName IN VARCHAR2,
    p_PassportNumber IN VARCHAR2
) AS
BEGIN
    INSERT INTO Customers (CustomerID, FirstName, LastName, PassportNumber, ParentID)
    VALUES (Customers_seq.NEXTVAL, p_FirstName, p_LastName, p_PassportNumber, p_ParentID);
END;


BEGIN
    AddSubordinate(p_ParentID => 1, p_FirstName => 'John', p_LastName => 'Doe', p_PassportNumber => '123456');
END;




//Процедура для перемещения подчиненной ветки


CREATE OR REPLACE PROCEDURE MoveSubtree (
    p_SourceID IN NUMBER,
    p_TargetID IN NUMBER
) AS
BEGIN
    UPDATE Customers
    SET ParentID = p_TargetID
    WHERE ParentID = p_SourceID;
END;



SELECT * FROM Customers;