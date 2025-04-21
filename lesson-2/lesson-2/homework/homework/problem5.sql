create table worker (
    id int,
    name varchar(100)
);

bulk insert worker
from 'C:\path\to\workers.csv'
with (
    firstrow = 2,               
    fieldterminator = ',',     
    rowterminator = '\n',       
    tablock
);

select * from worker;
