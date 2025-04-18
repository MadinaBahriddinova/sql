SELECT 
    Year1,
    Max1,
    Max2,
    Max3,
    MaxValue = MAX(v.MaxCol)
FROM TestMax
CROSS APPLY (VALUES (Max1), (Max2), (Max3)) AS v(MaxCol)
GROUP BY Year1, Max1, Max2, Max3;
