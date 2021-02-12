
------------Course 2021-02-03-------------

-----count/sum/avg/min/max------
SELECT
	COUNT(*)
	FROM
	Employee
	WHERE  job='chef'
--- overlook the null values when counting


SELECT
	SUM(salary) AS 'Total Salary'
FROM
	Employee

SELECT
	SUM(salary) AS 'Total Salary',
	SUM(ISNULL(commission,0)) AS 'Total Commission',
	SUM(salary+ISNULL(commission,0)) AS 'Total'
	
FROM
	Employee

SELECT
	SUM(salary)/COUNT(*) AS 'AVG Salary',
	AVG(salary) AS 'Correct AVG Salary'
	
FROM
	Employee

SELECT 
	AVG(commission) 
FROM 
	Employee


SELECT 
	AVG(ISNULL(commission,0)) 
FROM 
	Employee


SELECT 
	MAX(Salary),
	MIN(Salary),
	AVG(Salary)
FROM 
	Employee

------scalar functions------

SELECT DATEADD(DAY, -30 ,GETDATE())

-- date/time depends on server's timezone


--- DATEDIFF syntax
SELECT 
GETDATE(),
'1999-12-31',
DATEDIFF(year, '1999-12-31', getdate())



-- Last_day


--------Excercise-------

--1
SELECT
	COUNT(*) AS number_of_employee
FROM Employee
WHERE Salary>25000

--2

SELECT
	SUM(Salary) AS sum_of_salary
FROM Employee

--3

SELECT 
   MAX(Salary+ISNULL(Commission,0)) AS max_salary,
   Min(Salary+ISNULL(Commission,0)) AS min_salary
FROM Employee

--4

SELECT 
	CAST(SUM(Salary * 1.10) AS INT) AS New_Total_Salary,
	SUM(Salary) AS Old_Total_Salary,
	CAST(SUM(Salary * 0.10) AS INT)AS Diff_Salary
FROM Employee
-- cast into int
--5
SELECT
	HireDate,
	DATEADD(YEAR, 1 ,HireDate) AS New_Hire_date
FROM Employee

--6
SELECT
	DATEADD(day,7,HireDate)
FROM 
	Employee

--7
SELECT 

STDEV(Salary+ISNULL(Commission,0)) AS STDEV_Salary

FROM Employee
WHERE 
	Job='chef'
or  Job='VD'

--8
SELECT
	DATEDIFF(MONTH, HireDate, GETDATE()) 
FROM
	Employee

-------Mathmatic Functions-------

SELECT * FROM NUMMER

SELECT 
	a, 
	abs(a) 
FROM NUMMER


SELECT 
	a, 
	ceiling(a) 
FROM NUMMER
---- minimize integer number that is bigger than a


SELECT 
	a,
    FLOOR (a*10)
FROM NUMMER
--int=4 bytes, 1 byte=8 bitar, 4*8=32 >>>>> 2 uoohöjt i 32

SELECT POWER(9, 3)

SELECT sqrt(81)


INSERt INTO Nummer
VALUES(5.5, 108)

SELECT 
	a,
    SIGN (a)
FROM NUMMER

SELECT 
	Lastname, 
	LEFT(Lastname,3) 
FROM Employee

SELECT 
	Lastname, 
	RIGHT(Lastname,3) 
FROM Employee

-- If data type is char(10), we need to be careful to use right() because the result could be empty values.

SELECT 

	LASTNAME,
	SUBSTRING(LASTNAME, 1, 2)+ LOWER(SUBSTRING(Firstname, 1, 2))

FROM Employee

SELECT 
CHAR(92), 
CHAR(169)+'Nackademin AB',
CHAR(64)
--find the tecken in ASCII

SELECT ASCII('?')

SELECT 
	UPPER(Lastname) 
FROM EMPLOYEE

DECLARE @str char(100)
set @str='   Groda   '
SELECT right(rtrim(@STR), 2)


SELECT 
	Lastname,
	REPLACE(Lastname, 'ss', '')
FROM Employee
-- replace

--9
SELECT
Lastname,
RPAD (Lastname, 15, '_') AS RPAD
FROM 
Employee

-- alternatives
SELECT
	LEFT(lastname+'***************', 15)
FROM 
Employee

--
SELECT 
	Lastname+REPLICATE('*',15-LEN(Lastname))
FROM 
Employee

SELECT 
	LEFT(Lastname+REPLICATE('*',15), 15)
FROM 
Employee

--10
SELECT 
*,
REPLACE(job, 'Kontorist', 'Assistent') AS New_job
FROM
Employee


-- 11

SELECT
	*,
	UPPER(SUBSTRING(Lastname, 1, 1))+LOWER(RIGHT(Lastname,LEN(lastname)-1)) AS New_Lastname
FROM 
Employee

--12
SELECT
	Firstname+' '+ Lastname AS 'Fullname',
	UPPER(LEFT(Firstname, 2)+ LEFT(Lastname, 2)) AS 'Sign'
FROM 
Employee


---CAST

SELECT 
Firstname+'har arbetat '+ CAST(DATEDIFF(YEAR, HireDate, GETDATE()) AS VARCHAR(2))+ ' år i bolaget'
FROM Employee

---convert

--- date and time styles can check through website

----CASE----

SELECT 
Lastname
FROM Employee
ORDER BY Lastname asc

SELECT SUSER_NAME()

SELECT @@VERSION


-- 13. Byt ut sista bokstaven i namnet mot en * på alla som arbetar på avdelning 30.
SELECT
*,
CASE
	WHEN DeptID=30
	THEN REPLACE(Lastname,Right(Lastname,1),'*') 
	ELSE Lastname 
END
AS New_lastname
FROM
Employee

-- 14. Visa hur många år den som arbetat längst respektive kortast tid på företaget har arbetat.
SELECT
MAX(DATEDIFF(YEAR, HireDate,GETDATE())) AS Longest,
MIN(DATEDIFF(YEAR, HireDate,GETDATE())) AS Shortest
FROM 
Employee

-- 15. Visa namnet BLAKE i stället för 7698 för de som har BLAKE som chef, annars visas bara MGR. Visa ENAME, JOB, MGR. Obs! Använd CASE (i Oracle decode).
SELECT
Lastname,
Job,
CASE
   WHEN ManagerID=7698
   THEN REPLACE(ManagerID, 7698 ,'BLAKE')
ELSE 'MGR'
END
AS MGR

FROM Employee

-- 16. Visa hur många dagar längre den som arbetat längst på företaget har arbetat, jämfört med den som arbetat kortast tid.
SELECT

MAX(DATEDIFF(DAY, Hiredate, GETDATE())) AS Longest,
MIN(DATEDIFF(DAY, Hiredate, GETDATE())) AS Shortest,
MAX(DATEDIFF(DAY, Hiredate, GETDATE())) - MIN(DATEDIFF(DAY, Hiredate, GETDATE())) AS Diff

FROM
Employee

--- An advanced way

SELECT Lastname, HireDate FROM Employee
	WHERE Hiredate=
	(SELECT MIN(HireDate) FROM Employee)
	UNION
SELECT Lastname, HireDate FROM Employee
	WHERE Hiredate=
	(SELECT MAX(HireDate) FROM Employee)


