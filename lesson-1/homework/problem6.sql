create table customer (
    customer_id int primary key,
    name varchar(100),
    city varchar(100) constraint df_city default 'Unknown'
);
alter table customer
drop constraint df_city;

alter table customer
add constraint df_city default 'Unknown' for city;
