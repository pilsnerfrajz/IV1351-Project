CREATE TABLE contact_person (
 conact_person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 first_name VARCHAR(500) NOT NULL,
 last_name VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 phone VARCHAR(20) NOT NULL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (conact_person_id);


CREATE TABLE instructor (
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 first_name VARCHAR(500) NOT NULL,
 last_name VARCHAR(500) NOT NULL,
 person_number VARCHAR(255) UNIQUE NOT NULL,
 email VARCHAR(500) UNIQUE NOT NULL,
 phone VARCHAR(20) NOT NULL,
 teaches_ensemble BIT(1) NOT NULL,
 street VARCHAR(500) NOT NULL,
 zip CHAR(5) NOT NULL,
 city VARCHAR(500) NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instructor_availability (
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 time TIMESTAMP(10)
);

ALTER TABLE instructor_availability ADD CONSTRAINT PK_instructor_availability PRIMARY KEY (instructor_id);


CREATE TABLE lesson_price (
 lesson_price_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 type_price INT NOT NULL,
 skill_level_price INT,
 instructor_payment DECIMAL(10) NOT NULL,
 sibling_discount DECIMAL(10)
);

ALTER TABLE lesson_price ADD CONSTRAINT PK_lesson_price PRIMARY KEY (lesson_price_id);


CREATE TABLE plays_instrument (
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument VARCHAR(500) NOT NULL
);

ALTER TABLE plays_instrument ADD CONSTRAINT PK_plays_instrument PRIMARY KEY (instructor_id);


CREATE TABLE student (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 first_name VARCHAR(500) NOT NULL,
 last_name VARCHAR(500) NOT NULL,
 person_number VARCHAR(255) UNIQUE NOT NULL,
 email VARCHAR(500) UNIQUE,
 phone VARCHAR(20),
 street VARCHAR(500) NOT NULL,
 zip CHAR(5) NOT NULL,
 city VARCHAR(500) NOT NULL,
 contact_person_id INT GENERATED ALWAYS AS IDENTITY
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE student_skills (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument VARCHAR(500) NOT NULL,
 skill_level VARCHAR(12) NOT NULL
);

ALTER TABLE student_skills ADD CONSTRAINT PK_student_skills PRIMARY KEY (student_id);


CREATE TABLE booking (
 booking_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 location VARCHAR(500) NOT NULL,
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (booking_id);


CREATE TABLE lesson (
 lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lesson_type VARCHAR(500) NOT NULL,
 genre VARCHAR(500),
 max_number_of_students INT,
 min_number_of_students INT,
 skill_level VARCHAR(12),
 lesson_price_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 booking_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE rental (
 rental_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 rental_reference VARCHAR(500) UNIQUE NOT NULL,
 end_date DATE NOT NULL,
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE rental ADD CONSTRAINT PK_rental PRIMARY KEY (rental_id);


CREATE TABLE sibling (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 sibling_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (student_id,sibling_id);


CREATE TABLE instrument_for_rent (
 instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 brand VARCHAR(500) NOT NULL,
 type VARCHAR(500) NOT NULL,
 real_instrument_id UNIQUE VARCHAR(500) NOT NULL,
 cost INT NOT NULL,
 rental_id INT GENERATED ALWAYS AS IDENTITY
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);


ALTER TABLE instructor_availability ADD CONSTRAINT FK_instructor_availability_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE plays_instrument ADD CONSTRAINT FK_plays_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (contact_person_id) REFERENCES contact_person (conact_person_id);


ALTER TABLE student_skills ADD CONSTRAINT FK_student_skills_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_1 FOREIGN KEY (instructor_id) REFERENCES instructor_availability (instructor_id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (lesson_price_id) REFERENCES lesson_price (lesson_price_id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (booking_id) REFERENCES booking (booking_id);


ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE sibling ADD CONSTRAINT FK_sibling_1 FOREIGN KEY (sibling_id) REFERENCES student (student_id);


ALTER TABLE instrument ADD CONSTRAINT FK_instrument_0 FOREIGN KEY (rental_id) REFERENCES rental (rental_id);


