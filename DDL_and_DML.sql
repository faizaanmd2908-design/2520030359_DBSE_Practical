CREATE DATABASE IF NOT EXISTS retail_bank_practical;
USE retail_bank_practical;

CREATE TABLE bank_transactions (
    txn_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    branch_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    transaction_date DATE
);

ALTER TABLE bank_transactions
ADD account_no VARCHAR(20);

ALTER TABLE bank_transactions
MODIFY customer_name VARCHAR(100);

INSERT INTO bank_transactions
VALUES
(201,'Arjun Mehta','Pune','Deposit',8500,'2026-01-05','AC501'),
(202,'Nisha Rao','Mumbai','Withdrawal',3200,'2026-01-07','AC502'),
(203,'Vikram Shah','Delhi','Deposit',14500,'2026-01-09','AC503'),
(204,'Megha Iyer','Chennai','Deposit',6200,'2026-01-12','AC504'),
(205,'Rohan Das','Pune','Withdrawal',1800,'2026-01-15','AC505'),
(206,'Tanya Kapoor','Delhi','Deposit',11200,'2026-01-18','AC506'),
(207,'Kabir Singh','Mumbai','Withdrawal',2700,'2026-01-20','AC507'),
(208,'Ishita Nair','Chennai','Deposit',9300,'2026-01-22','AC508'),
(209,'Dev Malhotra','Delhi','Withdrawal',4100,'2026-01-25','AC509'),
(210,'Aarav Joshi','Pune','Deposit',7600,'2026-01-28','AC510');

SELECT * FROM bank_transactions;

UPDATE bank_transactions
SET amount = 4000
WHERE txn_id = 205;

INSERT INTO bank_transactions
VALUES
(211,'Sara Menon','Mumbai','Deposit',6800,'2026-02-02','AC511');

DELETE FROM bank_transactions
WHERE txn_id = 211;

SELECT *
FROM bank_transactions
WHERE transaction_type = 'Deposit';

SELECT *
FROM bank_transactions
ORDER BY amount DESC;

RENAME TABLE bank_transactions
TO customer_transactions;

SELECT * FROM customer_transactions;

TRUNCATE TABLE customer_transactions;

CREATE TABLE bank_backup (
    backup_id INT PRIMARY KEY,
    backup_note VARCHAR(100)
);

DROP TABLE bank_backup;