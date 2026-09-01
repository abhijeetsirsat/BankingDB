-- show databases
CREATE DATABASE BankingDB;
-- USE bankingdb;
CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    AccountCreationDate DATE
);
describe Customers;
select * from customers;

CREATE TABLE Accounts (
	AccountID INT,
	AccountType VARCHAR (20),
    Balance DECIMAL(10,2)
    );
    
describe Accounts;

CREATE TABLE Transactions (
	TransactionID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
 );
 DESCRIBE Transactions;
 
 CREATE TABLE Branches (
	BranchID INT,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200),
    BranchPhone VARCHAR(15)
);
describe Branches;

CREATE TABLE AccountBranches (
	AssignmentDate DATE 
);

CREATE TABLE Loans (
	LoanID INT,
    LoanAmount DECIMAL(10,2),
    IntrestRate DECIMAL(5,2),
    StartDate DATE,
	EndDate DATE
);
describe Loans;

ALTER TABLE Customers
ADD DateOfBirth Date;
Describe Customers;

ALTER TABLE Customers
MODIFY Phone VARCHAR(20);
DESCRIBE Customers;

ALTER TABLE Accounts 
ADD CONSTRAINT chk_MiniBalance
CHECK (Balance >= 1000);
DESCRIBE Accounts;

DROP TABLE AccountBranches;

ALTER TABLE Accounts 
ADD CustomerID INT;

DESCRIBE Accounts;

ALTER TABLE Accounts 
ADD CONSTRAINT FK_Accounts_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

DESCRIBE Accounts;

ALTER TABLE Accounts
ADD CONSTRAINT 
PRIMARY KEY(AccountID);

DESCRIBE Accounts;

ALTER TABLE Customers
MODIFY FirstName VARCHAR(50) NOT NULL;

DESCRIBE Customers;

ALTER TABLE Customers
ADD CONSTRAINT uq_Email UNIQUE(Email); 

DESCRIBE Customers;

ALTER TABLE Branches
ADD CONSTRAINT 
PRIMARY KEY(BranchID);

Describe Branches;

ALTER TABLE Accounts
ADD BranchID int;

Describe accounts;

ALTER TABLE Accounts
ADD CONSTRAINT FK_Branch_Customers
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);

Describe Accounts;

ALTER TABLE Transactions
ADD CustomerID INT;

desc transactions;

ALTER TABLE Transactions
DROP COLUMN CustomerID;

ALTER TABLE Transactions
ADD AccountID INT;
desc transactions;

ALTER TABLE Transactions
DROP COLUMN AccountID;

ALTER TABLE Transactions;

SELECT 
	CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'bankingdb'
AND TABLE_NAME = 'Accounts';
    
ALTER TABLE Transactions
modify TransactionID INT PRIMARY KEY;

ALTER TABLE Transactions
ADD AccountID INT;

ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_Accounts
FOREIGN KEY (AccountID)
REFERENCES Accounts(AccountID);

ALTER TABLE Loans
ADD CONSTRAINT PK_Loans
PRIMARY KEY(LoanID);

ALTER TABLE Loans
ADD CustomerID INT;

ALTER TABLE Loans
ADD CONSTRAINT FK_Loans_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

desc Loans;

-- normalization and dinormalization important foe the interwiews
-- Normalizaton is the process of removing duplicates data from table
-- divide large table to small table 

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES
(101,'Rahul','Sharma','rahul@gmail.com','9876543210','1998-04-15');

SELECT * FROM Customers;

SELECT * FROM Customers;

INSERT INTO Customers
VALUES
(102,'Ketan','Tiwari','ketan@gmail.com','8838938284','2026-08-04','2000-06-22');

SELECT * FROM Customers;

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, AccountCreationDate, DateOfBirth)
VALUES
(103,'Neha','Singh','neha@gmail.com','9277476727','2026-08-03','1992-07-03'),
(104,'Mukul','Jha','mukul@gmail.com','7929267534','2025-02-01','1995-11-06');

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, AccountCreationDate, DateOfBirth)
VALUES
(105,'Avinash','Mishra','avinash@gmail.com','9238938284','2026-03-08','2000-08-27');

SELECT * FROM Customers;

-- FOR UPDATE IN COLUMNS
UPDATE Customers 
SET 
    AccountCreationDate = '2025-06-29'
WHERE
    CustomerID = '101';

SELECT * FROM Customers;

INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance)
VALUES 
(201,101,'Savings',25000);

SELECT * FROM Accounts;

INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance, BranchID)
VALUES 
(202,102,'Savings','30000','302'),
(203,103,'Current','35000','303'),
(204,104,'Current','40000','304');

INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance, BranchID)
VALUES
(205,105,'Current','50000','305');

SELECT * FROM Accounts;

UPDATE Accounts
SET 
	BranchID = '301'
WHERE
    AccountID = '201';
    
SELECT * FROM Accounts;

INSERT INTO branches
(BranchID, BranchName, BranchAddress, BranchPhone)
VALUES
(301,'Central Branch','Sitabuldi,Nagpur','9876543210'),
(302,'City Branch','Dharampeth,Nagpur','9123456780'),
(303,'Lake View Branch','Ambazari,Nagpur','9988776655'),
(304,'East Branch','Manewada,Nagpur','9012345678');

INSERT INTO branches
(BranchID, BranchName, BranchAddress, BranchPhone)
VALUES
(305,'Vest Branch','Besa,Nagpur','9876543210');

SELECT * FROM branches;

INSERT INTO Transactions
(TransactionID,TransactionDate,Amount,TransactionType,AccountID)
VALUES 
(401, '2026-08-01', 5000.00, 'Deposit', '201'),
(402, '2026-08-08', 1200.00, 'Withdrawal', '202'),
(403, '2026-08-15', 2500.00, 'Deposit', '203'),
(404, '2026-08-20', 800.00, 'Withdrawal', '204');

INSERT INTO Transactions
(TransactionID,TransactionDate,Amount,TransactionType,AccountID)
VALUES 
(405, '2026-08-01', 5000.00, 'Deposit', '205');

SELECT * FROM Transactions;

INSERT INTO Loans
(LoanID, LoanAmount, IntrestRate, StartDate, EndDate, CustomerID)
VALUES
(501, 100000.00, 2.50, '2026-01-15', '2029-01-15', '101'),
(502, 250000.00, 3.25, '2026-02-10', '2031-02-10', '102'),
(503, 500000.00, 4.10, '2026-03-05', '2036-03-05', '103'),
(504, 150000.00, 5.75, '2026-04-20', '2030-04-20', '104');

INSERT INTO Loans
(LoanID, LoanAmount, IntrestRate, StartDate, EndDate, CustomerID)
VALUES
(505, 900000.00, 1.50, '2026-01-21', '2029-01-19', '105');

SELECT * FROM Loans;

-- for delete report or row
-- DELETE FROM Loans
-- WHERE LoanID = 302;

UPDATE Accounts 
SET 
    Balance = 35000
WHERE
    CustomerID = 101;
    
SELECT * FROM Accounts;
SELECT * FROM Loans;
SELECT * FROM Transactions;
SELECT * FROM Customers;

UPDATE Accounts 
SET 
    Balance = Balance + 2000
WHERE
    CustomerID = 102;
    
    UPDATE Customers 
SET 
    Email = 'rahulsharma@gmail.com',
    Phone = '7372748274'
WHERE
    CustomerID = 101;

SELECT 
    CustomerID, FirstName, LastName, Phone
FROM
    Customers;
    
SELECT * FROM Accounts
WHERE AccountType = 'Savings';
    
SELECT * FROM Accounts
WHERE Balance > 30000;
    
SELECT * FROM Accounts
WHERE AccountType != 'Savings';

SELECT * FROM Accounts
WHERE AccountType = 'Savings' AND Balance >=30000;

SELECT * FROM Accounts
WHERE AccountType = 'Savings' OR Balance >=30000;

SELECT * FROM Accounts
WHERE NOT AccountType = 'Savings';

-- FIND ALL CUSTOMERS REGISTERED AFTER 11JULY2026
SELECT * FROM Customers
WHERE AccountCreationDate > '2026-03-08';

-- USING IN 
SELECT firstname,lastname,phone
FROM Customers
WHERE Phone IN (7372748274,7929267534,9238938284);

-- same output using OR
SELECT firstname,lastname,phone
FROM Customers
WHERE Phone = '7372748274' OR Phone = '7929267534' OR Phone = '9238938284';

-- BETTWEEN OPERATORS

-- FIND CUSTOMERS HAVING BALANCE BRTWEEN 30000 TO 40000
SELECT * FROM Accounts
WHERE Balance BETWEEN  '30000' AND '40000';
-- The values specified in the range are including in the results.

-- using AND
SELECT * FROM Accounts
WHERE Balance >=30000 AND balance <=40000;

--    LIKE OPERATOR
-- find all customers whole first name starts from with letter 'k'
-- % matches any number of character and even zero character
-- "-" exactly match one character


SELECT * FROM Customers
WHERE FirstName LIKE 'k%';

SELECT * FROM Accounts;
SELECT * FROM Loans;
SELECT * FROM Transactions;
SELECT * FROM Customers;

-- find all customers whole Last name starts from with letter 'a'
SELECT * FROM Customers
WHERE LastName LIKE '%a';

-- find all customers whole last name has exackly 3 characters.

SELECT * FROM Customers
WHERE LastName LIKE '___';


-- ORDER BY CAUSE 
-- SORT THE ACCOUNTS TABLE ACCORDNG THE TABLE BALANCE

SELECT CustomerID,Balance 
FROM Accounts
ORDER BY Balance;

-- SORT THE BRANCHES TABLE ACCORDNG THE TABLE BRANCHNAME

SELECT BranchID,BranchName
FROM Branches
ORDER BY BranchName;

-- SORT THE ACCOUNT TABLE ACCORDNG THE CUSTOMER BALANCE FROM HIGHEST TO LOWEST

SELECT AccountID,Balance
FROM Accounts
ORDER BY Balance DESC;

-- SORT ACCORDING TO MULTIPLE COLUMN 
-- SORT ACCOUNTS TABLE ACCORDING TO THE ACCOUNTYPE AND BALNCE

SELECT AccountID,AccountType,Balance,CustomerID
FROM Accounts
ORDER BY AccountType DESC, Balance DESC;

-- DISTINCT CLAUSE
-- FIND THE DISTINCT (QUNIQUE) ACCOUNTS TYPES FROM ACCOUNT TABLE 

SELECT DISTINCT AccountType
FROM Accounts;

-- FIND THE DISTINCT (QUNIQUE) TRANSACTION TYPES AND ACCOUNTID
-- FROM TRANSACTIONS TABLE

SELECT DISTINCT TransactionType,AccountID
FROM Transactions;

-- USING LIMIT
SELECT * FROM  TRANSACTIONS
LIMIT 2;

-- USING LIMIT AND OFFSET
SELECT * FROM  TRANSACTIONS
LIMIT 2 OFFSET 2;

-- TO SHOW TO HIGHEST BALANCE BY LIMIT
SELECT * FROM  Accounts
ORDER BY Balance DESC
LIMIT 2;

-- 2 - ROWS TO SKIP , 1 - ROWS TO RETURNS
SELECT * FROM  Accounts
ORDER BY Balance DESC
LIMIT 2,1;  -- 2 - ROWS TO SKIP , 1 - ROWS TO RETURNS

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, AccountCreationDate, DateOfBirth)
VALUES
(106,'Priya','Mehta','priya@gmail.com',NULL,'2026-05-08','1991-07-016'),
(107,'Rohan','Shinde','rohan@gmail.com',NULL,'2025-04-09','1996-06-09'),
(108,'Om','Supare','om@gmail.com','9429267658','2025-03-07','1996-04-08');

SELECT * FROM Customers;

-- USING IS NOT -- IS RETURN NOT PHONE NUMBERS AVAILABLE 
SELECT * FROM Customers
WHERE Phone IS NULL;

-- USING IS NOT NULL -- IT RETURN ALL PHONE NUMBERS IS AVAILABLE
SELECT * FROM Customers
WHERE Phone IS NOT NULL;

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, AccountCreationDate, DateOfBirth)
VALUES
(109,'Ayush','Singh','ayush@gmail.com','9898765436','2025-05-09','1991-08-015');

INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance, BranchID)
VALUES 
(206,106,'Savings','60000','301'),
(207,107,'Current','55000','302'),
(208,108,'Current','63000','303'),
(209,109,'Current','91000','304');
Select * from accounts;

SELECT * 
FROM Accounts;
INSERT INTO Transactions
(TransactionID,TransactionDate,Amount,TransactionType,AccountID)
VALUES 
(406, '2026-07-05', 6000.00, 'Deposit', '206'),
(407, '2026-05-09', 5400.00, 'Withdrawal', '207'),
(408, '2026-05-17', 4500.00, 'Deposit', '208'),
(409, '2026-05-13', 7500.00, 'Withdrawal', '209');
select * from transactions;

INSERT INTO Loans
(LoanID, LoanAmount, IntrestRate, StartDate, EndDate, CustomerID)
VALUES
(506, 120000.00, 2.50, '2026-01-12', '2029-01-11', '106'),
(507, 170000.00, 3.25, '2026-02-09', '2031-02-03', '107'),
(508, 240000.00, 4.10, '2026-03-04', '2036-03-04', '108'),
(509, 320000.00, 5.75, '2026-04-17', '2030-04-16', '109');
select * from loans;

-- CASE STATEMENT...************************************************************************************
-- USED TO APPLY CONDTIONAL LOGIC
-- USING CASE STATEMENT

SELECT
AccountID,
AccountType,
Balance,
CASE
	WHEN Balance >= 50000 THEN 'High Value Customer'
    ELSE 'Low Value'
END AS Category
FROM Accounts;

-- HOMEWORK
-- Q.1) Display the CustomerID, FirstName and Email of customers whose AccountCreationDate is after 1-Jan-2025.

SELECT * FROM Customers
WHERE AccountCreationDate > '2025-01-01';

-- Q.2) Display all Savings accounts having balance greater than ₹20,000.

SELECT * FROM Accounts
WHERE AccountType ='Savings' AND Balance > 20000;

-- Q.3) Display customers whose Phone number is NOT NULL.

SELECT * FROM Customers
WHERE Phone IS NOT NULL;

-- Q.4) Display distinct Account Types available in the Accounts table.

SELECT DISTINCT AccountType
FROM Accounts;

-- Q.5) Display customers whose FirstName starts with 'R'.

SELECT * FROM Customers
WHERE FirstName LIKE 'R%';

-- Level 2 (Medium)
-- Q.1) Display Savings accounts having balance between ₹20,000 and ₹80,000.

SELECT * FROM Accounts
WHERE Balance BETWEEN  '20000' AND '80000';

-- Q.2) Display customer names whose phone number is NULL and account was created after 2025-01-01.

SELECT * FROM Customers
WHERE Phone IS NULL AND  AccountCreationDate >2025-01-01;

-- Q.3) Display all customers whose FirstName starts with 'A' OR LastName starts with 'S'.

SELECT * FROM Customers
WHERE FirstName LIKE 'A%' OR LastName Like 'S%';

-- Q.4) Display all accounts whose AccountType is Savings or Salary and balance is greater than ₹10,000.

SELECT * FROM Accounts
WHERE AccountType ='Savings' AND Balance > 10000;

-- Q.5) Display customers whose CustomerID is IN (101,102,105,109) and phone number is not NULL.

SELECT * FROM Customers
WHERE  CustomerID IN (101,102,105,109) AND Phone IS NOT NULL;

-- Level 3 (Intermediate)
-- Q.1) Display customers whose FirstName starts with 'P' and Phone IS NULL.

SELECT * FROM Customers
WHERE FirstName LIKE 'P%' AND Phone IS NULL;

-- Q.2) Display accounts whose balance is NOT BETWEEN ₹20,000 and ₹50,000.

SELECT * FROM Accounts
WHERE Balance NOT BETWEEN  '20000' AND '50000';

-- Q.3) Display customers whose CustomerID is NOT IN (101,102,103).

SELECT * FROM Customers
WHERE  CustomerID NOT IN (101,102,103);

-- Q.4) Display transactions that are Withdrawal and amount is less than ₹5000.

SELECT * FROM Transactions
WHERE TransactionType ='Withdrawal' AND Amount < 5000;

-- Q.5) Display customers whose email ends with gmail.com and phone number is available.

SELECT * FROM customers
WHERE Email LIKE '%gmail.com'
AND Phone IS NOT NULL;

-- Level 4 (Advanced Filtering)

-- Q.1) Display customer names whose phone number is NULL OR email starts with s.

SELECT FirstName, LastName
FROM customers
WHERE Phone IS NULL OR Email LIKE 's%';

-- Q.2) Display Savings accounts having balance greater than ₹10,000 AND belonging to Branch 1 ?

SELECT * FROM accounts
WHERE AccountType = 'Savings' AND Balance > 10000 AND BranchID = 1;

-- Q.3) Display Current accounts having balance between ₹40,000 and ₹1,00,000 

SELECT * FROM accounts
WHERE AccountType = 'Current' AND Balance BETWEEN 40000 AND 100000;

-- Q.4) Display customers whose last name starts with S and were AccountCreationDate after 2024

SELECT * FROM customers
WHERE LastName LIKE 'S%' AND AccountCreationDate > '2024-01-01'; 

-- q.5) Display transactions whose amount is IN (2000,3000,5000,7000)

SELECT * FROM transactions
WHERE Amount IN (2000, 3000, 5000, 7000);

-- Level 5 (Challenge Questions)
-- q.1) Display first 5 customers whose FirstName starts with A or R, ordered by CustomerID

SELECT * FROM customers
WHERE FirstName LIKE 'A%' OR FirstName LIKE 'R%'
ORDER BY CustomerID LIMIT 5;

-- Q.2) Display Savings and Salary accounts whose balance is greater than ₹15,000 and less than ₹60,000.
SELECT * FROM accounts
WHERE AccountType IN ('Savings', 'Salary') AND Balance > 15000 AND Balance < 60000;

-- Q.3) Display customers whose CustomerID is IN (101,103,105,107,109) and DateOfBirth is between 1994 and 2000

SELECT * FROM customers
WHERE CustomerID IN (101, 103, 105, 107, 109) AND DateOfBirth BETWEEN '1994-01-01' AND '2000-12-31';

-- Q.4) Display transactions whose amount is greater than ₹2000 but less than ₹8000 and TransactionType is not Withdrawal.

SELECT * FROM transactions
WHERE Amount > 2000 AND Amount < 8000 AND TransactionType <> 'Withdrawal';

-- Q.5) Display customers whose phone number is NULL or FirstName contains 'an'

SELECT * FROM customers
WHERE Phone IS NULL OR FirstName LIKE '%an%';

-- Tricky Level 1
-- Q.1) Display all customers whose first name starts with 'R' or 'S' but whose phone number is NULL.

SELECT * FROM customers
WHERE FirstName LIKE 'R%' OR FirstName LIKE 'S%' AND Phone IS NULL;

-- Q.2) Display all accounts that are not Savings accounts and have a balance greater than ₹30,000.

SELECT * FROM accounts
WHERE AccountType <> 'Savings' AND Balance > 30000;

-- Q.3) Display customers whose CustomerID is not 101, 102, or 103.

SELECT * FROM customers
WHERE CustomerID NOT IN (101, 102, 103);

-- Q.4) Display customers whose email does not end with "gmail.com"

SELECT * FROM customers
WHERE Email NOT LIKE '%gmail.com';

-- Q.5) Display accounts whose balance is not between ₹20,000 and ₹50,000.

SELECT * FROM accounts
WHERE Balance NOT BETWEEN 20000 AND 50000;

-- Tricky Level 2
-- Q.1) Display customers whose CustomerID is between 101 and 110 but not equal to 105 or 108.

SELECT * FROM customers
WHERE CustomerID BETWEEN 101 AND 110 AND CustomerID NOT IN (105, 108);

-- Q.2) Display transactions whose amount is greater than ₹2000 but not equal to ₹5000

SELECT * FROM transactions
WHERE Amount > 2000 AND Amount <> 5000;

-- Q.3) Display customers whose last name starts with 'S' and email contains gmail but phone number is NULL

SELECT * FROM customers
WHERE LastName LIKE 'S%' AND Email LIKE '%gmail%' AND Phone IS NULL;

-- Q.4) Display accounts having balance between ₹15,000 and ₹60,000 but not belonging to Branch 2.

SELECT * FROM accounts
WHERE Balance BETWEEN 15000 AND 60000 AND BranchID <> 2;

-- Q.5) Display customers whose FirstName starts with 'P' or ends with 't'

SELECT * FROM customers
WHERE FirstName LIKE 'P%' OR FirstName LIKE '%t';

-- Tricky Level 3 (Logical Confusion)
-- Q.1) Display all Savings accounts having balance greater than ₹20,000 OR belonging to Branch 1

SELECT * FROM accounts
WHERE AccountType = 'Savings' AND Balance > 20000 OR BranchID = 1;

-- Q.2) Display all customers whose phone is NULL OR email contains gmail.

SELECT * FROM customers
WHERE Phone IS NULL OR Email LIKE '%gmail%';

-- Q.3) Display customers whose FirstName starts with 'A' or 'R' and whose CustomerID is greater than 105

SELECT * FROM customers
WHERE (FirstName LIKE 'A%' OR FirstName LIKE 'R%') AND CustomerID > 105;

-- Q.4) Display customers whose CustomerID is NOT IN (101,103,105) and phone number is NOT NULL

SELECT * FROM customers
WHERE CustomerID NOT IN (101, 103, 105) AND Phone IS NOT NULL;

-- Q.5) Display accounts whose balance is less than ₹10,000 OR greater than ₹80,000.

SELECT * FROM accounts
WHERE Balance < 10000 OR Balance > 80000;

-- USING CASE STATEMENT..**************************************************************************************************

-- CATEGORIZE THE DEPOSITE IN THE TRANSACTIONS TABKL PER CONDITIONS GIVEN
-- IF ABOVE 10000(INCLUDE) HIGH AMOUNT
-- IF 5000(INCLUDE)TO 10000 MEDIUM AMOUNT
-- IF UPTO 5000 LOW AMOUNT
-- FOR TRANSACTIONS TYPE WITHDRAWAL"NOT APPLICABLE"


SELECT
AccountID,
AccountType,
Balance,
CASE
	WHEN Balance >= 50000 THEN 'High Value Customer'
    ELSE 'Low Value'
END AS Category
FROM Accounts;

SELECT 
    * ,
CASE 
WHEN TransactionType = 'Deposit' AND Amount >10000 THEN 'HIGH AMOUNT'
WHEN TransactionType = 'Deposit' AND Amount >= 5000 THEN 'MEDIUM AMOUNT'
WHEN TransactionType = 'Deposit' AND Amount < 5000 THEN 'LOW AMOUNT'
ELSE 'NOT APPLICABLE'
END AS'Transactions Profile'
FROM Transactions;

-- USING UPPER CASE...************************************************************************************

SELECT CustomerID, upper (FirstName), upper (LastName)
From Customers;

-- USING LOWE CASE...************************************************************************************

SELECT CustomerID, LOWER (FirstName), LOWER (LastName)
From Customers;

-- USING LENGTH CASE...************************************************************************************

SELECT LastName, LENGTH (LastName)
From Customers;

SELECT length("नागपूर"); -- GIVES OUTPUT IN NOMBER OF BYTES
SELECT length("NAGPUR"); -- GIVES OUTPUT IN NOMBER OF BYTES
SELECT char_length("NAGPUR"); -- GIVES OP IN NUMBER OF CHARACTERS
SELECT char_length("नागपूर"); -- GIVES OP IN NUMBER OF CHARACTERS
-- " AS " use for change the column name

-- CONCAT function...************************************************************************************

SELECT concat( " OM", " ","SUPARE") AS NAME;

SELECT concat(firstname, " ", lastname) AS fullname,phone from customers;

-- SUBSTRING () FUNCTION...************************************************************************************

SELECT substring("HELLO WORLD",1,5);

SELECT CustomerID, concat(substring(firstname,1,1),".",lastname)AS FULLNAME,Phone from customers;

-- TRIM FUNCTION ...************************************************************************************
-- trim remove extra spaces 
-- SELECT TRIM (username)
-- FROM user

SELECT length("HELLO WORLD"); -- without trim function
SELECT length(TRIM("  HELLO WORLD  ")); -- with trim function
SELECT length(TRIM(SUBSTRING("HELLO WORLD",6))); -- WITH TRIM AND SUBSTRING

-- REPLACE () FUNCTION...************************************************************************************
--  case sensitive
SELECT replace("Mat","M","C");

-- MATH BUILT-IN FUNCTION..**************************************************************************************************

-- AVG FUNCTION
SELECT avg(Balance) from accounts
WHERE AccountType = "Savings";

-- using round Function
SELECT round(avg(Balance),2) from accounts
WHERE AccountType = "Savings";

-- CEIL () OR CEILING FUNCTION
-- CEIL Always return integer values AND give higher value

SELECT ceil(avg(Balance)) from accounts
WHERE AccountType = "Savings";

-- FLOOR () FUNCTION

SELECT floor(avg(Balance)) from accounts
WHERE AccountType = "Savings";

-- ABSOLUTE () FUNCTION
-- IT Removes the signs
SELECT abs(-3656); -- IT Removes the signs
SELECT abs(-1.35); -- IT Removes the signs

-- MOD VALUE 
-- IT RETURNS REMAINDER UFTER DIVISION
SELECT (7/3); -- NORMAL DIVISION
SELECT mod(7,3); -- MOD DIVISION .... IT RETURN REMAINDER VALUE

-- POWER () 

SELECT power(2,3);
SELECT power(1.5,3);

-- SQUAREROOT ()..**************************************************************************************************

SELECT sqrt(9);
SELECT sqrt(124);

-- DATE FUNCTION 
-- NOW() FUNCTION
SELECT now();

-- CURTDATE FUNCTION
SELECT curdate();

-- CURTIME FUNCTION
SELECT curtime();

-- YEAR() MONTH() DATE()..**************************************************************************************************

SELECT DateOfBirth, year(Dateofbirth)AS YEAR,month(dateofbirth)AS MONTH,day(dateofbirth)AS DATE
from customers;

-- DATEDIFF() 
SELECT concat(firstname, " ", lastname) AS fullname,dateofbirth,
floor(datediff(curdate(),dateofbirth)/365) as age from customers;

-- DATE ADD function..**************************************************************************************************

SELECT concat(firstname, " ", lastname) AS fullname,AccountCreationDate,
date_add(AccountCreationDate,interval 1 year) as KYCRenual from customers;

-- 7.38  time aggrigate functions , count time 7.39 , MAX 8.04  GROUP BY 8.30

-- AGGRIGATE FUNCTION ..................................................................................................

-- COUNT () FUNCTION .... Count rows ..**************************************************************************************************

SELECT count(*) AS TotalCustomers FROM customers; -- count rows
SELECT count(Phone) AS TotalCustomers FROM customers; -- it skip the null values rows and return output

-- SUM () FUNCTION..**************************************************************************************************

SELECT sum(Balance) AS TotalBalance from Accounts;
SELECT sum(Balance) AS SavingBalance from Accounts where AccountType = "Savings";
SELECT sum(Balance) AS SavingBalance from Accounts where AccountType = "Current";

-- AVG () FUNCTION..**************************************************************************************************

SELECT avg(Amount) AS AverageAmount FROM transactions;
SELECT avg(Amount) AS AverageAmountDeposit FROM transactions WHERE transactiontype = "Deposit";
SELECT avg(Amount) AS AverageAmountWithdrawal FROM transactions WHERE transactiontype = "Withdrawal";

-- MAX () AND MIN () FUNCTION...**************************************************************************************************
-- find maximum balace in savings account
SELECT max(Balance) as MaxBalance from Accounts where AccountType = "Savings";

-- find minimum balace in savings account
SELECT min(Balance) as MaxBalance from Accounts where AccountType = "Savings";

-- GROUP BY () FUNCTION....********************************************************************************************************

SELECT transactiontype, sum(amount) from transactions
group by (TransactionType);

SELECT *FROM accounts;

SELECT AccountType, count(AccountType),
sum(Balance),
avg(Balance) 
from accounts 
group by (AccountType);

SELECT branchid,AccountType,
count(*)
From accounts
group by BranchID,AccountType
order by BranchID;

-- HAVING...**************************************************************************************************************

SELECT branchid,AccountType,
count(*)
From accounts
group by BranchID,AccountType
having count(*) >= 2;

SELECT * FROM loans
WHERE LoanID = 506;

DELETE FROM loans
WHERE LoanID = 509;

SELECT branchid,AccountType,
count(*)
From accounts
group by BranchID,AccountType
having count(*) >= 2; -- AND AccountType = "Savings";
select * from customers;

-- Find Number Of Customers Specific Years From Customers
SELECT year(AccountCreationDate) As Years, count(*) as NoOfAccounts
from customers
group by year(AccountCreationDate)
order by years;

-- JOINS..*****************************************************************************************************************
-- A join combines a relaated rows from different tables based on a column 

-- inner joins ...**********************************************************************************************************
-- defination : matches rows that exist in both tables

select * from loans;
select * from accounts;
select * from branches;
select * from customers;

select c.CustomerID,c.FirstName,c.LastName,l.LoanAmount,l.IntrestRate
FROM Customers c
INNER JOIN loans l
on 
c.CustomerID = L.customerID; 

-- find the branch name for all the accountid's savepoint
-- include accountid, accounttype, and brnchname, branchddress.

select a.accountid,a.accounttype,b.branchname,b.branchaddress
from accounts a
inner join branches b
on b.branchid = a.branchid
where AccountType = 'savings';

-- find all the cusomers(name,phone) where transactions (accounttype,balance) is deposit

select c.firstname,c.lastname,c.phone,a.accounttype,a.balance
from customers c
inner join accounts	a
on c.customerid = a.customerid
where accounttype = 'savings';

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, AccountCreationDate, DateOfBirth)
VALUES
(110,'Aditya','Gaydhane','aditya@gmail.com','9954868435','2026-05-08','1999-09-019'),
(111,'Suhas','Rajput','suhas@gmail.com',NULL,'2025-04-09','1995-02-05'),
(112,'Sarthak','Kamble','sarthak@gmail.com','9429265678','2022-03-07','1993-01-03');

select * from customers;
select * from accounts;

-- LEFT JOIN *************************** DATE : 18-08-2026.........................****************************************
-- RETURN all rows from the left table amd matches rows from the right

select c.firstname,c.lastname,c.phone,a.accounttype,a.balance
from customers c
left join accounts a
on c.CustomerID = a.CustomerID;

select c.firstname,c.lastname,c.phone,a.accounttype,a.balance
from  accounts a
left join customers c
on c.CustomerID = a.CustomerID;

INSERT INTO branches
(BranchID, BranchName, BranchAddress, BranchPhone)
VALUES
(306,'City Branch','Dharampeth,Nagpur','9876546578');

INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance, BranchID)
VALUES 
(210,110,'Savings','70000','306'),
(211,111,'Current','65000','305');

INSERT INTO Transactions
(TransactionID,TransactionDate,Amount,TransactionType,AccountID)
VALUES 
(410, '2026-06-01', 5000, 'Deposit', '201'),
(411, '2026-05-08', 12000, 'Withdrawal', '201'),
(412, '2026-07-15', 2000, 'Deposit', '202'),
(413, '2026-05-20', 8000, 'Withdrawal', '202'),
(414, '2026-03-15', 4000, 'Deposit', '203'),
(415, '2026-07-20', 3000, 'Withdrawal', '206'),
(416, '2026-08-15', 2500, 'Deposit', '204'),
(417, '2026-03-20', 4500, 'Withdrawal', '208'),
(418, '2026-09-15', 6500, 'Deposit', '204'),
(419, '2026-08-20', 5500, 'Withdrawal', '207'),
(420, '2026-02-20', 7500, 'Withdrawal', '205');

INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance, BranchID)
VALUES 
(212,101,'Current','70000','301'),
(213,103,'Savings','65000','301');

select * from accounts;
select * from transactions;

select c.CustomerID,a.accountid,concat(c.firstname," ",lastname) as Fullname, a.accounttype,a.balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
order by c.CustomerID;


-- RIGHT JOIN .....*************************************************************************************************************
-- 

-- Q.1) Display customers who do not have a Current account.

select a.AccountID,c.firstname,c.lastname
from customers c
inner join accounts	a
on c.customerid = a.customerid
where accounttype not in ("Current");

-- Q.2)  Display Customername,Accountcreation date,Accounttype,Balance for customers whose account was created in 2025.

select c.CustomerID,concat(c.firstname," ",c.lastname) as Fullname,c.accountcreationdate,a.accounttype,a.balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where year(accountCreationDate) =(2025);

-- Q.3) . Display:Customername,Accountcreation date,Accounttype and calculate the number of days since account creation.

Select c.CustomerID,concat(c.firstname," ",c.lastname) as Fullname,c.accountcreationdate,a.accounttype,
datediff(curdate(),accountcreationdate) as NoOfDays
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID;

select * from customers;
select * from accounts;

-- Q.4) Find the number of accounts held by each customer.

SELECT CustomerID,AccountType,
count(*)
From accounts
group by CustomerID,AccountType
order by CustomerID;

SELECT c.customerid,concat(c.firstname," ",c.lastname) AS fullname, COUNT(a.accountid) AS total_accounts
FROM customers c
left JOIN accounts a
ON c.customerid = a.customerid
GROUP BY c.customerid;

-- Q.5) Find the total balance held by each customer.

SELECT c.customerid,concat(c.firstname," ",c.lastname) AS fullname,sum(a.balance) as totalbalance
from customers c
left join accounts a
on c.CustomerID = a.customerid
GROUP BY c.customerid, fullname;

-- Q.6) find the number of customers for each account type.

SELECT a.accounttype,count(c.CustomerID) AS total_customer
FROM accounts a
left JOIN customers c
ON c.customerid = a.customerid
GROUP BY a.AccountType;

-- Q.7) Find the total balance for each account type.
SELECT AccountType,sum(balance) as totalbalance
from accounts
group by AccountType;

-- Q.8)  Find the highest balance held by each account type.

SELECT AccountType,max(balance) as highestbalance
from accounts
group by AccountType;

-- Q.9) Find the number of customers for each branch.

select BranchName,count(BranchID)
from branches
group by BranchName;

-- Q.10)  Find customers whose total account balance is greater than ₹40,000.

select c.customerid,sum(a.balance) as totalamount
from customers c 
inner join accounts a 
on c.CustomerID = a.CustomerID
group by c.CustomerID
having totalamount >40000;

select customerid,sum(balance) as totalbalance
from accounts
group by customerid
having totalbalance >40000;

-- Q.11) Find customers who have more than one account.

SELECT CustomerID,count(AccountID) as TotalAccounts
from accounts
group by CustomerID
HAVING TotalAccounts >=2; 

-- Q.12. Find customers who do not have an account

SELECT c.CustomerID,concat(c.firstname," ",c.lastname) as fullname
FROM Customers c
LEFT JOIN Accounts a 
ON c.CustomerID = a.CustomerID
WHERE a.AccountID IS NULL;

-- Q.13. Find customers who do not have any loan.

SELECT c.CustomerID,concat(c.firstname," ",c.lastname) as fullname
FROM Customers c
LEFT JOIN loans l 
ON c.CustomerID = l.CustomerID
WHERE l.loanid IS NULL;

-- Q.14. Find customers who have never performed a transaction.
SELECT c.CustomerID,a.accountid
from customers c
inner join accounts a 
on c.CustomerID = a.CustomerID;




select * from accounts;
select * from customers;
select * from loans;


-- Q.15) 15. Display all branches and their account count, including branches that have 1 or more accounts.

SELECT b.branchid,b.branchname,count(a.accountid) as totalaccount
from branches b
left join accounts a 
on b.branchid = a.branchid
group by branchid;

select * from accounts;

--  full outer join.........**************************************************************************  

-- joining Customers and acoounts

select * from customers c
left join accounts a 
on c.customerid = a.CustomerID
UNION
select * from customers c
right join accounts a 
on c.customerid = a.CustomerID;

-- cross join.............*********************************************************************************************

select * from customers c
cross join accounts a ;

-- SELF JOIN

CREATE TABLE Employees(
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(50) NOT NULL,
ManagerID INT,
Department VARCHAR(50),
Salary DECIMAL(10,2),
JoiningDate DATE,
BranchID INT,

FOREIGN KEY (ManagerID)
REFERENCES Employees(EmployeeID),

FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID)
);

SELECT * FROM employees;

INSERT INTO Employees
    (EmployeeID, EmployeeName, ManagerID, Department, Salary, JoiningDate, BranchID)
VALUES
    (1, 'Rajesh Sharma', NULL, 'Management', 120000.00, '2018-04-15', 301),
    (2, 'Priya Patel', 1, 'Human Resources', 75000.00, '2019-06-10', 302),
    (3, 'Amit Kumar', 1, 'Finance', 82000.00, '2020-01-20', 303),
    (4, 'Sneha Verma', 1, 'IT', 95000.00, '2019-09-05', 304),
    (5, 'Rahul Singh', 1, 'Sales', 78000.00, '2021-03-12', 305),
    (6, 'Neha Joshi', 2, 'Human Resources', 55000.00, '2021-07-19',301),
    (7, 'Vikas Gupta', 2, 'Human Resources', 52000.00, '2022-02-14',302),
    (8, 'Pooja Mehta', 3, 'Finance', 60000.00, '2021-11-08', 303),
    (9, 'Suresh Yadav', 3, 'Finance', 58000.00, '2022-05-16', 304),
    (10, 'Anjali Deshmukh', 4, 'IT', 72000.00, '2020-08-24', 305),
    (11, 'Rohan Kulkarni', 4, 'IT', 68000.00, '2021-10-11', 301),
    (12, 'Kavita Rao', 4, 'IT', 65000.00, '2022-01-17', 302),
    (13, 'Arjun Malhotra', 5, 'Sales', 57000.00, '2022-06-20', 303),
    (14, 'Meena Shah', 5, 'Sales', 59000.00, '2021-12-06', 304),
    (15, 'Deepak Thakur', 5, 'Sales', 54000.00, '2023-01-09', 305),
    (16, 'Nitin Pawar', 6, 'Human Resources', 42000.00, '2023-04-18', 301),
    (17, 'Swati Mishra', 7, 'Human Resources', 40000.00, '2023-07-03', 302),
    (18, 'Manish Jain', 8, 'Finance', 45000.00, '2023-02-27', 303),
    (19, 'Komal Sinha', 9, 'Finance', 43000.00, '2023-08-14',304),
    (20, 'Akash Bansal', 10, 'IT', 50000.00, '2023-05-22',305);

SELECT * FROM branches;

SELECT e.employeeid,e.EmployeeName AS EmployeeName,m.EmployeeName as ManagerName
FROM Employees e
left JOIN Employees m
on e.Managerid = m.employeeid; 

-- Including Branch Name Also

SELECT e.employeeid,b.branchname,e.EmployeeName AS EmployeeName,m.EmployeeName as ManagerName
FROM Employees e
left JOIN Employees m
on e.Managerid = m.employeeid
left JOIN branches b
on e.branchid = b.branchid;

-- find all the employees reports to sneha varma

SELECT e.employeeID,e.EmployeeName,e.Department
from employees e
inner join employees m
on m.ManagerID = e.EmployeeID
where m.EmployeeName = "Sneha Varma";

-- 8.12 time question
SELECT a.accounttype,concat(c.FirstName,c.LastName) as fullname,avg(a.Balance)
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where a.accounttype = "Savings"
group by Fullname
having avg(a.balance) > 56230.76;

select avg(balance) from accounts;

-- SUBQUERIES ..................*****************************************************************************************
-- subquery is a select statement written insdide another sql statement such as
-- select , insert, update, delete
-- types of subquery 
-- scaller subquery / single row subquery 
-- multiple row subquery
-- table subquery
-- corelated subquery 

-- scaler subquery
-- scalare subquery (single value)
-- defination it return single values
-- it return exactly one row and one column

select c.firstName,a.balance
from customers c 
left join accounts a
on a.CustomerID = c.CustomerID
where accounttype = "savings" AND balance > (
select avg(balance)  from accounts
);

-- find the account (s) having the highest value

select c.firstName,a.balance
from customers c 
left join accounts a
on a.CustomerID = c.CustomerID
where balance = (
select max(balance) from accounts
);

-- find the customer whose year of birth is earlier than the average year of birth of all customers

select firstname,lastname,year(dateofbirth)
from customers 
where year(dateofbirth) < (
select avg(year(dateofbirth)) 
from customers
);

select avg(year(dateofbirth)) from customers;

-- prcatice questions 

-- Q.2) Display the CustomerID, FirstName and Email of customers whose AccountCreationDate is after 1-Jan-2025.

SELECT customerid,firstname,email,AccountCreationDate
from customers
where AccountCreationDate > ( select (AccountCreationDate) = 2025-01-01
from customers
);

select  avg(balance) from accounts;

-- Q.1) 1. Find all accounts whose balance is greater than the average balance of all accounts.

SELECT accountid,balance
from accounts
where balance >(
select avg(balance) from accounts
);

SELECT max(balance) FROM accounts;

-- Q.2) Find the account(s) having the highest balance.

select accountid,balance
from accounts
where balance >=(
select max(balance) from accounts
);

-- Q.3) Find customers whose year of birth is earlier than the average year of birth of all customers.

select firstname,lastname,year(dateofbirth)
from customers 
where year(dateofbirth) < (
select avg(year(dateofbirth)) 
from customers
);

-- Q.4) 4. Find accounts whose balance is equal to the average balance of all accounts.

SELECT avg(balance) FROM accounts;

select accountid,balance
from accounts
where balance = (
select avg(balance) from accounts
);

select c.firstName,a.balance
from customers c 
left join accounts a
on a.CustomerID = c.CustomerID
where balance = (
select max(balance) from accounts
);

-- Q.5) 5. Find the customer who owns the account with the highest balance.

select c.firstname,a.balance
from customers c
left join accounts a 
on c.customerid = a.CustomerID
where a.balance = (
select max(balance) from accounts
);

-- B. Multiple-Row Subqueries

-- Q.1) Find all customers who have taken at least one loan.

select c.customerid,c.firstname,c.lastname
from customers c
join loans l
on c.customerid = l.CustomerID;

select * from loans;

-- Q.2) 7. Find all customers who have not taken any loan.

SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
LEFT JOIN Loans l
    ON c.CustomerID = l.CustomerID
WHERE l.CustomerID IS NULL;

-- Q.3) 8. Find all customers who have at least one Savings account.

SELECT c.CustomerID, c.FirstName, c.LastName,a.AccountType
FROM Customers c
LEFT JOIN accounts a 
    ON c.CustomerID = a.CustomerID
WHERE a.AccountType = "Savings";

-- Q.4)  Find all customers who have at least one Current account.

SELECT c.customerid,c.firstname,c.lastname,a.accounttype
from customers c
left join accounts a
on c.CustomerID = a.CustomerID
where a.AccountType = "Current";

-- Q.5) 10. Find all customers who have an account in BranchID = 1.

SELECT * FROM branches;
SELECT * FROM accounts;

SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
LEFT JOIN Accounts a
ON c.CustomerID = a.CustomerID
WHERE a.BranchID =301;

-- q.6) Find all accounts whose balance is greater than any account in BranchID = 1.

-- multiple row subquery
-- a multiple row subquery return more than one row , usually a single column
-- used in IN , ANY , ALL , EXIST

-- Q.1) Find all customers who have taken at least one loan.

SELECT customerid,firstname,lastname
from customers
where CustomerID IN ( 
select CustomerID from loans);

select c.customerid,c.firstname,a.accounttype
from customers c
left join accounts a
on c.CustomerID = a.CustomerID
where c.customerid IN (
SELECT a.customerid from accounts
where a.accounttype = "Savings");

select customerid,firstname,lastname
from customers
where customerid IN (
select customerid from accounts
where accounttype = "Savings");

-- Find all customers who have an account in BranchID = 1.
select *
from customers
where customerid IN (
SELECT customerid from accounts
where branchid = 301 );

SELECT customerid from accounts
where branchid = 301;

-- FIND ALL THE ACCOUNTS WHOSE BVALANCE IS GRETER THAN ANY ACCOUNT IN BRANCH ID = 1

select * from accounts;

SELECT *
FROM accounts
WHERE Balance > any (
    SELECT Balance
    FROM accounts
    WHERE BranchID = 301
);

-- FIND ALL THE ACCOUNTS WHOSE BVALANCE IS GRETER THAN ALL ACCOUNT IN BRANCH ID = 1

SELECT *
FROM accounts
WHERE Balance > all (
    SELECT Balance
    FROM accounts
    WHERE BranchID = 301
);

-- FIND THE BRANCH WITH THE HIGHEST AVERAGE ACCOUNT BALANCE

SELECT BranchID, floor(avg(Balance)) AS AverageBalance
FROM accounts
GROUP BY BranchID
ORDER BY AverageBalance DESC
LIMIT 1;

SELECT avg(BALANCE) FROM ACCOUNTS;

-- CORELATED SUBQUERY 
-- A correlated subquery refrences one or more columns from the outer query 

-- Q.1 FIND ACCOUNTS WHOSE BALANCE IS GRETER THAN THE AVERAGE BALANCE OF THE RESPECTIVE BRANCH

SELECT a.accountid,a.balance,a.branchid
from accounts a 
where a.balance > (
select avg(a1.balance) 
from accounts a1
where a1.branchid = a.branchid
);

select avg(balance) from accounts;
select *   from accounts;

select e.employeeid,e.salary,e.department
from employees e
where e.salary >(
select avg(e1.salary) from employees e1
where e1.department = e.department
);

-- find customers who have more than one accounts

SELECT c.firstname,c.lastname
from customers c
where  ( 
select count(*) from accounts a
where c.CustomerID =a.customerid
)>1;

select * from customers;
select * from accounts;

-- TABLE SUBQUERY ( DERIVED TABLE / INLINE VIEW )
-- A TABLE SUBQUERY RETURNS THE MULTIPLE ROW AND MULTIPKLE COLUMN
-- IT USED INSIDE INSIDE THE FROM CLAUSE AND BEHAVES LIKE A TEMOPORARY 
-- it subquery must have alias name 
-- SELECT country_date.country,country_data.avg_followers
-- from (
-- select country, avg(followers) as avgfollowers
-- 
-- find the average account balance for each accounttype using a deriverd table

select Accountbalance.AccountType,accountbalance.Avgbalance
from (
select accounttype,avg(balance)  as AvgBalance
from accounts 
group by accounttype) as accountbalance;

-- display only those accounttypes whose avg balance is greter than 30000

select Accountbalance.AccountType,accountbalance.Avgbalance
from (
select accounttype,avg(balance)  as AvgBalance
from accounts 
group by accounttype) as accountbalance
where AvgBalance > 53000;

-- find the top 3 customers based on their total account balance

select TopCustomers.customerid,TopCustomers.firstname,TopCustomers.TotalBalance
from(
select a.customerid,c.firstname,sum(a.balance) as TotalBalance
from accounts a
inner join Customers c
on a.CustomerID = c.customerid
group by customerid) as TopCustomers
order by  TotalBalance desc
LIMIT 3;

select customerid,sum(balance) as TotalBalance
from accounts 
group by customerid
order by sum(balance) desc
limit 3;

-- SUBQUERY IN SELECT CLAUSE
-- Subquery in the select clause is typically  a scaller subquery used to crete a derived column

-- display each customer along with the number of accounts they have

select c.customerid,
( 
select count(*) from accounts a
where c.customerid = a.customerID
) as TotalAccounts
from customers c
order by TotalAccounts;

-- Subqueries inside UPDATE clause
-- increase the balance of accounts belonging to custoners who have teken any loan by 5 %

UPDATE accounts
SET balance =  balance + balance *0.05
WHERE Customerid IN (
SELECT customerid 
FROM loans 
);

select * from accounts;
select * from transactions;

-- delete all transactions below amount of 500 where transactiontype is withdrawal

DELETE FROM transactions
WHERE TransactionType = "Withdrawal" and amount <5000 ;

DELETE FROM transactions
WHERE accountid IN (
    SELECT AccountID 
    FROM  (select AccountID from transactions
    WHERE amount < 5450 and Transactiontype = "Withdrawal")as temp
) and transactiontype = "Withdrawal";

select * from accounts;

-- SUBQUERY TO INSERT CLAUSE

-- 

CREATE TABLE HighValAccounts (
	AccountID INT,
    CustomerId INT,
    BranchID INT,
    Balance DECIMAL(10,2),
    AccountType VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchId)REFERENCES Branches(branchID)
);

INSERT INTO HighValAccounts(
Accountid,customerid,branchid,balance,accounttype)
select Accountid,customerid,branchid,balance,accounttype
from accounts where balance >( select avg(balance) from accounts);

select avg(balance) from accounts;

select * from highvalaccounts;

CREATE TABLE HighBalanceCustomers(
CustomerID INT,
TotalBalance DECIMAL(10,2),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO HighBalanceCustomers(customerid,TotalBalance)  
( select customerid,TotalBalance from
( select CustomerID,sum(balance) As TotalBalance
from Accounts
group by Customerid) AS CusBalance
where TotalBalance > 50000);

select sum(balance) from accounts;
select * from highbalancecustomers;

-- SQL VIEWS 
create view PremiumAccounts as 
select accountid,balance,accounttype,customerid
from accounts
where balance > 50000;

select * from premiumaccounts
where accounttype = "Savings";