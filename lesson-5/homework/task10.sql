SELECT *
FROM (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        HireDate,
        ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS RN
    FROM Employees
) AS Ranked
WHERE RN <= 3;

SELECT SUM(Salary) AS SumOfLast3Hires
FROM (
    SELECT Salary
    FROM Employees
    ORDER BY HireDate DESC
    OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) AS Last3;
