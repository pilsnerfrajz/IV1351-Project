--Enums----------------------------------------------------
INSERT INTO instrument_type (type) VALUES
('Piano'), ('Guitar'), ('Drums'), ('Bass'), ('Trumpet'), ('Saxophone'),
('Flute'), ('Cello'), ('Violin');

INSERT INTO instrument_brand (brand) VALUES
('Bach'),
('Fender'),
('Gibson'),
('Ibanez'),
('Sonor'),
('Stuart & Sons'),
('Stradivarius'),
('Tama'),
('Yamaha'),
('Zildjan');

INSERT INTO genre (genre) VALUES
('Classic'), ('Rock'), ('Jazz'), ('Film'), ('Pop'), ('Funk');

INSERT INTO instructor_instrument (instrument) VALUES
('Piano'), ('Guitar'), ('Drums'), ('Bass'), ('Trumpet'), ('Saxophone'),
('Flute'), ('Cello'), ('Violin');

INSERT INTO student_instrument (instrument) VALUES
('Piano'), ('Guitar'), ('Drums'), ('Bass'), ('Trumpet'), ('Saxophone'),
('Flute'), ('Cello'), ('Violin');

INSERT INTO lesson_instrument (instrument) VALUES
('Piano'), ('Guitar'), ('Drums'), ('Bass'), ('Trumpet'), ('Saxophone'),
('Flute'), ('Cello'), ('Violin');

INSERT INTO lesson_skill_level (skill_level) VALUES
('Beginner'), ('Intermediate'), ('Advanced');

INSERT INTO lesson_type (type) VALUES
('Individual'), ('Group'), ('Ensemble');

INSERT INTO student_skill_level (skill_level) VALUES
('Beginner'), ('Intermediate'), ('Advanced');

INSERT INTO price_type (type) VALUES
('Individual'), ('Group'), ('Ensemble');

INSERT INTO price_skill_level (skill_level) VALUES
('Beginner'), ('Intermediate'), ('Advanced');
-----------------------------------------------------------

INSERT INTO contact_person (first_name,last_name,email,phone)
VALUES
  ('Zeus','Walker','risus.nulla@hotmail.org','+46422137590'),
  ('Oliver','Mcintyre','vivamus.sit.amet@aol.edu','+46458587001'),
  ('Neville','Washington','aliquam.ultrices@hotmail.net','+46676067101'),
  ('Ariel','Thompson','tristique.pellentesque@protonmail.couk','+46487367087'),
  ('Zachery','Dillard','curabitur.vel@icloud.couk','+46852691279'),
  ('Lana','Hutchinson','dolor.fusce@google.couk','+46356122429'),
  ('Veronica','Cobb','lacinia.sed.congue@icloud.edu','+46367147966'),
  ('Genevieve','Randall','augue.ut@protonmail.edu','+46580751715');

INSERT INTO student (first_name,last_name,person_number,email,phone,street,zip,city,contact_person_id)
VALUES
  ('Sawyer','Yang','199201293157','duis.sit@protonmail.net','+46073347436','P.O. Box 778, 5576 Lacinia. Street','42407','Nässjö',
  (SELECT contact_person_id FROM contact_person WHERE first_name = 'Zeus')),
  ('Ira','Glenn','199305076631','gravida.sagittis@hotmail.net','+46819778511','2070 Posuere Rd.','45810','Alingsås',NULL),
  ('Allen','Macdonald','195009288480','elementum.at@google.org','+46215146743','P.O. Box 292, 722 Curabitur St.','92144','Söderhamn',
  (SELECT contact_person_id FROM contact_person WHERE first_name = 'Ariel')),
  ('Dominic','Reid','198901181449','ut@google.net','+46354313624','634-1436 Dolor. Avenue','52120','Upplands Väsby',NULL),
  ('Reuben','Wagner','193307101067','sed@outlook.edu','+46487963628','Ap #894-4236 Augue Ave','45956','Åkersberga',NULL),
  ('Bryar','Holloway','194010036145','laoreet.posuere@aol.ca','+46583581276','Ap #725-1332 Suspendisse Rd.','76224','Värnamo',
  (SELECT contact_person_id FROM contact_person WHERE first_name = 'Lana')),
  ('Rhea','Meadows','194002292466','velit@icloud.couk','+46303435651','Ap #375-7598 Neque Street','88548','Falun',
  (SELECT contact_person_id FROM contact_person WHERE first_name = 'Zeus')),
  ('Rylee','Flowers','196409096135','aenean.sed@aol.net','+46794378677','Ap #315-4338 Quam Av.','68236','Sandviken',
  (SELECT contact_person_id FROM contact_person WHERE first_name = 'Veronica')),
  ('Branden','Owen','194812201749','nam.porttitor@hotmail.couk','+46659674233','813-5979 Metus Rd.','38767','Uddevalla',NULL),
  ('Tucker','Mcneil','192603218310','commodo.ipsum.suspendisse@yahoo.couk','+46153352273','Ap #983-5817 Justo. Rd.','12224','Ludvika',NULL);

INSERT INTO instructor (first_name,last_name,person_number,email,phone,teaches_ensemble,street,zip,city)
VALUES
  ('Gray','Higgins','194907134052','convallis.in@icloud.com','+46824341184','0','702-144 Fringilla Ave','69501','Mora'),
  ('Alexa','Wade','200303097562','ipsum.sodales@google.couk','+46355876412','0','445 Vulputate, Ave','70312','Täby'),
  ('Allegra','Santana','196112088130','sed.dictum.proin@yahoo.org','+46365287389','0','Ap #891-1179 Pede, St.','35165','Södertälje'),
  ('Isabella','Whitehead','193004216978','lectus.sit.amet@outlook.org','+46692446867','0','180-9259 Arcu Street','34790','Linköping'),
  ('Dominic','Rosario','197105287762','tortor@protonmail.ca','+46855881751','1','Ap #599-935 Curabitur Street','33516','Upplands Väsby'),
  ('Leroy','Jenkins','197701017175','convallis.convallis.dolor@google.com','+46286425572','0','Ap #668-6199 Parturient Rd.','22322','Märsta'),
  ('Matthew','Wade','199509196342','pellentesque.ut@hotmail.edu','+46707634527','1','Ap #799-4702 Nec St.','14418','Avesta'),
  ('Aurelia','Sosa','199402041710','maecenas.mi@outlook.edu','+46407205860','0','P.O. Box 709, 9395 Magna. Rd.','32561','Hofors'),
  ('Lydia','Mejia','194510264437','dictum.magna@aol.org','+46559037283','0','P.O. Box 941, 5627 Pede Rd.','38632','Jönköping'),
  ('Sybil','Carney','201902177128','malesuada.integer@yahoo.org','+46027773075','1','6824 Vitae, Road','61562','Vetlanda');

INSERT INTO instrument (instrument_brand_id, instrument_type_id, real_instrument_id, cost) 
VALUES 
((SELECT instrument_brand_id FROM instrument_brand WHERE brand='Fender'), 
(SELECT instrument_type_id FROM instrument_type WHERE type='Guitar'), '084-26-4796', 268),

((SELECT instrument_brand_id FROM instrument_brand WHERE brand='Yamaha'), 
(SELECT instrument_type_id FROM instrument_type WHERE type='Piano'), '501-01-5627', 234),

((SELECT instrument_brand_id FROM instrument_brand WHERE brand='Ibanez'), 
(SELECT instrument_type_id FROM instrument_type WHERE type='Bass'), '931-31-8248', 162),

((SELECT instrument_brand_id FROM instrument_brand WHERE brand='Zildjan'), 
(SELECT instrument_type_id FROM instrument_type WHERE type='Drums'), '785-65-1122', 225),

((SELECT instrument_brand_id FROM instrument_brand WHERE brand='Fender'), 
(SELECT instrument_type_id FROM instrument_type WHERE type='Guitar'), '007-28-8162', 102),

((SELECT instrument_brand_id FROM instrument_brand WHERE brand='Fender'), 
(SELECT instrument_type_id FROM instrument_type WHERE type='Guitar'), '308-43-5788', 172),

((SELECT instrument_brand_id FROM instrument_brand WHERE brand='Fender'), 
(SELECT instrument_type_id FROM instrument_type WHERE type='Guitar'), '913-07-2998', 176),

((SELECT instrument_brand_id FROM instrument_brand WHERE brand='Yamaha'), 
(SELECT instrument_type_id FROM instrument_type WHERE type='Piano'), '022-77-0622', 285),

((SELECT instrument_brand_id FROM instrument_brand WHERE brand='Yamaha'), 
(SELECT instrument_type_id FROM instrument_type WHERE type='Piano'), '820-57-0208', 151),

((SELECT instrument_brand_id FROM instrument_brand WHERE brand='Zildjan'), 
(SELECT instrument_type_id FROM instrument_type WHERE type='Drums'), '565-11-9348', 216);

INSERT INTO rental (start_date, end_date,student_id, instrument_id) 
VALUES 
('2022-12-01', '2023-05-17',(SELECT student_id FROM student WHERE first_name = 'Sawyer'), (SELECT instrument_id FROM instrument WHERE real_instrument_id='084-26-4796')),
('2022-12-01', '2023-11-04',(SELECT student_id FROM student WHERE first_name = 'Sawyer'), (SELECT instrument_id FROM instrument WHERE real_instrument_id='501-01-5627')),
('2022-12-01', '2023-04-13',(SELECT student_id FROM student WHERE first_name = 'Rhea'), (SELECT instrument_id FROM instrument WHERE real_instrument_id='931-31-8248')),
('2022-12-01', '2023-11-09',(SELECT student_id FROM student WHERE first_name = 'Branden'), (SELECT instrument_id FROM instrument WHERE real_instrument_id='785-65-1122')),
('2022-12-01', '2023-07-28',(SELECT student_id FROM student WHERE first_name = 'Tucker'), (SELECT instrument_id FROM instrument WHERE real_instrument_id='007-28-8162'));

INSERT INTO student_skills (student_id, student_instrument_id, student_skill_level_id)
VALUES
(1,2,3),
(1,1,3),
(2,7,1),
(3,1,2),
(4,4,3),
(5,8,3),
(6,9,1),
(7,5,1),
(8,2,3),
(9,3,2),
(10,9,3);

INSERT INTO sibling (student_id, sibling_id) VALUES
(1, 2), (1, 3), (4, 6), (2, 1), (3, 1), (6, 4);

INSERT INTO plays_instrument (instructor_id, instructor_instrument_id) VALUES
(1, 1),
(1, 2),
(2, 5),
(3, 7),
(4, 8),
(5, 4),
(6, 9),
(7, 3),
(8, 6),
(9, 6),
(10, 1);

INSERT INTO booking (date, time, instructor_id) VALUES
('2022-12-01', '08:00:00', 1);

INSERT INTO booked_students (student_id, booking_id) VALUES
(1, (SELECT booking_id FROM booking WHERE time='08:00:00' AND date='2022-12-01' AND instructor_id=1));

INSERT INTO lesson_price (price, instructor_payment, sibling_discount, price_type_id, price_skill_level_id) VALUES
--Individual, beginner
(100, 60, 10, (SELECT price_type_id FROM price_type WHERE type='Individual'), 
(SELECT price_skill_level_id FROM price_skill_level WHERE skill_level='Beginner')),
--Individual, intermediate
(120, 80, 10, (SELECT price_type_id FROM price_type WHERE type='Individual'), 
(SELECT price_skill_level_id FROM price_skill_level WHERE skill_level='Intermediate')),
--Individual, advanced
(140, 100, 10, (SELECT price_type_id FROM price_type WHERE type='Individual'), 
(SELECT price_skill_level_id FROM price_skill_level WHERE skill_level='Advanced')),
--Group, beginner
(80, 60, 5, (SELECT price_type_id FROM price_type WHERE type='Group'), 
(SELECT price_skill_level_id FROM price_skill_level WHERE skill_level='Beginner')),
--Group, intermediate
(100, 80, 5, (SELECT price_type_id FROM price_type WHERE type='Group'), 
(SELECT price_skill_level_id FROM price_skill_level WHERE skill_level='Intermediate')),
--Group, advanced
(120, 100, 5, (SELECT price_type_id FROM price_type WHERE type='Group'), 
(SELECT price_skill_level_id FROM price_skill_level WHERE skill_level='Advanced')),
--Ensemble
(110, 70, 5, (SELECT price_type_id FROM price_type WHERE type='Ensemble'), NULL);

INSERT INTO lesson (booking_id, lesson_type_id, lesson_skill_level_id, lesson_price_id,
max_number_of_students, min_number_of_students, genre_id, lesson_instrument_id)
VALUES
(1, 
(SELECT lesson_type_id FROM lesson_type WHERE type='Individual'),
(SELECT lesson_skill_level_id FROM lesson_skill_level WHERE skill_level='Advanced'),
(SELECT lesson_price_id FROM lesson_price WHERE 
price_type_id=(SELECT price_type_id FROM price_type WHERE type='Individual') 
AND price_skill_level_id=(SELECT price_skill_level_id FROM price_skill_level WHERE skill_level='Advanced')),
NULL, NULL, NULL,
(SELECT lesson_instrument_id FROM lesson_instrument WHERE instrument='Piano'));