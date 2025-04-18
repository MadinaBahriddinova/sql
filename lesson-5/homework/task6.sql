SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalDeptSalary
FROM Employees;
