create table orders (
    order_id int constraint pk_orders primary key,
    customer_name varchar(100),
    order_date date
);
alter table orders
drop constraint pk_orders;

alter table orders
add constraint pk_orders primary key (order_id);
