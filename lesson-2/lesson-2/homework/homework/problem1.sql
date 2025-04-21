-- create the table
create table test_identity (
    id int identity(1,1) primary key,
    value varchar(50)
);

-- insert 5 rows
insert into test_identity (value) values 
('row 1'), ('row 2'), ('row 3'), ('row 4'), ('row 5');

delete from test_identity;
  
insert into test_identity (value) values ('new row');
-- id will be 6

truncate table test_identity;

insert into test_identity (value) values ('new row');
-- id will be 1

drop table test_identity;


