-- 1. Create the Audit Table to store history
CREATE TABLE Salary_Audit (
    Audit_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Emp_No NUMBER,
    Old_Salary NUMBER,
    New_Salary NUMBER,
    Change_Date DATE
);

-- 2. Create the Trigger (Automatically fires on UPDATE)
CREATE OR REPLACE TRIGGER trg_salary_audit
AFTER UPDATE OF SAL ON EMP
FOR EACH ROW
BEGIN
    -- Only log if the salary actually changed
    IF :OLD.SAL <> :NEW.SAL THEN
        INSERT INTO Salary_Audit (Emp_No, Old_Salary, New_Salary, Change_Date)
        VALUES (:OLD.EMPNO, :OLD.SAL, :NEW.SAL, SYSDATE);
    END IF;
END;
/

-- 3. Create the Stored Procedure (To give the raise)
CREATE OR REPLACE PROCEDURE give_raise (
    p_empno IN NUMBER,
    p_amount IN NUMBER
) AS
BEGIN
    UPDATE EMP
    SET SAL = SAL + p_amount
    WHERE EMPNO = p_empno;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Procedure executed: Salary updated for EMPNO ' || p_empno);
END;
/

SET SERVEROUTPUT ON;

-- Execute the procedure
EXEC give_raise(7782, 500);
