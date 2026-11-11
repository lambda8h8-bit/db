-- SESSION 1: Lock the row (Do NOT commit yet)
SELECT * FROM EMP WHERE EMPNO = 7782 FOR UPDATE;

-- SESSION 2: Try to update the same row
UPDATE EMP SET SAL = SAL + 500 WHERE EMPNO = 7782;

-- SESSION 1: Release the lock
COMMIT;
