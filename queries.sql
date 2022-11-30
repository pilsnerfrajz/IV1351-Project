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
WHERE b.date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY month
ORDER BY month;

-- List all ensembles next week sorted by genre and weekday. Since there are only 24 ensembles this year it might return null.
SELECT l.booking_id AS booking_id, b.date, EXTRACT(dow from b.date) AS day_of_week, t.type AS type, g.genre AS genre, 
CASE
    WHEN l.max_number_of_students - COUNT(*) FILTER (WHERE student_id IN (SELECT student_id FROM booked_students)) = 0 THEN 'fully booked'
    WHEN l.max_number_of_students - COUNT(*) FILTER (WHERE student_id IN (SELECT student_id FROM booked_students)) > 2 THEN 'more seats left'
    WHEN l.max_number_of_students - COUNT(*) FILTER (WHERE student_id IN (SELECT student_id FROM booked_students)) BETWEEN 1 AND 2 THEN '1-2 seats left'
END AS seats
FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id = l.booking_id 
INNER JOIN lesson_type AS t ON t.lesson_type_id = l.lesson_type_id
INNER JOIN genre AS g ON g.genre_id = l.genre_id
INNER JOIN booked_students AS bk ON bk.booking_id=l.booking_id
WHERE b.date BETWEEN CURRENT_DATE AND (SELECT CURRENT_DATE + INTERVAL '7 DAY') --Remove row for all ensembles
GROUP BY day_of_week, type, genre, l.booking_id, l.max_number_of_students, b.date
ORDER BY day_of_week, genre;

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
WHERE b.date BETWEEN '2022-01-01' AND '2022-12-31' AND l.lesson_type_id = 1
GROUP BY month
ORDER BY month;

-- Group
SELECT EXTRACT(MONTH from b.date) AS month, COUNT(l.lesson_type_id) AS group
FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id = l.booking_id 
WHERE b.date BETWEEN '2022-01-01' AND '2022-12-31' AND l.lesson_type_id = 2
GROUP BY month
ORDER BY month;

-- Ensemble
SELECT EXTRACT(MONTH from b.date) AS month, COUNT(l.lesson_type_id) AS ensemble
FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id = l.booking_id 
WHERE b.date BETWEEN '2022-01-01' AND '2022-12-31' AND l.lesson_type_id = 3
GROUP BY month
ORDER BY month;