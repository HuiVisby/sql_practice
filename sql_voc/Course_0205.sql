

---- FLOOR-----
SELECT 
A,
FLOOR(A)
FROM NUMMER

-----CEILING-----
SELECT 
B,
CEILING(B)
FROM NUMMER

SELECT 
B,
POWER(B,2)
FROM NUMMER

SELECT 
B,
SQRT(B) 
FROM NUMMER


----LEFT------

SELECT

	Firstname,
	RIGHT(Firstname,3) AS String

FROM 
Employee


------Excercise 4-------

-- 1. Visa efternamn (Lastname) och l�n (Salary) p� alla som arbetar som S�ljare i tabellen anst�llda (Employee). Sortera i bokstavsordning p� efternamnet
SELECT
	Lastname,
	Salary
FROM Employee
WHERE Job='S�ljare'
ORDER BY Lastname

--2. Sortera alla efter grundl�n (Salary) med den h�gst betalde �verst. Har tv� eller fler samma l�n ska bokstavsordning p� efternamn g�lla. Visa hela tabellen Employee.
SELECT
	*
FROM Employee
ORDER BY Salary DESC, Lastname ASC

-- 3. Visa alla anst�llda efter 2000-01-01(Hiredate), med den sist anst�llde �verst.
SELECT
	*
FROM Employee
WHERE 
	HireDate>'2000-01-01'
ORDER BY HireDate DESC

-- 4. R�kna ut hur m�nga kunder det finns p� varje ort. Anv�nd tabellen Customers.

SELECT 
	city,
	COUNT(Cust_ID) AS number_of_customers
FROM Customers
GROUP By city

SELECT 
ISNULL(job,'Total'),
SUM(salary)
FROM Employee
GROUP BY Job
WITH ROLLUP

-- 5. Visa de orter och antalet kunder d�r f�retaget har fler �n 5 kunder. Visa i fallande antal-ordning.

SELECT
	city,
	COUNT(Cust_ID) AS number_of_customers
FROM Customers
GROUP By city
HAVING 
	COUNT(Cust_ID)>5
ORDER BY 2 DESC

-- 6. Visa de orter och antalet kunder d�r s�ljaren Carola Karlsson 

SELECT
	city,
	COUNT(Cust_ID) AS number_of_customers
FROM Customers
	LEFT JOIN Employee
ON 
	Employee.EmpID=Customers.EmpID
WHERE
	Employee.Firstname='Carola'
AND 
	Employee.Lastname='Karlsson'
GROUP By city
HAVING 
	COUNT(Cust_ID)>1
ORDER BY 2 DESC

-- An alternative
SELECT * 
FROM Employee 
WHERE EmpID= (Firstname LIKE'Carola%' AND Lastname='Karlsson')
GROUP BY City,EmpID
Having count(*)>1
Order by COUNT(*) DESC


--7. Visa de orter och antalet kunder p� orten som inte blivit tilldelad en s�ljrepresentant (dvs d�r EmpID �r NULL).
SELECT
	city,
	COUNT(Cust_ID) AS number_of_customers
FROM Customers
WHERE 
	EmpID IS NULL
GROUP By city
ORDER BY 2 DESC

--8. Visa namnen p� de popul�raste blommorna f�ljt av antalet. De mest s�lda blommorna ska vara �verst. Anv�nd tabellen OrderDetails.

SELECT
	Name AS Blomma,
	SUM(Amount) AS Total_amount
FROM OrderDetails
WHERE 
	NAME!='75kr frakt'
GROUP BY Name
ORDER BY 2 DESC

--- an alternative---
SELECT 
	Name AS 'Blomma',
	SUM(amount) AS 'Antal'
FROM OrderDetails
WHERE IsDeliveryItem=0
GROUP BY Name
ORDER BY SUM(Amount) DESC, Name

-- 9. Det kanske inte �r l�nsamt att ha alla typer av blommor p� lager. Visa de buketter som s�lts 3 g�nger eller f�rre.
SELECT
	Name,
	COUNT(DISTINCT Orders_id) AS number_of_orders,
	SUM(Amount) AS total_amount
FROM OrderDetails
WHERE 
	NAME!='75kr frakt'
GROUP BY 
	Name
HAVING
	COUNT(DISTINCT Orders_id)<=3
ORDER BY 2 DESC

-- 10. Visa int�kt per artikel (oavsett om det �r en bukett eller frakt) med den mest inkomstbringande artikeln �verst. Visa tre kolumner: artikelns namn, int�kt och antal s�lda artiklar.
SELECT
	Name AS 'Flower',
	SUM(AMOUNT * PRICE) AS 'Income',
	SUM(AMOUNT * PRICE *(1+CAST(VatValue AS float)/100)) AS 'Income including tax', 
	-- cast the data type of vatvalue to float first and then count 
	SUM (Amount) AS 'Sales'
FROM 
	OrderDetails
GROUP BY NAME
ORDER BY 2 DESC, Name


----------join--------
---cross join
---inner join(vanlig koppling)
---left outer join respektive right outer join
---self join


SELECT * 
FROM Department
INNER JOIN Employee
ON Department.DeptID=Employee.DeptID


SELECT 
	Department.*, 
	Lastname
FROM Employee
RIGHT OUTER JOIN Department
ON Department.DeptID=Employee.DeptID
-- ON Department.DeptID=Employee.DeptID

SELECT *
FROM Employee
RIGHT OUTER JOIN Department
ON Department.DeptID=Employee.DeptID


SELECT E.Firstname, Lastname,DeptName, E.DeptID
FROM Employee E
RIGHT JOIN Department  D
ON D.DeptID=E.DeptID

SELECT 
	Firstname,
	Lastname,
	Deptname,
	D.DeptID
FROM Employee AS e LEFT JOIN Department AS d
ON e.DeptID=d.DeptID



SELECT empl.Firstname AS AnstFN, empl.Lastname AS AnstLN, boss.Firstname, boss.Lastname 
FROM Employee as empl INNER JOIN Employee AS boss
ON empl.ManagerID=boss. EmpID


SELECT boss.Firstname AS BossFN, boss.Lastname AS BossLN, empl.Firstname AS AnstFN, empl.Lastname AS AnstLN
FROM Employee as empl LEFT OUTER JOIN Employee AS boss
ON empl.ManagerID=boss. EmpID

ORDER BY boss.Lastname, empl.Lastname


---------Subquery/Underfr�ga--------
/* 
SELECT  *
FROM  TABLE1

WHERE TABLE.COL1 =(SELECT COL2
                   FROM table2 
				   WHERE col3=somevalue) */

