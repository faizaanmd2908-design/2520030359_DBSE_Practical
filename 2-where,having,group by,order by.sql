CREATE DATABASE IF NOT EXISTS academic_marks_practical;
USE academic_marks_practical;

CREATE TABLE student_marks (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    subject VARCHAR(50),
    marks DECIMAL(5,2)
);

INSERT INTO student_marks
VALUES
(101,'Aditi','Mathematics',86.50),
(102,'Karthik','Mathematics',93.25),
(103,'Neel','Mathematics',76.80),
(104,'Riya','Mathematics',89.40),
(105,'Varun','Mathematics',81.75),
(106,'Mohan','Cloud Computing',96.50),
(107,'Diya','DBMS',94.25),
(108,'Ira','English',88.60),
(109,'Yash','Cloud Computing',91.90),
(110,'Tanvi','Azure',79.50);

SELECT * FROM student_marks;

SELECT COUNT(*) AS total_students
FROM student_marks;

SELECT SUM(marks) AS total_marks
FROM student_marks;

SELECT AVG(marks) AS average_marks
FROM student_marks;

SELECT MAX(marks) AS highest_marks
FROM student_marks;

SELECT MIN(marks) AS lowest_marks
FROM student_marks;

SELECT *
FROM student_marks
WHERE marks > 85;

SELECT *
FROM student_marks
WHERE marks >= 90;

SELECT *
FROM student_marks
WHERE marks < 80;

SELECT *
FROM student_marks
WHERE marks BETWEEN 80 AND 90;

SELECT *
FROM student_marks
WHERE name LIKE 'R%';

SELECT *
FROM student_marks
WHERE name IN ('Aditi','Neel','Diya');

SELECT *
FROM student_marks
WHERE marks > 85
AND (subject = 'Mathematics' OR name LIKE 'R%');

UPDATE student_marks
SET marks = 84.50
WHERE roll_no = 103;

UPDATE student_marks
SET subject = 'Remedial Mathematics'
WHERE marks < 80;

DELETE FROM student_marks
WHERE roll_no = 105;

DELETE FROM student_marks
WHERE marks < 75;

SELECT *
FROM student_marks
ORDER BY marks ASC;

SELECT *
FROM student_marks
ORDER BY marks DESC;

SELECT *
FROM student_marks
ORDER BY name ASC;

SELECT *
FROM student_marks
ORDER BY name DESC;

SELECT subject,
       SUM(marks) AS total_marks
FROM student_marks
GROUP BY subject;

SELECT subject,
       AVG(marks) AS average_marks
FROM student_marks
GROUP BY subject;

SELECT subject,
       COUNT(*) AS student_count
FROM student_marks
GROUP BY subject;

SELECT subject,
       AVG(marks) AS average_marks
FROM student_marks
GROUP BY subject
HAVING AVG(marks) > 85;

SELECT subject,
       COUNT(*) AS student_count
FROM student_marks
GROUP BY subject
HAVING COUNT(*) > 1;