SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees;
