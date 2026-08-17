DROP DATABASE IF EXISTS personal_bank_practical;
CREATE DATABASE personal_bank_practical;
USE personal_bank_practical;

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Account (
    Account_No INT PRIMARY KEY,
    Customer_ID INT,
    Account_Type VARCHAR(20),
    Balance DECIMAL(12,2) DEFAULT 0,
    Branch VARCHAR(50),
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID)
);

CREATE TABLE Bank_Transaction (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Account_No INT,
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(12,2),
    Transaction_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Account_No)
    REFERENCES Account(Account_No)
);

CREATE TABLE Loan (
    Loan_ID INT PRIMARY KEY,
    Customer_ID INT,
    Loan_Type VARCHAR(30),
    Loan_Amount DECIMAL(12,2),
    Interest_Rate DECIMAL(5,2),
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID)
);

INSERT INTO Customer
VALUES
(201,'Naveen Bhat','9810012345','naveen.bhat@mail.com','Mysuru'),
(202,'Harini Rao','9810012346','harini.rao@mail.com','Bengaluru'),
(203,'Aditya Sen','9810012347','aditya.sen@mail.com','Kolkata'),
(204,'Pallavi Nair','9810012348','pallavi.nair@mail.com','Kochi'),
(205,'Ritesh Jain','9810012349','ritesh.jain@mail.com','Jaipur');

INSERT INTO Account
VALUES
(21001,201,'Savings',62000,'Mysuru'),
(21002,202,'Savings',88000,'Bengaluru'),
(21003,203,'Current',135000,'Kolkata'),
(21004,204,'Savings',54000,'Kochi'),
(21005,205,'Current',97000,'Jaipur');

INSERT INTO Bank_Transaction
(Account_No,Transaction_Type,Amount)
VALUES
(21001,'DEPOSIT',12000),
(21002,'DEPOSIT',18000),
(21003,'WITHDRAW',25000),
(21004,'DEPOSIT',7000),
(21005,'WITHDRAW',9000);

INSERT INTO Loan
VALUES
(601,201,'Home Loan',4200000,7.25),
(602,202,'Education Loan',900000,6.75),
(603,203,'Car Loan',750000,8.10),
(604,204,'Personal Loan',350000,10.25);

SELECT * FROM Customer;
SELECT * FROM Account;
SELECT * FROM Bank_Transaction;
SELECT * FROM Loan;

DELIMITER //

CREATE PROCEDURE GetAllCustomers()
BEGIN
    SELECT * FROM Customer;
END //

DELIMITER ;

CALL GetAllCustomers();

DELIMITER //

CREATE PROCEDURE GetAccountDetails(
    IN p_Account_No INT
)
BEGIN
    SELECT *
    FROM Account
    WHERE Account_No = p_Account_No;
END //

DELIMITER ;

CALL GetAccountDetails(21001);

DELIMITER //

CREATE PROCEDURE GetCustomerAccounts(
    IN p_Customer_ID INT
)
BEGIN
    SELECT
        C.Customer_ID,
        C.Customer_Name,
        A.Account_No,
        A.Account_Type,
        A.Balance,
        A.Branch
    FROM Customer C
    JOIN Account A
    ON C.Customer_ID = A.Customer_ID
    WHERE C.Customer_ID = p_Customer_ID;
END //

DELIMITER ;

CALL GetCustomerAccounts(201);

DELIMITER //

CREATE PROCEDURE DepositMoney(
    IN p_Account_No INT,
    IN p_Amount DECIMAL(12,2)
)
BEGIN
    UPDATE Account
    SET Balance = Balance + p_Amount
    WHERE Account_No = p_Account_No;
END //

DELIMITER ;

CALL DepositMoney(21001,4500);

DELIMITER //

CREATE PROCEDURE WithdrawMoney(
    IN p_Account_No INT,
    IN p_Amount DECIMAL(12,2)
)
BEGIN
    UPDATE Account
    SET Balance = Balance - p_Amount
    WHERE Account_No = p_Account_No;
END //

DELIMITER ;

CALL WithdrawMoney(21001,2500);

DELIMITER //

CREATE TRIGGER CheckBalance
BEFORE UPDATE ON Account
FOR EACH ROW
BEGIN
    IF NEW.Balance < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction failed: Insufficient balance';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER CheckTransactionAmount
BEFORE INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN
    IF NEW.Amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction amount must be greater than zero';
    END IF;
END //

DELIMITER ;

CREATE TABLE Transaction_Audit (
    Audit_ID INT PRIMARY KEY AUTO_INCREMENT,
    Transaction_ID INT,
    Account_No INT,
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(12,2),
    Audit_Date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER TransactionAudit
AFTER INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN
    INSERT INTO Transaction_Audit
    (
        Transaction_ID,
        Account_No,
        Transaction_Type,
        Amount
    )
    VALUES
    (
        NEW.Transaction_ID,
        NEW.Account_No,
        NEW.Transaction_Type,
        NEW.Amount
    );
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER UpdateBalanceAfterTransaction
AFTER INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN
    IF NEW.Transaction_Type = 'DEPOSIT' THEN
        UPDATE Account
        SET Balance = Balance + NEW.Amount
        WHERE Account_No = NEW.Account_No;
    ELSEIF NEW.Transaction_Type = 'WITHDRAW' THEN
        UPDATE Account
        SET Balance = Balance - NEW.Amount
        WHERE Account_No = NEW.Account_No;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER PreventInsufficientWithdrawal
BEFORE INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN
    DECLARE CurrentBalance DECIMAL(12,2);

    SELECT Balance
    INTO CurrentBalance
    FROM Account
    WHERE Account_No = NEW.Account_No;

    IF NEW.Transaction_Type = 'WITHDRAW'
       AND NEW.Amount > CurrentBalance THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Withdrawal failed: Insufficient balance';
    END IF;
END //

DELIMITER ;

INSERT INTO Bank_Transaction
(Account_No,Transaction_Type,Amount)
VALUES
(21001,'DEPOSIT',3500);

SELECT * FROM Transaction_Audit;

SELECT *
FROM Account
WHERE Account_No = 21001;

DELIMITER //

CREATE PROCEDURE TransferMoney(
    IN SenderAccount INT,
    IN ReceiverAccount INT,
    IN TransferAmount DECIMAL(12,2)
)
BEGIN
    DECLARE SenderBalance DECIMAL(12,2);

    SELECT Balance
    INTO SenderBalance
    FROM Account
    WHERE Account_No = SenderAccount;

    IF SenderBalance < TransferAmount THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transfer failed: Insufficient balance';
    ELSE
        UPDATE Account
        SET Balance = Balance - TransferAmount
        WHERE Account_No = SenderAccount;

        UPDATE Account
        SET Balance = Balance + TransferAmount
        WHERE Account_No = ReceiverAccount;
    END IF;
END //

DELIMITER ;

CALL TransferMoney(21001,21002,5000);

DELIMITER //

CREATE PROCEDURE GetCustomerLoans(
    IN p_Customer_ID INT
)
BEGIN
    SELECT
        C.Customer_Name,
        L.Loan_ID,
        L.Loan_Type,
        L.Loan_Amount,
        L.Interest_Rate
    FROM Customer C
    JOIN Loan L
    ON C.Customer_ID = L.Customer_ID
    WHERE C.Customer_ID = p_Customer_ID;
END //

DELIMITER ;

CALL GetCustomerLoans(201);

DELIMITER //

CREATE PROCEDURE HighBalanceAccounts(
    IN MinimumBalance DECIMAL(12,2)
)
BEGIN
    SELECT *
    FROM Account
    WHERE Balance >= MinimumBalance
    ORDER BY Balance DESC;
END //

DELIMITER ;

CALL HighBalanceAccounts(70000);

DELIMITER //

CREATE PROCEDURE GetBalance(
    IN p_Account_No INT,
    OUT p_Balance DECIMAL(12,2)
)
BEGIN
    SELECT Balance
    INTO p_Balance
    FROM Account
    WHERE Account_No = p_Account_No;
END //

DELIMITER ;

CALL GetBalance(21001,@CurrentBalance);

SELECT @CurrentBalance;

SHOW TRIGGERS;

SHOW PROCEDURE STATUS
WHERE Db = 'personal_bank_practical';