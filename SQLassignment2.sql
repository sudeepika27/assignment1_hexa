create database Student_Information_System
use Student_Information_System

--TABLE STUDENTS

create table students
(student_id int constraint pk_sid primary key,
first_name varchar(30),
last_name varchar(30),
date_of_birth datetime,
email varchar(40),
phone_number bigint)

--TABLE COURSES

create table courses
(course_id int constraint pk_cid primary key,
course_name varchar(30),
credits int,
teacher_id int constraint fk_tid foreign key references teacher(teacher_id))


--TABLE ENROLLMENTS

create table enrollments
(enrollment_id int constraint pk_eid primary key,
student_id int constraint fk_sid foreign key references students(student_id),
course_id int constraint fk_cid foreign key references courses(course_id),
enrollment_date datetime)

--TABLE TEACHER

create table teacher
(teacher_id int constraint pk_tid primary key ,
first_name varchar(30),
last_name varchar(30),
email varchar(40))

--TABLE PAYMENTS

create table payments
(payment_id int constraint pk_pid primary key ,
student_id int constraint fk_spid foreign key references students(student_id),
amount int,
payment_date datetime)

-- STUDENTS
INSERT INTO Students (student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES 
(1, 'Aarav', 'Sharma', '2003-05-10', 'aarav.sharma@email.com', '9876543210'),
(2, 'Diya', 'Patel', '2004-02-15', 'diya.patel@email.com', '9876543211'),
(3, 'Kunal', 'Reddy', '2002-09-22', 'kunal.reddy@email.com', '9876543212'),
(4, 'Meera', 'Iyer', '2003-11-30', 'meera.iyer@email.com', '9876543213'),
(5, 'Arjun', 'Verma', '2001-08-19', 'arjun.verma@email.com', '9876543214'),
(6, 'Riya', 'Singh', '2003-03-25', 'riya.singh@email.com', '9876543215'),
(7, 'Rohan', 'Kumar', '2002-12-12', 'rohan.kumar@email.com', '9876543216'),
(8, 'Simran', 'Das', '2004-07-08', 'simran.das@email.com', '9876543217'),
(9, 'Vikram', 'Naik', '2003-06-11', 'vikram.naik@email.com', '9876543218'),
(10, 'Neha', 'Roy', '2002-04-03', 'neha.roy@email.com', '9876543219');


-- COURSES

INSERT INTO Courses (course_id, course_name, credits, teacher_id)
VALUES 
(101, 'Mathematics', 4, 201),
(102, 'Physics', 3, 202),
(103, 'Chemistry', 3, 203),
(104, 'Computer Science', 4, 204),
(105, 'Electronics', 3, 205),
(106, 'Artificial Intelligence', 4, 206),
(107, 'Data Science', 3, 207),
(108, 'Communication Skills', 2, 208),
(109, 'Environmental Science', 2, 209),
(110, 'Digital Logic Design', 4, 210);


--ENROLLMENTS

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES 
(1, 1, 101, '2024-01-10'),
(2, 2, 102, '2024-02-05'),
(3, 3, 103, '2024-03-01'),
(4, 4, 104, '2024-03-15'),
(5, 5, 105, '2024-04-20'),
(6, 6, 106, '2024-05-10'),
(7, 7, 107, '2024-06-11'),
(8, 8, 108, '2024-07-15'),
(9, 9, 109, '2024-08-25'),
(10, 10, 110, '2024-09-30');


-- TEACHER

INSERT INTO Teacher (teacher_id, first_name, last_name, email)
VALUES 
(201, 'Anita', 'Sharma', 'anita.sharma@email.com'),
(202, 'Rajesh', 'Kumar', 'rajesh.kumar@email.com'),
(203, 'Sanjay', 'Patel', 'sanjay.patel@email.com'),
(204, 'Deepika', 'Iyer', 'deepika.iyer@email.com'),
(205, 'Amit', 'Verma', 'amit.verma@email.com'),
(206, 'Priya', 'Singh', 'priya.singh@email.com'),
(207, 'Kiran', 'Das', 'kiran.das@email.com'),
(208, 'Neha', 'Roy', 'neha.roy@email.com'),
(209, 'Suresh', 'Naik', 'suresh.naik@email.com'),
(210, 'Vivek', 'Reddy', 'vivek.reddy@email.com');


--PAYMENTS

INSERT INTO Payments (payment_id, student_id, amount, payment_date)
VALUES 
(1, 1, 1000, '2024-01-15'),
(2, 2, 2000, '2024-02-10'),
(3, 3, 1500, '2024-03-20'),
(4, 4, 3000, '2024-04-05'),
(5, 5, 2500, '2024-05-12'),
(6, 6, 3500, '2024-06-18'),
(7, 7, 2000, '2024-07-22'),
(8, 8, 1800, '2024-08-10'),
(9, 9, 2750, '2024-09-05'),
(10, 10, 3200, '2024-10-01');

select * from students
select * from 

--TASK 2

--1
insert into students values(11,'john','deo','1995-08-15',': john.doe@example.com',1234567890)

--2
insert into enrollments values ( 11,11,101,'2025-03-13')

--3
update teacher
set email = 'raj.kumar@email.com'
where teacher_id = 202

--4
delete from enrollments
where student_id = 1 and course_id = 101

--5
 update courses
 set teacher_id = 202
 where course_id = 102

 --6
 delete from enrollments 
 where student_id = 2
 delete from students
 where student_id = 2
 
 --7
 update payments
 set amount = 5000
 where payment_id = 3
   
  -- TASK 3

  --1
  select  s.first_name,sum(p.amount) as total
 from students s
 join payments p
 on p.student_id = s.student_id
 group by first_name

 --2
select c.course_name ,count(e.enrollment_id) as no_of_stu
from courses c
join enrollments e
on e.course_id = c.course_id
group by c.course_name

--3
select s.first_name
from students s
left join enrollments e
on s.student_id = e.student_id
where e.student_id is null

--4
select s.first_name,s.last_name,c.course_name
from students s
join enrollments e
on e.student_id = s.student_id
join courses c
on c.course_id = e.course_id

--5
select t.first_name,c.course_name
from teacher t
join courses c
on t.teacher_id =c.teacher_id

--6
select s.first_name,e.enrollment_date,c.course_name
from students s
join enrollments e
on e.student_id = s.student_id
join courses c
on c.course_id = e.course_id

--7
select s.first_name
from students s
left join payments p
on p.student_id = s.student_id
where p.student_id is null

--8
select c.course_name
from courses c
left join enrollments e
on e.course_id = c.course_id
where e.course_id is null

--9
select e.student_id, count(e1.course_id) as count_
from enrollments e
join enrollments e1
on e.student_id = e1.student_id
GROUP BY e.student_id  
HAVING COUNT(DISTINCT e1.course_id) > 1;

--10
select t.first_name
from teacher t
left join courses c
on c.teacher_id = t.teacher_id
where c.teacher_id is null


--TASK 4s
--1
select avg(student_count) as avg_students_per_course
from (select course_id, count(student_id) as student_count
from enrollments
group by course_id
) as course_enrollments

--2
select s.first_name, s.last_name
from students s
where s.student_id = (select student_id 
from payments 
where amount = (select max(amount) from payments)
)


--3
select s.first_name
from students s
left join enrollments e
on s.student_id = e.student_id
where e.student_id is null


--4
select s.first_name,s.last_name,c.course_name
from students s
join enrollments e  on e.student_id = s.student_id
join courses c on c.course_id = e.course_id

--5
select t.first_name,c.course_id
from teacher t
join courses c on t.teacher_id = c.teacher_id
)

--6
select t.first_name
from teacher t
where t.teacher_id not in (select c.teacher_id from courses c)

--7
select avg(datediff(year,date_of_birth, getdate()))as average
from students


--8
select c.course_name
from courses c
where c.course_id not in (select e.course_id from enrollments e)

--9
select s.first_name, c.course_name, sum(p.amount) as total_payment
from students s
join enrollments e on s.student_id = e.student_id
join courses c on e.course_id = c.course_id
join payments p on s.student_id = p.student_id
group by s.first_name, c.course_name
