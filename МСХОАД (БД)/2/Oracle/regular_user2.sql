drop PROCEDURE CreateOrder (
    p_CustomerID IN NUMBER,
    p_VehicleID IN NUMBER,
    p_DriverID IN NUMBER,
    p_Status IN VARCHAR2,
    p_Route IN VARCHAR2,
    p_TotalCost IN NUMBER
) AS
BEGIN
    INSERT INTO Orders (OrderID, CustomerID, VehicleID, DriverID, Status, Route, TotalCost)
    VALUES (Orders_seq.NEXTVAL, p_CustomerID, p_VehicleID, p_DriverID, p_Status, p_Route, p_TotalCost);
END;
/



CREATE OR REPLACE VIEW VehicleInventory AS
SELECT VehicleID, LicensePlate, Model, Year, Capacity
FROM Vehicles;



CREATE OR REPLACE FUNCTION GetMyTrips (
    p_CustomerID IN NUMBER
) RETURN SYS_REFCURSOR AS
    trips_cursor SYS_REFCURSOR;
BEGIN
    OPEN trips_cursor FOR
    SELECT o.OrderID, o.Route, o.Status, o.TotalCost
    FROM Orders o
    WHERE o.CustomerID = p_CustomerID;

    RETURN trips_cursor;
END;
/


//////////////////////////админ




CREATE OR REPLACE VIEW AdminTrips AS
SELECT o.OrderID, o.Route, o.Status, o.TotalCost
FROM Orders o;




CREATE OR REPLACE VIEW Routes AS
SELECT DISTINCT Route
FROM Orders;





CREATE OR REPLACE PROCEDURE ManageFleet (
    p_VehicleID IN NUMBER,
    p_LicensePlate IN VARCHAR2,
    p_Model IN VARCHAR2,
    p_Year IN NUMBER,
    p_Capacity IN NUMBER
) AS
BEGIN
    UPDATE Vehicles
    SET LicensePlate = p_LicensePlate,
        Model = p_Model,
        Year = p_Year,
        Capacity = p_Capacity
    WHERE VehicleID = p_VehicleID;
END;
/




CREATE OR REPLACE PROCEDURE IssueBonus (
    p_UserID IN NUMBER,
    p_BonusPoints IN NUMBER
) AS
BEGIN
    UPDATE Users
    SET BonusPoints = BonusPoints + p_BonusPoints
    WHERE UserID = p_UserID;
END;
/




/////////////////////////////////////водитель




CREATE OR REPLACE VIEW DriverVehicleInventory AS
SELECT VehicleID, LicensePlate, Model, Year, Capacity
FROM Vehicles;




CREATE OR REPLACE VIEW DriverRoutes AS
SELECT DISTINCT Route
FROM Orders;


CREATE OR REPLACE VIEW AvailableOrders AS
SELECT o.OrderID, o.Route, o.TotalCost
FROM Orders o
WHERE o.Status = 'Available';




CREATE OR REPLACE PROCEDURE AcceptOrder (
    p_OrderID IN NUMBER,
    p_DriverID IN NUMBER
) AS
BEGIN
    UPDATE Orders
    SET Status = 'Accepted', DriverID = p_DriverID
    WHERE OrderID = p_OrderID;
END;
/




CREATE OR REPLACE PROCEDURE RentOrCompleteRental (
    p_RentalID IN NUMBER,
    p_Action IN VARCHAR2,
    p_DriverID IN NUMBER,
    p_VehicleID IN NUMBER
) AS
BEGIN
    IF p_Action = 'Rent' THEN
        -- Логика аренды
        INSERT INTO VehicleRentals (RentalID, DriverID, VehicleID, StartDate, EndDate)
        VALUES (VehicleRentals_seq.NEXTVAL, p_DriverID, p_VehicleID, SYSDATE, NULL);
    ELSIF p_Action = 'Complete' THEN
        -- Логика завершения аренды
        UPDATE VehicleRentals
        SET EndDate = SYSDATE
        WHERE RentalID = p_RentalID;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Invalid action. Use "Rent" or "Complete".');
    END IF;
END;
/





