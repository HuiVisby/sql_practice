
------variabler------

-- variabler ska består av ett @ som första tecken
-- variabler should be declared with datatype before it is used

declare @slaska int

set @slaska = 99

select @slaska

select @slaska = @slaska+1
select @slaska += 1


select @@VERSION

declare @cnt int
select @cnt = count(*) from Department
select @cnt as antal


DECLARE @name varchar(50)
select @name = Lastname  from Employee 
select @name
-- it takes only the last one of the 'Lastname' column

DECLARE @name varchar(50)
select @name = MIN(Lastname) from Employee GROUP BY Lastname 
select @name


DECLARE @name1 varchar(50)
select top 1 Lastname from Employee 
select @name1


DECLARE @search VARCHAR(50)
SET @search='A'
SET @search='%'+@search+'%'


SELECT Firstname, lastname from Employee
WHERE FIRSTNAME LIKE @search 
or Lastname LIKE @search 

PRINT 'Nu startades skriptet'

declare @cnt int
select @cnt = count(*) from Employee

PRINT 'Nästan mitt in skriptet'

select @cnt as 'Count'

PRINT 'NU är skriptet klart'

PRINT getdate()

PRINT cast(getdate() as char(10) )

--- print shows in 'Messages'


-------/While/-------

-- while is used for creating a loop
SET NOCOUNT ON


Declare @cnt INT
SET @CNT = 1

WHILE (@cnt<=10)
	BEGIN

		SELECT @cnt
		PRINT CAST(@CNT AS VARCHAR(2)) + '-->' + CONVERT (VARCHAR(40), GETDATE(), 121)
		
		if @cnt = 5
			set @cnt =7

		waitfor delay'00:00:01'
		SET @cnt +=1

	END

SET NOCOUNT OFF


