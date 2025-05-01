DECLARE @N INT = 10;

WITH FibonacciCTE AS (
    SELECT 1 AS n, 1 AS Fibonacci_Number
    UNION ALL
    SELECT 2, 1
    UNION ALL
    SELECT n + 1, 
           (SELECT Fibonacci_Number FROM FibonacciCTE WHERE n = f.n - 1) + 
           (SELECT Fibonacci_Number FROM FibonacciCTE WHERE n = f.n - 2)
    FROM FibonacciCTE f
    WHERE n + 1 <= @N
)
SELECT * FROM FibonacciCTE
ORDER BY n
OPTION (MAXRECURSION 32767);
