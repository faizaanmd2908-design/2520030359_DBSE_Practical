CREATE DATABASE IF NOT EXISTS campus_join_practical;
USE campus_join_practical;

CREATE TABLE students (
    id INT,
    name VARCHAR(30)
);

CREATE TABLE student_locations (
    id INT,
    city VARCHAR(30)
);

INSERT INTO students
VALUES
(11,'Kavin'),
(12,'Mira'),
(13,'Raghav'),
(14,'Sana'),
(15,'Ishaan');

INSERT INTO student_locations
VALUES
(11,'Pune'),
(12,'Kochi'),
(13,'Jaipur'),
(16,'Surat'),
(17,'Indore');

SELECT *
FROM students
CROSS JOIN student_locations;

SELECT *
FROM students
INNER JOIN student_locations
ON students.id = student_locations.id;

SELECT students.name,
       student_locations.city
FROM students
INNER JOIN student_locations
ON students.id = student_locations.id;

SELECT *
FROM students
NATURAL JOIN student_locations;

SELECT *
FROM students
LEFT JOIN student_locations
ON students.id = student_locations.id;

SELECT *
FROM students
LEFT JOIN student_locations
ON students.id = student_locations.id
WHERE student_locations.id IS NULL;

SELECT *
FROM students
RIGHT JOIN student_locations
ON students.id = student_locations.id;

SELECT *
FROM students
RIGHT JOIN student_locations
ON students.id = student_locations.id
WHERE students.id IS NULL;

SELECT students.id,
       students.name,
       student_locations.id AS location_id,
       student_locations.city
FROM students
LEFT JOIN student_locations
ON students.id = student_locations.id

UNION

SELECT students.id,
       students.name,
       student_locations.id AS location_id,
       student_locations.city
FROM students
RIGHT JOIN student_locations
ON students.id = student_locations.id;

SELECT students.id,
       students.name,
       student_locations.id AS location_id,
       student_locations.city
FROM students
LEFT JOIN student_locations
ON students.id = student_locations.id
WHERE student_locations.id IS NULL

UNION

SELECT students.id,
       students.name,
       student_locations.id AS location_id,
       student_locations.city
FROM students
RIGHT JOIN student_locations
ON students.id = student_locations.id
WHERE students.id IS NULL;

CREATE TABLE first_branch (
    id INT,
    name VARCHAR(30)
);

CREATE TABLE second_branch (
    id INT,
    name VARCHAR(30)
);

INSERT INTO first_branch
VALUES
(21,'Aarohi'),
(22,'Dev'),
(23,'Kabir'),
(24,'Meera');

INSERT INTO second_branch
VALUES
(23,'Kabir'),
(24,'Meera'),
(25,'Nakul'),
(26,'Tara');

SELECT *
FROM first_branch
UNION
SELECT *
FROM second_branch;

SELECT name
FROM first_branch
UNION
SELECT name
FROM second_branch;

SELECT *
FROM first_branch
UNION ALL
SELECT *
FROM second_branch;

SELECT name
FROM first_branch
INTERSECT
SELECT name
FROM second_branch;

SELECT *
FROM first_branch
INTERSECT
SELECT *
FROM second_branch;

SELECT f.id,
       f.name,
       CASE
           WHEN s.id IS NULL THEN 'Location Missing'
           ELSE 'Location Available'
       END AS status
FROM students f
LEFT JOIN student_locations s
ON f.id = s.id;