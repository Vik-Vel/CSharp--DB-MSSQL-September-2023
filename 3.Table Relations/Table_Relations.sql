CREATE DATABASE TableRelations

USE TableRelations


/*1.	One-To-One Relationship
Create two tables and use appropriate data types.
Insert the data from the example above. Alter the Persons table and make PersonID a primary key. Create a foreign key between Persons and Passports by using the PassportID column.
*/
CREATE TABLE Persons
(
PersonID INT NOT NULL,
FirstName NVARCHAR(150) NOT NULL,
Salary DECIMAL(10,2),
PassportID INT UNIQUE
)

CREATE TABLE Passports
(
PassportID INT NOT NULL UNIQUE,
PassportNumber NVARCHAR(50)
)

INSERT INTO Passports (PassportID, PassportNumber)
VALUES
    (101, 'N34FG21B'),
    (102, 'K65LO4R7'),
    (103, 'ZE657QP2');


INSERT INTO Persons (PersonID, FirstName, Salary, PassportID)
VALUES
    (1, 'Roberto', 43300.00, 102),
    (2, 'Tom', 56100.00, 103),
    (3, 'Yana', 60200.00, 101);

	
	ALTER TABLE Persons 
	ADD PRIMARY KEY (PersonID);


	ALTER TABLE Passports 
	ADD PRIMARY KEY (PassportID);

	ALTER TABLE Persons 
	ADD CONSTRAINT FK_Persons_Passports FOREIGN KEY (PassportID)
	REFERENCES Passports(PassportID)


	/*2.	One-To-Many Relationship
Create two tables and use appropriate data types.
Insert the data from the example above and add primary keys and foreign keys.*/


CREATE TABLE Manufacturers
(
ManufacturerID INT NOT NULL,
[Name] NVARCHAR(150) NOT NULL,
EstablishedOn DATE
)

CREATE TABLE Models
(
ModelsID INT NOT NULL UNIQUE,
[Name] NVARCHAR(150) NOT NULL,
ManufacturerID INT NOT NULL
)


INSERT INTO Models (ModelsID, Name, ManufacturerID)
VALUES
    (101, 'X1', 1),
    (102, 'i6', 1),
    (103, 'Model S', 2),
    (104, 'Model X', 2),
    (105, 'Model 3', 2),
    (106, 'Nova', 3);


	INSERT INTO Manufacturers (ManufacturerID, Name, EstablishedOn)
VALUES
    (1, 'BMW', '1916-07-03'),
    (2, 'Tesla', '2003-01-01'),
    (3, 'Lada', '1966-01-05');

	
	ALTER TABLE Manufacturers
	ADD PRIMARY KEY (ManufacturerID);

	ALTER TABLE Models
	ADD CONSTRAINT PK_ModelsID 
	PRIMARY KEY (ModelsID)


	ALTER TABLE Models
	ADD CONSTRAINT FK_Manufacturer 
	FOREIGN KEY (ManufacturerID) 
	REFERENCES Manufacturers(ManufacturerID)


	/*3.	Many-To-Many Relationship
Create three tables and use appropriate data types.
Insert the data from the example above and add primary keys and foreign keys. Keep in mind that the table "StudentsExams" should have a composite primary key.*/

CREATE TABLE Students
(
StudentID INT NOT NULL,
[Name] NVARCHAR(150)
)

CREATE TABLE Exams
(
ExamID INT NOT NULL,
[Name] NVARCHAR(150)
)

CREATE TABLE StudentsExams
(
StudentID INT NOT NULL,
ExamID INT NOT NULL
)

-- Insert data into the Students table
INSERT INTO Students (StudentID, Name)
VALUES
    (1, 'Mila'),
    (2, 'Toni'),
    (3, 'Ron');

	-- Insert data into the Exams table
INSERT INTO Exams (ExamID, [Name])
VALUES
    (101, 'SpringMVC'),
    (102, 'Neo4j'),
    (103, 'Oracle 11g');

	-- Insert data into the StudentsExams table to associate students with exams
INSERT INTO StudentsExams (StudentID, ExamID)
VALUES
    (1, 101),
    (1, 102),
    (2, 101),
    (3, 103),
    (2, 102),
    (2, 103);



	ALTER TABLE Students
	ADD CONSTRAINT PK_StudentID
	PRIMARY KEY (StudentID)

		ALTER TABLE Exams
	ADD CONSTRAINT PK_ExamID
	PRIMARY KEY (ExamID)


	-- Add a composite primary key to the StudentsExams table
	ALTER TABLE StudentsExams
	ADD CONSTRAINT PK_StudentID_ExamID 
	PRIMARY KEY(StudentID, ExamID)

	ALTER TABLE StudentsExams
	ADD CONSTRAINT FK_StudentsExams_Students FOREIGN KEY(StudentID) REFERENCES Students(StudentID)


	ALTER TABLE StudentsExams
	ADD CONSTRAINT FK_StudentsExams_ExamID FOREIGN KEY(ExamID) REFERENCES Exams(ExamID)

	/*4.	Self-Referencing 
Create one table and use appropriate data types.
Insert the data from the example above and add primary keys and foreign keys. The foreign key should be between ManagerId and TeacherId.*/

CREATE TABLE Teachers
(
TeacherID INT NOT NULL,
[Name] NVARCHAR(150) NOT NULL,
ManagerID INT
)


INSERT INTO Teachers (TeacherID, Name, ManagerID)
VALUES
    (101, 'John', NULL),
    (102, 'Maya', 106),
    (103, 'Silvia', 106),
    (104, 'Ted', 105),
    (105, 'Mark', 101),
    (106, 'Greta', 101);


	ALTER TABLE Teachers
	ADD CONSTRAINT PK_TeacherID 
	PRIMARY KEY (TeacherID)

	ALTER TABLE Teachers
	ADD CONSTRAINT FK_ManagerID
	FOREIGN KEY (ManagerID) 
	REFERENCES Teachers(TeacherID)


	/*5.	Online Store Database*/

	CREATE TABLE Orders
	(
	OrderID INT NOT NULL,
	CustomerID INT NOT NULL
	)

		CREATE TABLE Customers
	(
	CustomerID INT NOT NULL,
	[Name] NVARCHAR(150) NOT NULL,
	Birthday DATE,
	CityID INT NOT NULL
	)

		CREATE TABLE Cities
	(
	CityID INT NOT NULL,
	[Name] NVARCHAR(150) NOT NULL
	)

	CREATE TABLE OrderItems
	(
	OrderID INT NOT NULL,
	ItemID INT NOT NULL 
	)

		CREATE TABLE Items
	(
	ItemID INT NOT NULL,
	[Name] NVARCHAR(150) NOT NULL,
	ItemTypeID INT NOT NULL
	)
	

		CREATE TABLE ItemTypes
	(
	ItemTypeID INT NOT NULL ,
	[Name] NVARCHAR(150) NOT NULL
	)

	
	ALTER TABLE Orders
	ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID)

	ALTER TABLE Customers
	ADD CONSTRAINT PK_Customers PRIMARY KEY (CustomerID)

	ALTER TABLE  Orders
	ADD CONSTRAINT FK_CustomerID
	FOREIGN KEY (CustomerID) 
	REFERENCES Customers(CustomerID)

	ALTER TABLE Cities
	ADD CONSTRAINT PK_Cities PRIMARY KEY (CityID)

	
	ALTER TABLE  Customers
	ADD CONSTRAINT FK_CityID
	FOREIGN KEY (CityID) 
	REFERENCES Cities(CityID)

	ALTER TABLE Items
	ADD CONSTRAINT PK_Items PRIMARY KEY (ItemID)

		ALTER TABLE ItemTypes
	ADD CONSTRAINT PK_ItemTypes PRIMARY KEY (ItemTypeID)

		ALTER TABLE Items
	ADD CONSTRAINT FK_ItemTypesID
	FOREIGN KEY (ItemTypeID) 
	REFERENCES ItemTypes(ItemTypeID)

	ALTER TABLE OrderItems
	ADD CONSTRAINT PK_OrderID_ItemID 
	PRIMARY KEY(OrderID, ItemID)

	
	ALTER TABLE  OrderItems
	ADD CONSTRAINT FK_OrderID
	FOREIGN KEY (OrderID) 
	REFERENCES Orders(OrderID)

	ALTER TABLE OrderItems
	ADD CONSTRAINT FK_ItemsID
	FOREIGN KEY (ItemID) 
	REFERENCES Items(ItemID)



	/*6.	University Database
Create a new database and design the following structure: */


CREATE TABLE Majors
(
MajorID		INT NOT NULL,
[Name]		NVARCHAR(150),
CONSTRAINT PK_Majors PRIMARY KEY (MajorID)
)

CREATE TABLE Students
(
StudentID		INT NOT NULL, 
StudentNumber	INT,
StudentName		NVARCHAR(100),
MajorID			INT ,
CONSTRAINT PK_Sudents PRIMARY KEY (StudentID),
CONSTRAINT FK_Students_Majors FOREIGN KEY(MajorID)
REFERENCES Majors(MajorID)
)

CREATE TABLE Payments
(
PaymentID		INT NOT NULL,
PaymentDate		DATE,
PaymentAmount	DECIMAL(10,2) NOT NULL,
StudentID		INT NOT NULL,
CONSTRAINT PK_Payments PRIMARY KEY(PaymentID),
CONSTRAINT FK_Payments_Students FOREIGN KEY(StudentID) 
REFERENCES Students(StudentID)
)

CREATE TABLE Subjects
(
SubjectID INT NOT NULL ,
SubjectName NVARCHAR(150),
CONSTRAINT PK_Subjects PRIMARY KEY (SubjectID) 
)

CREATE TABLE Agenda
(
StudentID INT NOT NULL,
SubjectID INT NOT NULL,
PRIMARY KEY (StudentID,SubjectID),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
)

/*9.	*Peaks in Rila
Display all peaks for "Rila" mountain. Include:
�	MountainRange
�	PeakName
�	Elevation
Peaks should be sorted by elevation descending.*/

USE Geography


SELECT m.MountainRange, PeakName, Elevation
FROM Peaks AS p
JOIN Mountains AS m ON m.Id = p.MountainId
WHERE MountainId = (SELECT Id FROM Mountains 
					WHERE MountainRange = 'Rila')
ORDER BY Elevation DESC







