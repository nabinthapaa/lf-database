WITH max_salaries AS( 
	SELECT e.emp_dept_id AS dept_id, max(emp_salary) AS emp_salary 
	FROM day3classwork.employees e 
	GROUP BY e.emp_dept_id 
)SELECT dept_name, ms.emp_salary 
FROM day3classwork.departments d 
JOIN max_salaries ms
ON ms.dept_id = d.dept_id ;

CREATE SCHEMA IF NOT EXISTS day4classwork;

-- Table to store customers
CREATE TABLE day4classwork.customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255)
);

-- Table to store products
CREATE TABLE day4classwork.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);

-- Table to store orders
CREATE TABLE day4classwork.orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES day4classwork.customers(customer_id)
);

-- Table to store order details (relation between orders and products)
CREATE TABLE day4classwork.order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES day4classwork.orders(order_id),
    FOREIGN KEY (product_id) REFERENCES day4classwork.products(product_id)
);

-- View to display all orders with customer details
CREATE VIEW day4classwork.order_details_view AS
SELECT order_id, order_date, total_amount, c.* 
FROM day4classwork.orders o 
JOIN day4classwork.customers c 
ON o.customer_id = c.customer_id;

-- Create a materialized view to store total sales per customer
CREATE MATERIALIZED VIEW day4classwork.order_details_m_view AS
SELECT c.customer_id, c.first_name, c.last_name, COUNT(order_id) AS total_sales
FROM day4classwork.orders o 
JOIN day4classwork.customers c 
ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;


-- Create orders table
CREATE TABLE day4classwork.orders_second (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL
);

-- Create order_items table
CREATE TABLE day4classwork.order_second_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMERIC(8, 2) NOT NULL,
    CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES day4classwork.orders_second(order_id)
);


CREATE OR REPLACE PROCEDURE increase_amount(
	amount int,
	orderId int,
	customerId int
)
LANGUAGE plpgsql
AS $$
BEGIN 
	UPDATE day4classwork.orders_second
	SET total_amount = total_amount + amount
	WHERE order_id = orderId
	AND customer_id = customerId;

	COMMIT;
END;$$;

CREATE OR REPLACE PROCEDURE get_total_sales(
	customerId int,
	orderId int
)
LANGUAGE plpgsql
AS $$
BEGIN 
	SELECT customer_id, SUM(unit_price * quantity)
	FROM day4classwork.orders_second os
	WHERE customer_id = customerId
	AND order_id = orderId
	JOIN day4classwork.order_second_items osi
	ON os.order_id = osi.order_id
	GROUP BY customer_id;
END;$$;








































