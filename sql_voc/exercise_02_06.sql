
--------1-4---------

--1.Ta reda på var alla anställda arbetar med hjälp av tabellerna Employee och Department. 
--Visa efternamn (Lastname), lön (Salary), avdnummer (DeptID) och arbetsplats (Location). 
--Sortera på arbetsplats och namn.

SELECT
	E.Lastname,
	E.Salary,
	D.DeptID,
	D.[Location]
FROM Employee AS E INNER JOIN Department AS D
ON 
	E.DeptID=D.DeptID
ORDER BY
	4, 1

--2. Samma som ovan, men visa även de avdelningar som inte har några anställda.

SELECT
	E.Lastname,
	E.Salary,
	D.DeptID,
	D.[Location]
FROM Employee AS E RIGHT JOIN Department AS D
ON 
	E.DeptID=D.DeptID
ORDER BY
	4, 1

--3. Samma som 1, men ta bara med de som arbetar i Stockholm.
SELECT
	E.Lastname,
	E.Salary,
	D.DeptID,
	D.[Location]
FROM Employee AS E LEFT JOIN Department AS D
ON 
	E.DeptID=D.DeptID
WHERE Location='Stockholm'
ORDER BY
	4, 1

--4. Vad heter avdelningen där Smith arbetar?
SELECT
E.Lastname,
E.DeptID,
D.DeptName
FROM Department AS D INNER JOIN Employee AS E
ON E.DeptID= D.DeptID
WHERE Lastname='SMITH'

--5.Lista alla anställningsnummer (EmpID), efternamn (Lastname) och chefens anställningsnummer (ManagerID) från tabellen Employee. Använd vanlig SELECT!

SELECT 
EmpID,
Lastname,
ManagerID
FROM Employee

--6. Samma som uppgift 5 men ta även med namnet för chefen (en egenkoppling på Employee-tabellen).

SELECT 
	E1.EmpID,
	E1.Lastname,
	E1.ManagerID,
	E2.Lastname AS Manager
FROM Employee AS E1, Employee AS E2
WHERE E1.ManagerID=E2.EmpID



--7.Som uppgift 5 men se till att även de som inte har någon chef kommer med i listan. 

SELECT 
	Empl. EmpID,
	Empl. Lastname AS Employee,
	Mana. Lastname AS Manager
FROM Employee AS Empl LEFT JOIN Employee AS Mana
ON Empl.ManagerID=Mana.EmpID

--8. Som uppgift 6 men lägg till kolumnerna för de anställdas  och chefernas lön. Gör en restriktion så att endast anställda som tjänar mer än sin chef kommer med.

SELECT 
	Empl.EmpID,
	Empl.Lastname AS Emlpoyee,
	Empl.Salary AS Employee_salary,
	Empl.ManagerID,
	Mana.Lastname AS Chef,
	Mana.Salary AS Chef_salary
FROM Employee AS Empl
LEFT JOIN Employee AS Mana
ON Empl.ManagerID=Mana.EmpID 
WHERE Empl.Salary>Mana.Salary


SELECT 
	E1.EmpID,
	E1.Lastname AS Emlpoyee,
	E1.Salary AS Employee_salary,
	E1.ManagerID,
	E2.Lastname AS Chef,
	E2.Salary AS Chef_salary
FROM Employee AS E1, Employee AS E2
WHERE E1.ManagerID=E2.EmpID 
AND E1.Salary>E2.Salary

SELECT * FROM Employee

--9. Ta reda på anställningsnummer och efternamn för alla chefer och räkna ut medellönen för de personer som är direkt underställd respektive chef. Visa i ett svar.

SELECT 
	Mana.EmpID,
	Mana.Lastname AS Manager,
	AVG(Empl.Salary) AS Avg_empl_salary 
FROM Employee AS Empl INNER JOIN Employee AS Mana
ON Empl.ManagerID=Mana.EmpID 
GROUP BY Mana.Lastname, Mana.EmpID

SELECT* FROM Employee

--10. Visa namn och jobb på som har samma arbete som CLARK.

SELECT
	Firstname,
	Lastname,
	Job
FROM
	Employee
WHERE Job= 
			(
			SELECT
			Job
			FROM Employee
			WHERE Lastname='Clark'
			)


--11. Vilken säljare tjänar mest inklusive provision (Commission)? 

SELECT 
	Firstname,
	Lastname,
	Salary+ ISNULL(Commission, 0) AS Total_salary
FROM Employee
WHERE 
	 Salary+ ISNULL(Commission, 0) = 
									(
									SELECT
									MAX(Salary+ ISNULL(Commission, 0))
									FROM 
									Employee
									WHERE Job='Säljare'
									)
-- top 1 function
SELECT TOP 1 EMPID,LASTNAME, (SALARY+ISNULL(Commission,0)) AS MEST_LÖN
FROM Employee
WHERE job='Säljare'


--12. Vilka anställda har BLAKE som chef?

SELECT 
*
FROM Employee
WHERE ManagerID=(
					SELECT
					EmpID
					FROM Employee
					WHERE Lastname='Blake')

-- an alternative


SELECT 
	Empl. EmpID,
	Empl. Lastname AS Employee,
	Mana. Lastname AS Manager
FROM Employee AS Empl inner join Employee AS Mana
ON Empl.ManagerID=Mana.EmpID
WHERE Mana.Lastname='Blake'

--13. Vilka arbetar i samma stad som Smith?

SELECT 
	Lastname,
	Firstname,
	[Location]
FROM Employee LEFT JOIN Department
ON Employee.DeptID=Department.DeptID
WHERE  [Location]=(
					SELECT
					[LOCATION]
					FROM Employee LEFT JOIN Department
					ON Employee.DeptID=Department.DeptID
					WHERE Lastname='Smith')

--- an alternative 

SELECT FIRSTNAME, LASTNAME FROM EMPLOYEE
WHERE DEPTID IN
(
SELECT DEPTID FROM DEPARTMENT
WHERE LOCATION=
(
		SELECT LOCATION FROM DEPARTMENT
		WHERE DEPTID=
		(
		SELECT DEPTID FROM Employee
		WHERE Lastname='Smith'
		)
	)
)

-- another option
SELECT E2.* FROM Employee AS E
INNER JOIN Department D
ON E.DeptID =D.DeptID
RIGHT OUTER JOIN Department D2
ON D.Location=D2.Location
INNER JOIN Employee E2
ON D2.DeptID=e2.DeptID
WHERE E.Lastname LIKE 'Smith%'


-- 14.Visa avdelningsnamn och lönekostnad per avdelning. I lönekostnaden ingår provision.

SELECT 
	DeptName,
	SUM(Salary+ISNULL(Commission,0)) AS total_salary
FROM Employee INNER JOIN Department
ON Employee.DeptID=Department.DeptID
GROUP BY DeptName
ORDER BY 2 DESC

--15. Samma som ovan men ta bara med de avdelningar som har fler än tre anställda. 

SELECT 
	DeptName,
	SUM(Salary+ISNULL(Commission,0)) AS total_salary
FROM Employee INNER JOIN Department
ON Employee.DeptID=Department.DeptID
GROUP BY DeptName
HAVING COUNT(EmpID)>3
ORDER BY 2 DESC

--16. Samma som ovan, men visa även avdelningsort (Location). 

SELECT 
	DeptName,
	SUM(Salary+ISNULL(Commission,0)) AS total_salary,
	Location
FROM Employee LEFT JOIN Department
ON Employee.DeptID=Department.DeptID
GROUP BY DeptName, Location
HAVING COUNT(EmpID)>3
ORDER BY 1 DESC

-- 17. Visa anställningsdatum för den längsta respektive den kortaste tid någon har varit anställd på varje ort. 

SELECT 
	MAX(HireDate) AS Latest_date,
	MIN(HireDate) AS Earliest_date,
	Location
FROM Employee LEFT JOIN Department
ON Employee.DeptID=Department.DeptID
GROUP BY Location


SELECT * FROM Employee
SELECT * FROM Department