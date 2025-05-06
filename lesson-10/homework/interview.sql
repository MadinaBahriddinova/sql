-- Step 1: Create a CTE that includes 7 rows with zero shipments
WITH zero_shipments AS (
    SELECT 0 AS Num FROM generate_series(1, 7)
),
all_shipments AS (
    SELECT Num FROM Shipments
    UNION ALL
    SELECT Num FROM zero_shipments
),
ordered AS (
    SELECT Num, ROW_NUMBER() OVER (ORDER BY Num) AS rn
    FROM all_shipments
),
median_values AS (
    SELECT Num FROM ordered
    WHERE rn IN (20, 21)  -- Since total = 40, median = avg(20th and 21st values)
)
-- Final Step: Take the average of 20th and 21st values
SELECT AVG(Num * 1.0) AS median
FROM median_values;
