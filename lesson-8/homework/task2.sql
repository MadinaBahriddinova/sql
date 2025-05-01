-- Recursive CTE to generate years
WITH YearList AS (
    SELECT 1975 AS yr
    UNION ALL
    SELECT yr + 1 FROM YearList WHERE yr + 1 <= YEAR(GETDATE())
),
HireYears AS (
    SELECT DISTINCT YEAR(HIRE_DATE) AS hire_year FROM dbo.EMPLOYEES_N
),
MissingYears AS (
    SELECT yr FROM YearList
    WHERE yr NOT IN (SELECT hire_year FROM HireYears)
),
Grouped AS (
    SELECT 
        yr,
        yr - ROW_NUMBER() OVER (ORDER BY yr) AS grp
    FROM MissingYears
),
FinalRanges AS (
    SELECT 
        MIN(yr) AS Start_Year,
        MAX(yr) AS End_Year
    FROM Grouped
    GROUP BY grp
)
SELECT 
    CAST(Start_Year AS VARCHAR) + ' - ' + CAST(End_Year AS VARCHAR) AS Years
FROM FinalRanges
ORDER BY Start_Year
OPTION (MAXRECURSION 32767);
