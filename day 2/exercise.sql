CREATE SCHEMA IF NOT EXISTS day2;


ALTER SEQUENCE day2.location_location_id_seq RESTART WITH 1;

CREATE TABLE IF NOT EXISTS day2.employees(
  emp_id INT,
  emp_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE,
  salary DECIMAL,
  department VARCHAR(50) DEFAULT 'UNKNOWN',
  created_at TIMESTAMP DEFAULT CURRENT_DATE,
  PRIMARY KEY(emp_id),
  CHECK ( salary > 25000 )
);


CREATE TABLE IF NOT EXISTS day2.location(
  location_id SERIAL,
  emp_id INT,
  city VARCHAR(150),
  state VARCHAR(100),
  PRIMARY KEY(location_id),
  FOREIGN KEY(emp_id) REFERENCES day2.employees(emp_id)
);

TRUNCATE TABLE day2.location, day2.employees;

INSERT INTO day2.employees (emp_id, emp_name, email, salary, department)
VALUES 
(1, 'John Doe', 'john.doe@example.com', 30000, 'Sales'),
(2, 'Jane Smith', 'jane.smith@example.com', 45000, 'Engineering'),
(3, 'Jake Johnson', 'jake.johnson@example.com', 50000, 'Marketing'),
(4, 'Julia Roberts', 'julia.roberts@example.com', 55000, 'Finance'),
(5, 'James Brown', 'james.brown@example.com', 35000, 'Finance');

INSERT INTO day2.employees(emp_id, emp_name, email, salary)
VALUES (6, 'Harry Brook', 'harry@rmai.com', 26000);


INSERT INTO day2.location (emp_id,city, state)
VALUES 
(1, 'New York', 'NY'),
(3, 'San Francisco', 'CA'),
(3, 'Chicago', 'IL'),
(3, 'Houston', 'TX'),
(4, 'Miami', 'FL'),
(2, 'New York', 'NY'),
(5, 'New York', 'CA'),
(6, 'Miami', 'FL');

SELECT * FROM day2.employees;
SELECT * FROM day2.employees WHERE salary BETWEEN 30000 AND 50000;
UPDATE day2.employees SET salary=salary+5000;
SELECT * FROM day2.employees;

SELECT * FROM day2.employees WHERE department='Sales';
SELECT * FROM day2.employees WHERE email LIKE 'j%';

SELECT department, AVG(salary) as average_salary, MIN(salary) as min_salary, MAX(salary) as max_salary
FROM day2.employees 
GROUP BY department;


SELECT city,COUNT(location_id)
FROM day2.location 
GROUP BY city;
