use Gringotts


/*1. Records' Count
Import the database and send the total count of records from the one and only table to Mr. Bodrog. Make sure nothing gets lost.*/
SELECT COUNT(*) AS [Count]
FROM WizzardDeposits

/*2. Longest Magic Wand
Select the size of the longest magic wand. Rename the new column appropriately.*/

SELECT MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits

/*3. Longest Magic Wand Per Deposit Groups
For wizards in each deposit group show the longest magic wand. Rename the new column appropriately.*/

SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits AS wd
GROUP BY wd.DepositGroup


/*4. Smallest Deposit Group Per Magic Wand Size
Select the two deposit groups with the lowest average wand size.*/

SELECT TOP 2 DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)


/*5. Deposits Sum
Select all deposit groups and their total deposit sums.*/

SELECT DepositGroup, SUM(wz.DepositAmount) AS TotalSum
FROM WizzardDeposits AS wz
GROUP BY DepositGroup


/*6. Deposits Sum for Ollivander Family
Select all deposit groups and their total deposit sums, but only for the wizards, who have their magic wands crafted by the Ollivander family.*/

SELECT DepositGroup, SUM(wz.DepositAmount) AS TotalSum
FROM WizzardDeposits AS wz
WHERE wz.MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup


/*7. Deposits Filter
Select all deposit groups and their total deposit sums, but only for the wizards, who have their magic wands crafted by the Ollivander family. Filter total deposit amounts lower than 150000. Order by total deposit amount in descending order.*/

SELECT DepositGroup, SUM(wz.DepositAmount) AS TotalSum
FROM WizzardDeposits AS wz
WHERE wz.MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(wz.DepositAmount) < 150000
ORDER BY TotalSum DESC


/*8.  Deposit Charge
Create a query that selects:
•	Deposit group 
•	Magic wand creator
•	Minimum deposit charge for each group 
Select the data in ascending order by MagicWandCreator and DepositGroup.*/

SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits AS wd
GROUP BY DepositGroup, MagicWandCreator
--ORDER BY MagicWandCreator, DepositGroup

/*9. Age Groups
Write down a query that creates 7 different groups based on their age.
Age groups should be as follows:
•	[0-10]
•	[11-20]
•	[21-30]
•	[31-40]
•	[41-50]
•	[51-60]
•	[61+]
The query should return
•	Age groups
•	Count of wizards in it*/

SELECT AgeGroup, Count(*) FROM
(SELECT FirstName, Age,
CASE
		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 0 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 0 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 0 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 0 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 0 AND 60 THEN '[51-60]'
		ELSE '[61+]'
	END AS [AgeGroup]
FROM WizzardDeposits) AS wd
GROUP BY AgeGroup

/*10. First Letter
Create a query that returns all the unique wizard first letters of their first names only if they have deposit of type Troll Chest. Order them alphabetically. Use GROUP BY for uniqueness.*/

/*1*/
SELECT SUBSTRING(FirstName,1,1) AS FirstLetter
FROM WizzardDeposits 
WHERE DepositGroup = 'Troll Chest'
GROUP BY SUBSTRING(FirstName,1,1)
ORDER BY FirstLetter

/*2*/
SELECT DISTINCT LEFT(FirstName,1) AS [FirstLetter]
  FROM WizzardDeposits
 WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName,1)
ORDER BY FirstLetter

/*11. Average Interest 
Mr. Bodrog is highly interested in profitability. He wants to know the average interest of all deposit groups, split by whether the deposit has expired or not. But that's not all. He wants you to select deposits with start date after 01/01/1985. Order the data descending by Deposit Group and ascending by Expiration Flag.*/


SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
WHERE DepositStartDate > '1985-1-1'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired

/*12. *Rich Wizard, Poor Wizard
Mr. Bodrog definitely likes his werewolves more than you. This is your last chance to survive! Give him some data to play his favorite game Rich Wizard, Poor Wizard. The rules are simple: 
You compare the deposits of every wizard with the wizard after him. If a wizard is the last one in the database, simply ignore it. In the end you have to sum the difference between the deposits.*/

SELECT SUM(ResultTable.[Difference]) AS SumDifference
FROM  (SELECT DepositAmount - (SELECT DepositAmount FROM WizzardDeposits WHERE Id = WizDeposits.Id +1) AS [Difference] FROM WizzardDeposits AS WizDeposits) AS ResultTable


/*Part II – Queries for SoftUni Database*/

/*13. Departments Total Salaries
Create a query that shows the total sum of salaries for each department. Order them by DepartmentID.
Your query should return:	
•	DepartmentID*/

USE SoftUni2

SELECT DepartmentID, SUM(Salary) AS TotalSalary
FROM Employees 
GROUP BY DepartmentID
ORDER BY DepartmentID


/*14. Employees Minimum Salaries
Select the minimum salary from the employees for departments with ID (2, 5, 7) but only for those, hired after 01/01/2000.
Your query should return:	
•	DepartmentID*/

SELECT DepartmentID, Min(Salary) AS MinimumSalary
FROM Employees 
WHERE HireDate > '2000-1-1'
GROUP BY DepartmentID
HAVING DepartmentID IN (2,5,7)
ORDER BY DepartmentID

/*15. Employees Average Salaries
Select all employees who earn more than 30000 into a new table. Then delete all employees who have ManagerID = 42 (in the new table). Then increase the salaries of all employees with DepartmentID = 1 by 5000. Finally, select the average salaries in each department.*/

SELECT *
INTO NewEmployees
FROM Employees
WHERE Salary > 30000


DELETE FROM NewEmployees 
WHERE ManagerID = 42

UPDATE NewEmployees
SET Salary += 5000
WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary) AS AverageSalary
FROM NewEmployees
GROUP BY DepartmentID


/*16. Employees Maximum Salaries
Find the max salary for each department. Filter those, which have max salaries NOT in the range 30000 – 70000.*/

SELECT DepartmentID, MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

/*17. Employees Count Salaries
Count the salaries of all employees, who don’t have a manager.*/

SELECT COUNT(*) AS [Count]
FROM Employees
WHERE ManagerID IS NULL

/*18. *3rd Highest Salary
Find the third highest salary in each department if there is such. */

SELECT DepartmentID, Salary AS ThirdHighestSalary
FROM 
(SELECT Salary, DepartmentID, DENSE_RANK() OVER (PARTITION BY DepartmentID  ORDER BY Salary DESC) AS AvgSalary
FROM Employees 
GROUP BY DepartmentID, Salary) AS SalaryAvg
WHERE SalaryAvg.AvgSalary = 3

/*19. **Salary Challenge
Create a query that returns:
•	FirstName
•	LastName
•	DepartmentID
Select all employees who have salary higher than the average salary of their respective departments. Select only the first 10 rows. Order them by DepartmentID.*/


SELECT TOP 10 FirstName, LastName, DepartmentID
FROM Employees AS ex
WHERE Salary >
(SELECT AVG(Salary) AS SalaryAvg
FROM Employees AS en
WHERE ex.DepartmentID = en.DepartmentID
GROUP BY DepartmentID) 
ORDER BY DepartmentID


