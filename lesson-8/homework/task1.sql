WITH Grouped AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY StepNumber) -
           ROW_NUMBER() OVER (PARTITION BY Status ORDER BY StepNumber) AS grp
    FROM Groupings
)
SELECT 
    MIN(StepNumber) AS [Min Step Number],
    MAX(StepNumber) AS [Max Step Number],
    Status,
    COUNT(*) AS [Consecutive Count]
FROM Grouped
GROUP BY Status, grp
ORDER BY [Min Step Number];
