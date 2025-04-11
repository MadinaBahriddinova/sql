create table student (
    id int primary key,
    name varchar(50),
    classes int,
    tuition_per_class decimal(10,2),
    total_tuition as (classes * tuition_per_class)
);

insert into student (id, name, classes, tuition_per_class) values
(1, 'alice', 5, 300.00),
(2, 'bob', 3, 400.00),
(3, 'charlie', 4, 250.00);

select * from student;
