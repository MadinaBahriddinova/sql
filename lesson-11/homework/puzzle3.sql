-- Create a view that summarizes all the required aggregations
CREATE VIEW vw_MonthlyWorkSummary AS
SELECT 
    -- Employee-level aggregation
    wl.EmployeeID,
    wl.EmployeeName,
    wl.Department,
    SUM(wl.HoursWorked) AS TotalHoursWorked,
    
    -- Department total and average using subqueries
    (SELECT SUM(HoursWorked) 
     FROM WorkLog w2 
     WHERE w2.Department = wl.Department) AS TotalHoursDepartment,

    (SELECT AVG(HoursWorked * 1.0) 
     FROM WorkLog w3 
     WHERE w3.Department = wl.Department) AS AvgHoursDepartment

FROM WorkLog wl
GROUP BY wl.EmployeeID, wl.EmployeeName, wl.Department;

-- Retrieve the records
SELECT * FROM vw_MonthlyWorkSummary;
