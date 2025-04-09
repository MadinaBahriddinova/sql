create table books (
    book_id int identity(1,1) primary key,
    title varchar(255) not null constraint ck_title_nonempty check (len(title) > 0),
    price decimal(10,2) constraint ck_price_positive check (price > 0),
    genre varchar(100) not null constraint df_genre default 'unknown'
);
-- valid insert: all columns specified
insert into books (title, price, genre) 
values ('harry potter and the sorcerer''s stone', 19.99, 'fantasy');

-- valid insert: genre column omitted, default 'unknown' should be applied
insert into books (title, price) 
values ('lord of the rings', 29.99);

-- invalid insert: empty title (should trigger ck_title_nonempty)
insert into books (title, price) 
values ('', 9.99);

-- invalid insert: price less than or equal to 0 (should trigger ck_price_positive)
insert into books (title, price) 
values ('some book with invalid price', 0);

select * from books;
