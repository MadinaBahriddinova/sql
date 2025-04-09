create table invoice (
    invoice_id int identity(1,1) primary key,
    amount decimal(10,2)
);
insert into invoice (amount) values (100.00);
insert into invoice (amount) values (200.00);
insert into invoice (amount) values (300.00);
insert into invoice (amount) values (400.00);
insert into invoice (amount) values (500.00);

set identity_insert invoice on;

insert into invoice (invoice_id, amount) values (100, 999.99);

set identity_insert invoice off;
