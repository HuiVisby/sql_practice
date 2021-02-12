
select top 25 * from [sales].customers

select count(*) from [sales].customers

select top 50 * from [sales].customers
order by last_name,first_name

create index idx_lastname on sales.customers(last_name)

create index idx_cover on sales.customers(last_name, first_name)

create index idx_cover on sales.customers(last_name) include (first_name)
drop index sales.customers.idx_cover

select first_name, last_name from sales.customers
where last_name='ESPINOZA'

-- 1. table
-- 2. lastname
-- 3. firstname
-- 4. lastname+firstname


--1 Se till att tabellen Employee blir indexerad på lön, med högsta lönen först.
Ta bort ovanstående index.
Skapa en kopia på Department och döp den till Dept. Skapa därefter ett unikt sammansatt index på kolumnerna Deptname och Location i tabellen Dept. Försök ändra namn till Ekonomi där DeptID = 10. 

CREATE INDEX idx_salary ON Employee(Salary DESC)



--2. Ta bort ovanstående index.

DROP INDEX Employee.idx_salary

--3. Skapa en kopia på Department och döp den till Dept. 
-- Skapa därefter ett unikt sammansatt index på kolumnerna Deptname och Location i tabellen Dept. 
-- Försök ändra namn till Ekonomi där DeptID = 10. 


SELECT * INTO Dept FROM Department 
select * from Dept

CREATE UNIQUE INDEX idx_com ON Dept(Deptname, Location)

UPDATE Dept
SET DeptName ='Finance'
WHERE DeptID=10


---- cannot insert duplicate values that are same as unique index 

--4. Ta bort tabellen Dept. Försvinner det index som du skapade automatiskt när tabellen tas bort?! 

select* from Dept
DROP TABLE DEPT

--JA

select name from sysobjects

select * from sysobjects

select * from sysindexes


set showplan_all on 

set statistics io on

set statistics time off

DBCC showcontig