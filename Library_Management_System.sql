CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2),
    Category VARCHAR(50) DEFAULT 'General',
    CHECK (Price > 0)
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15) NOT NULL
);

CREATE TABLE Borrow (
    BorrowID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    BorrowDate DATE DEFAULT (CURRENT_DATE),
    ReturnDate DATE NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE
);

INSERT INTO Books
    (BookID, Title, Author, Price, Category)
VALUES
    (101, 'SQL Basics', 'John Smith', 450, 'Database'),
    (102, 'Python Programming', 'Guido Rossum', 600, 'Programming'),
    (103, 'Java Fundamentals', 'James Gosling', 550, 'Programming'),
    (104, 'Computer Networks', 'Andrew Tanenbaum', 700, 'Networking'),
    (105, 'Database Systems', 'Raghu Ramakrishnan', 800, 'Database');

INSERT INTO Members
    (MemberID, Name, Email, Phone)
VALUES
    (1, 'Ravi Kumar', 'ravi@example.com', '9876543210'),
    (2, 'Priya Sharma', 'priya@example.com', '9876543211'),
    (3, 'Amit Verma', 'amit@example.com', '9876543212'),
    (4, 'Sneha Patel', 'sneha@example.com', '9876543213');

INSERT INTO Borrow
    (BorrowID, BookID, MemberID, BorrowDate, ReturnDate)
VALUES
    (1001, 101, 1, '2026-10-01', '2026-10-10'),
    (1002, 102, 1, '2026-10-05', NULL),
    (1003, 103, 2, '2026-10-07', '2026-10-15'),
    (1004, 104, 3, '2026-10-10', NULL),
    (1005, 105, 2, '2026-10-12', NULL),
    (1006, 101, 4, '2026-10-15', NULL);

ALTER TABLE Members
ADD CONSTRAINT uq_member_phone UNIQUE (Phone);

ALTER TABLE Borrow
ADD CONSTRAINT chk_return_date
CHECK (ReturnDate IS NULL OR ReturnDate > BorrowDate);

SELECT
    B.BookID,
    B.Title,
    B.Author,
    B.Price,
    BR.BorrowDate,
    BR.ReturnDate
FROM Members M
JOIN Borrow BR ON M.MemberID = BR.MemberID
JOIN Books B ON BR.BookID = B.BookID
WHERE M.Name = 'Ravi Kumar';

SELECT
    M.Name AS MemberName,
    B.Title AS BookTitle,
    BR.BorrowDate
FROM Borrow BR
INNER JOIN Members M ON BR.MemberID = M.MemberID
INNER JOIN Books B ON BR.BookID = B.BookID;

SELECT
    M.MemberID,
    M.Name AS MemberName,
    COUNT(BR.BorrowID) AS TotalBooksBorrowed
FROM Members M
LEFT JOIN Borrow BR ON M.MemberID = BR.MemberID
GROUP BY M.MemberID, M.Name
ORDER BY TotalBooksBorrowed DESC;

SELECT * FROM Books;
SELECT * FROM Members;
SELECT * FROM Borrow;
