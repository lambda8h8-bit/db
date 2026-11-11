SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE validate_and_update_salary (
    p_empno IN NUMBER,
    p_new_sal IN NUMBER
) AS
    v_current_sal NUMBER;
    v_min_sal NUMBER := 1000;
    v_max_increase_pct NUMBER := 0.50; -- 50% maximum increase
BEGIN
    -- Get the current salary
    SELECT SAL INTO v_current_sal FROM EMP WHERE EMPNO = p_empno;

    -- VALIDATION RULE 1: Minimum wage
    IF p_new_sal < v_min_sal THEN
        RAISE_APPLICATION_ERROR(-20001, 'Validation Failed: New salary cannot be below ' || v_min_sal);

    -- VALIDATION RULE 2: Maximum increase check
    ELSIF p_new_sal > (v_current_sal + (v_current_sal * v_max_increase_pct)) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Validation Failed: Increase exceeds ' || (v_max_increase_pct*100) || '% limit.');

    -- IF ALL VALIDATIONS PASS, EXECUTE THE UPDATE
    ELSE
        UPDATE EMP SET SAL = p_new_sal WHERE EMPNO = p_empno;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Employee ' || p_empno || ' salary updated to ' || p_new_sal);
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Employee ID ' || p_empno || ' not found.');
END;
/

-- TEST 1: Invalid (Below Minimum Wage)
PROMPT --- TEST 1: Trying to set salary to 500 ---
BEGIN
    validate_and_update_salary(7782, 500);
END;
/

-- TEST 2: Invalid (Increase too high)
PROMPT --- TEST 2: Trying to set salary to 5000 (100%+ increase) ---
BEGIN
    validate_and_update_salary(7782, 5000);
END;
/

-- TEST 3: Valid (Within limits)
PROMPT --- TEST 3: Trying to set salary to 3000 ---
BEGIN
    validate_and_update_salary(7782, 3000);
END;
/
