USE SoftUni2

SELECT FirstName, LastName 
FROM Employees
WHERE FirstName LIKE 'Sa%'


SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE '%ei%'


SELECT FirstName
FROM Employees
WHERE DepartmentID IN (3,10) 
AND
YEAR(HireDate) BETWEEN 1995 AND 2005

SELECT FirstName, LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

SELECT [Name]
FROM Towns
WHERE LEN([Name]) BETWEEN 5 AND 6
ORDER BY [Name]


SELECT TownID, [Name]
FROM Towns
WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name]

SELECT TownID, [Name]
FROM Towns
WHERE [Name] NOT LIKE '[RBD]%'
ORDER BY [Name]

SELECT FirstName, LastName
FROM Employees
WHERE YEAR(HireDate) > 2000

SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5



SELECT EmployeeID,FirstName, LastName, Salary,
DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC

SELECT *
FROM
(SELECT EmployeeID,FirstName, LastName, Salary,
DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000) AS [SOM]
WHERE SOM.[Rank] = 2
ORDER BY Salary DESC


USE Geography

SELECT [CountryName], IsoCode
FROM Countries
WHERE CountryName LIKE  '%a%a%a%'
ORDER BY IsoCode


SELECT p.PeakName, r.RiverName,
LOWER(LEFT(p.PeakName, LEN(p.PeakName)-1) + r.RiverName) AS Mix
FROM Peaks p, Rivers r
WHERE RIGHT(p.PeakName,1) = LEFT(r.RiverName,1)
ORDER BY Mix

USE Diablo

SELECT TOP 50 [Name],
(FORMAT([Start], 'yyyy-MM-dd')) AS [Start]
FROM Games
WHERE (YEAR([Start])) IN (2011,2012)
ORDER BY [Start],[Name]


SELECT Username,
SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS [Email Provider]
FROM Users 
ORDER BY [Email Provider], Username


SELECT Username,IpAddress AS [IP Address]
FROM Users
WHERE IpAddress LIKE '___.1%.%.___' 
ORDER BY Username


SELECT [Name] AS [Game],
(CASE 
	WHEN DATEPART(HOUR,[Start]) BETWEEN 0 AND 11 THEN 'Morning'
	WHEN DATEPART(HOUR,[Start]) BETWEEN 12 AND 17  THEN 'Afternoon'
	WHEN DATEPART(HOUR,[Start]) BETWEEN 18 AND 23  THEN 'Evening'
END) AS [Part of the Day],
(CASE
	WHEN Duration  BETWEEN 0 AND 3 THEN 'Extra Short'
	WHEN Duration  BETWEEN 4 AND 6 THEN 'Short'
	WHEN Duration  > 6 THEN 'Long'
	ELSE 'Extra Long'
END) AS Duration
FROM Games
ORDER BY [Name], Duration, [Part of the Day]



USE Orders

SELECT ProductName, OrderDate,
DATEADD(DAY,3,OrderDate)  AS [Pay Due],
DATEADD(MONTH,1,OrderDate)  AS [Deliver Due]
FROM Orders