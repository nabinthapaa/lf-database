CREATE SCHEMA IF NOT EXISTS assignment1;

ALTER SEQUENCE assignment1.products_product_id_seq RESTART WITH 1;
ALTER SEQUENCE assignment1.orders_order_id_seq RESTART WITH 1;

CREATE TABLE IF NOT EXISTS assignment1.products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL,
  price DECIMAL NOT NULL
);

CREATE TABLE IF NOT EXISTS assignment1.orders (
  order_id SERIAL PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  product_id INT,
  quantity INT DEFAULT 1,
  order_date DATE DEFAULT CURRENT_DATE,
  FOREIGN KEY(product_id) REFERENCES assignment1.products(product_id)
);

-- Truncating for intersetion
TRUNCATE TABLE assignment1.orders; 
TRUNCATE TABLE assignment1.products;

-- Insertions into products table 
INSERT INTO  assignment1.products (product_name, category, price) VALUES 
('Zucchini - Yellow', 'Vegetable', 27.37),
('Currants', 'Fruit', 36.03),
('Wine - White, Chardonnay', 'Beverage', 38.48),
('Green Scrubbie Pad H.duty', 'Cleaning Supplies', 31.32),
('Compound - Mocha', 'Food Ingredient', 21.88),
('Steamers White', 'Seafood', 28.66),
('Mushroom - Shitake, Dry', 'Vegetable', 22.46),
('Dill Weed - Dry', 'Herb', 36.73),
('Puree - Kiwi', 'Fruit', 20.80),
('The Pop Shoppe - Grape', 'Beverage', 30.98),
('Carrots', 'Vegetable', 15.25),
('Tomatoes', 'Vegetable', 12.10),
('Lettuce', 'Vegetable', 8.50),
('Spinach', 'Vegetable', 7.99),
('Blueberries', 'Fruit', 18.45),
('Apple Juice', 'Beverage', 5.50),
('Dish Soap', 'Cleaning Supplies', 3.75),
('Cocoa Powder', 'Food Ingredient', 11.20),
('Salmon', 'Seafood', 25.00),
('Rosemary', 'Herb', 14.30),
('Strawberry Puree', 'Fruit', 19.80);

--Insertins  into orders
INSERT INTO assignment1.orders (customer_name,  quantity, product_id, order_date) VALUES 
('John Doe', 1, 2, '2024-06-21'),
('Jane Smith', 2, 1, '2024-06-22'),
('Michael Brown', 3, 4, '2024-06-23'),
('Emily Davis', 4, 3, '2024-06-24'),
('David Wilson', 5, 5, '2024-06-25'),
('Sophia Johnson', 6, 2, '2024-06-26'),
('William Lee', 7, 6, '2024-06-27'),
('Olivia Martin', 8, 1, '2024-06-28'),
('James White', 9, 4, '2024-06-29'),
('Mia Gonzalez', 10, 12,'2024-06-30'),
('Alexander Clark', 11, 3, '2024-07-01'),
('Chris Green', 12, 13, '2024-07-02'),
('Nancy Adams', 13, 2, '2024-07-03'),
('Brandon Harris', 14, 5, '2024-07-04'),
('Patricia Clark', 15, 4, '2024-07-05'),
('Linda Taylor', 16, 13, '2024-07-06'),
('Joseph Allen', 17, 16, '2024-07-07'),
('Angela Scott', 18, 12, '2024-07-08'),
('Matthew Brown', 19, 11, '2024-07-09'),
('Barbara King', 20, 14, '2024-07-10'),
('Jennifer Lee', 21, 12, '2024-07-11');

-- Displaying both orders and products TABLE
SELECT * FROM assignment1.products;
SELECT * FROM assignment1.orders;

-- Count of prodcuts category
SELECT category, COUNT(product_id) FROM assignment1.products 
GROUP BY category 
ORDER BY COUNT(product_id) 
DESC;

-- Count of orders
SELECT product_name, COUNT(order_id) AS order_count, SUM(quantity) as total_quantity 
FROM assignment1.orders 
JOIN assignment1.products 
ON assignment1.orders.product_id=assignment1.products.product_id 
GROUP BY assignment1.products.product_id
HAVING SUM(quantity) > 5
ORDER BY COUNT(order_id) DESC;

-- altering table products to add a discount percentage
ALTER TABLE assignment1.products ADD COLUMN IF NOT EXISTS discount_percent INT DEFAULT 5;

-- Displaying both orders and products TABLE
SELECT * FROM assignment1.products;

-- Updating product price
UPDATE assignment1.products 
SET discount_percent=
  CASE 
    WHEN price>35 THEN 8
    WHEN price>30 AND price<35 THEN 6
    ELSE 5
  END
;

SELECT * FROM assignment1.products;
SELECT * FROM assignment1.orders;

DELETE FROM assignment1.products WHERE price<10 CASCADE;
SELECT * FROM assignment1.products;
SELECT * FROM assignment1.orders;

