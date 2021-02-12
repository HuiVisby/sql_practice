----------del 5: relations/db/table/view----------

-- CASCADE

select * from Employee

update Department set DeptID= 99
where DeptName='EKONOMI'


SELECT * FROM Employee


---create database

create database pear

CREATE DATABASE [Lunch]
 ON  PRIMARY 
( NAME = N'Lunch', FILENAME = N'C:\Windows\Temp\Lunch.mdf' , SIZE = 1000KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Lunch_log', FILENAME = N'C:\Windows\Temp\Lunch_log.ldf' , SIZE = 3000KB , FILEGROWTH = 65536KB )

---create table

SELECT * INTO Employee_bak_20210209 FROM Employee

SELECT  * FROM Employee 
SELECT  * FROM Employee_bak_20210209

SP_HELP Employee_bak_20210209

DROP TABLE Employee
SP_RENAME 'Employee_bak_20210209', 'Employee' --change table name



----------view---------

SELECT * FROM Employee

sp_help employee

CREATE VIEW TEST2 AS 
SELECT FIRSTNAME, LASTNAME  FROM EMPLOYEE


SELECT * FROM TEST2

create view test3 AS
	SELECT firstname, lastname, DeptName,Location 
	FROM Employee E INNER JOIN Department D
	ON E.DeptID = D.DeptID

SELECT * FROM test3

UPDATE test3 SET LASTNAME='Trump' WHERE LASTNAME='Carlsson'
UPDATE test3 SET DeptName='Economics' WHERE DeptName='Ekonomi'

select * from employee
select * from Department

---we can alter view, create view or delete view


--------exercises-------

--1. Skapa en tabell med namnet ANST, som �r en kopia p� tabellen Employee.

SELECT * 
INTO ANST 
FROM Employee

SELECT * FROM ANST

--2. �ndra kolumnen Lastname i tabellen ANST till VARCHAR(50). 
-- Skriv kommandot SP_HELP ANST f�r att se tabellens egenskaper.

SP_HELP ANST

ALTER TABLE ANST
ALTER COLUMN LASTNAME VARCHAR(50)

--3. L�gg till en ny kolumn MANAGER CHAR(1) i tabellen ANST.  

ALTER TABLE ANST
ADD MANAGER CHAR(1)

--4. Uppdatera tabellen ANST och s�tt ett �Y� i MANAGER-kolumnen f�r 
--de som har n�gra anst�llda underst�llda sig.
 SELECT * FROM ANST

 UPDATE ANST
 SET MANAGER ='Y'
 WHERE EmpID IN 
			(
			 SELECT DISTINCT
				ManagerID
			FROM ANST 
			)


--5. Uppdatera tabellen ANST och s�tt ett �N� i kolumnen MANAGER f�r dem som inte har n�gra anst�llda 
--underst�llda sig.

-- OPTION 1

 UPDATE ANST
 SET MANAGER ='N'
 WHERE Manager IS NULL


-- OPTION 2

 UPDATE ANST
 SET MANAGER ='N'
 WHERE EmpID NOT IN 
			(
			 SELECT DISTINCT
			 ManagerID
			 FROM ANST  WHERE managerID  IS NOT NULL
			)
---- Because managerID has null values, it needs to convert null values to '0' or to select out null values.

SELECT * FROM ANST

--6. �ndra kolumnen MANAGER i tabellen ANST till NOT NULL.

ALTER TABLE ANST
ALTER COLUMN MANAGER CHAR(1) NOT NULL

SP_HELP ANST

--7. Skapa en kopia av tabellen Department, namnge den AVD

SELECT * 
INTO AVD
FROM Department

--8. Skapa en prim�rnyckel p� kolumnen DeptID i tabellen AVD

ALTER TABLE AVD
ADD PRIMARY KEY(DeptID)

select * from AVD
sp_help avd


--9.Skapa en referential integrity constraint mellan tabellerna ANST och AVD, 
-- allts� en fr�mmande nyckel p� kolumnen deptno i ANST. Namnge den FK_DEPTNUM

ALTER TABLE ANST
ADD CONSTRAINT FK_DEPTNUM
FOREIGN KEY(DeptID) REFERENCES AVD (DeptID)

ON DELETE CASCADE
ON UPDATE CASCADE

--10. Ta bort avdelning 10 fr�n tabellen AVD. Gick det?

/* begin tran
ALTER TABLE ANST
ADD CONSTRAINT FK_DEPTNO
FOREIGN KEY(DeptID) REFERENCES AVD (DeptID)
ON DELETE CASCADE
ON UPDATE CASCADE
*/

DELETE FROM AVD
WHERE DeptID=10

select * from AVD
select * from ANST
ROLLBACK TRAN

--11. Ta bort constraint FK_DEPTNUM. 

ALTER TABLE ANST
DROP CONSTRAINT FK_DEPTNUM


--12. Pr�va nu att ta bort avdelning 10 fr�n AVD. �r detta bra? Diskutera!

DELETE FROM AVD
WHERE DeptID=10

--13. Ta bort tabellerna AVD och ANST.
DROP TABLE AVD, ANST

--14. Skapa en tabell; Totalinfo. Den ska inneh�lla alla kolumner fr�n Employee och Department. 
--Ta endast med DeptID en g�ng. Vilka f�rdelar respektive nackdelar finns det med denna enda tabell 
--i st�llet f�r tv� tabeller Employee och Department?

CREATE TABLE Totalinfo
(Empid 		SMALLINT 	NOT NULL,
 Firstname 		VARCHAR(25),   	
 Lastname 		VARCHAR(25),   	
 Job 		    VARCHAR(10),
 Managerid 		SMALLINT,        	
 Hiredate 		DATETIME,
 Salary 		INT,      	
 Commission		INT,
 DeptID 		SMALLINT,
 DeptName       VARCHAR(15),
 Location       VARCHAR(15)
)

SELECT EmpID, Firstname, Lastname, Job, ManagerID, Hiredate, Salary, Commission, D.DeptID, D.DeptName, Location INTO Totalinfo 
FROM Employee AS E RIGHT OUTER JOIN Department AS D
ON E.DeptID=D.DeptID

---- Here we should notice DeptId.

select * from employee
select * from Department
select * from totalinfo

--15. Ta bort Totalinfo
DROP TABLE Totalinfo



-----------exercise 2-----------

--1. Skapa en vy baserad p� tabellen Customers och kalla den VY1. 
-- Ta med kolumnerna Cust_ID, Firstname, Lastname, City och s�tt egna namn p� kolumnerna.  

CREATE VIEW VY1 AS
	SELECT  
	Cust_ID AS Cust_No,
	FirstName AS First_Name,
	LastName AS Last_Name,
	City AS City_New
	FROM Customers

SELECT * FROM VY1

--2. G�r en vy av Employee- och Department-tabellerna och kalla den VY2. 
--Den ska inneh�lla alla anst�llda som tj�nar mer �n 10 000. 
--Ta med kolumnerna anst�llningsnr, efternamn, jobb, l�n och avdelningsnamn.

CREATE VIEW VY2 AS
	SELECT 
		EmpID,
		Lastname,
		Job,
		Salary,
		DeptName
	FROM Employee INNER JOIN Department 
	ON Employee.DeptID = Department.DeptID
	WHERE Salary >10000

SELECT * FROM VY2


--3. Skapa VY3 baserad p� VY2 d�r l�nen �r omvandlad till dollar. En dollar �r v�rd 7.50 skr.

CREATE VIEW VY3 AS 

     SELECT
		EmpID,
		Lastname,
		Job,
		CAST(ROUND(Salary/7.5, 2)) AS US_Salary,
		-- FLOOR(Salary/7.5) AS US_Salary
		DeptName
      FROM VY2


select floor(US_Salary) from VY3

--4. Ta bort vyerna VY1, VY2 och VY3.

DROP VIEW VY1, VY2, VY3

--5. Skapa en vy VY5 av Employee-tabellen d�r man sl�r ihop L�n (salary) och Bonus (commission) till en kolumn. 
--Ta med efternamn, jobb och den nya l�nekolumnen.

CREATE VIEW VY5 AS
     SELECT
	 Lastname,
	 Job,
	 Salary+ISNULL(Commission,0) AS Total_Salary
	 FROM Employee

select * from VY5

--6. Se till att de som inte har n�gon bonus �nd� f�r med sin l�n i den nya kolumnen.

--7. Samma som ovan men l�gg till en kolumn som visar varje anst�llds chef. 
-- De som inte har n�gon chef f�r texten �The Boss� i st�llet.

CREATE VIEW VY6 AS
	SELECT 
		E1.EmpID,
		E1.Lastname,
		E1.Job,
		E1.Salary + ISNULL(E1.Commission,0) AS Salary,
		CASE 
			WHEN E2.Lastname IS NULL  THEN 'The boss' 
			ELSE E2.Lastname 
			End 
			AS Chef
	FROM Employee AS E1 LEFT JOIN Employee AS E2
	ON E1.ManagerID=E2.EmpID

	SELECT * FROM VY6
--8. Skapa en vy som visar avdelning, plats, antal anst�llda, medell�nen och maxl�nen f�r varje avdelning. 

CREATE VIEW VY7 AS
		SELECT
		  DeptName,
		  Location,
		  COUNT(EmpID) AS Number_of_employee,
		  AVG(Salary+ISNULL(Commission, 0)) AS Average_salary,
		  MAX(Salary+ISNULL(Commission, 0)) AS Max_salary
		FROM Employee AS E INNER JOIN Department AS D
		ON E.DeptID= D.DeptID
		GROUP BY DeptName, Location

select* from VY7


--9. Skapa en vy som talar om vad varje anst�lld ska betala i skatt varje m�nad. 
-- Antag att man betalar 30% i skatt. Ta med kolumnerna Namn(lastname) och skatt. 
-- De som har bonus (comm) ska betala 50% i skatt p� sin bonus men bara 30% p� l�nen.

CREATE VIEW VY8 AS

	SELECT 
		Lastname,
		(0.30*Salary)+(0.50*ISNULL(Commission,0)) AS Tax
	FROM Employee

select* from VY8

--10. Ta bort alla vyer
DROP VIEW VY5, VY6, VY7, VY8


--11. Skapa en chefs-vy, enbart best�ende av chefer, deras anst�llningsnummer, 
--l�n, jobbtitel, f�r- och efternamn samt orten d�r de arbetar.

CREATE VIEW VY9 AS
	 SELECT 
		Firstname,
		Lastname,
		Salary,
		job,
		[Location]
		FROM Employee INNER JOIN Department
		ON Employee.deptid = Department.DeptID
		WHERE empid in
		   (
			SELECT Distinct
			   MANAGERID
			FROM Employee
			)

SELECT * FROM VY9