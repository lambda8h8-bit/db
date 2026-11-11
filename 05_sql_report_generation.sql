-- 1. Set formatting environment
SET PAGESIZE 50
SET LINESIZE 100
SET FEEDBACK OFF

-- 2. Add Report Titles
TTITLE '=============================================' SKIP 1 -
       '          COMPANY EMPLOYEE SALARY REPORT     ' SKIP 1 -
       '=============================================' SKIP 2
BTITLE 'End of Report'

-- 3. Format the Columns
COLUMN DNAME FORMAT A15 HEADING 'Department'
COLUMN ENAME FORMAT A15 HEADING 'Employee'
COLUMN JOB FORMAT A10 HEADING 'Job Title'
COLUMN SAL FORMAT 99,999 HEADING 'Salary'

-- 4. Set up Grouping and Subtotals
-- BREAK ON DNAME SKIP 1: Groups by department and leaves a blank line
BREAK ON DNAME SKIP 1 ON REPORT

-- 5. Compute Totals
COMPUTE SUM LABEL 'Dept Total:' OF SAL ON DNAME
COMPUTE SUM LABEL 'GRAND TOTAL:' OF SAL ON REPORT

-- 6. The Main Query
SELECT d.DNAME, e.ENAME, e.JOB, e.SAL
FROM EMP e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.DEPTNO IN (10, 20)
ORDER BY d.DNAME, e.SAL DESC;
