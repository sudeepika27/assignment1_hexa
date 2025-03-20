create database BankingSystem
use bankingsystem

-- customers table
create table customers (
    customer_id int constraint pk_id primary key,
    first_name varchar(50),
    last_name varchar(50),
    dob date,
    email varchar(100),
    phone_number varchar(20),
    address text
);

--  accounts table
create table accounts (
    account_id int constraint pk_aid primary key,
    customer_id int,
    account_type varchar(20), 
    balance decimal(10,2) constraint fk_balance 
    foreign key (customer_id) references customers(customer_id)
);

-- transactions table
create table transactions (
    transaction_id int constraint pk_tid primary key,
    account_id int,
    transaction_type varchar(20), 
    amount decimal(15,2),
    transaction_date datetime, constraint fk_tid
    foreign key (account_id) references accounts(account_id)
);

insert into customers (customer_id, first_name, last_name, dob, email, phone_number, address) values
(1, 'john', 'doe', '1990-05-15', 'john.doe@email.com', '1234567890', '123 main st, ny'),
(2, 'jane', 'smith', '1985-08-22', 'jane.smith@email.com', '9876543210', '456 oak st, la'),
(3, 'michael', 'johnson', '1992-12-10', 'michael.j@email.com', '5678901234', '789 pine st, sf'),
(4, 'emily', 'davis', '1995-07-18', 'emily.d@email.com', '6789012345', '321 maple st, houston'),
(5, 'david', 'wilson', '1988-03-25', 'david.w@email.com', '7890123456', '654 birch st, chicago'),
(6, 'lisa', 'brown', '1993-09-05', 'lisa.b@email.com', '8901234567', '987 cedar st, miami'),
(7, 'robert', 'martin', '1991-11-30', 'robert.m@email.com', '9012345678', '135 walnut st, seattle'),
(8, 'susan', 'lee', '1994-06-12', 'susan.l@email.com', '0123456789', '246 elm st, denver'),
(9, 'james', 'taylor', '1987-02-14', 'james.t@email.com', '1234509876', '579 spruce st, atlanta'),
(10, 'karen', 'anderson', '1996-04-09', 'karen.a@email.com', '2345678901', '802 fir st, boston');

insert into accounts (account_id, customer_id, account_type, balance) values
(101, 1, 'savings', 5000.00),
(102, 2, 'current', 10000.50),
(103, 3, 'zero_balance', 0.00),
(104, 4, 'savings', 7500.25),
(105, 5, 'current', 15000.75),
(106, 6, 'savings', 2000.00),
(107, 7, 'zero_balance', 0.00),
(108, 8, 'current', 5000.00),
(109, 9, 'savings', 8500.30),
(110, 10, 'current', 12000.45);


insert into transactions (transaction_id, account_id, transaction_type, amount, transaction_date) values
(201, 101, 'deposit', 1000.00, '2024-03-01 10:00:00'),
(202, 102, 'withdrawal', 500.00, '2024-03-02 12:30:00'),
(203, 103, 'transfer', 200.00, '2024-03-03 14:45:00'),
(204, 104, 'deposit', 750.00, '2024-03-04 09:15:00'),
(205, 105, 'withdrawal', 300.00, '2024-03-05 11:20:00'),
(206, 106, 'transfer', 450.00, '2024-03-06 16:05:00'),
(207, 107, 'deposit', 1200.00, '2024-03-07 08:55:00'),
(208, 108, 'withdrawal', 600.00, '2024-03-08 13:40:00'),
(209, 109, 'transfer', 800.00, '2024-03-09 15:25:00'),
(210, 110, 'deposit', 950.00, '2024-03-10 10:50:00');

--1
1. Write a SQL query to retrieve the name, account type and email of all customers. 
select c.first_name,a.account_type,c.email
from customers c
join accounts a
on a.customer_id = c.customer_id

--2
2. Write a SQL query to list all transaction corresponding customer
select t.*, c.first_name
from transactions t
join accounts a
on a.account_id = t.account_id
join customers c
on c.customer_id = a.customer_id

--3
3. Write a SQL query to increase the balance of a specific account by a certain amount
select account_id,(amount + 20) as new_bal
from transactions
where account_id = 101

update accounts
set balance = balance + 200
where account_id = 101

--4
4. Write a SQL query to Combine first and last names of customers as a full_name.

select (first_name +' ' + last_name)
from customers

--5
5.. Write a SQL query to remove accounts with a balance of zero where the account
type is savings.
delete from accounts
where account_type = 'savings' and balance =0

--6
6. Write a SQL query to Find customers living in a specific city

alter table customers
add adetails varchar(40) 
update customers
set adetails ='ap'
where customer_id in (6,7,8,9)

select c.first_name
from customers 
where adetails = 'chennai'


SELECT adetails AS city, first_name
FROM customers
ORDER BY adetails;

--7
. Write a SQL query to Get the account balance for a specific account.
select balance ,account_id
from accounts
where account_id = 101

--8
8. Write a SQL query to List all current accounts with a balance greater than $1,000.
select account_id,balance
from accounts
where balance > 1000

--9
9. Write a SQL query to Retrieve all transactions for a specific account.
select * from transactions
where 
account_id = 102

--10
10. Write a SQL query to Calculate the interest accrued on savings accounts based on a
given interest rate.

alter table accounts
add interest_rate decimal(8,2)
 select * from accounts


update accounts
set interest_rate = 6.5
where account_id in (106,107,108,109,110)

select account_id,balance,interest_rate,(balance*interest_rate/100)
from accounts
where account_type ='savings'

--11
11. Write a SQL query to Identify accounts where the balance is less than a specified
overdraft limit.

select account_id ,balance
from accounts
where balance < 1000

--12
12. Write a SQL query to Find customers not living in a specific city.
select first_name,adetails
from customers
where adetails <> 'chennai' 

--TASK 3

--1
1. Write a SQL query to Find the average account balance for all customers. 
select customer_id, avg(balance) as average
from accounts
group by customer_id


--2
2. Write a SQL query to Retrieve the top 10 highest account balances.
select top 10 balance
from accounts
order by balance desc

--3
3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
select sum(amount)
from transactions
where transaction_type = 'deposit'
and transaction_date = '2025-03-01'


--4
4. Write a SQL query to Find the Oldest and Newest Customers.
alter table customers
add created_date datetime

update customers
set created_date = '2025-03-03'
where customer_id in (7,8,9,10)

select customer_id,first_name,created_date
from customers 
where created_date 

--5
5. Write a SQL query to Retrieve transaction details along with the account type.
select t.*,a.account_type
from transactions t
join accounts a
on t.account_id = a.account_id

--6
6. Write a SQL query to Get a list of customers along with their account details.
select c.first_name,a.*
from customers c
join accounts a
on a.customer_id = c.customer_id


--7
7. Write a SQL query to Retrieve transaction details along with customer information for a
specific account.
select t.*,c.*
from customers c
join accounts a
on a.customer_id = c.customer_id
join transactions t
on t.account_id = a.account_id
where a.account_id = 101

--8
8. Write a SQL query to Identify customers who have more than one account
select c.first_name,count(a.account_id)
from customers c
join accounts a
on a.customer_id = c.customer_id
group by c.first_name
having count(a.account_id) > 1



--9
9. Write a SQL query to Calculate the difference in transaction amounts between deposits and
withdrawals.
select (select sum(amount)
from transactions where transaction_type = 'deposit') -
(select sum(amount) from transactions where transaction_type = 'withdrawal') as diff


--10
10. Write a SQL query to Calculate the average daily balance for each account over a specified
period.
select (select avg(balance) from accounts ),account_id
from accounts
group by account_id

--11
11. Calculate the total balance for each account type.
select sum(balance)as total,account_type
from accounts
group by account_type

--12
12. Identify accounts with the highest number of transactions order by descending order.
select account_id,count(transaction_id) as txn
from transactions
group by account_id 
order by txn desc

--13
13. List customers with high aggregate account balances, along with their account types.
select c.first_name, sum(a.balance)as bal,a.account_type
from customers c
join accounts a
on a.customer_id = c.customer_id
group by c.first_name,a.account_type
order by bal desc
--14
14. Identify and list duplicate transactions based on transaction amount, date, and account.
select account_id, amount, transaction_date,count(t.transaction_id) as no_of_txns
from transactions t
group by t.account_id,amount, transaction_date
having count(transaction_id) >1


--TASK 4
--1
1. Retrieve the customer(s) with the highest account balance.
select c.first_name,a.balance
from customers c
join accounts a
on  c.customer_id = a.customer_id
where a.balance = (select max(balance) from accounts)

--2
2. Calculate the average account balance for customers who have more than one account.
select avg(a.balance),c.first_name,count(account_id)
from customers c
join accounts a
on  c.customer_id = a.customer_id
group by c.first_name
having count(account_id) > 1

--3
3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
select a.account_id,t.transaction_id
from accounts a
join transactions t
on t.account_id = a.account_id
where t.amount > (select avg(amount) from transactions) 

--4
4. Identify customers who have no recorded transactions.
select c.first_name
from customers c
left join accounts a
on  c.customer_id = a.customer_id
join transactions t
on t.account_id = a.account_id
where transaction_id is null

--5
5. Calculate the total balance of accounts with no recorded transactions.
select sum(a.balance)
from accounts a
left join transactions t
on t.account_id = a.account_id
where transaction_id is null

--6
6. Retrieve transactions for accounts with the lowest balance.
select t.transaction_id,a.balance
from transactions t
join accounts a
on a.account_id = t.account_id
order by balance asc

--7
7. Identify customers who have accounts of multiple types.
select c.first_name,count(a.account_type)
from customers c
join accounts a
on a.customer_id = c.customer_id
group by c.first_name
having count(a.account_type) > 1

--8
8. Calculate the percentage of each account type out of the total number of accounts.
select account_type,count(*) as account_count,
(count(*) * 100.0 / (select count(*) from accounts)) as percentage
from accounts
group by account_type
order by percentage desc;

--9
9. Retrieve all transactions for a customer with a given customer_id.
select t.*,c.first_name
from customers c
join accounts a
on  c.customer_id = a.customer_id
join transactions t
on t.account_id = a.account_id
where c.customer_id =2

10. Calculate the total balance for each account type, including a subquery within the SELECT
clause.
select sum(a.balance) as total,a.account_type
from accounts a
group by a.account_type

