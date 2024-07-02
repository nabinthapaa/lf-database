CREATE TABLE IF NOT EXISTS pop_schema.employees (
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

INSERT INTO pop_schema.employees (id, name, age, email, phone) VALUES
(1, 'pop', 20, 'pop@email.com', '9867789890'),
(2, 'top', 20, 'top@email.com', '9867789889');

SELECT * FROM (SELECT employee, COUNT(id) FROM pop_schema.employees) WHERE count > 4;
SELECT employee, COUNT(id) FROM pop_schema.employees HAVING COUNT(id) > 4;
