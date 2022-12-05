-- Copy student into the archives
INSERT INTO student(student_id, first_name, last_name, person_number, email, phone, street, zip, city)
SELECT student_id, first_name, last_name, person_number, email, phone, street, zip, city
FROM dblink('dbname=sgms user=postgres password=1234',
'SELECT student_id, first_name, last_name, person_number, email, phone, street, zip, city 
FROM student')
AS copy(student_id INT, first_name VARCHAR(500), last_name VARCHAR(500), person_number CHAR(12),
 email VARCHAR(500), phone VARCHAR(20), street VARCHAR(500), zip VARCHAR(100), city VARCHAR(500))
ON CONFLICT (student_id) DO NOTHING;

-- Copy bookings into the archives
INSERT INTO booking(booking_id, date, time)
SELECT booking_id, date, time
FROM dblink('dbname=sgms user=postgres password=1234', 
'SELECT booking_id, date, time 
FROM booking')
AS copy(booking_id INT, date DATE, time TIME(6))
ON CONFLICT (booking_id) DO NOTHING;

-- Copy booked_students into the archives
INSERT INTO booked_students(student_id, booking_id)
SELECT student_id, booking_id
FROM dblink('dbname=sgms user=postgres password=1234', 
'SELECT student_id, booking_id 
FROM booked_students')
AS copy(student_id INT, booking_id INT)
ON CONFLICT (student_id, booking_id) DO NOTHING;

-- Copy lessons into archive
INSERT INTO lesson(lesson_id, booking_id, price, type)
SELECT lesson_id, booking_id, price, type
FROM dblink('dbname=sgms user=postgres password=1234',
'SELECT l.lesson_id, b.booking_id, lp.price, lt.type FROM lesson AS l 
INNER JOIN booking AS b ON b.booking_id=l.booking_id 
INNER JOIN lesson_price AS lp ON l.lesson_price_id=lp.lesson_price_id
INNER JOIN lesson_type AS lt ON lt.lesson_type_id=l.lesson_type_id')
AS copy(lesson_id INT, booking_id INT, price INT, type VARCHAR (100))
ON CONFLICT (lesson_id) DO NOTHING;