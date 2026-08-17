DROP DATABASE IF EXISTS booknest_week1;
CREATE DATABASE booknest_week1;
USE booknest_week1;

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) NOT NULL UNIQUE,
    published_year INT,
    CONSTRAINT chk_published_year CHECK (published_year < 2027)
);

CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

INSERT INTO books
(title,isbn,published_year)
VALUES
('Deep Work','9781455586691',2016),
('The Pragmatic Programmer','9780135957059',1999),
('The Psychology of Money','9780857197689',2020);

INSERT INTO members
(full_name,email)
VALUES
('Faizan Mirza','faizan.mirza@example.com'),
('Neha Kapoor','neha.kapoor@example.com'),
('Advik Rao','advik.rao@example.com');

SELECT * FROM books;

DESCRIBE members;

SELECT * FROM members;