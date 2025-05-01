WITH Hierarchy AS (
    -- Anchor: President has depth 0
    SELECT 
        EmployeeID,
        ManagerID,
        JobTitle,
        0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Recursive: Add 1 to the depth for each direct report
    SELECT 
        e.EmployeeID,
        e.ManagerID,
        e.JobTitle,
        h.Depth + 1
    FROM Employees e
    INNER JOIN Hierarchy h ON e.ManagerID = h.EmployeeID
)
SELECT * FROM Hierarchy
ORDER BY EmployeeID
OPTION (MAXRECURSION 100);
