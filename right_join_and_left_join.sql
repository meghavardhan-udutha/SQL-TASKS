use mock;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    order_amount DECIMAL(10,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO Customers (customer_name, city) VALUES
('Rahul', 'Hyderabad'),
('Sneha', 'Mumbai'),
('Arjun', 'Bangalore'),
('Meera', 'Chennai'),
('Kiran', 'Delhi');
INSERT INTO Orders (order_date, order_amount, customer_id) VALUES
('2024-01-10', 2500, 1),
('2024-02-15', 5000, 1),
('2024-03-20', 1500, 2),
('2024-04-05', 7000, 3),
('2024-05-18', 3500, 3);

-- 1.	Display all customers and their order details using LEFT JOIN.
select c.customer_name, o.order_id, o.order_date, o.order_amount from customers c left join orders o on o.customer_id = c.customer_id;
-- 2.	Show all customers including those who have not placed any orders.
select c.customer_name, o.order_id from customers c left join orders o on o.customer_id = c.customer_id;

-- 3.	Find customers who have no orders using LEFT JOIN.
select c.customer_name from customers c left join orders o on o.customer_id = c.customer_id where o.order_id is null;

-- 4.	Display customer names and order amounts, showing NULL where orders are not available.
select c.customer_name,o.order_amount from customers c left join orders o on o.customer_id = c.customer_id;

-- 5.	List all customers and their order dates, including customers without orders.
select c.customer_name, o.order_date from customers c left join orders o on o.customer_id = c.customer_id;

-- 6.	Count the number of orders per customer, including customers with zero orders.
select c.customer_name, count(o.order_id) from customers c left join orders o on o.customer_id = c.customer_id group by c.customer_name;
-- 7.	Show all customers and their latest order date, including customers who never ordered.
SELECT c.customer_id,
       c.customer_name,
       MAX(o.order_date) AS latest_order_date
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
-- 8.	Find customers who have placed more than one order using LEFT JOIN.
SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1;
-- 9.	Display customer details along with order details where the order amount is greater than 3000, including customers with no orders.
SELECT c.customer_id,
       c.customer_name,
       o.order_id,
       o.order_amount
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
AND o.order_amount > 3000;