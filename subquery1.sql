create DATABASE subquery1;
use subquery1;

CREATE TABLE Emp (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    Age INT,
    City VARCHAR(50)
);
INSERT INTO Emp (EmpID, Name, Department, Salary, Age, City) VALUES
(1, 'Amit', 'HR', 35000, 29, 'Delhi'),
(2, 'Sneha', 'Finance', 48000, 32, 'Mumbai'),
(3, 'Ravi', 'IT', 55000, 28, 'Bangalore'),
(4, 'Priya', 'Sales', 40000, 30, 'Chennai'),
(5, 'Karan', 'Finance', 60000, 35, 'Delhi'),
(6, 'Meena', 'HR', 30000, 26, 'Pune'),
(7, 'Suresh', 'IT', 70000, 40, 'Hyderabad'),
(8, 'Divya', 'Sales', 42000, 27, 'Mumbai'),
(9, 'Vikram', 'Finance', 65000, 36, 'Bangalore'),
(10, 'Nisha', 'IT', 72000, 31, 'Delhi'),
(11, 'Rohit', 'HR', 31000, 25, 'Chennai'),
(12, 'Pooja', 'Sales', 38000, 29, 'Pune'),
(13, 'Anil', 'Finance', 58000, 34, 'Hyderabad'),
(14, 'Neha', 'IT', 64000, 33, 'Mumbai'),
(15, 'Rajesh', 'Sales', 45000, 37, 'Delhi'),
(16, 'Komal', 'HR', 33000, 28, 'Bangalore'),
(17, 'Deepak', 'Finance', 52000, 30, 'Chennai'),
(18, 'Swati', 'IT', 76000, 38, 'Pune'),
(19, 'Arjun', 'Sales', 47000, 29, 'Hyderabad'),
(20, 'Lakshmi', 'Finance', 61000, 32, 'Delhi'),
(21, 'Manoj', 'IT', 69000, 36, 'Bangalore'),
(22, 'Sakshi', 'Sales', 39000, 26, 'Mumbai'),
(23, 'Harish', 'HR', 29500, 24, 'Chennai'),
(24, 'Kavita', 'Finance', 57000, 35, 'Hyderabad'),
(25, 'Sunil', 'IT', 73000, 39, 'Delhi'),
(26, 'Ramesh', 'Sales', 46000, 33, 'Pune'),
(27, 'Jyoti', 'Finance', 59000, 31, 'Bangalore'),
(28, 'Ashok', 'IT', 71000, 34, 'Mumbai'),
(29, 'Tanvi', 'Sales', 41000, 27, 'Delhi'),
(30, 'Gaurav', 'HR', 34000, 29, 'Hyderabad');

select * from emp;

-- BASIC SUB QUERIES
-- 1. Find employees whose salary is greater than the average salary of all employees.
select name, department, salary from emp where salary > (select avg(salary) from emp);
-- 2. Find employees whose age is less than the youngest employee in the HR department.
SELECT * from emp where age < (select age from emp where department = 'HR' order by age limit 1);
-- 3. Find employees living in the same city as Ravi
select name from emp where city = (select city from emp where name = 'Ravi');
-- 4. Find employees with the same salary as Karan
select name from emp where salary = (select salary from emp where name = 'karan');

-- 5. Find employees earning more than Sneha
select name from emp where salary > (select salary from emp where name = 'sneha');

-- 6. Find employees working in the same department as Nisha
SELECT name from emp where department = (select department from emp where name = 'Nisha');
-- 7. Find employees who live in the same cities as Finance department employees.
select name from emp where city in (select city from emp where department = 'Finance');
-- 8. Find employees older than any employee in the Sales department.
SELECT name from emp where age > (select age from emp where department = 'sales' order by age limit 1);

-- 9. Find employees earning more than all employees in HR.
select name from emp where salary > (select salary from emp where department = 'HR' order by salary desc limit 1);