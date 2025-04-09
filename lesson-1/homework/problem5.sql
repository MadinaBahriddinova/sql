create table account(
    account_id int primary key,
    balance decimal(10, 2) constraint chk_balance check (balance >= 0),
    account_type varchar(50) constraint chk_account_type check (account_type in ('Saving', 'Checking'))
);
alter table account
drop constraint chk_balance;

alter table account
drop constraint chk_account_type;

alter table account
add constraint chk_balance check (balance >= 0);

alter table account
add constraint chk_account_type check (account_type in ('Saving', 'Checking'));
