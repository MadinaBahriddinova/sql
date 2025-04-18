SELECT *
FROM (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptRank
    FROM Employees
) AS Ranked
WHERE DeptRank <= 2;
