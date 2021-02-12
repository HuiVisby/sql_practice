
-------update/insert/delete/02-08------

SP_LOCK
SP_WHO2



SELECT top 10 * FROM Employee

SELECT * FROM KUNDER
INSERT INTO Employee(EmpID, Firstname, Lastname, Salary, DeptID)
VALUES(1234,'James','Bond',25000,50)

BEGIN TRAN

UPDATE Employee
SET Commission=Commission*1.25
WHERE Job='s�ljare'
AND Salary+ISNULL(Commission,0)*1.25<
									(
									SELECT MAX(Salary) FROM Employee
									)
DELETE FROM KUNDER
WHERE ZIP<50000

SELECT * FROM KUNDER

rollback transaction

------- exercise-----------
Begin transaction
--1. L�gg till en rad med f�ljande v�rden i tabellen COUNTRY

INSERT INTO country(CountryId, Country, Population, Government)
VALUES('BRA', 'Brasilien', 140000000, 'Demokrati')

SELECT * FROM country
select newid()
sp_help customers

--2. L�gg till Rio de Janeiro i CITY-tabellen. Rio de Janeiro har 10 miljoner inv�nare.
SELECT * FROM city

INSERT INTO city(City, CountryId, Population)
VALUES('Rio de Janeiro', 'BRA', '10000000')


-- a good way to count rows
Begin transaction
select row_number() over(order by countryID) AS rownum, * from country
set rowcount 1000

ROllback tran


-- 3. L�gg till Ume� (40000 inv�nare), Norrk�ping (115000 inv�nare) och �rebro (90000 inv�nare) utan att ange kolumnnamn i Insert-satsen.
INSERT INTO city
VALUES
	(
	 'Ume�', 
	 'SWE', 
	 4000
	),
	(
	 'Norrk�ping', 
	 'SWE', 
	  90000
	 ),
	(
	 '�rebro', 
	 'SWE', 
	 115000
	 )

	SELECT * FROM CITY

--  4. Byt ut den svenska beteckningen (COUNTRYID) mot SVE i COUNTRY- och CITY-tabellerna.
UPDATE country
SET CountryId='SVE'
WHERE Country='Sverige'


UPDATE city
SET CountryId='SVE'
WHERE CITY IN 
		(
		SELECT City 
		FROM city 
		WHERE CountryId='SWE'
		)

--5. Det finns ett land och en stad d�r inv�narantalet saknas. Uppdatera dessa kolumner med l�mpliga (eller p�hittade) v�rden.

-- sarajevo 275524
-- JUG 3531159
UPDATE city
SET Population=275524
WHERE City= 
		(
		SELECT 
			City 
		FROM city
		WHERE Population IS NULL
		)
-- WHERE countryid ='JUG'

UPDATE country
SET Population=3531159
WHERE CountryId = (SELECT CountryId FROM country
WHERE Population IS NULL
)
-- WHERE 

--6. Uppdatera befolkningsm�ngden f�r alla l�nder och st�der med 100 procent.

UPDATE country
SET Population=Population*2

UPDATE city
SET Population=Population*2


--7. L�gg till alla st�der fr�n Customers-tabellen i City-tabellen. 
-- Utg� fr�n att alla st�der som finns i Customers-tabellen finns i Sverige. Ange inget inv�narantal.

-- OPTION 1
INSERT INTO city(City)
SELECT distinct city FROM Customers

UPDATE city
SET CountryId ='SVE'
WHERE CountryId IS NULL

-- OPTION 2
INSERT INTO city
       SELECT DISTINCT city,'SVE',NULL
	   FROM Customers



--8. Ta bort de rader som lades till ovan

DELETE FROM city
WHERE Population IS NULL

--9. L�gg till st�der fr�n Customers-tabellen i City-tabellen, 
-- men se till att du inte l�gger in dubbletter. Undvik ocks� att skapa dubbletter (d v s l�gg inte in en stad som redan finns).
begin tran
-- OPTION 1, alter column properties
alter table customers
alter column city varchar(50) collate Finnish_Swedish_CI_AI

rollback transaction

-- option 2, don't alter column properties
INSERT INTO city(City, CountryId)

      SELECT DISTINCT customers.City, 'SVE' FROM Customers
      WHERE customers.City collate Finnish_Swedish_CI_AI 
	  NOT IN(SELECT city FROM city)

-- UPDATE country id
UPDATE city
SET CountryId='SVE'
WHERE CountryId IS NULL


SELECT * FROM Customers
SELECT * FROM city

-- 10.

UPDATE country
SET Country.Population= T2.Sum_Population
FROM country
INNER JOIN (SELECT 
			CountryId, 
			SUM(Population) AS Sum_Population 
			FROM city
			GROUP BY CountryId) AS T2
ON T2.CountryId=country.CountryId


-- OPTION 2

UPDATE country
SET Population=
        (SELECT 
			SUM(ISNULL(Population,0)) 
			FROM city
			WHERE city.CountryId=country.CountryId
			GROUP BY CountryId
			)


--11. Uppdatera l�nen f�r alla anst�llda som arbetar i Stockholm med 30 %.
UPDATE Employee
Set Salary = Salary*1.30
WHERE Employee.DeptID IN
		(
		 SELECT 
		 DeptID
		 FROM Department
		 WHERE Location='Stockholm'
		 )
-- 12. Uppdatera STEVE MILLER, s� namnet �r med inledande versal och resten gemener, d v s Steve Miller.

UPDATE Employee
SET Firstname='Steve',
    Lastname='Miller'
WHERE EmpID=7934

UPDATE Employee
SET Firstname = UPPER(LEFT(Firstname,1))+ Lower(RIGHT(Firstname, len(Firstname)-1)), 
    Lastname = UPPER(LEFT(Lastname,1))+ Lower(RIGHT(Lastname, len(Lastname)-1)) 
WHERE EmpID=
		(
		 SELECT EmpID
		 FROM Employee
		 WHERE Firstname= 'STEVE'
		 AND Lastname='MILLER'
        )


-- 13. L�gg till en anst�lld i Employee-tabellen. Valfritt namn, jobb, l�n och avdelning.

INSERT INTO Employee(EmpID, Lastname, Firstname, Job, HireDate, Salary, DeptID)
VALUES (1111,'Captain','America','Chef',GETDATE(),30000, 30)

--14. Ta bort alla rader i Department-tabellen. G�r det? 
-- Borde det g�? Vad h�nder i s� fall med raderna i Employee-tabellen?
 
 /*begin tran
 DELETE FROM Department
 */
 --TRANCATE TABLE 
 -- TA BORT ALLA RADER MEN KAN INTE ROLLBACK
ROLLBACK TRANSACTION

select * from Employee
