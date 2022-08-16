---1
CREATE DATABASE ScenarioDB

USE ScenarioDB

CREATE TABLE BOOK (
	BookID INT PRIMARY KEY,
	Title VARCHAR(50),
	Author VARCHAR(20),
	Isbn BIGINT UNIQUE NOT NULL,
	PublishedDate DATETIME
)
DROP TABLE Book
INSERT INTO BOOK VALUES(1,'My First SQL Book','Mary Parker',981483029127,'2012-02-22 12:08:17'),
						(2,'My Second SQL Book','John Mayer',857300923713,'1972-07-03 09:22:45'),
						(3,'My Third SQL Book','Cary Flint',523120967812,'2015-10-18 14:05:44')

SELECT * FROM Book

DELETE FROM Book

SELECT * FROM Book WHERE Author LIKE '%ER'
---2
CREATE TABLE Reviews (
	ID INT PRIMARY KEY,
	BID INT REFERENCES Book(BookID),
	ReviewerName VARCHAR(30),
	Content VARCHAR(30),
	Rating INT,
	PublishedDate DATETIME
)

INSERT INTO Reviews VALUES(1,1,'John Smith','My First Review',4,'2017-12-10 05:50:11'),
							(2,2,'John Smith','My Second Review',5,'2017-10-13 15:05:12'),
							(3,2,'Alice Walker','Another Review',1,'2017-10-22 23:47:10')

SELECT * FROM Reviews

SELECT b.Title,b.Author,r.ReviewerName FROM Book b JOIN Reviews r ON b.BookID = r.BID

---3
SELECT DISTINCT ReviewerName FROM Reviews WHERE ReviewerName IN (SELECT ReviewerName FROM Reviews GROUP BY ReviewerName HAVING COUNT(ReviewerName) > 1)

---4
CREATE TABLE CUSTOMER (
	CustID INT PRIMARY KEY,
	CustName VARCHAR(20),
	Age INT,
	Address VARCHAR(20),
	Salary FLOAT
)

INSERT INTO CUSTOMER VALUES(1,'Ramesh',32,'Ahmedabad',2000.00),
							(2,'Khilan',25,'Delhi',1500.00),
							(3,'Kaushik',23,'Kota',2000.00),
							(4,'Chaitali',25,'Mumbai',6500.00),
							(5,'Hardik',27,'Bhopal',8500.00),
							(6,'Komal',22,'MP',4500.00),
							(7,'Muffy',24,'Indore',10000.00)

SELECT * FROM CUSTOMER

SELECT CustName FROM CUSTOMER WHERE Address LIKE '%o%'

---5
CREATE TABLE Orders (
	OID INT PRIMARY KEY,
	Date DATETIME,
	CustomerID INT REFERENCES CUSTOMER(CustID),
	Amount INT 
)

INSERT INTO Orders VALUES(102,'2009-10-08 00:00:00',3,3000),
						(100,'2009-10-08 00:00:00',3,1500),
						(101,'2009-11-20 00:00:00',2,1560),
						(103,'2008-05-20 00:00:00',4,2060)

SELECT * FROM Orders

SELECT Date,COUNT(CustomerID) AS OrderPlaced FROM Orders JOIN CUSTOMER ON Orders.CustomerID = CUSTOMER.CustID WHERE COUNT(CustomerID) > 1 GROUP BY Date

SELECT o.Date,COUNT(DISTINCT o.CustomerID) AS TotalNoOfOrderPlaced FROM Orders o , CUSTOMER c WHERE o.CustomerID = c.CustID GROUP BY Date HAVING COUNT(CustomerID) > 1

---6
CREATE TABLE Employee (
	EmpID INT PRIMARY KEY,
	Ename VARCHAR(20),
	Age INT,
	Address VARCHAR(20),
	Salary FLOAT
)

INSERT INTO Employee VALUES(1,'Ramesh',32,'Ahmedabad',2000.00),
							(2,'Khilan',25,'Delhi',1500.00),
							(3,'Kaushik',23,'Kota',2000.00),
							(4,'Chaitali',25,'Mumbai',6500.00),
							(5,'Hardik',27,'Bhopal',8500.00),
							(6,'Komal',22,'MP',NULL),
							(7,'Muffy',24,'Indore',NULL)

SELECT LOWER(Ename) FROM Employee WHERE Salary is NULL

---7
CREATE TABLE Student (
	RegNo INT PRIMARY KEY,
	StudName VARCHAR(10),
	Age INT,
	Qualification VARCHAR(10),
	MobileNo BIGINT,
	MailID VARCHAR(30),
	Location VARCHAR(20),
	Gender CHAR(1)
)

INSERT INTO Student VALUES(2,'Sai',22,'B.E',9952836777,'Sai@gmail.com','Chennai','M'),
							(3,'Kumar',20,'BSC',7890125648,'Kumar@gmail.com','Madurai','M'),
							(4,'Selvi',22,'B.TECH',8904567342,'selvi@gmail.com','Selam','F'),
							(5,'Nisha',25,'M.E',7834672310,'Nisha@gmail.com','Theni','F'),
							(6,'SaiSaran',21,'B.A',7890345678,'saran@gmail.com','Madurai','F'),
							(7,'Tom',23,'BCA',8901234675,'Tom@gmail.com','Pune','M')

SELECT * FROM Student

SELECT Gender,COUNT(Gender) AS TOTAL_GENDER_COUNT FROM Student GROUP BY Gender

---8
CREATE TABLE CourseDetails (
	CourseID VARCHAR(10) PRIMARY KEY,
	CName VARCHAR(30),
	StartDate DATE,
	EndDate DATE,
	Fee INT
)

INSERT INTO CourseDetails VALUES('DN003','DotNet','2018-02-01','2018-02-28',15000),
								('DV004','DataVisualization','2018-03-01','2018-04-15',15000),
								('JA002','AdvancedJava','2018-01-02','2018-01-20',10000),
								('JC001','CoreJava','2018-01-02','2018-01-12',3000)

SELECT * FROM CourseDetails

CREATE TABLE CourseReg (
	RegisterNo INT REFERENCES Student(RegNo),
	CID VARCHAR(10) REFERENCES CourseDetails(CourseID),
	Batch CHAR(2)
)

INSERT INTO CourseReg VALUES(2,'DN003','FN'),
							(3,'DV004','AN'),
							(4,'JA002','FN'),
							(2,'JA002','AN'),
							(5,'JC001','FN')

SELECT * FROM CourseReg

SELECT Cd.CourseID,Cd.CName,COUNT(Cr.CID) AS StudentRegistered FROM CourseDetails cd , CourseReg Cr WHERE Cd.CourseID = Cr.CID AND Cd.StartDate BETWEEN '2018-01-02' AND '2018-02-28' GROUP BY Cd.CName,Cd.CourseID ORDER BY Cd.CourseID DESC

---9

CREATE TABLE tblCustomer (
	CustID INT PRIMARY KEY,
	FName VARCHAR(20),
	LName VARCHAR(20)
)

INSERT INTO tblCustomer VALUES(1,'George','Washington'),
								(2,'John','Adams'),
								(3,'Thomas','Jefferson'),
								(4,'James','Madison'),
								(5,'James','Monroe')

SELECT * FROM tblCustomer

CREATE TABLE tblOrders (
	orderID INT PRIMARY KEY,
	orderDate DATE,
	Amount FLOAT,
	CustomerID INT
)

DROP TABLE tblOrders

INSERT INTO tblOrders VALUES(1,'07/04/1776',234.56,1),
							(2,'03/14/1760',78.50,3),
							(3,'05/23/1784',124.00,2),
							(4,'09/03/1790',65.50,3),
							(5,'07/21/1795',25.50,10),
							(6,'11/27/1787',14.40,9)

SELECT * FROM tblOrders

SELECT c.Fname,c.Lname FROM tblCustomer c JOIN tblOrders o ON c.CustID = o.CustomerID GROUP BY c.Fname,c.LName HAVING COUNT(o.CustomerID) = 2

---10
SELECT StudName,UPPER(Location) AS Capitalize_Location FROM Student ORDER BY StudName DESC

---11


---12
SELECT cd.CName FROM CourseDetails cd , CourseReg cr , Student s WHERE cd.CourseID = cr.CID AND cr.RegisterNo = s.RegNo AND s.StudName = 'NISHA'