create table product (
    product_id int constraint uq_product_id unique,
    product_name varchar(100),
    price decimal(10, 2)
);
alter table product
drop constraint uq_product_id;

alter table product
add constraint uq_product_id_name unique (product_id, product_name);
