SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        ORDER BY EmployeeID 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSalary
FROM Employees;
