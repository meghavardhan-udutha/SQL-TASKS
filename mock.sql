use mock;
show tables;


CREATE TABLE Departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2),
    date_join DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

INSERT INTO Departments (dept_name) VALUES
('IT'),
('HR'),
('Finance'),
('Marketing');

INSERT INTO Employees (emp_name, salary, date_join, dept_id) VALUES
('Rahul', 50000, '2021-05-10', 1),
('Sneha', 35000, '2019-03-15', 2),
('Arjun', 60000, '2022-07-20', 1),
('Meera', 45000, '2020-11-25', 3),
('Kiran', 30000, '2023-01-12', 4);


-- INNER JOIN Questions
-- 1.	Display employee name and their department name using INNER JOIN.
select e.emp_name, d.dept_name from employees e inner join departments d on e.dept_id = d.dept_id;
-- 2.	Display all employee details along with department name for employees who belong to a department.
select e.*, d.dept_name from employees e inner join departments d on e.dept_id = d.dept_id;
-- 3.	Find employees working in the IT department using INNER JOIN.
select e.* from employees e inner join departments d on e.dept_id = d.dept_id where d.dept_name = 'IT';
-- 4.	Count the number of employees in each department.
select d.dept_name, COUNT(e.emp_id) from employees e inner join departments d on e.dept_id = d.dept_id group by d.dept_name;
-- 5.	Display employees whose salary is greater than 40,000 along with their department name.
select e.emp_name, d.dept_name from employees e inner join departments d on e.dept_id = d.dept_id where e.salary > 40000;
-- 6.	Display employees who joined after 2020 along with department name.  date_join > ‘2020-01-01’
select e.emp_name, d.dept_name from employees e inner join departments d on e.dept_id = d.dept_id where e.date_join > '2020-01-01';
-- 7.	Find the maximum salary in each department.
SELECT d.dept_name, MAX(e.salary) AS max_salary
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;
-- 8.	Retrieve employees whose department name starts with 'H'.
SELECT e.emp_name, d.dept_name
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id
WHERE d.dept_name LIKE 'H%';
-- 9.	List all employees whose department ID matches in both tables.
SELECT e.*
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id;
-- 10.	Display employee names, salaries, and department names sorted by department name  
SELECT e.emp_name, e.salary, d.dept_name
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id
ORDER BY d.dept_name ASC;


CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    duration_months INT
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100),
    join_date DATE,
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Courses (course_name, duration_months) VALUES
('Java', 6),
('Python', 5),
('SQL', 3),
('Data Science', 8),
('Cyber Security', 7);

INSERT INTO Students (student_name, join_date, course_id) VALUES
('Amit', '2024-02-10', 1),
('Neha', '2024-03-15', 2),
('Ravi', '2023-12-01', 1),
('Priya', '2024-05-20', 3),
('Karan', '2025-01-05', 2);

-- RIGHT JOIN Questions (Course–Student)
-- 1.	Display all courses and their students using RIGHT JOIN.
select c.course_name, s.student_name from students s right join courses c on c.course_id = s.course_id;
-- 2.	Display all courses even if no students are enrolled.
select c.course_name, s.student_name from students s right join courses c on c.course_id = s.course_id;
-- 3.	Find courses that do not have any students using RIGHT JOIN.
select c.course_name from students s right join courses c on c.course_id = s.course_id where s.student_name is NULL;
-- 4.	Display course names and student names, showing NULL where students are not available.
select c.course_name, s.student_name from students s right join courses c on c.course_id = s.course_id;
-- 5.	Count the number of students in each course using RIGHT JOIN.
select c.course_name, count(s.student_name) from students s right join courses c on c.course_id = s.course_id group by c.course_name;
-- 6.	Display course names and latest student join date for each course.
SELECT c.course_name, 
       MAX(s.join_date) AS latest_join_date
FROM Students s
RIGHT JOIN Courses c
ON s.course_id = c.course_id
GROUP BY c.course_name;
-- 7.	List all courses with the total number of students enrolled.
select c.course_name, count(s.student_name) from students s right join courses c on c.course_id = s.course_id group by c.course_name;

-- 8.	Display course details along with student details where course IDs match.
SELECT c.*, s.*
FROM Students s
RIGHT JOIN Courses c
ON s.course_id = c.course_id;
-- 9.	Find courses where students joined after 2024-01-01 using RIGHT JOIN.
SELECT c.course_name, s.student_name, s.join_date
FROM Students s
RIGHT JOIN Courses c
ON s.course_id = c.course_id
WHERE s.join_date > '2024-01-01';
-- 10.	Display all course names and student names ordered by course name using RIGHT JOIN.
SELECT c.course_name, s.student_name
FROM Students s
RIGHT JOIN Courses c
ON s.course_id = c.course_id
ORDER BY c.course_name ASC;
