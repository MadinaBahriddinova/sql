SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgDeptSalary
FROM Employees;
