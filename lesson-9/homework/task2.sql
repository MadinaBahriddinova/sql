DECLARE @N INT = 10;

WITH FactorialCTE AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, Factorial * (Num + 1)
    FROM FactorialCTE
    WHERE Num + 1 <= @N
)
SELECT * FROM FactorialCTE
OPTION (MAXRECURSION 32767);
