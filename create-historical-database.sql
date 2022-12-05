CREATE TABLE booking (
 booking_id INT NOT NULL,
 date DATE NOT NULL,
 time TIME(6) NOT NULL
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (booking_id);

CREATE TABLE student (
 student_id INT NOT NULL,
 first_name VARCHAR(500) NOT NULL,
 last_name VARCHAR(500) NOT NULL,
 person_number CHAR(12) UNIQUE NOT NULL,
 email VARCHAR(500) UNIQUE,
 phone VARCHAR(20),
 street VARCHAR(500) NOT NULL,
 zip VARCHAR(100) NOT NULL,
 city VARCHAR(500) NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);

CREATE TABLE booked_students (
 student_id INT NOT NULL,
 booking_id INT NOT NULL
);

ALTER TABLE booked_students ADD CONSTRAINT PK_booked_students PRIMARY KEY (student_id,booking_id);


CREATE TABLE lesson (
 lesson_id INT NOT NULL,
 booking_id INT NOT NULL,
 price INT NOT NULL,
 type VARCHAR (100) NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);

ALTER TABLE booked_students ADD CONSTRAINT FK_booked_students_0 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE NO ACTION;
ALTER TABLE booked_students ADD CONSTRAINT FK_booked_students_1 FOREIGN KEY (booking_id) REFERENCES booking (booking_id) ON DELETE NO ACTION;

ALTER TABLE lesson ADD CONSTRAINT FK_lesson_4 FOREIGN KEY (booking_id) REFERENCES booking (booking_id) ON DELETE NO ACTION;

CREATE extension dblink;