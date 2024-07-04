--  Retrieve the list of students and their enrolled courses.
SELECT
  student_name
FROM
  assignment3.students s
  JOIN assignment3.enrollments e ON e.student_id = s.student_id
GROUP BY
  s.student_name;

-- List all students and their enrolled courses, 
-- including those who haven't enrolled in any course.
SELECT
  student_name,
  c.course_name
FROM
  assignment3.students s
  LEFT JOIN assignment3.enrollments e ON s.student_id = e.student_id
  LEFT JOIN assignment3.courses c ON e.course_id = c.course_id
ORDER BY
  s.student_name;

-- Display all courses and the students enrolled in each course, 
-- including courses with no enrolled students.
SELECT
  c.course_name,
  student_name
FROM
  assignment3.students s
  RIGHT JOIN assignment3.enrollments e ON s.student_id = e.student_id
  RIGHT JOIN assignment3.courses c ON e.course_id = c.course_id
ORDER BY
  c.course_name;

-- Find pairs of students who are enrolled in at least one common course.
SELECT
  DISTINCTs.student_name AS student_1,
  s2.student_name AS student_2
FROM
  assignment3.enrollments e
  JOIN assignment3.enrollments e2 ON e.course_id = e2.course_id
  JOIN assignment3.students s ON e.student_id = s.student_id
  JOIN assignment3.students s2 ON e2.student_id = s2.student_id
WHERE
  e.student_id < e2.student_id;

-- Retrieve students who are enrolled in 'Introduction to CS' but not in 'Data Structures'.
SELECT
  s.student_name
FROM
  assignment3.students s
  JOIN assignment3.enrollments e ON s.student_id = e.student_id
  JOIN assignment3.courses c ON e.course_id = c.course_id
WHERE
  c.course_name = 'Introduction to CS'
  AND s.student_idNOTIN (
    SELECT
      e2.student_id
    FROM
      assignment3.enrollments e2
      JOIN assignment3.courses c2 ON e2.course_id = c2.course_id
    WHERE
      c2.course_name = 'Data Structures'
  );

-- List all students along with a row number based on their enrollment date in ascending order.
-- Using ROW_NUMBER()
SELECT
  s.student_name,
  c.course_nameROW_NUMBER () OVER (
    -- PARTITION BY e.course_id 
    ORDER BY
      e.enrollment_date
  ) AS row_number_count
FROM
  assignment3.enrollments e
  JOIN assignment3.students s ON s.student_id = e.student_id
  JOIN assignment3.courses c ON e.course_id = c.course_id;

-- Rank students based on the number of courses they are enrolled in,
-- handling ties by assigning the same rank. Using RANK()
SELECT
  s.student_name,
  COUNT(e.course_id) AS course_countRANK () OVER (
    ORDER BY
      COUNT(e.course_id) DESC
  )
FROM
  assignment3.enrollments e
  JOIN assignment3.students s ON s.student_id = e.student_id
GROUP BY
  s.student_id;

-- Rank students based on the number of courses they are enrolled in,
-- handling ties by assigning the same rank. Using DENSE_RANK();
SELECT
  c.course_name,
  COUNT(e.student_id) AS student_countDENSE_RANK () OVER (
    ORDER BY
      COUNT(e.student_id) DESC
  )
FROM
  assignment3.enrollments e
  JOIN assignment3.courses c ON e.course_id = c.course_id
GROUP BY
  c.course_name;