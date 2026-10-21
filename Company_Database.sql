CREATE DATABASE IF NOT EXISTS CompanyDB;
USE CompanyDB;

CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) DEFAULT 'Chennai'
);

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100) NOT NULL,
    Gender VARCHAR(10),
    Salary DECIMAL(10,2) CHECK (Salary >= 0),
    HireDate DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

INSERT INTO Departments (DeptID, DeptName, Location) VALUES
(1, 'IT', 'Bengaluru'),
(2, 'HR', 'Chennai'),
(3, 'Finance', 'Mumbai'),
(4, 'Computer Science', 'Hyderabad');

INSERT INTO Employees
(EmpID, EmpName, Gender, Salary, HireDate, DeptID)
VALUES
(101, 'Amit Sharma', 'Male', 45000, '2025-01-15', 1),
(102, 'Priya Singh', 'Female', 55000, '2026-09-10', 1),
(103, 'Rahul Kumar', 'Male', 35000, '2024-05-20', 2),
(104, 'Sneha Patel', 'Female', 60000, '2025-06-12', 3),
(105, 'Arjun Verma', 'Male', 75000, '2026-10-01', 4),
(106, 'Anjali Gupta', 'Female', 50000, '2026-09-25', 2),
(107, 'Vikram Rao', 'Male', 90000, '2023-03-10', 1),
(108, 'Simran Das', 'Female', 40000, '2025-11-05', 4);

INSERT INTO Projects
(ProjectID, ProjectName, StartDate, EndDate, DeptID)
VALUES
(201, 'Website Development', '2025-01-10', '2026-12-31', 1),
(202, 'Recruitment System', '2025-06-01', '2026-06-30', 2),
(203, 'Financial Analysis', '2024-08-15', '2025-12-31', 3),
(204, 'AI Research', '2025-02-01', '2026-12-31', 4);

SELECT
    E.EmpID,
    E.EmpName,
    E.Gender,
    E.Salary,
    D.DeptName
FROM Employees E
INNER JOIN Departments D
    ON E.DeptID = D.DeptID;

SELECT *
FROM Employees
WHERE DATEDIFF(CURRENT_DATE, HireDate) BETWEEN 0 AND 60;

SELECT
    D.DeptName,
    AVG(E.Salary) AS AverageSalary
FROM Departments D
INNER JOIN Employees E
    ON D.DeptID = E.DeptID
GROUP BY D.DeptID, D.DeptName
ORDER BY AverageSalary DESC;

SELECT
    EmpName,
    Salary,
    CASE
        WHEN Salary < 40000 THEN 'Junior'
        WHEN Salary BETWEEN 40000 AND 70000 THEN 'Mid'
        ELSE 'Senior'
    END AS EmployeeLevel
FROM Employees;

SELECT *
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);

SELECT E.*
FROM Employees E
WHERE EXISTS (
    SELECT 1
    FROM Projects P
    WHERE P.DeptID = E.DeptID
      AND P.StartDate >= '2025-01-01'
);

SELECT DeptName AS Name
FROM Departments
UNION
SELECT ProjectName AS Name
FROM Projects;

SELECT EmpName AS CommonName
FROM Employees
WHERE EmpName IN (
    SELECT ProjectName
    FROM Projects
);

SELECT *
FROM Employees
WHERE EmpName LIKE 'S%'
  AND Salary BETWEEN 30000 AND 60000;

SELECT
    CONCAT(E.EmpName, ' works in ', D.DeptName) AS EmployeeInfo
FROM Employees E
INNER JOIN Departments D
    ON E.DeptID = D.DeptID;
