PROMPT =========================================
PROMPT 1. SIMPLE QUERY: Dept 10 & Salary > 2000
PROMPT =========================================
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE DEPTNO = 10
  AND SAL > 2000;

PROMPT =========================================
PROMPT 2. COMPLEX QUERY: Depts beating company average
PROMPT =========================================
SELECT d.DNAME AS Department_Name,
       COUNT(e.EMPNO) AS Total_Employees,
       ROUND(AVG(e.SAL), 2) AS Dept_Avg_Salary
FROM EMP e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO
GROUP BY d.DNAME
HAVING AVG(e.SAL) > (SELECT AVG(SAL) FROM EMP) -- The complex subquery
ORDER BY Dept_Avg_Salary DESC;

SELECT ROUND(AVG(SAL), 2) AS Overall_Company_Average FROM EMP;
