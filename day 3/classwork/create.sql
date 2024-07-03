CREATE SCHEMA IF NOT EXISTS day3classwork;

CREATE TABLE
    day3classwork.employees (
        emp_id SERIALPRIMARYKEY,
        emp_nameVARCHAR (100) NOTNULL,
        emp_salaryDECIMAL (10, 2),
        emp_dept_idINT,
        emp_manager_idINT
    );

CREATE TABLE
    day3classwork.departments (
        dept_id SERIALPRIMARYKEY,
        dept_nameVARCHAR (100) NOTNULL,
        dept_head_idINT,
        LOCATIONVARCHAR (100)
    );

CREATE TABLE
    day3classwork.projects (
        project_id SERIALPRIMARYKEY,
        project_nameVARCHAR (100) NOTNULL,
        project_budgetDECIMAL (12, 2),
        start_dateDATE,
        end_dateDATE
    );

CREATE TABLE
    day3classwork.employee_projects (
        emp_idINT,
        project_idINT,
        PRIMARYKEY (emp_id, project_id),
        FOREIGNKEY (emp_id) REFERENCESemployees (emp_id) FOREIGNKEY (project_id) REFERENCESprojects (project_id)
    );

CREATE TABLE
    day3classwork.salaries (
        salary_id SERIALPRIMARYKEY,
        emp_idINT,
        salary_amountDECIMAL (10, 2) NOTNULL,
        salary_dateDATENOTNULLFOREIGNKEY (emp_id) REFERENCESemployees (emp_id)
    );

INSERT INTO
    day3classwork.employees (emp_name, emp_salary, emp_dept_id, emp_manager_id)
VALUES
    ('John Doe', 60000.00, 1, NULL),
    ('Jane Smith', 70000.00, 1, 1),
    ('Michael Johnson', 65000.00, 2, NULL),
    ('Emily Davis', 62000.00, 2, 3),
    ('Robert Brown', 68000.00, 1, 1),
    ('Jessica Wilson', 64000.00, 2, 3),
    ('David Martinez', 61000.00, 3, NULL),
    ('Lisa Anderson', 69000.00, 3, 7),
    ('Daniel Taylor', 63000.00, 3, 7),
    ('Sarah Garcia', 66000.00, 1, 1);

INSERT INTO
    day3classwork.departments (dept_name, dept_head_idLOCATION)
VALUES
    ('Sales', 1, 'New York'),
    ('Marketing', 3, 'San Francisco'),
    ('Finance', 7, 'Chicago'),
    ('HR', 10, 'Utah'),
    ('ADMIN', 11, 'California'),
    ('ACCOUNT', 12, 'texas');

INSERT INTO
    day3classwork.projects (
        project_name,
        project_budget,
        start_date,
        end_date
    )
VALUES
    (
        'Project A',
        100000.00,
        '2024-01-01',
        '2024-06-30'
    ),
    (
        'Project B',
        150000.00,
        '2024-02-15',
        '2024-07-31'
    ),
    (
        'Project C',
        120000.00,
        '2024-03-01',
        '2024-08-15'
    ),
    ('Project D', 90000.00, '2024-04-01', '2024-09-30'),
    (
        'Project E',
        110000.00,
        '2024-05-01',
        '2024-10-31'
    );

INSERT INTO
    day3classwork.employee_projects (emp_id, project_id)
VALUES
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 2),
    (5, 1),
    (6, 3),
    (7, 3),
    (8, 2),
    (9, 1),
    (10, 3);

INSERT INTO
    day3classwork.salaries (emp_id, salary_amount, salary_date)
VALUES
    (1, 60000.00, '2024-06-01'),
    (2, 70000.00, '2024-06-01'),
    (3, 65000.00, '2024-06-01'),
    (4, 62000.00, '2024-06-01'),
    (5, 68000.00, '2024-06-01'),
    (6, 64000.00, '2024-06-01'),
    (7, 61000.00, '2024-06-01'),
    (8, 69000.00, '2024-06-01'),
    (9, 63000.00, '2024-06-01'),
    (10, 66000.00, '2024-06-01');