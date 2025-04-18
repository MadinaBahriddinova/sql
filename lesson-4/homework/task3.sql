SELECT EmpId, EmpName, BirthDate
FROM EmpBirth
WHERE 
    MONTH(BirthDate) = 5
    AND DAY(BirthDate) BETWEEN 7 AND 15;
