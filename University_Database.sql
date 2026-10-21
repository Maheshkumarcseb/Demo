CREATE DATABASE IF NOT EXISTS University;
USE University;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Department VARCHAR(50) DEFAULT 'General'
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT CHECK (Credits > 0)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE DEFAULT (CURRENT_DATE),
    Grade DECIMAL(5,2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    CHECK (Grade BETWEEN 0 AND 100)
);

INSERT INTO Students
    (StudentID, FullName, Email, Phone, Department)
VALUES
    (1, 'Arjun Menon', 'arjun@univ.com', '9876543210', 'Computer Science');

INSERT INTO Students
    (StudentID, FullName, Email, Phone, Department)
VALUES
    (2, 'Priya Sharma', 'priya@univ.com', '9876543211', 'IT'),
    (3, 'Amit Kumar', 'amit@univ.com', '9876543212', 'Computer Science'),
    (4, 'Sneha Patel', 'sneha@univ.com', '9876543213', 'General'),
    (5, 'Anjali Verma', 'anjali@univ.com', '9876543214', 'IT');

INSERT INTO Courses
    (CourseID, CourseName, Credits)
VALUES
    (101, 'Database Systems', 4),
    (102, 'Data Structures', 3),
    (103, 'Java Programming', 4),
    (104, 'Computer Networks', 5);

INSERT INTO Enrollments
    (EnrollmentID, StudentID, CourseID, EnrollmentDate, Grade)
VALUES
    (1001, 1, 101, CURRENT_DATE, 85);

INSERT INTO Enrollments
    (EnrollmentID, StudentID, CourseID, EnrollmentDate, Grade)
VALUES
    (1002, 2, 102, '2025-11-15', 92),
    (1003, 3, 101, '2025-12-10', 78),
    (1004, 4, 103, '2025-11-20', 65),
    (1005, 5, 104, '2025-12-25', 48),
    (1006, 1, 103, '2025-11-25', 95),
    (1007, 2, 104, '2025-12-05', 88);

ALTER TABLE Courses
ADD CONSTRAINT uq_course_name UNIQUE (CourseName);

ALTER TABLE Courses
ADD CONSTRAINT chk_credits_max CHECK (Credits <= 6);

SELECT
    S.FullName,
    C.CourseName,
    E.Grade
FROM Students S
INNER JOIN Enrollments E ON S.StudentID = E.StudentID
INNER JOIN Courses C ON E.CourseID = C.CourseID;

SELECT
    AVG(E.Grade) AS AverageGrade
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE S.Department = 'Computer Science';

SELECT
    FullName,
    UPPER(FullName) AS UpperName,
    LOWER(FullName) AS LowerName
FROM Students;

SELECT
    Email,
    LENGTH(Email) AS EmailLength
FROM Students;

SELECT
    Email,
    SUBSTRING(Email, LOCATE('@', Email) + 1) AS EmailDomain
FROM Students
WHERE LOCATE('@', Email) > 0;

SELECT
    CONCAT(FullName, ' - ', Department) AS StudentInfo
FROM Students;

SELECT
    TRIM(Department) AS Department
FROM Students;

SELECT
    Grade,
    ROUND(Grade) AS RoundedGrade
FROM Enrollments;

SELECT
    Grade,
    ABS(Grade - (SELECT AVG(Grade) FROM Enrollments)) AS AbsoluteDifference
FROM Enrollments;

SELECT
    AVG(Grade) AS AverageGrade,
    CEILING(AVG(Grade)) AS CeilingGrade,
    FLOOR(AVG(Grade)) AS FloorGrade
FROM Enrollments;

SELECT
    EnrollmentID,
    EnrollmentDate,
    DATEDIFF(CURRENT_DATE, EnrollmentDate) AS DaysSinceEnrollment
FROM Enrollments;

SELECT
    EnrollmentDate,
    DATE_ADD(EnrollmentDate, INTERVAL 15 DAY) AS NewDate
FROM Enrollments;

SELECT *
FROM Enrollments
WHERE EnrollmentDate = CURRENT_DATE;

SELECT
    Grade,
    CAST(Grade AS CHAR) AS GradeText
FROM Enrollments;

SELECT CAST(CURRENT_DATE AS CHAR) AS CurrentDate;

SELECT
    S.FullName,
    E.Grade,
    CASE
        WHEN E.Grade >= 90 THEN 'Excellent'
        WHEN E.Grade >= 75 THEN 'Good'
        WHEN E.Grade >= 50 THEN 'Average'
        ELSE 'Poor'
    END AS GradeCategory
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID;

SELECT
    S.FullName,
    S.Department,
    E.Grade,
    CASE
        WHEN S.Department = 'Computer Science' THEN E.Grade + 5
        WHEN S.Department = 'IT' THEN E.Grade + 3
        ELSE E.Grade + 1
    END AS TotalMarks
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID;

SELECT
    S.FullName,
    E.Grade,
    E.Grade +
        CASE
            WHEN S.Department = 'Computer Science' THEN 5
            WHEN S.Department = 'IT' THEN 3
            ELSE 1
        END AS TotalMarks
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID;

SELECT
    S.FullName,
    S.Department,
    E.Grade
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.Grade >= 80
  AND S.Department = 'Computer Science';

SELECT *
FROM Students
WHERE FullName LIKE 'A%';

SELECT
    S.Department,
    AVG(E.Grade) AS AverageGrade
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
GROUP BY S.Department;

SELECT *
FROM Courses
ORDER BY Credits DESC;

SELECT *
FROM Enrollments
WHERE EnrollmentDate BETWEEN '2025-11-01' AND '2025-12-31';

SELECT *
FROM Courses
WHERE CourseName IN ('Database Systems', 'Data Structures');

SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
