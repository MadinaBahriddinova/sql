SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    MAX(Salary) OVER (
        ORDER BY EmployeeID
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
    ) AS SlidingMax
FROM Employees;
