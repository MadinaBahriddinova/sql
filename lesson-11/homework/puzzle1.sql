-- Step 1: Create a temporary table with the same structure
CREATE TABLE #EmployeeTransfers (
    EmployeeID INT,
    Name VARCHAR(50),
    Department VARCHAR(20),
    Salary INT
);

-- Step 2: Insert employees into #EmployeeTransfers with shifted departments
INSERT INTO #EmployeeTransfers (EmployeeID, Name, Department, Salary)
SELECT
    EmployeeID,
    Name,
    CASE 
        WHEN Department = 'HR' THEN 'IT'
        WHEN Department = 'IT' THEN 'Sales'
        WHEN Department = 'Sales' THEN 'HR'
    END AS Department,
    Salary
FROM Employees;

-- Step 3: Retrieve the updated records
SELECT * FROM #EmployeeTransfers;
