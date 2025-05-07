SET DATEFIRST 7;

DECLARE @FirstOfMonth DATE = '2025-05-01';
DECLARE @LastOfMonth DATE = EOMONTH(@FirstOfMonth);

-- Recursive CTE to build the list of dates in the month
WITH DatesCTE AS (
    SELECT @FirstOfMonth AS CalendarDate
    UNION ALL
    SELECT DATEADD(DAY, 1, CalendarDate)
    FROM DatesCTE
    WHERE DATEADD(DAY, 1, CalendarDate) <= @LastOfMonth
),
-- Add week and weekday labels
LabeledDates AS (
    SELECT
        CalendarDate,
        DATEPART(WEEK, DATEADD(DAY, -DATEPART(WEEKDAY, @FirstOfMonth), CalendarDate)) AS WeekNum,
        CHOOSE(DATEPART(WEEKDAY, CalendarDate), 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday') AS DayOfWeek
)
-- Pivot into calendar table
SELECT
    WeekNum,
    MAX(CASE WHEN DayOfWeek = 'Sunday' THEN CalendarDate END) AS Sunday,
    MAX(CASE WHEN DayOfWeek = 'Monday' THEN CalendarDate END) AS Monday,
    MAX(CASE WHEN DayOfWeek = 'Tuesday' THEN CalendarDate END) AS Tuesday,
    MAX(CASE WHEN DayOfWeek = 'Wednesday' THEN CalendarDate END) AS Wednesday,
    MAX(CASE WHEN DayOfWeek = 'Thursday' THEN CalendarDate END) AS Thursday,
    MAX(CASE WHEN DayOfWeek = 'Friday' THEN CalendarDate END) AS Friday,
    MAX(CASE WHEN DayOfWeek = 'Saturday' THEN CalendarDate END) AS Saturday
FROM LabeledDates
GROUP BY WeekNum
ORDER BY WeekNum
OPTION (MAXRECURSION 1000);
