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