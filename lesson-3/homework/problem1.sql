DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);
DROP TABLE IF EXISTS Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);
DROP TABLE IF EXISTS Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

WITH Percentiles AS (
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        Department,
        Salary,
        HireDate,
        PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Salary) OVER () AS Salary90Percentile
    FROM Employees
),
Top10Percent AS (
    SELECT *
    FROM Percentiles
    WHERE Salary >= Salary90Percentile
),
SalaryCategoryTagged AS (
    SELECT
        Department,
        Salary,
        CASE
            WHEN Salary > 80000 THEN 'High'
            WHEN Salary BETWEEN 50000 AND 80000 THEN 'Medium'
            ELSE 'Low'
        END AS SalaryCategory
    FROM Top10Percent
),
DepartmentAverages AS (
    SELECT
        Department,
        AVG(Salary) AS AverageSalary,
        MIN(SalaryCategory) AS SalaryCategory  -- if multiple categories exist, just picking one for display
    FROM SalaryCategoryTagged
    GROUP BY Department
),
RankedDepartments AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY AverageSalary DESC) AS RowNum
    FROM DepartmentAverages
)
SELECT Department, AverageSalary, SalaryCategory
FROM RankedDepartments
WHERE RowNum > 2 AND RowNum <= 7;
