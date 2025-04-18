SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;
