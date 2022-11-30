-- Show the number of students that has 0, 1 or 2 siblings
SELECT COUNT(*) FROM (SELECT student_id, COUNT(student_id) FROM sibling GROUP BY student_id HAVING COUNT(sibling_id) = 2) as f;
SELECT COUNT(*) FROM (SELECT student_id, COUNT(student_id) FROM sibling GROUP BY student_id HAVING COUNT(sibling_id) = 1) as f;
SELECT COUNT(*) FROM (SELECT * FROM student WHERE student_id NOT IN (SELECT student_id FROM sibling)) as foo;

SELECT COUNT(*) FROM (SELECT * FROM student WHERE student_id NOT IN (SELECT student_id FROM sibling)) as foo
UNION
SELECT COUNT(*) FROM (SELECT student_id, COUNT(student_id) FROM sibling GROUP BY student_id HAVING COUNT(sibling_id) = 1) as f 
UNION
SELECT COUNT(*) FROM (SELECT student_id, COUNT(student_id) FROM sibling GROUP BY student_id HAVING COUNT(sibling_id) = 2) as f;

-- Show all given lessons by the instructors
SELECT i.first_name, i.last_name, i.person_number, COUNT(*) AS lessons_given FROM instructor AS i 
INNER JOIN booking AS b ON i.instructor_id = b.instructor_id 
WHERE b.date BETWEEN '2022-01-01' AND '2022-06-01' -- Change interval
GROUP BY i.first_name, i.last_name, i.person_number
HAVING COUNT(*) >= 0 -- Change
ORDER BY COUNT(*) DESC;

-- Test
SELECT type, b.date, COUNT(*) FROM lesson_type GROUP BY type;
SELECT t.type, COUNT(*) FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id = l.booking_id 
INNER JOIN lesson_type AS t ON t.lesson_type_id=l.lesson_type_id
WHERE b.date BETWEEN '2022-01-01' AND '2022-02-01'
GROUP BY t.type;

-- total lessons per month
SELECT EXTRACT(MONTH from b.date) AS month, COUNT(*) AS lessons_given 
FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id = l.booking_id 
INNER JOIN lesson_type AS t ON t.lesson_type_id=l.lesson_type_id
WHERE b.date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY month
ORDER BY month;

-- Individual
SELECT EXTRACT(MONTH from b.date) AS month, COUNT(l.lesson_type_id) AS individual
FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id = l.booking_id 
INNER JOIN lesson_type AS t ON t.lesson_type_id=l.lesson_type_id
WHERE b.date BETWEEN '2022-01-01' AND '2022-12-31' AND l.lesson_type_id = 1
GROUP BY month
ORDER BY month;

-- Group
SELECT EXTRACT(MONTH from b.date) AS month, COUNT(l.lesson_type_id) AS group
FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id = l.booking_id 
INNER JOIN lesson_type AS t ON t.lesson_type_id=l.lesson_type_id
WHERE b.date BETWEEN '2022-01-01' AND '2022-12-31' AND l.lesson_type_id = 2
GROUP BY month
ORDER BY month;

-- Ensemble
SELECT EXTRACT(MONTH from b.date) AS month, COUNT(l.lesson_type_id) AS ensemble
FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id = l.booking_id 
INNER JOIN lesson_type AS t ON t.lesson_type_id=l.lesson_type_id
WHERE b.date BETWEEN '2022-01-01' AND '2022-12-31' AND l.lesson_type_id = 3
GROUP BY month
ORDER BY month;