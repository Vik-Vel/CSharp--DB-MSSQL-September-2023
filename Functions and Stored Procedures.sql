USE SoftUni2

/*1.	Employees with Salary Above 35000
Create stored procedure usp_GetEmployeesSalaryAbove35000 that returns all employees' first and last names, whose salary above 35000.  */
GO
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS 
SELECT FirstName, LastName
FROM Employees
WHERE Salary > 35000
GO

EXEC usp_GetEmployeesSalaryAbove35000 


/*2.	Employees with Salary Above Number
Create a stored procedure usp_GetEmployeesSalaryAboveNumber that accepts a number (of type DECIMAL(18,4)) as parameter and returns all employees' first and last names, whose salary is above or equal to the given number. */
GO
CREATE OR ALTER PROC usp_GetEmployeesSalaryAboveNumber
	@number DECIMAL(18,4)
AS
BEGIN
SELECT FirstName, LastName
FROM Employees
WHERE Salary >= @number
END
GO

EXEC  usp_GetEmployeesSalaryAboveNumber 48100


/*3.	Town Names Starting With
Create a stored procedure usp_GetTownsStartingWith that accepts a string as parameter and returns all town names starting with that string. */

GO
CREATE PROC usp_GetTownsStartingWith 
 @stringParam NVARCHAR(10)
 AS
 BEGIN
 SELECT [Name] AS Town
 FROM Towns
 WHERE [Name] LIKE @stringParam +'%'
 END
 GO

 EXEC usp_GetTownsStartingWith b


 /*4.	Employees from Town
Create a stored procedure usp_GetEmployeesFromTown that accepts town name as parameter and returns the first and last name of those employees, who live in the given town. */

GO
CREATE PROC usp_GetEmployeesFromTown 
	@townName NVARCHAR(255)
AS
BEGIN
SELECT FirstName, LastName
FROM Employees AS e
JOIN Addresses AS a
ON e.AddressID = a.AddressID
JOIN Towns AS t
ON t.TownID = a.TownID
WHERE t.[Name] = @townName
END
GO

EXEC usp_GetEmployeesFromTown 'Sofia'


/*5.	Salary Level Function
Create a function ufn_GetSalaryLevel(@salary DECIMAL(18,4)) that receives salary of an employee and returns the level of the salary.
•	If salary is < 30000, return "Low"
•	If salary is between 30000 and 50000 (inclusive), return "Average"
•	If salary is > 50000, return "High"*/
GO
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4)) 
RETURNS  VARCHAR(10) AS
BEGIN
	DECLARE @levelOfSalary VARCHAR(10)
	IF(@salary < 30000)
	SET @levelOfSalary =  'Low'
	IF (@salary BETWEEN 30000 AND 50000)
	SET @levelOfSalary = 'Average'
	IF(@salary > 50000)
	SET @levelOfSalary = 'High'
	RETURN @levelOfSalary
END
GO

SELECT Salary,dbo.ufn_GetSalaryLevel(e.Salary) SalaryLevel
From Employees as e

/*6.	Employees by Salary Level
Create a stored procedure usp_EmployeesBySalaryLevel that receives as parameter level of salary (low, average, or high) and print the names of all employees, who have the given level of salary. You should use the function - "dbo.ufn_GetSalaryLevel(@Salary)", which was part of the previous task, inside your "CREATE PROCEDURE …" query.*/

/*1*/
GO
CREATE PROC usp_EmployeesBySalaryLevel 
	@levelOfSalary VARCHAR(10) 
AS
BEGIN
SELECT FirstName,LastName
FROM 
(SELECT FirstName,LastName,dbo.ufn_GetSalaryLevel(e.Salary) AS  SalaryLevel
From Employees as e) AS query
WHERE dbo.ufn_GetSalaryLevel = query.SalaryLevel
END

/*2*/
GO
CREATE PROC usp_EmployeesBySalaryLevel 
	@levelOfSalary VARCHAR(10) 
AS
BEGIN
SELECT FirstName,LastName
FROM Employees 
WHERE dbo.ufn_GetSalaryLevel(Salary) = @levelOfSalary
END

EXEC usp_EmployeesBySalaryLevel 'High'

/*7.	Define Function
Define a function ufn_IsWordComprised(@setOfLetters, @word) that returns true or false, depending on that if the word is comprised of the given set of letters. */

GO
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @currentIndex int = 1;

	WHILE(@currentIndex <= LEN(@word))
	BEGIN
		DECLARE @currentLetter VARCHAR(1) = SUBSTRING(@word, @currentIndex,1);
		IF(CHARINDEX(@currentLetter, @setOfLetters)) = 0
			RETURN 0;
		ELSE
			SET @currentIndex += 1;
	END
	RETURN 1
END
GO

SELECT  dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')


/*8.	Delete Employees and Departments
Create a procedure with the name usp_DeleteEmployeesFromDepartment (@departmentId INT) which deletes all Employees from a given department. Delete these departments from the Departments table too. Finally, SELECT the number of employees from the given department. If the delete statements are correct the select query should return 0.
After completing that exercise restore your database to revert all changes.
Hint:
You may set ManagerID column in Departments table to nullable (using query "ALTER TABLE …").*/

GO
CREATE PROC usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS

DECLARE @empIDsToBeDeleted TABLE
(
Id int
)

INSERT INTO @empIDsToBeDeleted
SELECT e.EmployeeID
FROM Employees AS e
WHERE e.DepartmentID = @departmentId

ALTER TABLE Departments
ALTER COLUMN ManagerID INT NULL

DELETE FROM EmployeesProjects
WHERE EmployeeID IN (SELECT Id FROM @empIDsToBeDeleted)

UPDATE Employees
SET ManagerID = NULL
WHERE ManagerID IN (SELECT Id FROM @empIDsToBeDeleted)

UPDATE Departments
SET ManagerID = NULL
WHERE ManagerID IN (SELECT Id FROM @empIDsToBeDeleted)

DELETE FROM Employees
WHERE EmployeeID IN (SELECT Id FROM @empIDsToBeDeleted)

DELETE FROM Departments
WHERE ManagerID IN (SELECT Id FROM @empIDsToBeDeleted)


SELECT COUNT(*) AS [Employees Count] FROM Employees AS e
JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID
WHERE e. DepartmentID = @departmentId



/*9.	Find Full Name
You are given a database schema with tables AccountHolders(Id (PK), FirstName, LastName, SSN) and Accounts(Id (PK), AccountHolderId (FK), Balance).  Write a stored procedure usp_GetHoldersFullName that selects the full name of all people. */

USE Bank

GO
CREATE PROC usp_GetHoldersFullName
AS
SELECT FirstName + ' ' + LastName AS [Full Name]
FROM AccountHolders
GO


/*10.	People with Balance Higher Than
Your task is to create a stored procedure usp_GetHoldersWithBalanceHigherThan that accepts a number as a parameter and returns all the people, who have more money in total in all their accounts than the supplied number. Order them by their first name, then by their last name. */

CREATE PROC usp_GetHoldersWithBalanceHigherThan(@number DECIMAL(13,2))
AS
SELECT ah.FirstName, ah.LastName 
FROM AccountHolders AS ah
JOIN Accounts AS ac
ON ac.AccountHolderId = ah.Id
GROUP BY FirstName, LastName
HAVING SUM(ac.Balance) > @number
ORDER BY FirstName, LastName


EXEC dbo.usp_GetHoldersWithBalanceHigherThan 40000
 

 /*11.	Future Value Function
Your task is to create a function ufn_CalculateFutureValue that accepts as parameters – sum (decimal), yearly interest rate (float), and the number of years (int). It should calculate and return the future value of the initial sum rounded up to the fourth digit after the decimal delimiter. Use the following formula:
FV= 1×((1+R))^T)
	I – Initial sum
	R – Yearly interest rate
	T – Number of years*/
	GO
	CREATE FUNCTION ufn_CalculateFutureValue(@Sum DECIMAL(18,2), @Rate FLOAT, @Years INT)
	RETURNS DECIMAL(20,4)
	AS
	BEGIN
		RETURN @Sum * POWER((1 + @Rate), @Years)
	END
	GO

	SELECT dboufn_CalculateFutureValue(1000, .1, 5)

/*12.	Calculating Interest
Your task is to create a stored procedure usp_CalculateFutureValueForAccount that uses the function from the previous problem to give an interest to a person's account for 5 years, along with information about their account id, first name, last name and current balance as it is shown in the example below. It should take the AccountId and the interest rate as parameters. Again, you are provided with the dbo.ufn_CalculateFutureValue function, which was part of the previous task.*/

GO
CREATE or alter PROCEDURE usp_CalculateFutureValueForAccount(@AccountId INT, @InterestRate FLOAT)
AS
	DECLARE @Years INT = 5

	SELECT a.Id [Account Id], ah.FirstName, ah.LastName, a.Balance,
	dbo.ufn_CalculateFutureValue(a.Balance, @InterestRate, @Years) AS [Balance in 5 years]
	FROM AccountHolders  AS ah
	JOIN Accounts AS a
	ON a.AccountHolderId = ah.Id
	WHERE a.Id = 1

GO

EXEC usp_CalculateFutureValueForAccount 1, 0.1 