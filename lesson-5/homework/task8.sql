SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgDeptSalary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromAvg
FROM Employees;
