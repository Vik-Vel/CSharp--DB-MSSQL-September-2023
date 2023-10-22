USE SoftUni2

/*1.	Employee Address
Create a query that selects:
•	EmployeeId
•	JobTitle
•	AddressId
•	AddressText
Return the first 5 rows sorted by AddressId in ascending order.*/

SELECT TOP 5 EmployeeID, JobTitle, e.AddressID, a.AddressText
FROM Employees AS e
JOIN Addresses AS a 
ON e.AddressID = a.AddressID
ORDER BY AddressID

/*2. Write a query that selects:
•	FirstName
•	LastName
•	Town
•	AddressText
Sort them by FirstName in ascending order, then by LastName. Select the first 50 employees.*/

SELECT TOP 50 e.FirstName, e.LastName, t.[Name] AS Town , a.AddressText
FROM Employees AS e
JOIN Addresses AS a
ON e.AddressID = a.AddressID
JOIN Towns AS t
ON t.TownID = a.TownID
ORDER BY FirstName, LastName

/*3.	Sales Employee
Create a query that selects:
•	EmployeeID
•	FirstName
•	LastName
•	DepartmentName
Sort them by EmployeeID in ascending order. Select only employees from the "Sales" department.*/

SELECT EmployeeID, FirstName, LastName, d.[Name] AS DepartmentName
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE d.[Name] = 'Sales'
ORDER BY EmployeeID


/*4.	Employee Departments
Create a query that selects:
•	EmployeeID
•	FirstName 
•	Salary
•	DepartmentName
Filter only employees with a salary higher than 15000. Return the first 5 rows, sorted by DepartmentID in ascending order. */

SELECT TOP 5 EmployeeID, FirstName, Salary, d.[Name] AS DepartmentName
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID 
WHERE e.Salary > 15000
ORDER BY e.DepartmentID 

/*5.	Employees Without Project
Create a query that selects:
•	EmployeeID
•	FirstName
Filter only employees without a project. Return the first 3 rows, sorted by EmployeeID in ascending order.*/

SELECT TOP 3 e.EmployeeID, e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects as ep
ON e.EmployeeID = ep.EmployeeID
LEFT JOIN Projects AS p
ON p.ProjectID = ep.ProjectID
WHERE ep.EmployeeID IS NULL
ORDER BY e.EmployeeID

/*6.	Employees Hired After
Create a query that selects:
•	FirstName
•	LastName
•	HireDate
•	DeptName
Filter only employees hired after 1.1.1999 and are from either "Sales" or "Finance" department. Sort them by HireDate (ascending).*/

SELECT FirstName, LastName, HireDate, d.[Name] AS DeptName
FROM Employees AS e
JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID
WHERE d.[Name] IN ('Sales','Finance')
AND e.HireDate > '1-1-1999'
ORDER BY HireDate


/*7.	Employees with Project
Create a query that selects:
•	EmployeeID
•	FirstName
•	ProjectName
Filter only employees with a project which has started after 13.08.2002 and it is still ongoing (no end date). Return the first 5 rows sorted by EmployeeID in ascending order.*/

SELECT TOP 5 ep.EmployeeID, e.FirstName, p.[Name] AS ProjectName
FROM Employees AS e
JOIN EmployeesProjects AS ep
ON ep.EmployeeID = e.EmployeeID
JOIN Projects AS p
ON p.ProjectID = ep.ProjectID
WHERE p.StartDate > '2002-08-13'
AND EndDate IS NULL
ORDER BY e.EmployeeID 

/*8.	Employee 24
Create a query that selects:
•	EmployeeID
•	FirstName
•	ProjectName
Filter all the projects of employee with Id 24. If the project has started during or after 2005 the returned value should be NULL.*/

SELECT e.EmployeeID, FirstName, --p.[Name] AS ProjectName
CASE
	WHEN p.StartDate >= '2005-01-01' THEN NULL
	ELSE p.[Name]
END AS ProjectName
FROM Employees AS e
JOIN EmployeesProjects AS ep
ON ep.EmployeeID = e.EmployeeID
 JOIN Projects AS p
ON p.ProjectID = ep.ProjectID
WHERE e.EmployeeID = 24

/*9.	Employee Manager
Create a query that selects:
•	EmployeeID
•	FirstName
•	ManagerID
•	ManagerName
Filter all employees with a manager who has ID equals to 3 or 7. Return all the rows, sorted by EmployeeID in ascending order.*/

SELECT e.EmployeeID, e.FirstName, e.ManagerID, m.FirstName AS ManagerName
FROM Employees AS e
JOIN Employees AS m
ON e.ManagerID =  m.EmployeeID
WHERE m.EmployeeID IN (3,7)
ORDER BY e.EmployeeID

/*10.	Employees Summary
Create a query that selects:
•	EmployeeID
•	EmployeeName
•	ManagerName
•	DepartmentName
Show the first 50 employees with their managers and the departments they are in (show the departments of the employees). Order them by EmployeeID.*/

SELECT TOP 50 e.EmployeeID, CONCAT_WS(' ',e.FirstName, e.LastName) AS EmployeeName, CONCAT_WS(' ',m.FirstName, m.LastName) AS ManagerName, d.[Name] AS DepartmentName
FROM Employees AS e
JOIN Employees AS m
ON e.ManagerID = M.EmployeeID
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID

/*11.	Min Average Salary
Create a query that returns the value of the lowest average salary of all departments.*/

SELECT  TOP 1  AVG(Salary) AS MinAverageSalary
FROM Employees AS e
JOIN Departments AS d on d.DepartmentID = e.DepartmentID
GROUP BY d.[Name]
ORDER BY MinAverageSalary


/*Part II – Queries for Geography Database*/

USE Geography

/*12.	Highest Peaks in Bulgaria
Create a query that selects:
•	CountryCode
•	MountainRange
•	PeakName
•	Elevation
Filter all the peaks in Bulgaria, which have elevation over 2835. Return all the rows, sorted by elevation in descending order.*/

SELECT c.CountryCode,m.MountainRange,p.PeakName,p.Elevation
FROM Countries AS c
JOIN MountainsCountries AS mc
ON c.CountryCode = mc.CountryCode
JOIN Mountains AS m 
ON mc.MountainId = m.Id
JOIN Peaks AS p 
ON p.MountainId = m.Id
WHERE c.CountryName = 'Bulgaria'
AND p.Elevation > 2835
ORDER BY p.Elevation DESC


/*13.	Count Mountain Ranges
Create a query that selects:
•	CountryCode
•	MountainRanges
Filter the count of the mountain ranges in the United States, Russia and Bulgaria */

SELECT CountryCode, COUNT(*) AS MountainRanges
FROM MountainsCountries
WHERE CountryCode IN ('US','RU', 'BG')
GROUP BY CountryCode


/*14.	Countries With or Without Rivers
Create a query that selects:
•	CountryName
•	RiverName
Find the first 5 countries with or without rivers in Africa. Sort them by CountryName in ascending order. */

SELECT TOP 5 CountryName, r.RiverName
FROM Countries AS c
LEFT JOIN CountriesRivers AS cr
ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r
ON r.Id = cr.RiverId
WHERE ContinentCode = 'AF'
ORDER BY CountryName


/*15.	*Continents and Currencies
Create a query that selects:
•	ContinentCode
•	CurrencyCode
•	CurrencyUsage
Find all continents and their most used currency. Filter any currency, which is used in only one country. Sort your results by ContinentCode.*/

SELECT ContinentCode, CurrencyCode, CurrencyUsage FROM
	(SELECT *, 
	DENSE_RANK() OVER (PARTITION BY ContinentCode ORDER BY CurrencyUsage DESC) AS CurrencyRank
	FROM
			(SELECT  ContinentCode, CurrencyCode, COUNT(CurrencyCode) AS CurrencyUsage
			FROM Countries
			GROUP BY ContinentCode, CurrencyCode) AS CoreQuery
	WHERE CurrencyUsage > 1 ) AS SecondSubQuery
WHERE CurrencyRank = 1
ORDER BY ContinentCode

SELECT co.ContinentCode, cr.CurrencyCode, COUNT(c.CountryCode) AS CurrencyUsage
FROM Continents AS co
JOIN Countries AS c 
ON co.ContinentCode = c.ContinentCode
JOIN Currencies AS cr 
ON c.CurrencyCode = cr.CurrencyCode
GROUP BY co.ContinentCode, cr.CurrencyCode
HAVING COUNT(c.CountryCode) > 1 
ORDER BY co.ContinentCode


SELECT ContinentCode, CurrencyCode, CurrencyUsage
FROM
(SELECT *, 
DENSE_RANK() OVER (PARTITION BY ContinentCode
ORDER BY CurrencyUsage DESC) AS CurrencyRank
FROM
(SELECT ContinentCode, CurrencyCode, COUNT(CurrencyCode) AS CurrencyUsage
FROM Countries
GROUP BY ContinentCode,CurrencyCode) AS CoreQuery
WHERE CurrencyUsage > 1) AS SecondSubQuery
WHERE CurrencyRank = 1


/*16.	Countries Without Any Mountains
Create a query that returns the count of all countries, which don’t have a mountain.*/

SELECT COUNT(*)
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc
ON mc.CountryCode = c.CountryCode
WHERE mc.MountainId IS NULL


/*17.	Highest Peak and Longest River by Country
For each country, find the elevation of the highest peak and the length of the longest river, sorted by the highest peak elevation (from highest to lowest), then by the longest river length (from longest to smallest), then by country name (alphabetically). Display NULL when no data is available in some of the columns. Limit only the first 5 rows.*/

SELECT TOP 5 c.CountryName, MAX(p.Elevation) AS [HigestPeakElevation], MAX(r.[Length]) AS [LongestRiverLength]
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc 
ON c.CountryCode = mc.CountryCode
LEFT JOIN Peaks AS p
ON p.MountainId = mc.MountainId
LEFT JOIN CountriesRivers AS cr
ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r
ON r.Id = cr.RiverId
GROUP BY c.CountryName
ORDER BY HigestPeakElevation DESC, LongestRiverLength DESC, c.CountryName





/*18.	Highest Peak Name and Elevation by Country
For each country, find the name and elevation of the highest peak, along with its mountain. When no peaks are available in some countries, display elevation 0, "(no highest peak)" as peak name and "(no mountain)" as a mountain name. When multiple peaks in some countries have the same elevation, display all of them. Sort the results by country name alphabetically, then by highest peak name alphabetically. Limit only the first 5 rows.*/


SELECT TOP (5) WITH TIES c.CountryName, ISNULL(p.PeakName, '(no highest peak)') AS 'HighestPeakName', ISNULL(MAX(p.Elevation), 0) AS 'HighestPeakElevation', ISNULL(m.MountainRange, '(no mountain)')
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
LEFT JOIN Peaks AS p ON m.Id = p.MountainId
GROUP BY c.CountryName, p.PeakName, m.MountainRange
ORDER BY c.CountryName, p.PeakName
