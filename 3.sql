CREATE DATABASE IF NOT EXISTS sales_analysis_practical;
USE sales_analysis_practical;

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);

INSERT INTO orders
VALUES
(92001,425.75,'2026-01-11',5201,7201),
(92002,1860.40,'2026-01-18',5202,7202),
(92003,95.20,'2026-01-11',5203,7203),
(92004,3150.80,'2026-02-05',5201,7202),
(92005,740.25,'2026-02-19',5204,7201),
(92006,4685.60,'2026-03-07',5202,7202),
(92007,1395.35,'2026-03-21',5205,7204),
(92008,3890.90,'2026-03-21',5201,7202),
(92009,125.50,'2026-04-02',5203,7203),
(92010,2380.45,'2026-04-02',5206,7204),
(92011,925.30,'2026-04-18',5204,7201),
(92012,5450.75,'2026-04-18',5202,7202);

SELECT *
FROM orders
WHERE purch_amt > 2000;

SELECT *
FROM orders
WHERE ord_date = '2026-03-21';

SELECT *
FROM orders
WHERE salesman_id = 7202;

SELECT *
FROM orders
ORDER BY purch_amt DESC;

SELECT *
FROM orders
ORDER BY ord_date ASC;

SELECT SUM(purch_amt) AS total_revenue
FROM orders;

SELECT AVG(purch_amt) AS average_order
FROM orders;

SELECT MAX(purch_amt) AS highest_order
FROM orders;

SELECT MIN(purch_amt) AS lowest_order
FROM orders;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT salesman_id,
       SUM(purch_amt) AS total_sales
FROM orders
GROUP BY salesman_id;

SELECT customer_id,
       SUM(purch_amt) AS total_purchase
FROM orders
GROUP BY customer_id;

SELECT customer_id,
       MAX(purch_amt) AS highest_purchase
FROM orders
GROUP BY customer_id;

SELECT salesman_id,
       SUM(purch_amt) AS total_sales
FROM orders
GROUP BY salesman_id
HAVING SUM(purch_amt) > 3000;

SELECT customer_id,
       SUM(purch_amt) AS total_purchase
FROM orders
GROUP BY customer_id
HAVING SUM(purch_amt) > 2500;

SELECT customer_id,
       COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT customer_id,
       SUM(purch_amt) AS total_purchase
FROM orders
GROUP BY customer_id
HAVING SUM(purch_amt) > 1000
ORDER BY total_purchase DESC;

SELECT customer_id,
       MAX(purch_amt) AS max_purchase
FROM orders
GROUP BY customer_id
HAVING MAX(purch_amt) BETWEEN 2000 AND 6000;

SELECT salesman_id,
       COUNT(*) AS total_orders
FROM orders
GROUP BY salesman_id
HAVING COUNT(*) >= 2;

SELECT ord_date,
       MAX(purch_amt) AS highest_purchase
FROM orders
GROUP BY ord_date
HAVING MAX(purch_amt) > 2000;