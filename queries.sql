-- Query for showing siblings
SELECT * FROM show_siblings;

-- Query for showing given lessons the current month
SELECT * FROM lessons_given WHERE lessons_given > 0; -- 0 = variable

-- Query for showing total lessons per month for a specific year
SELECT * FROM lessons_per_month WHERE year = '2022'; -- 2022 = variable

-- Query for showing all ensembles the following week
SELECT * FROM ensembles_next_week;




-- Show the number of students that has 0, 1 or 2 siblings
SELECT 
SUM(CASE WHEN student_id NOT IN (SELECT student_id FROM sibling) THEN 1 ELSE 0 END) AS no_sibling,
(SELECT COUNT(*) FROM (SELECT student_id, COUNT(student_id) FROM sibling GROUP BY student_id HAVING COUNT(sibling_id) = 1) AS one) AS one_sibling,
(SELECT COUNT(*) FROM (SELECT student_id, COUNT(student_id) FROM sibling GROUP BY student_id HAVING COUNT(sibling_id) = 2) AS two) AS two_siblings
FROM student;

-- CREATE VIEW for siblings
CREATE VIEW show_siblings AS
SELECT 
SUM(CASE WHEN student_id NOT IN (SELECT student_id FROM sibling) THEN 1 ELSE 0 END) AS no_sibling,
(SELECT COUNT(*) FROM (SELECT student_id, COUNT(student_id) FROM sibling GROUP BY student_id HAVING COUNT(sibling_id) = 1) AS one) AS one_sibling,
(SELECT COUNT(*) FROM (SELECT student_id, COUNT(student_id) FROM sibling GROUP BY student_id HAVING COUNT(sibling_id) = 2) AS two) AS two_siblings
FROM student;


-- Show all given lessons by the instructors the current month
SELECT i.first_name, i.last_name, i.person_number, COUNT(*) AS lessons_given FROM instructor AS i 
INNER JOIN booking AS b ON i.instructor_id = b.instructor_id 
WHERE (SELECT EXTRACT(MONTH FROM b.date)) = (SELECT EXTRACT(MONTH FROM NOW()))
GROUP BY i.first_name, i.last_name, i.person_number
HAVING COUNT(*) >= 0 -- Change
ORDER BY COUNT(*) DESC;

-- CREATE VIEW to show all given lessons by the instructors the current month
CREATE VIEW given_lessons AS 
SELECT i.first_name, i.last_name, i.person_number, COUNT(*) AS lessons_given FROM instructor AS i 
INNER JOIN booking AS b ON i.instructor_id = b.instructor_id 
WHERE (SELECT EXTRACT(MONTH FROM b.date)) = (SELECT EXTRACT(MONTH FROM NOW()))
GROUP BY i.first_name, i.last_name, i.person_number
ORDER BY COUNT(*) DESC;


-- Show total lessons per month, and the number of lessons for each type per month for a specific year
SELECT EXTRACT(YEAR from b.date) AS year, EXTRACT(MONTH from b.date) AS month,
COUNT(*) AS lessons_given,
SUM(CASE WHEN l.lesson_type_id = 1 THEN 1 ELSE 0 END) AS individual,
SUM(CASE WHEN l.lesson_type_id = 2 THEN 1 ELSE 0 END) AS group,
SUM(CASE WHEN l.lesson_type_id = 3 THEN 1 ELSE 0 END) AS ensemble
FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id = l.booking_id 
WHERE (SELECT EXTRACT(YEAR FROM b.date)) = '2022'
GROUP BY month, year
ORDER BY month;

-- CREATE VIEW
CREATE VIEW show_lessons AS
SELECT EXTRACT(YEAR from b.date) AS year, EXTRACT(MONTH from b.date) AS month,
COUNT(*) AS lessons_given,
SUM(CASE WHEN l.lesson_type_id = 1 THEN 1 ELSE 0 END) AS individual,
SUM(CASE WHEN l.lesson_type_id = 2 THEN 1 ELSE 0 END) AS group,
SUM(CASE WHEN l.lesson_type_id = 3 THEN 1 ELSE 0 END) AS ensemble
FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id = l.booking_id
GROUP BY month, year
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
WHERE (SELECT EXTRACT(WEEK FROM b.date)) = (SELECT EXTRACT(WEEK FROM NOW() + INTERVAL '1 WEEK')) --Remove row for all ensembles
GROUP BY day_of_week, type, genre, l.booking_id, l.max_number_of_students, b.date
ORDER BY day_of_week, genre;

-- CREATE VIEW for the ensembles the next week
CREATE MATERIALIZED VIEW ensembles_next_week AS
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
WHERE (SELECT EXTRACT(WEEK FROM b.date)) = (SELECT EXTRACT(WEEK FROM NOW() + INTERVAL '1 WEEK'))
GROUP BY day_of_week, type, genre, l.booking_id, l.max_number_of_students, b.date
ORDER BY day_of_week, genre;









-- TEST QUERIES *******************************************************************************
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