CREATE SCHEMA IF NOT EXISTS assignment2;

-- Grades table
CREATE TABLE assignment2.Grades (
  grade_id INT PRIMARY KEY,
  grade_name VARCHAR(10)
);

-- Students table
CREATE TABLE assignment2.Students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(50),
  student_age INT,
  student_grade_id INT,
  FOREIGN KEY (student_grade_id) REFERENCES assignment2.Grades(grade_id)
);


-- Courses table
CREATE TABLE assignment2.Courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(50)
);

-- Enrollments table
CREATE TABLE assignment2.Enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  enrollment_date DATE,
  FOREIGN KEY (student_id) REFERENCES assignment2.Students(student_id),
  FOREIGN KEY (course_id) REFERENCES assignment2.Courses(course_id)
);

-- Insert into Grades table
INSERT INTO assignment2.Grades (grade_id, grade_name) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C');

-- Insert into Courses table
INSERT INTO assignment2.Courses (course_id, course_name) VALUES
(101, 'Math'),
(102, 'Science'),
(103, 'History');

-- Insert into Students table
INSERT INTO assignment2.Students (student_id, student_name, student_age, student_grade_id) VALUES
(1, 'Alice', 17, 1),
(2, 'Bob', 16, 2),
(3, 'Charlie', 18, 1),
(4, 'David', 16, 2),
(5, 'Eve', 17, 1),
(6, 'Frank', 18, 3),
(7, 'Grace', 17, 2),
(8, 'Henry', 16, 1),
(9, 'Ivy', 18, 2),
(10, 'Jack', 17, 3);

-- Insert into Enrollments table
INSERT INTO assignment2.Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
(1, 1, 101, '2023-09-01'),
(2, 1, 102, '2023-09-01'),
(3, 2, 102, '2023-09-01'),
(4, 3, 101, '2023-09-01'),
(5, 3, 103, '2023-09-01'),
(6, 4, 101, '2023-09-01'),
(7, 4, 102, '2023-09-01'),
(8, 5, 102, '2023-09-01'),
(9, 6, 101, '2023-09-01'),
(10, 7, 103, '2023-09-01');


-- Assignments
-- Find all students enrolled in the Math course.
SELECT * FROM assignment2.Students s
JOIN assignment2.Enrollments e
ON e.student_id = s.student_id
JOIN assignment2.Courses c
ON c.course_id = e.course_id
WHERE course_name = 'Math';

SELECT student_name FROM assignment2.Students s 
WHERE  s.student_id IN(
	SELECT student_id FROM assignment2.Enrollments e, assignment2.Courses c 
	WHERE  e.course_id = c.course_id 
	AND c.course_name = 'Math'
);

-- List all courses taken by students named Bob.
SELECT * FROM assignment2.Students s
JOIN assignment2.Enrollments e
ON e.student_id = s.student_id
JOIN assignment2.Courses c
ON c.course_id = e.course_id
WHERE student_name = 'Bob';

SELECT course_name FROM assignment2.Courses 
WHERE course_id IN(
	SELECT e.course_id FROM assignment2.Enrollments e, assignment2.Students s 
	WHERE  e.student_id = s.student_id
	AND s.student_name = 'Bob'
);

-- Find the names of students who are enrolled in more than one course.
SELECT student_name FROM assignment2.Students s
JOIN assignment2.Enrollments e
ON e.student_id = s.student_id
GROUP BY s.student_name
HAVING COUNT(course_id) > 1;

SELECT student_name FROM assignment2.Students s 
WHERE student_id IN(
	SELECT student_id FROM assignment2.Enrollments e 
	GROUP BY student_id 
	HAVING count(course_id) > 1
);

-- List all students who are in Grade A (grade_id = 1).
SELECT student_name FROM assignment2.Students s
JOIN assignment2.Grades g
ON s.student_grade_id = g.grade_id
WHERE grade_name='A';

SELECT student_name FROM assignment2.Students s 
WHERE student_grade_id IN(
	SELECT grade_id FROM assignment2.Grades g 
	WHERE grade_name = 'A'
); 


-- Find the number of students enrolled in each course.
SELECT course_name, COUNT(e.student_id) AS student_count
FROM assignment2.Enrollments e
JOIN assignment2.Courses c
ON c.course_id = e.course_id
GROUP BY course_name;

SELECT course_name, 
    (SELECT COUNT(*)
     FROM assignment2.Enrollments e
     WHERE e.course_id = c.course_id) AS student_count
FROM assignment2.Courses c;

-- Retrieve the course with the highest number of enrollments.
SELECT course_name, COUNT(s.student_id) AS student_count
FROM assignment2.Students s
JOIN assignment2.Enrollments e
ON e.student_id = s.student_id
JOIN assignment2.Courses c
ON c.course_id = e.course_id
GROUP BY course_name
HAVING COUNT(e.student_id)=(
  SELECT COUNT(student_id) FROM assignment2.Enrollments 
  GROUP BY course_id 
  ORDER BY COUNT(student_id) DESC LIMIT 1
);


SELECT course_name,(
	SELECT Count(*) FROM assignment2.Enrollments e
	WHERE c.course_id = e.course_id
)
FROM assignment2.Courses c 
WHERE c.course_id IN (
	SELECT course_id 
	FROM assignment2.Enrollments e
	GROUP BY course_id 
	HAVING COUNT(e.student_id) = (
		SELECT COUNT(student_id) FROM assignment2.Enrollments 
		GROUP BY course_id 
		ORDER BY COUNT(student_id) DESC LIMIT 1
	) 
);


-- List students who are enrolled in all available courses.
SELECT student_name FROM assignment2.Students s
JOIN assignment2.Enrollments e
ON e.student_id = s.student_id
JOIN assignment2.Courses c
ON c.course_id = e.course_id
GROUP BY student_name
HAVING COUNT(e.course_id)=(
  SELECT COUNT(course_id) FROM assignment2.Courses
);

SELECT student_name FROM assignment2.Students s 
WHERE student_id IN(
	SELECT student_id FROM assignment2.Enrollments e
	GROUP BY student_id 
	HAVING COUNT(e.course_id) = (
		SELECT 	COUNT(*) FROM assignment2.Courses
	) 
);

-- Find students who are not enrolled in any courses.
SELECT student_name FROM assignment2.Students s
LEFT JOIN assignment2.Enrollments e
ON e.student_id = s.student_id 
GROUP BY student_name
HAVING COUNT(e.course_id)=0;

SELECT student_name FROM assignment2.Students s
WHERE s.student_id NOT IN (
  SELECT student_id FROM assignment2.Enrollments
  GROUP BY student_id
  HAVING COUNT(course_id) > 0
);
-- Retrieve the average age of students enrolled in the Science course.
SELECT AVG(s.student_age) AS average_age_science FROM assignment2.Students s
JOIN assignment2.Enrollments e
ON e.student_id = s.student_id
JOIN assignment2.Courses c
ON c.course_id = e.course_id
WHERE c.course_name='Science';

SELECT AVG(s.student_age) AS average_age_science 
FROM assignment2.Students s WHERE student_id IN(
	SELECT student_id FROM assignment2.Enrollments e
	WHERE course_id IN (
		SELECT  course_id FROM assignment2.Courses c 
		WHERE course_name = 'Science'
	)
);

-- Find the grade of students enrolled in the History course.
SELECT student_name AS name, grade_name AS grade FROM assignment2.Students s
JOIN assignment2.Enrollments e
ON e.student_id = s.student_id
JOIN assignment2.Courses c
ON c.course_id = e.course_id
JOIN assignment2.Grades g
ON g.grade_id=s.student_grade_id
WHERE c.course_name='History';

SELECT student_name,
(
	SELECT g.grade_name FROM assignment2.Grades g
	WHERE s.student_grade_id = g.grade_id
)
FROM assignment2.Students s 
WHERE student_id IN (
			SELECT student_id  FROM assignment2.Enrollments 
			WHERE course_id = (
				SELECT course_id FROM assignment2.Courses 
				WHERE course_name = 'History'
		)	
); 

