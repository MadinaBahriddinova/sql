create table photos (
    id int primary key,
    image_data varbinary(max)
);

insert into photos (id, image_data)
select 1, 
    bulkcolumn 
from openrowset(
    bulk 'C:\path\to\your\image.jpg', 
    single_blob
) as img;