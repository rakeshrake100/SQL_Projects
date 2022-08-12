Create Table Employee(
Emp_id INT Primary key,
First_name VARCHAR(40),
Last_name VARCHAR(40),
Birth_date date,
Sex VARCHAR(1),
Salary INT,
Super_id INT,
Branch_id INT
);

Create Table Branch(
Branch_id INT Primary Key,
Branch_Name VARCHAR(20),
Mgr_ID INT,
Mgr_start_date date
References Employee(Emp_id) ON Delete Set Null
);

Create Table Client(
Client_id Int Primary Key,
Client_Name VARCHAR(40),
Branch_id INT,
foreign key(Branch_id) references Branch(Branch_id) on delete set Null
);

Create Table Works_with (
Emp_id Int,
Client_id INT,
Total_Sales int,
Primary Key(Emp_id,Client_id),
foreign key (Emp_id) References Employee(Emp_id) on delete Cascade,
foreign key (Client_id)References Client(Client_id) on delete Cascade
);

Create Table Branch_Supplier (
Branch_id INT,
Supplier_name VARCHAR(40),
Supply_type VARCHAR (40),
foreign key (Branch_id) References Branch(Branch_id) on delete Cascade
);

Alter Table Employee
Add foreign key(Branch_id)
References branch(branch_id)
on Delete SET Null;


Alter Table Employee
Add foreign key(Super_id)
References Employee(Emp_id)
on delete SET Null;

# corporate 
Insert Into Employee Values(100,'David','Wallace','1967-11-17','M',250000,NULL,NULL);
Insert Into Branch values(1,'Corporate',100,'2006-02-09');
Update Employee
Set Branch_id = 1
Where emp_id = 100;

Insert Into Employee Values(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

# Scranton
Insert Into employee Values(102, 'Michael', 'Scott', '1964-05-11', 'M', 75000, 100, Null);
Insert Into Branch Values(2, 'Scranton', 102, '1992-04-06');

Update Employee
Set Branch_id = 2
Where Emp_id =102;

Insert Into Employee Values(103, 'Angela', 'Martin', '1971-06-25','F', 63000,102,2);
Insert Into Employee Values(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000,102,2);
Insert Into Employee Values(105, 'Stanley', 'Hudson', '1969-09-19','M', 69000,102,2);

# Stamford

Insert Into Employee Values(106, 'Josh', 'Porter', '1969-09-05', 'M', 65000, 106, Null);
Insert Into Branch Values(3, 'Stamford', 106, '1998-02-13');

Update Employee
Set Branch_id = 3
Where Emp_id = 106;
Insert Into Employee Values(107, 'Andy', 'Bernard', '1973-07-22','M', 65000,106,3);
Insert Into Employee Values(108, 'Jim', 'Halpert', '1978-10-01','M',71000,106,3);

# Client 
Insert Into Client Values(400,'dunmore HighSchool', 2);
Insert Into Client Values(401,'Lackawana Country', 2);
Insert Into Client Values(402,'FedEx', 3);
Insert Into Client Values(403,'John Daly Law,LLC', 3);
Insert Into Client Values(404,'Scranton Whitepages', 2);
Insert Into Client Values(405,'Times Newspaper', 2);
Insert Into Client Values(406,'FedEx', 2);

# Works_with
Insert Into Works_with Values(105,400,55000);
Insert Into Works_with Values(102,401,267000);
Insert Into Works_with Values(108,402,22500);
Insert Into Works_with Values(107,403,5000);
Insert Into Works_with Values(108,403,12000);
Insert Into Works_with Values(105,404,33000);
Insert Into Works_with Values(107,405,26000);
Insert Into Works_with Values(102,406,15000);
Insert Into Works_with Values(105,406,130000);

# Branch_supplier
Insert Into Branch_supplier Values(2, 'Hammer Mill', 'Paper');
Insert Into Branch_supplier Values(2, 'Uni-Ball', 'Writing Utensils');
Insert Into Branch_supplier Values(3, 'Patriot Paper', 'Paper');
Insert Into Branch_supplier Values(2, 'J.T.Forms & Labels', 'Custom Forms');
Insert Into Branch_supplier Values(3, 'Uni-Ball', 'Writing Utensils');
Insert Into Branch_supplier Values(3, 'Hammer Mill', 'Paper');
Insert Into Branch_supplier Values(3, 'Stamford Labels', 'Custom Forms');

# To view all the tables 

Select * from Employee;
Select * from Branch;
Select*from Client;
Select*from Branch_supplier;
Select*from works_with;

# to view ordered by sex, name

Select * From Employee
order By sex,First_name,Last_name;

# to view first 5 employees 
Select * From Employee
Limit 5;

# to view first and last name of the employees
Select First_name, Last_name from employee;

# Find the forename and surnames of all employees
Select First_name AS 'Forename', Last_name as 'Surname' from employee;

# find out all different genders

Select distinct sex from employee;

# find the number of employee
select count(super_id) from employee;

# find the number of employee born after 1970
select count(super_id) from employee
where sex = 'F' and birth_date > '1971-01-01';

# find the average of all employees
select sum(salary) from employee;

# find out how many males and females are there
select count(sex),sex from employee
group by sex;

# find the total sales of each salesman
select sum(total_sales), Client_id
from works_with 
group by Client_id;

# wild card
Select *from branch_supplier
where supplier_name LIKE '%Label%';

Select * from employee
where birth_date LIKE '____-10';

# Union join

select first_name from employee
union
select branch_name from branch
union 
select client_name from client;


Select sum(Salary), emp_id from employee 
group by emp_id
union
select sum(total_sales),emp_id from works_with
group by emp_id;

# Joins
# Find all branches and the names of their managers

select emp_id,first_name, branch_name from employee 
Left join branch 
on emp_id = Mgr_id;

# Find names of employees who have sold more than 30000 to single client

select emp_id, first_name,last_name from employee 
where emp_id IN (
Select emp_id from works_with 
where total_sales>30000
);

# find all clients who are handled by the branch i.e, Michael Scott , assume you know Michael's ID

select client_name from client 
where branch_id = (
select branch_id from branch 
where mgr_id = 102
);

















