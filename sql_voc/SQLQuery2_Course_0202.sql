---------- SQL 2021-02-02--------


SELECT * FROM Employee

-- markera ett ord, shift +ctrl+U = UPPER
-- markera ett ord, shift +ctrl+L = LOWER

SELECT getdate()
-- F5 or Ctrl+E to execute 

SELECT [Location], DeptName, DeptID FROM Department
-- [] for sensitive keyword as column

SELECT [Location], DeptName, DeptName,DeptName,DeptName,DeptID FROM Department
-- can show same columns for several times

SELECT [DeptName], * FROM Department
-- it shows all the columns that star from deptname.

SELECT 
	artikel,
	utpris AS 'pris exkl moms', 
	utpris*1.25 AS 'pris inkl moms'
FROM pris
-- give column a new name

SELECT 
	artikel,
	exclusive_moms=utpris,
	utpris*1.25 inkl_moms
FROM pris
-- different ways to name a column

SELECT TOP 5 * FROM Employee

SELECT 
	/*Firstname,
	Lastname,*/
	Firstname+' '+ Lastname 'FULL NAME'
FROM Employee

SELECT 
	Firstname Förnamn,
	lastname Efternamn 
FROM Employee
-- it is right, 'as' can be omitted in syntax.


SELECT 
	lower(Firstname+'.'+ Lastname+'@nackademin.se') -- lowercase 
FROM Employee
-- combine two columns into another new one

SELECT NAME FROM sysdatabases
-- get names of all the databases existed

SELECT 'backup databse'+ NAME 
FROM sysdatabases



----- WHERE-----
-- case insensitive
SELECT 
	Firstname,
	Lastname,
	Job
FROM Employee
WHERE Job <> 'kontorist' --job is not kontorist. '!=' or '<>'

SELECT * FROM Employee
WHERE Commission IS NOT NULL   -- it is wrong to write '= null' because of empty values. Instead, we use 'IS NULL' or 'IS NOT NULL'.

SELECT *, Salary+ ISNULL(Commission,10000) FROM Employee 
-- if one value is NULL, the result will be null if we count them directly.
-- Instead we can use ISNULL to convert null to '0' or other values, ex. 10000. Then the plus formula will work out.


-------LIKE------
-- 'a%'. Finds any values that start with "a"
-- '%a'. Finds any values that end with "a"
-- '%or%'. Finds any values that have "or" in any position

SELECT * 
FROM Employee
WHERE Firstname LIKE 'a%' 
OR Lastname LIKE 'c%'
AND Salary >20000

SELECT * 
FROM Employee
WHERE (Firstname LIKE 'a%' 
OR Lastname LIKE 'c%')
AND Salary >20000

--and, or 


-----UNION------
SELECT 
	*
	FROM Fotboll
	UNION ALL
SELECT 
	* 
	FROM Ishockey

--- union MUST HAVE the same number of columns and same data type.
--- union will make duplicate or same rows into one. We can use union all in case we
--- don't want the result cover duplicate rows.


------INTERSECT------

SELECT 
	Namn
	FROM Fotboll
	INTERSECT
SELECT 
	Namn
	FROM Ishockey

--- ex. Larsson+Nilsson+ Pettersson finns i båda. 'INTERSECT' will query values that exist in both tables.


-------EXCEPT-------
SELECT 
	Namn
	FROM Fotboll
	EXCEPT
SELECT 
	Namn
	FROM Ishockey
--- Show all the values except the duplicate values.




---------IN/NOT IN-----------
SELECT Lastname, job FROM Employee
WHERE Job='vd'
OR job='chef'
OR Job='säljare'

-- the easier way is shown as below.Use 'IN' or 'NOT IN'to query the values.

SELECT 
	Lastname, 
	job 
FROM Employee
WHERE Job NOT IN ('vd','chef','säljare')


SELECT 
	Lastname, 
	job 
FROM Employee
WHERE Job IN ('vd','chef','säljare')



--------Between AND----------
SELECT 
	*
FROM Employee
WHERE HireDate BETWEEN '1994-01-01' AND '2000-01-01'

-- An alternative way
SELECT 
	*
FROM Employee
WHERE HireDate >= '1994-01-01' 
AND HireDate <='2000-01-01'


SELECT
	* 
FROM PRIS
WHERE utpris 
BETWEEN 10 AND 15


------ DISTINCT-------

SELECT
DISTINCT city
FROM Customers
