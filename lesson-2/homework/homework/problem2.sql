drop table if exists data_types_demo;
create table data_types_demo (
    id int,                              
    name varchar(50),                    
    age tinyint,                         
    is_active bit,                       
    balance decimal(10,2),               
    rating float,                        
    birth_date date,                     
    created_at datetime,                 
    notes text,                          
    profile_image varbinary(max)         
);

insert into data_types_demo (
    id, name, age, is_active, balance, rating, birth_date, created_at, notes, profile_image
)
values (
    1,
    'alice',
    25,
    1,
    1234.56,
    4.5,
    '2000-01-01',
    getdate(),
    'this is a test note',
    convert(varbinary(max), 'samplebinarydata')
);

select * from data_types_demo;
