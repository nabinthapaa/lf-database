CREATE SCHEMA IF NOT EXISTS assignment4;

CREATE TABLE IF NOT EXISTS assignment4.employees(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
    last_name VARCHAR(50),
    sex CHAR(1),
    doj DATE,
    current_date_ DATE,
    designation VARCHAR(50),
    age INTEGER,
    salary NUMERIC(10, 2),
    unit VARCHAR(50),
    leaves_used INT,
    leaves_remaining INT,
    ratings INT,
    past_exp INT
);

-- Copy csv files to tables
-- COPY assignment4.employees 
-- FROM '/Salary Prediction of Data Professions.csv'
-- DELIMITER ','
-- CSV HEADER;

-- Calculate the average salary by department for all Analysts.
WITH analyst as(
	SELECT id AS analyst_id, unit, salary AS analyst_salary 
	FROM assignment4.employees
	WHERE designation LIKE '%Analyst'
)SELECT unit, ROUND(avg(analyst_salary), 2) 
FROM analyst a 
GROUP BY unit;


-- List all employees who have used more than 10 leaves.
WITH employees as(
	SELECT id AS analyst_id, concat(first_name,' ', last_name) AS emp_name ,leaves_used
	FROM assignment4.employees
)SELECT emp_name, leaves_used
FROM employees
WHERE leaves_used > 10;  


-- Create a view to show the details of all Senior Analysts.
CREATE VIEW assignment4.senior_analyst AS
SELECT * FROM assignment4.employees
WHERE designation = 'Senior Analyst';

SELECT * FROM assignment4.senior_analyst;

-- Create a materialized view to store the count of employees by department.
CREATE MATERIALIZED VIEW assignment4.employees_count AS
SELECT unit, COUNT(id) AS employees_count 
FROM assignment4.employees
GROUP BY unit;

SELECT * FROM assignment4.employees_count;

-- Create a procedure to update an employee's salary by their first name and last name.
CREATE OR REPLACE PROCEDURE update_salary(
	firstName varchar,
	lastName varchar,
	updatePercentage decimal
)
LANGUAGE plpgsql
AS $$
BEGIN 
	UPDATE assignment4.employees
	SET salary = salary + salary * updatePercentage
	WHERE first_name = firstName
	AND last_name = lastName;

	COMMIT;
END;$$;

CALL update_salary('TOMASA', 'ARMEN', 0.5);

SELECT * FROM assignment4.employees 
ORDER BY id
LIMIT 5;

-- Create a procedure to calculate the total number of leaves used across all departments.
CREATE OR REPLACE PROCEDURE used_leaves(
	INOUT _total_leaves int DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN 
	SELECT sum(leaves_used)
	FROM assignment4.employees 
	INTO _total_leaves;
END;$$;

CALL used_leaves(); 
 





























