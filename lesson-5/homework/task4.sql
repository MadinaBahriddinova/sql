SELECT *
FROM (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS DeptLowRank
    FROM Employees
) AS Ranked
WHERE DeptLowRank = 1;

SELECT *
FROM (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS DeptLowRank
    FROM Employees
) AS Ranked
WHERE DeptLowRank = 1;
