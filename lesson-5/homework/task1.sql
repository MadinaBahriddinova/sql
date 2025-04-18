SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;
