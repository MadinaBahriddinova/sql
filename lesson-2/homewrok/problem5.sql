create table worker (
    id int,
    name varchar(100)
);

bulk insert worker
from 'C:\path\to\workers.csv'
with (
    firstrow = 2,               -- skip header row
    fieldterminator = ',',      -- comma-separated
    rowterminator = '\n',       -- newline for each row
    tablock
);

select * from worker;
