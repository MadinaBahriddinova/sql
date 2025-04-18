SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        ORDER BY HireDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningAvg
FROM Employees;
