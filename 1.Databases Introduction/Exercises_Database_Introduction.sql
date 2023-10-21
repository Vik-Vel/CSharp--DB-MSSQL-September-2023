/*1.Create Database*/
/*First, just create new database named Minions.*/
CREATE DATABASE Minions
/*2.Create Tables*/
/*In the newly created database Minions add table Minions (Id, Name, Age). Then add a new table Towns (Id, Name). Set Id columns of both tables to be primary key as constraint.*/
CREATE TABLE Minions (
Id int NOT NULL PRIMARY KEY,
Name NVARCHAR(150), 
Age int
);

CREATE TABLE Towns(
Id int NOT NULL PRIMARY KEY,
Name NVARCHAR(150)
);

/*3.Alter Minions Table*/
/*Change the structure of the Minions table to have a new column TownId that would be of the same type as the Id column in Towns table. Add a new constraint that makes TownId foreign key and references to Id column in Towns table.*/

ALTER TABLE Minions
ADD TownId INT;

ALTER TABLE Minions
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id);

/*4.Insert Records in Both Tables*/
/*Populate both tables with sample records, given in the table below.*/

INSERT INTO Towns
VALUES 
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions
VALUES 
(1, 'Kevin',22,1),
(2, 'Bob',15,3),
(3, 'Steward',NULL,2)


/*5.Truncate Table Minions*/
/*Delete all the data from the Minions table using SQL query.*/
DELETE FROM Minions;

/*6.Drop All Tables*/
/*Delete all tables from the Minions database using SQL query.*/
DROP TABLE Minions, Towns;


/*7.Create Table People*/
/*Using SQL query, create table People with the following columns:
•	Id – unique number. For every person there will be no more than 231-1 people (auto incremented).
•	Name – full name of the person. There will be no more than 200 Unicode characters (not null).
•	Picture – image with size up to 2 MB (allow nulls).
•	Height – in meters. Real number precise up to 2 digits after floating point (allow nulls).
•	Weight – in kilograms. Real number precise up to 2 digits after floating point (allow nulls).
•	Gender – possible states are m or f (not null).
•	Birthdate – (not null).
•	Biography – detailed biography of the person. It can contain max allowed Unicode characters (allow nulls).
Make the Id a primary key. Populate the table with only 5 records. Submit your CREATE and INSERT statements as Run queries & check DB.*/

CREATE TABLE PEOPLE
(
Id INT PRIMARY KEY Identity  ,
[Name] NVARCHAR(200) NOT NULL,
Picture VARBINARY(2000),
Height FLOAT(2),
[Weight] FLOAT(2),
Gender CHAR  NOT NULL CHECK(Gender = 'm'OR Gender = 'f'),
Birthdate DATETIME NOT NULL,
Biography NVARCHAR(MAX)
)




INSERT INTO People(Name,Picture,Height,Weight,Gender,Birthdate,Biography) Values
('Stela',Null,1.65,44.55,'f','2000-09-22',Null),
('Ivan',Null,2.15,95.55,'m','1989-11-02',Null),
('Qvor',Null,1.55,33.00,'m','2010-04-11',Null),
('Karolina',Null,2.15,55.55,'f','2001-11-11',Null),
('Pesho',Null,1.85,90.00,'m','1983-07-22',Null)

/*8.	Create Table Users*/
/*Using SQL query create table Users with columns:
•	Id – unique number for every user. There will be no more than 263-1 users (auto incremented).
•	Username – unique identifier of the user. It will be no more than 30 characters (non Unicode)  (required).
•	Password – password will be no longer than 26 characters (non Unicode) (required).
•	ProfilePicture – image with size up to 900 KB. 
•	LastLoginTime
•	IsDeleted – shows if the user deleted his/her profile. Possible states are true or false.
Make the Id a primary key. Populate the table with exactly 5 records. Submit your CREATE and INSERT statements as Run queries & check DB.*/


CREATE TABLE Users
(
Id INT PRIMARY KEY  Identity,
Username VARCHAR(30) NOT NULL,
[Password]  VARCHAR(26) NOT NULL,
ProfilePicture VARBINARY(900) NOT NULL,
LastLoginTime DATETIME,
IsDeleted VARCHAR(5)  NOT NULL CHECK(IsDeleted = 'true'OR IsDeleted = 'false')
)

INSERT INTO Users(Username,[Password],ProfilePicture,LastLoginTime,IsDeleted) Values
('Stela45',158936,745,'2000-09-22','true'),
('Ivan58',895612,888,'1989-11-02','false'),
('Qvor77',756315,125,'2010-04-11','false'),
('Karolina22',987456,145,'2001-11-11','true'),
('Pesho12',0147892,659,'1983-07-22','true')


/*9.Change Primary Key*/
/*Using SQL queries modify table Users from the previous task. First remove the current primary key and then create a new primary key that would be a combination of fields Id and Username.*/

ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC074AEE543A;

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY(ID, Username);

/*10. Add Check Constraint*/
/*Using SQL queries modify table Users. Add check constraint to ensure that the values in the Password field are at least 5 symbols long.*/

ALTER TABLE Users
ADD CHECK (Password >= 5);


/*11.Set Default Value of a Field*/
/*Using SQL queries modify table Users. Make the default value of LastLoginTime field to be the current time.*/

ALTER TABLE Users 
ADD CONSTRAINT DF_Users DEFAULT GETDATE() FOR LastLoginTime;

/*12.Set Unique Field*/
/*Using SQL queries modify table Users. Remove Username field from the primary key so only the field Id would be primary key. Now add unique constraint to the Username field to ensure that the values there are at least 3 symbols long.*/
ALTER TABLE Users 
DROP CONSTRAINT PK_Users;

ALTER TABLE Users
ADD CONSTRAINT PK_UsersID PRIMARY KEY(ID);

ALTER TABLE Users
ADD CONSTRAINT CHK_Username CHECK (LEN(Username) >= 3); 


/*13.Movies Database*/
/*Using SQL queries create Movies database with the following entities:
•	Directors (Id, DirectorName, Notes)
•	Genres (Id, GenreName, Notes)
•	Categories (Id, CategoryName, Notes)
•	Movies (Id, Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
Set the most appropriate data types for each column. Set a primary key to each table. Populate each table with exactly 5 records. Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields are always required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check DB.*/

CREATE DATABASE Movies;

CREATE TABLE Directors 
(
ID INT PRIMARY KEY NOT NULL Identity,
DirectorName NVARCHAR(150) NOT NULL,
NOTES NVARCHAR(1500)
);

CREATE TABLE Genres  
(
ID INT PRIMARY KEY NOT NULL Identity,
GenreName NVARCHAR(150) NOT NULL,
NOTES NVARCHAR(1500)
);

CREATE TABLE Categories  
(
ID INT PRIMARY KEY NOT NULL Identity,
CategorYName NVARCHAR(150) NOT NULL,
NOTES NVARCHAR(1500)
);

CREATE TABLE Movies  
(
ID INT PRIMARY KEY NOT NULL Identity,
Title NVARCHAR(150) NOT NULL,
DirectorId INT FOREIGN KEY REFERENCES Directors(Id),
CopyrightYear DATE NOT NULL,
[LENGTH] INT NOT NULL,
GenreId INT FOREIGN KEY REFERENCES Genres(Id),
CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
RATING INT,
NOTES NVARCHAR(1500)
);


INSERT INTO Directors(DirectorName, Notes) VALUES
('Viktor Veleve', 'Love movies'),
('Viktoriq Veleva', NULL),
('Ivailo Velev', NULL),
('Viktoriq Ivanova', NULL),
('Viktoriq Teneva', NULL)

INSERT INTO Genres(GenreName, Notes) VALUES
('Comedy', NULL),
('Horror', NULL),
('Drama', NULL),
('Romance', NULL),
('Documental', NULL)

INSERT INTO Categories(CategorYName, Notes) VALUES
('Comedy', NULL),
('adventure', NULL),
('fantasy', NULL),
('Western', NULL),
('sports', NULL)


INSERT INTO Movies (Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes) VALUES
('2001: A Space Odyssey (1968) Film. Science fiction.', 1,'1968',145,4,2,NULL,NULL),
('The Godfather (1972) Film. Thrillers', 5,'1972',123,3,1,NULL,NULL),
('Citizen Kane', 2,'1941',102,2,3,NULL,NULL),
('Jeanne Dielman', 4,'1985',99,1,5,NULL,NULL),
('Raiders of the Lost Ark (1981) Film', 3,'1981',99,5,4,NULL,NULL)

/*14. Car Rental Database*/
/*Using SQL queries create CarRental database with the following entities:
•	Categories (Id, CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
•	Cars (Id, PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
•	Employees (Id, FirstName, LastName, Title, Notes)
•	Customers (Id, DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
•	RentalOrders (Id, EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
Set the most appropriate data types for each column. Set a primary key to each table. Populate each table with only 3 records. Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields are always required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check DB.*/

CREATE DATABASE CarRental; 

Use CarRental;

CREATE TABLE Categories
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
CategoryName NVARCHAR(50) NOT NULL,
DailyRate DECIMAL(10,2) NOT NULL,
WeeklyRate DECIMAL(10,2) NOT NULL,
MonthlyRate DECIMAL(10,2) NOT NULL,
WeekendRate DECIMAL(10,2) NOT NULL
)

CREATE TABLE Cars
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
PlateNumber NVARCHAR(50) NOT NULL,
Manufacturer NVARCHAR(50) NOT NULL,
Model NVARCHAR(50) NOT NULL,
CarYear DATE NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
Doors INT  NOT NULL,
Picture VARBINARY(MAX),
Condition NVARCHAR(50),
Available NVARCHAR(10) NOT NULL
)


CREATE TABLE Employees  
(
ID INT PRIMARY KEY NOT NULL Identity,
FirstName NVARCHAR(150) NOT NULL,
LastName NVARCHAR(150) NOT NULL,
Title NVARCHAR(50) NOT NULL,
Notes NVARCHAR(1500)
);

CREATE TABLE Customers   
(
ID INT PRIMARY KEY NOT NULL Identity,
DriverLicenceNumber NVARCHAR(150) NOT NULL,
FullName NVARCHAR(150) NOT NULL,
[Address] NVARCHAR(50) NOT NULL,
City NVARCHAR(1500),
ZIPCode VARCHAR(10),
Notes NVARCHAR(1500)
);

CREATE TABLE  RentalOrders  
(
ID INT PRIMARY KEY NOT NULL Identity,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
CustomerId INT FOREIGN KEY REFERENCES Customers(Id),
CarId INT FOREIGN KEY REFERENCES Cars(Id),
TankLevel  DECIMAL(10,2) NOT NULL,
KilometrageStart INT NOT NULL,
KilometrageEnd INT NOT NULL,
TotalKilometrage INT NOT NULL,
StartDate DATETIME2 NOT NULL,
EndDate DATETIME2 NOT NULL,
TotalDays INT NOT NULL,
RateApplied NVARCHAR(100),
TaxRate DECIMAL(10,2),
OrderStatus NVARCHAR(100),
Notes NVARCHAR(1500)
);


INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES
( 'Стандартна', 45.00, 270.00, 900.00, 55.00),
( 'Луксозна', 65.00, 390.00, 1300.00, 75.00),
( 'Икономична', 35.00, 210.00, 700.00, 45.00);


INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
VALUES
('CT1999BP', 'AUDI', 'A4', '2005-07-08', 1, 5, NULL, 'Използван', 'Да'),
('CT1998BP', 'BMW', 'E30', '2006-07-08', 1, 2, NULL, 'Използван', 'Да'),
('CT1999CP', 'Mercedes', 'Sprinter', '2010-08-09', 3, 8, NULL, 'Използван', 'Да');



INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES
('Иван', 'Иванов', 'Мениджър', 'Отговаря за ренталната дейност'),
('Мария', 'Петрова', 'Работник', 'Отговаря за обслужване на клиенти'),
('Георги', 'Георгиев', 'Шофьор', 'Изпълнява доставки и връща автомобили');


INSERT INTO Customers(DriverLicenceNumber, FullName, [Address], City, ZIPCode, Notes)
VALUES
('DL123456', 'Иван Иванов', 'ул. Главна 123', 'София', '1000', 'Лоялен клиент'),
('DL654321', 'Мария Петрова', 'бул. Основна 456', 'Пловдив', '2000', 'Интересува се за специални оферти'),
('DL987654', 'Георги Георгиев', 'ул. Паралелна 789', 'Варна', '3000', 'Редовно наемане на автомобили');



INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
VALUES
(1, 1, 1, 80, 5000, 5500, 500, '2023-09-10', '2023-09-12', 2, 8.3, 0.18, 'Completed', 'Customer was satisfied'),
(2, 2, 2, 70, 6000, 6200, 200, '2023-09-11', '2023-09-14', 3, 6.5, 0.15, 'Completed', 'Car needed maintenance'),
(3, 3, 3, 90, 7500, 7700, 200, '2023-09-12', '2023-09-15', 3, 2.4, 0.12, 'Completed', 'Customer returned the bus on time');


/*15. Hotel Database*/
/*Using SQL queries create Hotel database with the following entities:
•	Employees (Id, FirstName, LastName, Title, Notes)
•	Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
•	RoomStatus (RoomStatus, Notes)
•	RoomTypes (RoomType, Notes)
•	BedTypes (BedType, Notes)
•	Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
•	Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
•	Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
Set the most appropriate data types for each column. Set a primary key to each table. Populate each table with only 3 records. Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields are always required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check DB.*/

CREATE DATABASE Hotel 

USE Hotel; 

CREATE TABLE Employees  
(
Id INT PRIMARY KEY NOT NULL Identity,
FirstName NVARCHAR(150) NOT NULL,
LastName NVARCHAR(150) NOT NULL,
Title NVARCHAR(50) NOT NULL,
Notes NVARCHAR(1500)
);

INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES
('Иван', 'Иванов', 'Мениджър', 'Отговаря за ренталната дейност'),
('Мария', 'Петрова', 'Работник', 'Отговаря за обслужване на клиенти'),
('Георги', 'Георгиев', 'Шофьор', 'Изпълнява доставки и връща автомобили');


CREATE TABLE Customers   
(
AccountNumber INT PRIMARY KEY NOT NULL IDENTITY,
FirstName NVARCHAR(150) NOT NULL,
LastName NVARCHAR(150) NOT NULL,
PhoneNumber NVARCHAR(20) NOT NULL,
EmergencyName NVARCHAR(150) NOT NULL,
EmergencyNumber NVARCHAR(20),
Notes NVARCHAR(1500)
);

INSERT INTO Customers (FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
VALUES
('Иван', 'Иванов', '0888123456', 'Петър Петров', '0888234567', 'Лоялен клиент'),
('Мария', 'Петрова', '0877123456', 'Георги Георгиев', '0878234567', 'Постоянен клиент'),
('Георги', 'Георгиев', '0899123456', 'Иван Иванов', '0899234567', 'Специални заявки');


CREATE TABLE RoomStatus
(
    RoomStatus NVARCHAR(50) PRIMARY KEY NOT NULL,
    Notes NVARCHAR(1500)
);

INSERT INTO RoomStatus (RoomStatus, Notes)
VALUES
('Свободна', 'Стаята е готова за настаняване'),
('Заета', 'Стаята е заета от клиент'),
('Почиства се', 'Стаята се почиства и подготвя за нов клиент');


CREATE TABLE RoomTypes 
(
    RoomType NVARCHAR(50) PRIMARY KEY NOT NULL,
    Notes NVARCHAR(1500)
);

INSERT INTO RoomTypes (RoomType, Notes)
VALUES
('Стандартна стая', 'Обичайна стая с основни удобства'),
('Луксозна стая', 'Просторна стая с разширени удобства и гледка'),
('Фамилна стая', 'Стая, подходяща за семейства с допълнително спално място за деца');

CREATE TABLE BedTypes 
(
    BedType NVARCHAR(50) PRIMARY KEY NOT NULL,
    Notes NVARCHAR(1500)
);

INSERT INTO BedTypes (BedType, Notes)
VALUES
('Единично легло', 'Стандартно единично легло'),
('Двойно легло', 'Стандартно двойно легло'),
('Кинг сайз легло', 'Голямо и комфортно легло за двама');


CREATE TABLE Rooms
(
    RoomNumber INT PRIMARY KEY IDENTITY NOT NULL,
	RoomType NVARCHAR(50) FOREIGN KEY REFERENCES RoomTypes(RoomType),
    BedTypes NVARCHAR(50)FOREIGN KEY REFERENCES BedTypes(BedType),
	Rate DECIMAL(6,2),
	RoomStatus NVARCHAR(50) FOREIGN KEY REFERENCES RoomStatus(RoomStatus),
    Notes NVARCHAR(1500)
);

INSERT INTO Rooms (RoomType, BedTypes, Rate, RoomStatus, Notes)
VALUES
( 'Стандартна стая', 'Двойно легло', 80.00, 'Свободна', 'Изглед към градския парк'),
( 'Луксозна стая', 'Кинг сайз легло', 120.00, 'Заета', 'С изглед към морето'),
( 'Фамилна стая', 'Двойно легло', 100.00, 'Свободна', 'С допълнително легло за деца');



CREATE TABLE Payments
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
PaymentDate DATE NOT NULL, 
AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber),
FirstDateOccupied DATE NOT NULL,
LastDateOccupied DATE NOT NULL,
TotalDays INT,
AmountCharged INT,
TaxRate DECIMAL(8, 2),
TaxAmount DECIMAL(8, 2),
PaymentTotal DECIMAL(15, 2),
Notes NVARCHAR(1500)
);

INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
VALUES
(1, '2023-09-10', 1, '2023-09-10', '2023-09-12', 2, 160.00, 0.18, 28.80, 188.80, 'Плащане на стая 101'),
(2, '2023-09-11', 2, '2023-09-11', '2023-09-14', 3, 360.00, 0.15, 54.00, 414.00, 'Плащане на стая 201'),
(3, '2023-09-12', 3, '2023-09-12', '2023-09-15', 3, 300.00, 0.12, 36.00, 336.00, 'Плащане на стая 301');


CREATE TABLE Occupancies
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
DateOccupied DATE NOT NULL, 
AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber),
RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber),
RateApplied DECIMAL(6,2),
PhoneCharge DECIMAL(6,2),
Notes NVARCHAR(1500)
);

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
VALUES
(1, '2023-09-10', 1, 1, 80.00, 10.00, 'Около клиентите бяха много доволни'),
(2, '2023-09-11', 2, 2, 120.00, 15.00, 'Клиентът изрази желание да удължи престоя си'),
(3, '2023-09-12', 3, 3, 100.00, 12.50, 'Семейство с две деца настанени в стаята');



/*16.Create SoftUni Database*/
/*Now create bigger database called SoftUni. You will use the same database in the future tasks. It should hold information about
•	Towns (Id, Name)
•	Addresses (Id, AddressText, TownId)
•	Departments (Id, Name)
•	Employees (Id, FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)
The Id columns are auto incremented, starting from 1 and increased by 1 (1, 2, 3, 4…). Make sure you use appropriate data types for each column. Add primary and foreign keys as constraints for each table. Use only SQL queries. Consider which fields are always required and which are optional.*/

CREATE DATABASE SoftUni

USE SoftUni

CREATE TABLE Towns
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Addresses 
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
AddressText NVARCHAR(200) NOT NULL, 
TownId INT FOREIGN KEY REFERENCES Towns(Id)
)

CREATE TABLE Departments 
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Employees 
(Id INT PRIMARY KEY NOT NULL IDENTITY,
FirstName NVARCHAR(50) NOT NULL, 
MiddleName NVARCHAR(50),
LastName NVARCHAR(50) NOT NULL, 
JobTitle NVARCHAR(50) NOT NULL,
DepartmentId INT FOREIGN KEY REFERENCES Departments(Id), 
HireDate DATE NOT NULL, 
Salary DECIMAL(10,2),
AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)

/*17.	Backup Database*/
/*Backup the database SoftUni from the previous task into a file named "softuni-backup.bak". Delete your database from SQL Server Management Studio. Then restore the database from the created backup.*/

BACKUP DATABASE SoftUni
TO DISK = 'D:\SoftUni\backups\softuni-backup.bak'

DROP DATABASE SoftUni

RESTORE DATABASE SoftUni
FROM DISK = 'D:\SoftUni\backups\softuni-backup.bak'


/*18.	Basic Insert
Use the SoftUni database and insert some data using SQL queries.
•	Towns: Sofia, Plovdiv, Varna, Burgas
•	Departments: Engineering, Sales, Marketing, Software Development, Quality Assurance
•	Employees:
Name	Job Title	Department	Hire Date	Salary
Ivan Ivanov Ivanov	.NET Developer	Software Development	01/02/2013	3500.00
Petar Petrov Petrov	Senior Engineer	Engineering	02/03/2004	4000.00
Maria Petrova Ivanova	Intern	Quality Assurance	28/08/2016	525.25
Georgi Teziev Ivanov	CEO	Sales	09/12/2007	3000.00
Peter Pan Pan	Intern	Marketing	28/08/2016	599.88 */

USE SoftUni

INSERT INTO Towns ([Name]) 
VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

INSERT INTO Departments ([Name]) 
VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary) 
VALUES
('Ivan','Ivanov', 'Ivanov','.NET Developer', 4, '2013-02-01',3500.00),
('Petar','Petrov', 'Petrov','Senior Engineer', 1, '2004-03-02',4000.00),
('Maria','Petrova', 'Ivanova','Intern', 5, '2016-08-28',525.25),
('Georgi','Teziev', 'Ivanov','CEO', 2, '2007-12-09',3000.00),
('Peter','Pan', 'Pan','Intern', 3, '2016-08-28',599.88)

/*19.Basic Select All Fields
Use the SoftUni database and first select all records from the Towns, then from Departments and finally from Employees table. Use SQL queries and submit them to Judge at once. Submit your query statements as Prepare DB & Run queries.*/

SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees

/*20.	Basic Select All Fields and Order Them
Modify the queries from the previous problem by sorting:
•	Towns - alphabetically by name
•	Departments - alphabetically by name
•	Employees - descending by salary
Submit your query statements as Prepare DB & Run queries.*/

SELECT * FROM Towns
ORDER BY [Name] ASC;

SELECT * FROM Departments
ORDER BY [Name] ASC;

SELECT * FROM Employees
ORDER BY Salary DESC;


/*21.	Basic Select Some Fields
Modify the queries from the previous problem to show only some of the columns. For table:
•	Towns – Name
•	Departments – Name
•	Employees – FirstName, LastName, JobTitle, Salary
Keep the ordering from the previous problem. Submit your query statements as Prepare DB & Run queries.*/


SELECT [Name] FROM Towns
ORDER BY [Name] ASC;

SELECT [Name] FROM Departments
ORDER BY [Name] ASC;

SELECT FirstName, LastName, JobTitle, Salary FROM Employees  
ORDER BY Salary DESC;


/*22.	Increase Employees Salary
Use SoftUni database and increase the salary of all employees by 10%. Then show only Salary column for all the records in the Employees table. Submit your query statements as Prepare DB & Run queries.*/

UPDATE Employees
SET Salary = Salary *1.10; 

SELECT Salary FROM Employees

/*23.	Decrease Tax Rate
Use Hotel database and decrease tax rate by 3% to all payments. Then select only TaxRate column from the Payments table. Submit your query statements as Prepare DB & Run queries.*/

USE Hotel

UPDATE Payments
SET TaxRate = TaxRate - 0.03; 

SELECT TaxRate FROM Payments;


/*24.	Delete All Records
Use Hotel database and delete all records from the Occupancies table. Use SQL query. Submit your query statements as Run skeleton, run queries & check DB.*/

DELETE  FROM Occupancies 
