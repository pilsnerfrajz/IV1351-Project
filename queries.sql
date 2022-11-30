-- Show the number of students that has 0, 1 or 2 siblings
SELECT 
SUM(CASE WHEN student_id NOT IN (SELECT student_id FROM sibling) THEN 1 ELSE 0 END) AS no_sibling,
(SELECT COUNT(*) FROM (SELECT student_id, COUNT(student_id) FROM sibling GROUP BY student_id HAVING COUNT(sibling_id) = 1) AS one) AS one_sibling,
(SELECT COUNT(*) FROM (SELECT student_id, COUNT(student_id) FROM sibling GROUP BY student_id HAVING COUNT(sibling_id) = 2) AS two) AS two_siblings
FROM student;

-- Show all given lessons by the instructors
SELECT i.first_name, i.last_name, i.person_number, COUNT(*) AS lessons_given FROM instructor AS i 
INNER JOIN booking AS b ON i.instructor_id = b.instructor_id 
WHERE b.date BETWEEN '2022-01-01' AND '2022-06-01' -- Change interval
GROUP BY i.first_name, i.last_name, i.person_number
HAVING COUNT(*) >= 0 -- Change
ORDER BY COUNT(*) DESC;

-- Show total lessons per month, and the number of lessons for each type per month
SELECT EXTRACT(MONTH from b.date) AS month,
COUNT(*) AS lessons_given,
SUM(CASE WHEN l.lesson_type_id = 1 THEN 1 ELSE 0 END) AS individual,
SUM(CASE WHEN l.lesson_type_id = 2 THEN 1 ELSE 0 END) AS group,
SUM(CASE WHEN l.lesson_type_id = 3 THEN 1 ELSE 0 END) AS ensemble
FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id = l.booking_id 
INNER JOIN lesson_type AS t ON t.lesson_type_id=l.lesson_type_id
WHERE b.date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY month
ORDER BY month;

-- List all ensembles next week sorted by genre and weekday
 2022-12-19
 2022-12-21
 2022-12-23








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