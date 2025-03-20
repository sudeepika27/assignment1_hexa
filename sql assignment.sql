create database TechShop
use techshop
-- 1.TABLE CUSTOMERS
create table Customers(
customerID int constraint pk_cid primary key,
firstname varchar(50),
lastname varchar(50),
Email varchar(50),
Phone bigint,
address varchar(100))
-- 2. TABLE PRODUCTS
create table products(
productID int constraint pk_pid primary key,
productname varchar(50),
description varchar(100),
price decimal)
-- 3. TABLE ORDERS
create table orders(
orderID int constraint pk_oid primary key,
customerid int Constraint fk_oid Foreign key references customers(customerid),
orderdate datetime,
totalamount decimal)
-- 4. TABLE ORDERDETAILS
create table orderdetails(
orderdetailid int constraint pk_odid primary key,
orderid int constraint fk_odid foreign key references orders(orderid),
productid int constraint fk_podid foreign key references products(productid),
quantity int)
-- 5. TABLE INVENTORY
create table inventory(
inventoryid int constraint pk_iid primary key,
productid int constraint fk_iid foreign key references products(productid),
quantityinstock int,
laststockupdate datetime)



 
 
 --- TABLE 1
insert into customers values(1,'abhi','a','abhi@gmail.com',9876543217,'andhra'),
(2,'bhavya','b','bhavya@gmail.com',9876543216,'andhra'),
(3,'chitra','c','chitra@gmail.com',9876543215,'andhra'),
(4,'deepa','d','deepa@gmail.com',9876543214,'andhra'),
(5,'eswari','e','eswari@gmail.com',9876543213,'andhra'),
(6,'fatima','f','fatima@gmail.com',9876543212,'andhra'),
(7,'ganesh','g','ganesh@gmail.com',9876543211,'andhra'),
(8,'hari','h','hari@gmail.com',9876543218,'andhra'),
(9,'ian','i','ian@gmail.com',9876543219,'andhra'),
(10,'james','j','james@gmail.com',9876543277,'andhra')


 
 -- TABLE 2
insert into products values(1, 'Mouse', 'designed with adjustable pin', 799.00),
(2, 'Keyboard', 'RGB backlit with blue switches', 1999.00),
(3, 'Charger', 'Fast charging adapter', 599.00),
(4, 'Speaker', 'Portable speaker with deep bass', 1499.00),
(5, 'Smartwatch', 'Fitness tracker with heart rate monitor', 2499.00),
(6, 'Headset', 'Noise-canceling mic with 7.1 surround sound', 2999.00),
(7, 'Hard Drive', '1TB storage with USB 3.0', 3499.00),
(8, 'Earbuds', 'Bluetooth 5.0 with touch controls', 1799.00),
(9, 'PowerBank', '10000mAh with fast charging support', 999.00),
(10, 'Laptop', '5-fan setup with adjustable angles', 88899.00)

 
 
 -- TABLE 3
insert into orders values(1, 1, '2025-03-01', 2599.00),
(2, 2, '2025-03-02', 4999.00),
(3, 3, '2025-03-03', 1499.00),
(4, 4, '2025-03-04', 3499.00),
(5, 5, '2025-03-05', 1999.00),
(6, 6, '2025-03-06', 2799.00),
(7, 7, '2025-03-07', 3999.00),
(8, 8, '2025-03-08', 599.00),
(9, 9, '2025-03-09', 899.00),
(10, 10, '2025-03-10', 1299.00)

--TABLE 4

insert into orderdetails values
(1, 1, 1, 2),
(2, 1, 2, 1),
(3, 2, 3, 4),
(4, 3, 4, 1),
(5, 4, 5, 3),
(6, 5, 6, 2),
(7, 6, 7, 1),
(8, 7, 8, 5),
(9, 8, 9, 2),
(10, 9, 10, 3)

 -- TABLE 5
insert into inventory values
(1, 1, 50, '2025-02-01'),
(2, 2, 30, '2025-02-05'),
(3, 3, 40, '2025-02-10'),
(4, 4, 20, '2025-02-12'),
(5, 5, 35, '2025-02-15'),
(6, 6, 25, '2025-02-20'),
(7, 7, 15, '2025-02-22'),
(8, 8, 45, '2025-02-25'),
(9, 9, 60, '2025-02-28'),
(10, 10, 10, '2025-03-01')

--1
 select firstname,email from customers

--2
select o.orderid, o.orderdate, c.firstname,c.lastname
from orders o
join customers c
on o.customerid = c.customerID

--3 
 insert into Customers (customerID,firstname, email,address)values (11,'kelly','doe',kelly@gmail.com,9876543211,'nextchennai')

--4
update products
set price = price *1.10


--5
delete from orderdetails where orderid = 3
delete from orders where orderid = 3

--6
insert into orders(orderid,customerid,orderdate,totalamount)values(11,11,'2025-03-14',6599)

--7
update customers
set email = 'abhinay@gmail.com',
address ='kerala'
where customerID = 1

--8
 update orders
 set totalamount = (select sum(p.price * od.quantity)
 from orderdetails od
 join products p
 on od.productid = p.productid
 where od.orderid = orders.orderID
 )

--9
 delete from orderdetails
where orderid in (select orderid from orders
where customerid = 3)

delete from orders
where customerid =3

--10
insert into products values (11,'geaser','portable',9000.0)

--11
alter table orders
add status varchar(30) default 'pending'
update orders
set status = 'shipped'
where orderid=1

--12
alter table customers
add order_count int

update customers 
set order_count = (select count(*)
from orders o
where o.customerid = customers.customerid)


---TASK 3

--1
select o.orderid,c.*
from orders o
join customers c
on c.customerID = o.customerid

--2
select p.productname,sum(p.price*o.quantity) as totalrevenue
from products p
join orderdetails o
on p.productID = o.productid
group by p.productname
order by totalrevenue desc

--3
select c.*,o.orderid
from Customers c
left join orders o 
on o.customerid = c.customerID

--4
select top(1) sum(o.quantity) as popular,p.productname
from orderdetails o
join products p
on p.productID = o.orderid
group by p.productname
order by popular desc

--5
select p.productname,o.*
from orderdetails o
join products p
on p.productID = o.orderid

--6
select avg(o.totalamount) as avgamount, c.firstname
from customers c
left join orders o 
on c.customerid = o.customerid
group by c.firstname

--7
select top 1 o.orderid, c.customerid, c.firstname, c.lastname, c.email, c.phone, c.address,  
       sum(p.price * od.quantity) as total_revenue  
from orders o  
join customers c on o.customerid = c.customerid  
join orderdetails od on o.orderid = od.orderid  
join products p on od.productid = p.productid  
group by o.orderid, c.customerid, c.firstname, c.lastname, c.email, c.phone, c.address  
order by total_revenue desc;


--8
select p.productname, count(o.orderid) as count
from products p
join orderdetails o
on p.productID = o.productid
group by p.productname

--9
select c.firstname
from Customers c
join orders o
on c.customerid = o.customerid
join orderdetails od
on o.orderid = od.orderid
join products p
on p.productID = od.productid
where productname ='keyboard'

--10
select sum(p.price*o.quantity) as totalrevenue
from products p
join orderdetails o
on p.productID = o.productid
join orders od
on od.orderID = o.orderid
where od.orderdate between '2025-03-01' and '2025-03-10'


--TASK 4

--1
select c.firstname
from customers c
where c.customerID not in (select customerid from orders)
 
 --2
 select count(productname) as no_of_products
 from products
 where productid in ( select productID from inventory where QuantityInStock > 0)

 --3
 select sum(totalamount) as revenue
 from orders


 --4
alter table products
add category varchar(40)

update products
set category = 'health'
where productid in (1,3,5)

update products
set category = 'electronics'
where productid in (2,4,6,7)

update products 
set category = 'crime'
where productid in (8,9,10)


select avg(od.quantity) as average
from orderdetails od
where od.productid in (select productid from products
where category = 'health')


--5
select sum(totalamount) as revenue 
from orders 
 where customerid = 1
group by customerid

--6
select c.firstname , (select count(orderid) from orders where  customerid = c.customerid )
from customers c
where (select count(orderid)
from orders o
where  o.customerid = c.customerid) = (select max(count(o.orderid))
from orders
group by customerid
)


--7
select c.category,(select sum(quantity) from orderdetails od where od.orderid in select(o.orderid from orders
o where o.ocustomerid = c.customerid)) as total 
from customer c
where (select sum(quantity) from orderdetails od where od.orderid in ( select o.orderid from order o 
where o.customerid = c.customerid)) = (select(max(total)
from (select sum(quantity) as total
from orderdetails od
where od.orderid in ( select orderid
from orders o)
group by od.orderid)as order_total))


--8
select top 3 c.firstname, c.lastname, sum(o.totalamount) as total_spent
from customers c
join orders o on c.customerid = o.customerid
group by c.firstname, c.lastname
order by total_spent desc;


--9
select sum(totalamount)/count(orderid) as average
from orders

 --10
 select c.firstname,(select count(orderid) from orders where orders.customerid = c.customerid)
 from customers c
