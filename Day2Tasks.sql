SELECT * FROM Emp
---1
SELECT DISTINCT e1.EName AS MANAGERS FROM Emp e1 Join Emp e2 ON e1.EmpNo = e2.Mgr_ID

---2
SELECT EName,Sal FROM Emp WHERE Sal > 1000

---3
SELECT EName,Sal FROM Emp WHERE EName<>'James'

---4
SELECT * FROM Emp WHERE EName LIKE 'S%'

---5
SELECT EName FROM Emp WHERE EName LIKE '%A%'

---6
SELECT EName FROM Emp WHERE EName LIKE '__L%'

---7
SELECT ROUND((Sal/31),2) AS DAILY_SAL FROM Emp WHERE EName='JONES'

---8
SELECT SUM(Sal) AS TOTAL_MONTHLY_SALARY FROM Emp

---9
SELECT ROUND(AVG(Sal*12),2) AS AVERAGE_ANNUAL_SAL From Emp

---10
SELECT EName,Job,Sal,DID FROM Emp WHERE Job<>'SALESMAN' OR DID<>30
--- OR
SELECT EName,Job,Sal,DID FROM Emp WHERE Job NOT IN ('SALESMAN') OR DID NOT IN (30)

---11
SELECT DISTINCT(DID) FROM Emp

---12
SELECT EName AS Employee,Sal AS Monthly_Salary FROM Emp WHERE Sal > 1500 AND DID IN (10,30)

---13
SELECT EName,Job,Sal FROM Emp WHERE Job IN ('MANAGER','ANALYST') AND Sal NOT IN(1000,3000,5000)

---14
SELECT EName,Sal,Comm FROM Emp WHERE Comm > ANY (SELECT Sal = Sal + ((Sal*10)/100) FROM Emp)

---15
SELECT EName FROM Emp WHERE EName LIKE '%L%L%' AND DID=30 OR Mgr_ID=7782

---16
SELECT EName,COUNT(EName) AS TOTAL_EMP FROM Emp WHERE DATEDIFF(YEAR,Hiredate,GETDATE()) > 10 OR DATEDIFF(YEAR,Hiredate,GETDATE()) < 20 GROUP BY EName

---17
SELECT d.DName,e.EName FROM Dept d,Emp e WHERE d.DeptNo = e.DID ORDER BY EName DESC

---18
SELECT DATEDIFF(YEAR,HireDate,GETDATE()) AS EXPERIENCE FROM Emp WHERE EName='MILLER'