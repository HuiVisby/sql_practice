
--------1-4---------

--1.Ta reda p� var alla anst�llda arbetar med hj�lp av tabellerna Employee och Department. 
--Visa efternamn (Lastname), l�n (Salary), avdnummer (DeptID) och arbetsplats (Location). 
--Sortera p� arbetsplats och namn.

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

--2. Samma som ovan, men visa �ven de avdelningar som inte har n�gra anst�llda.

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

--4. Vad heter avdelningen d�r Smith arbetar?
SELECT
E.Lastname,
E.DeptID,
D.DeptName
FROM Department AS D INNER JOIN Employee AS E
ON E.DeptID= D.DeptID
WHERE Lastname='SMITH'

--5.Lista alla anst�llningsnummer (EmpID), efternamn (Lastname) och chefens anst�llningsnummer (ManagerID) fr�n tabellen Employee. Anv�nd vanlig SELECT!

SELECT 
EmpID,
Lastname,
ManagerID
FROM Employee

--6. Samma som uppgift 5 men ta �ven med namnet f�r chefen (en egenkoppling p� Employee-tabellen).

SELECT 
	E1.EmpID,
	E1.Lastname,
	E1.ManagerID,
	E2.Lastname AS Manager
FROM Employee AS E1, Employee AS E2
WHERE E1.ManagerID=E2.EmpID



--7.Som uppgift 5 men se till att �ven de som inte har n�gon chef kommer med i listan. 

SELECT 
	Empl. EmpID,
	Empl. Lastname AS Employee,
	Mana. Lastname AS Manager
FROM Employee AS Empl LEFT JOIN Employee AS Mana
ON Empl.ManagerID=Mana.EmpID

--8. Som uppgift 6 men l�gg till kolumnerna f�r de anst�lldas  och chefernas l�n. G�r en restriktion s� att endast anst�llda som tj�nar mer �n sin chef kommer med.

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

--9. Ta reda p� anst�llningsnummer och efternamn f�r alla chefer och r�kna ut medell�nen f�r de personer som �r direkt underst�lld respektive chef. Visa i ett svar.

SELECT 
	Mana.EmpID,
	Mana.Lastname AS Manager,
	AVG(Empl.Salary) AS Avg_empl_salary 
FROM Employee AS Empl INNER JOIN Employee AS Mana
ON Empl.ManagerID=Mana.EmpID 
GROUP BY Mana.Lastname, Mana.EmpID

SELECT* FROM Employee

--10. Visa namn och jobb p� som har samma arbete som CLARK.

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


--11. Vilken s�ljare tj�nar mest inklusive provision (Commission)? 

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
									WHERE Job='S�ljare'
									)
-- top 1 function
SELECT TOP 1 EMPID,LASTNAME, (SALARY+ISNULL(Commission,0)) AS MEST_L�N
FROM Employee
WHERE job='S�ljare'


--12. Vilka anst�llda har BLAKE som chef?

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


-- 14.Visa avdelningsnamn och l�nekostnad per avdelning. I l�nekostnaden ing�r provision.

SELECT 
	DeptName,
	SUM(Salary+ISNULL(Commission,0)) AS total_salary
FROM Employee INNER JOIN Department
ON Employee.DeptID=Department.DeptID
GROUP BY DeptName
ORDER BY 2 DESC

--15. Samma som ovan men ta bara med de avdelningar som har fler �n tre anst�llda. 

SELECT 
	DeptName,
	SUM(Salary+ISNULL(Commission,0)) AS total_salary
FROM Employee INNER JOIN Department
ON Employee.DeptID=Department.DeptID
GROUP BY DeptName
HAVING COUNT(EmpID)>3
ORDER BY 2 DESC

--16. Samma som ovan, men visa �ven avdelningsort (Location). 

SELECT 
	DeptName,
	SUM(Salary+ISNULL(Commission,0)) AS total_salary,
	Location
FROM Employee LEFT JOIN Department
ON Employee.DeptID=Department.DeptID
GROUP BY DeptName, Location
HAVING COUNT(EmpID)>3
ORDER BY 1 DESC

-- 17. Visa anst�llningsdatum f�r den l�ngsta respektive den kortaste tid n�gon har varit anst�lld p� varje ort. 

SELECT 
	MAX(HireDate) AS Latest_date,
	MIN(HireDate) AS Earliest_date,
	Location
FROM Employee LEFT JOIN Department
ON Employee.DeptID=Department.DeptID
GROUP BY Location


SELECT * FROM Employee
SELECT * FROM Department