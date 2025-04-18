SELECT letter
FROM letters
ORDER BY 
    CASE WHEN letter = 'b' THEN 0 ELSE 1 END, 
    letter;

SELECT letter
FROM letters
ORDER BY 
    CASE WHEN letter = 'b' THEN 1 ELSE 0 END, 
    letter;

WITH Ordered AS (
    SELECT letter,
           ROW_NUMBER() OVER (ORDER BY letter) AS rn
    FROM letters
    WHERE letter <> 'b'
), B AS (
    SELECT letter FROM letters WHERE letter = 'b'
)
SELECT letter FROM Ordered WHERE rn < 3
UNION ALL
SELECT letter FROM B
UNION ALL
SELECT letter FROM Ordered WHERE rn >= 3
ORDER BY 
    CASE 
        WHEN rn < 3 THEN rn 
        WHEN letter = 'b' THEN 3 
        ELSE rn + 1 
    END;
