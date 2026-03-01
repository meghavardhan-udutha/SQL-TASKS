show databases;

create database jointaskfeb;


show tables;
create table customers(
    customer_id int primary key AUTO_INCREMENT,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    email varchar(200) unique,
    phone_number VARCHAR(11),
    address text,
    date_joined date not null
);

create table categories(
    category_id int primary key AUTO_INCREMENT,
    category_name VARCHAR(100) not null,
    description text
);

create table orders(
    order_id int PRIMARY KEY AUTO_INCREMENT,
    customer_id int not null,
    order_date date,
    total_amount DECIMAL,
    shipping_address text,
    payment_status VARCHAR(50) not null,
    Foreign Key (customer_id) REFERENCES customers(customer_id) on delete CASCADE
);

create table products(
    product_id int PRIMARY key AUTO_INCREMENT,
    name VARCHAR(100) not null,
    description text,
    price DECIMAL,
    stock_quantity int,
    category_id int not null,
    Foreign Key (category_id) REFERENCES categories(category_id) on delete cascade
);

create table order_items(
    order_item_id int PRIMARY key AUTO_INCREMENT,
    order_id int not null,
    product_id int not null,
    quantity int,
    item_price decimal,
    Foreign Key (order_id) REFERENCES orders(order_id) on DELETE CASCADE,
    Foreign Key (product_id) REFERENCES products(product_id) on delete CASCADE
);

INSERT INTO Categories (category_id, category_name, description) VALUES
(1, 'Electronics', 'Electronic devices'),
(2, 'Clothing', 'Apparel and garments'),
(3, 'Books', 'Educational and entertainment books'),
(4, 'Home Appliances', 'Household items');

INSERT INTO Customers (customer_id, first_name, last_name, email, phone_number, address, date_joined) VALUES
(1, 'John', 'Doe', 'john@example.com', '1234567890', 'New York, USA', '2023-01-15'),
(2, 'Alice', 'Smith', 'alice@example.com', '2223334444', 'Los Angeles, USA', '2023-03-10'),
(3, 'Bob', 'Johnson', 'bob@example.com', '5556667777', 'Chicago, USA', '2023-06-20'),
(4, 'Emma', 'Brown', 'emma@example.com', '8889990000', 'Houston, USA', '2024-02-01'),
(5, 'Michael', 'Davis', 'michael@example.com', '1112223333', 'Miami, USA', '2024-05-12'),
(6, 'Sophia', 'Wilson', 'sophia@example.com', '4445556666', 'Seattle, USA', '2024-07-08');

INSERT INTO Products (product_id, name, description, price, stock_quantity, category_id) VALUES
(1, 'Laptop', 'Gaming Laptop', 1200.00, 10, 1),
(2, 'Smartphone', 'Android Smartphone', 800.00, 0, 1),
(3, 'T-Shirt', 'Cotton T-Shirt', 25.00, 100, 2),
(4, 'Jeans', 'Denim Jeans', 50.00, 50, 2),
(5, 'SQL Book', 'Learn SQL Guide', 40.00, 20, 3),
(6, 'Microwave', '800W Microwave Oven', 150.00, 5, 4),
(7, 'Refrigerator', 'Double Door Fridge', 900.00, 2, 4),
(8, 'Notebook', 'College Notebook', 5.00, 200, 3);

INSERT INTO Orders (order_id, customer_id, order_date, total_amount, shipping_address, payment_status) VALUES
(1, 1, '2025-02-01', 2000.00, 'New York, USA', 'Paid'),
(2, 2, '2025-01-15', 75.00, 'Los Angeles, USA', 'Paid'),
(3, 3, '2024-12-10', 900.00, 'Chicago, USA', 'Pending'),
(4, 1, '2024-08-05', 150.00, 'New York, USA', 'Paid'),
(5, 4, '2025-02-10', 1250.00, 'Houston, USA', 'Paid'),
(6, 5, '2024-03-15', 45.00, 'Miami, USA', 'Cancelled'),
(7, 2, '2025-02-12', 3000.00, 'Los Angeles, USA', 'Paid');

INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, item_price) VALUES
-- Order 1 (John)
(1, 1, 1, 1, 1200.00),
(2, 1, 2, 1, 800.00),
-- Order 2 (Alice)
(3, 2, 3, 2, 25.00),
(4, 2, 5, 1, 40.00),
-- Order 3 (Bob)
(5, 3, 7, 1, 900.00),
-- Order 4 (John)
(6, 4, 6, 1, 150.00),
-- Order 5 (Emma)
(7, 5, 1, 1, 1200.00),
(8, 5, 3, 2, 25.00),
-- Order 6 (Michael)
(9, 6, 8, 5, 5.00),
-- Order 7 (Alice - Large Order >5 items total quantity)
(10, 7, 1, 2, 1200.00),
(11, 7, 3, 3, 25.00),
(12, 7, 5, 2, 40.00);



select * from customers;
select * from orders;
select * from products;
select * from categories;
select * from order_items;

use jointaskfeb;
-- SELF JOIN AND NATURAL JOIN
-- Join the Customers table with the Orders table to list all orders made by a specific customer.
SELECT o.order_id, o.order_date from customers s NATURAL JOIN orders o where customer_id = 6;
-- Find all orders placed by customers who live in a specific city (using the address field in Customers table).
SELECT o.order_id, o.order_date from customers c NATURAL JOIN orders o where c.address = 'Los Angeles, USA';

-- List the products and their categories by joining the Products and Categories tables.
select a.product_id, b.category_id from products a join products b on a.product_id = b.product_id;

-- Get a list of all products purchased by a particular customer, including their name, description, and quantity ordered (using Orders, Order_Items, and Products).
select * from orders o inner join order_items oi on o.order_id = oi.order_id INNER JOIN products p on p.product_id = oi.product_id;
select p.name, p.description, oi.quantity from orders o NATURAL join order_items oi NATURAL JOIN products p where o.customer_id = 1;
-- Join Order_Items with Orders to get a list of all products ordered along with the order's total amount.
select oi.order_id, oi.product_id, o.total_amount from order_items oi natural join orders o order by oi.order_id;
-- Find the total number of items ordered for each product (using Order_Items and Products).
select p.name, sum(oi.quantity) from order_items oi natural join products p group by p.name;
-- Find the customer who placed the highest value order (using Orders and Customers).
select c.first_name, c.last_name, o.total_amount from customers c NATURAL join orders o order by o.total_amount desc limit 1;
SELECT c.first_name, c.last_name, SUM(o.total_amount) AS total_spent
FROM customers c
NATURAL JOIN orders o
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 1;
-- Get a list of all customers who ordered a specific product (join Customers, Orders, and Order_Items).
select c.customer_id, c.first_name, c.last_name from order_items oi NATURAL join orders o NATURAL join customers c where oi.product_id = 1;
-- Join Products and Order_Items to find the total revenue generated by each product.
select p.name, sum(p.price * oi.quantity) from order_items oi natural join products p GROUP BY p.name;
-- Find the most popular product in each category (using Products, Order_Items, and Categories).
-- Get a list of all orders with their corresponding products, including product name and quantity ordered (using Orders, Order_Items, and Products).
SELECT o.order_id,
       p.name,
       oi.quantity
FROM orders o
NATURAL JOIN order_items oi
NATURAL JOIN products p;
-- Find the average number of items ordered per customer (using Orders and Order_Items).
SELECT AVG(total_items) AS avg_items_per_customer
FROM (
    SELECT o.customer_id,
           SUM(oi.quantity) AS total_items
    FROM orders o
    JOIN order_items oi 
         ON o.order_id = oi.order_id
    GROUP BY o.customer_id
) t;
-- List customers who have not placed any orders (using Customers and Orders).
SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
LEFT JOIN orders o 
       ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
-- Find all orders that contain more than 5 items, including customer details (using Orders, Order_Items, and Customers).
SELECT o.order_id,
       c.first_name,
       c.last_name,
       SUM(oi.quantity) AS total_items
FROM orders o
JOIN customers c 
     ON o.customer_id = c.customer_id
JOIN order_items oi 
     ON o.order_id = oi.order_id
GROUP BY o.order_id, c.customer_id, c.first_name, c.last_name
HAVING SUM(oi.quantity) > 5;
-- List the total number of products sold per category (using Products, Order_Items, and Categories).
SELECT c.category_name,
       SUM(oi.quantity) AS total_products_sold
FROM categories c
JOIN products p 
     ON c.category_id = p.category_id
JOIN order_items oi 
     ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name;
-- Find all orders placed in the last 30 days along with the products purchased (using Orders, Order_Items, and Products).
SELECT o.order_id,
       p.name,
       oi.quantity,
       o.order_date
FROM orders o
JOIN order_items oi 
     ON o.order_id = oi.order_id
JOIN products p 
     ON oi.product_id = p.product_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;
-- Get a list of products that are out of stock and were previously ordered (using Products and Order_Items).
SELECT DISTINCT p.product_id, p.name
FROM products p
JOIN order_items oi 
     ON p.product_id = oi.product_id
WHERE p.stock_quantity = 0;
-- List the products that have not been sold in the last 6 months (using Products and Order_Items).
SELECT p.product_id, p.name
FROM products p
WHERE p.product_id NOT IN (
    SELECT DISTINCT oi.product_id
    FROM order_items oi
    JOIN orders o 
         ON oi.order_id = o.order_id
    WHERE o.order_date >= CURDATE() - INTERVAL 6 MONTH
);
-- Find customers who have placed orders above a certain value threshold, with order details (using Orders, Customers).
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       o.order_id,
       o.total_amount
FROM customers c
JOIN orders o 
     ON c.customer_id = o.customer_id
WHERE o.total_amount > 1000;