use subquery1;

-- BASIC SUB QUERIES
-- 1. Find employees whose salary is greater than the average salary of all employees.
select name, department, salary
from emp
where
    salary > (
        select avg(salary)
        from emp
    );
-- 2. Find employees whose age is less than the youngest employee in the HR department.
SELECT *
from emp
where
    age < (
        select age
        from emp
        where
            department = 'HR'
        order by age
        limit 1
    );
-- 3. Find employees living in the same city as Ravi
select name
from emp
where
    city = (
        select city
        from emp
        where
            name = 'Ravi'
    );
-- 4. Find employees with the same salary as Karan
select name
from emp
where
    salary = (
        select salary
        from emp
        where
            name = 'karan'
    );

-- 5. Find employees earning more than Sneha
select name
from emp
where
    salary > (
        select salary
        from emp
        where
            name = 'sneha'
    );

-- 6. Find employees working in the same department as Nisha
SELECT name
from emp
where
    department = (
        select department
        from emp
        where
            name = 'Nisha'
    );
-- 7. Find employees who live in the same cities as Finance department employees.
select name
from emp
where
    city in (
        select city
        from emp
        where
            department = 'Finance'
    );
-- 8. Find employees older than any employee in the Sales department.
SELECT name
from emp
where
    age > (
        select age
        from emp
        where
            department = 'sales'
        order by age
        limit 1
    );

-- 9. Find employees earning more than all employees in HR.
select name
from emp
where
    salary > (
        select salary
        from emp
        where
            department = 'HR'
        order by salary desc
        limit 1
    );

-- 10. Find employees working in a department where at least one employee earns more than 70,000.
SELECT department, name
FROM emp
WHERE
    department IN (
        SELECT DISTINCT
            department
        FROM emp
        WHERE
            salary > 70000
    );

select * from emp;
-- CORRELATED SUB QUERIES
-- 11. Find employees whose salary is greater than the average salary of their department.
select e1.name, e1.department, e1.salary
from emp as e1
where
    salary > (
        select avg(salary)
        from emp e2
        where
            e1.department = e2.department
    );
-- 12. Find employees earning the maximum salary in their department.
select e1.name, e1.department, e1.salary
from emp as e1
where
    salary = (
        select max(salary)
        from emp as e2
        where
            e1.department = e2.department
    );
-- 13. Find employees earning the minimum salary in their department.
select e1.name, e1.department, e1.salary
from emp as e1
where
    salary = (
        select min(salary)
        from emp as e2
        where
            e1.department = e2.department
    );

-- 14. Find employees older than the average age of their department.
select e1.name, e1.department, e1.age
from emp as e1
where
    age > (
        select avg(age)
        from emp as e2
        where
            e1.department = e2.department
    );

-- 15. Find employees who have the same city as at least one of their department colleagues.
SELECT e1.name, e1.department, e1.city
FROM emp e1
WHERE
    EXISTS (
        SELECT 1
        FROM emp e2
        WHERE
            e2.department = e1.department
            AND e2.city = e1.city
            AND e2.EmpID <> e1.EmpID
    );
-- 16. Find the city with the maximum number of employees.

SELECT city, COUNT(*) AS total_employees
FROM emp
GROUP BY
    city
ORDER BY total_employees DESC
LIMIT 1;

-- 17. Find employees whose salary equals the second-highest salary in the company.
select *
from emp
where
    salary = (
        select max(salary)
        from emp
        where
            salary < (
                select max(salary)
                from emp
            )
    );
-- 18. Find employees whose salary equals the third-highest salary in the company.
select *
from emp
where
    salary = (
        select max(salary)
        from emp
        where
            salary < (
                select max(salary)
                from emp
                where
                    salary < (
                        select max(salary)
                        from emp
                    )
            )
    );
-- 19. Find employees whose salary is greater than the average salary of employees in Delhi.
select *
from emp
where
    salary > (
        select avg(salary)
        from emp
        where
            city = 'Delhi'
    );
-- 20. Find employees who earn more than the average salary of employees who are older than 30
select *
from emp
where
    salary > (
        select avg(salary)
        from emp
        where
            age > 30
    );
-- 21. Find employees who are younger than the oldest employee in Sales department.
select *
from emp
where
    age < (
        select age
        from emp
        where
            department = 'Sales'
        order by age desc
        limit 1
    );
-- 22. Find employees whose salary is greater than the average salary of Finance employees but less than the maximum salary of IT employees.
select *
from emp
where
    salary > (
        select avg(salary)
        from emp
        where
            department = 'Finance'
    )
    and (
        select min(salary)
        from emp
        where
            department = 'IT'
    );
-- 23. Find employees who belong to the department that has the least number of employees.
select *
from emp
where
    department = (
        select department
        from emp
        group by
            department
        order by count(*)
        limit 1
    );
-- 24. Find employees whose city has more employees than the city of Priya.
SELECT e1.name, e1.city
FROM emp e1
WHERE (
        SELECT COUNT(*)
        FROM emp e2
        WHERE
            e2.city = e1.city
    ) > (
        SELECT COUNT(*)
        FROM emp
        WHERE
            city = (
                SELECT city
                FROM emp
                WHERE
                    name = 'Priya'
            )
    );
-- 25. Find employees who belong to the department where the average salary is greater than 55,000.
SELECT e1.name, e1.department, e1.salary
FROM emp e1
WHERE (
        SELECT AVG(e2.salary)
        FROM emp e2
        WHERE
            e2.department = e1.department
    ) > 55000;
-- 26. Find employees who earn more than the average salary of all employees but less than the maximum salary of their department.
select e1.name, e1.department, e1.salary
from emp e1
where
    salary > (
        select avg(salary)
        from emp e2
        where
            e2.department = e1.department
    )
    and salary < (
        select max(salary)
        from emp e3
        where
            e3.department = e1.department
    );
-- 27. Find employees whose salary is above the company average and age is below the company average.
SELECT name, salary, age
FROM emp
WHERE salary > (SELECT AVG(salary) FROM emp)
AND age < (SELECT AVG(age) FROM emp);