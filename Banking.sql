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