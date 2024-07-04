CREATE SCHEMA IF NOT EXISTS assignment3;

-- Create Students table
CREATE TABLE
  IF NOT EXISTS assignment3.Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    student_major VARCHAR(100)
  );

-- Create Courses table
CREATE TABLE
  IF NOT EXISTS assignment3.Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    course_description VARCHAR(255)
  );

-- Create Enrollments table
CREATE TABLE
  IF NOT EXISTS assignment3.Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES assignment3.Students (student_id),
    FOREIGN KEY (course_id) REFERENCES assignment3.Courses (course_id)
  );

-- Insert data into Students table
INSERT INTO
  assignment3.Students (student_id, student_name, student_major)
VALUES
  (1, 'Alice', 'Computer Science'),
  (2, 'Bob', 'Biology'),
  (3, 'Charlie', 'History'),
  (4, 'Diana', 'Mathematics');

-- Insert data into Courses table
INSERT INTO
  assignment3.Courses (course_id, course_name, course_description)
VALUES
  (
    101,
    'Introduction to CS',
    'Basics of Computer Science'
  ),
  (102, 'Biology Basics', 'Fundamentals of Biology'),
  (
    103,
    'World History',
    'Historical events and cultures'
  ),
  (104, 'Calculus I', 'Introduction to Calculus'),
  (105, 'Data Structures', 'Advanced topics in CS');

-- Insert data into Enrollments table
INSERT INTO
  assignment3.Enrollments (
    enrollment_id,
    student_id,
    course_id,
    enrollment_date
  )
VALUES
  (1, 1, 101, '2023-01-15'),
  (2, 2, 102, '2023-01-20'),
  (3, 3, 103, '2023-02-01'),
  (4, 1, 105, '2023-02-05'),
  (5, 4, 104, '2023-02-10'),
  (6, 2, 101, '2023-02-12'),
  (7, 3, 105, '2023-02-15'),
  (8, 4, 101, '2023-02-20'),
  (9, 1, 104, '2023-03-01'),
  (10, 2, 104, '2023-03-05');