SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    CAST(Salary * 100.0 / SUM(Salary) OVER (PARTITION BY Department) AS DECIMAL(5,2)) AS SalaryPercentInDept
FROM Employees;
