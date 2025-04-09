-- create the book table
create table book (
    book_id int primary key,
    title varchar(255),
    author varchar(255),
    published_year int
);

-- create the member table
create table member (
    member_id int primary key,
    name varchar(255),
    email varchar(255),
    phone_number varchar(50)
);

-- create the loan table with foreign key constraints
create table loan (
    loan_id int primary key,
    book_id int,
    member_id int,
    loan_date date,
    return_date date null,
    constraint fk_loan_book foreign key (book_id) references book(book_id),
    constraint fk_loan_member foreign key (member_id) references member(member_id)
);

insert into book (book_id, title, author, published_year)
values 
    (1, 'to kill a mockingbird', 'harper lee', 1960),
    (2, '1984', 'george orwell', 1949),
    (3, 'pride and prejudice', 'jane austen', 1813);

insert into member (member_id, name, email, phone_number)
values 
    (1, 'john doe', 'john.doe@example.com', '123-456-7890'),
    (2, 'jane smith', 'jane.smith@example.com', '234-567-8901'),
    (3, 'alice johnson', 'alice.johnson@example.com', '345-678-9012');

insert into loan (loan_id, book_id, member_id, loan_date, return_date)
values 
    (1, 1, 1, '2025-03-01', '2025-03-15'),
    (2, 2, 1, '2025-03-05', null),  -- book is still borrowed
    (3, 3, 2, '2025-03-10', '2025-03-20');
