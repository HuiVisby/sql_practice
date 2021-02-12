----------EXERCISE 2021-02-02----------
--1
USE T618

SELECT * FROM Employee

--2

SELECT * 
FROM Employee
WHERE HireDate='2002-12-03'
--An alternative
SELECT*
-- FROM SERVER.databasen.schema.tabell
FROM [T618].[dbo].[Employee]

--3
SELECT * 
FROM Employee
WHERE HireDate>='2000-01-01'



--4
SELECT
	Lastname,
	Job,
	Salary,
	Commission
FROM Employee
WHERE Salary>20000

--5

SELECT 
Firstname,
Lastname,
Job,
Salary+ ISNULL(Commission,0) AS Final_salary

FROM 
Employee
WHERE 
Job='Säljare'

-- 6
SELECT

	Lastname AS Efternamn,
	Salary AS Lön,
	Salary*1.10 AS Nylön

FROM Employee
WHERE Salary<=10000

--7 
SELECT

Lastname AS Efternamn,
Salary+ ISNULL(Commission,0) AS Inkomst,
Salary+ ISNULL(Commission,0)*0.30 AS Skatt

FROM Employee

--8 

SELECT 
Lastname AS Efternamn,
Salary AS Inkomst,
Commission AS Bonus
FROM Employee
WHERE Commission IS NULL

--9

SELECT 
Lastname,
Job,
Salary
FROM Employee

WHERE 
Job='Chef'
AND
Lastname='Jones'

-- 10
SELECT 
Lastname,
Job,
Salary
FROM Employee

WHERE 
Job='Chef'
AND
Lastname !='Jones'

--11
SELECT
	*
FROM 
	Employee
WHERE 
	Lastname LIKE 'J%'
	OR 
	Lastname LIKE '%AR%'

--12
SELECT
*,
Lower(Firstname+','+Lastname+'@nackademin.se') AS Email
FROM Employee


--13
SELECT 
Lastname,
EmpID
FROM Employee
WHERE EmpID BETWEEN 7600 AND 7800

--14
SELECT
*
FROM Employee
WHERE Salary IN(11000,28000,30000)

--15
SELECT
*
FROM Fotboll
UNION
SELECT
* 
FROM Ishockey

--16
SELECT
*
FROM Fotboll
UNION ALL
SELECT
* 
FROM Ishockey

--17
SELECT 
DISTINCT [Location]
FROM Department

--18

SELECT
Namn
FROM Fotboll
INTERSECT
SELECT
Namn
FROM Ishockey

--19
SELECT
Namn
FROM Fotboll
EXCEPT
SELECT
Namn
FROM Ishockey


--20
SELECT
Namn
FROM Ishockey
EXCEPT
SELECT
Namn
FROM Fotboll

--21
SELECT 
DeptID,
COUNT(DeptID) AS Number_of_Employees
FROM Employee
GROUP BY (DeptID)
-- HAVING COUNT(DeptID) > 1

--- an alternative
SELECT 
DeptID
FROM  Department
INTERSECT
SELECT 
DeptID
FROM  Employee

--22
SELECT 
DeptID
FROM  Department
EXCEPT
SELECT 
DeptID
FROM  Employee

