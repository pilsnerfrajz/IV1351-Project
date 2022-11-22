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
  ('Leroy','Holland','197701017175','convallis.convallis.dolor@google.com','+46286425572','0','Ap #668-6199 Parturient Rd.','22322','Märsta'),
  ('Matthew','Wade','199509196342','pellentesque.ut@hotmail.edu','+46707634527','1','Ap #799-4702 Nec St.','14418','Avesta'),
  ('Aurelia','Sosa','199402041710','maecenas.mi@outlook.edu','+46407205860','0','P.O. Box 709, 9395 Magna. Rd.','32561','Hofors'),
  ('Lydia','Mejia','194510264437','dictum.magna@aol.org','+46559037283','0','P.O. Box 941, 5627 Pede Rd.','38632','Jönköping'),
  ('Sybil','Carney','201902177128','malesuada.integer@yahoo.org','+46027773075','1','6824 Vitae, Road','61562','Vetlanda');

INSERT INTO rental (end_date,student_id) 
VALUES 
('2023-05-17',(SELECT student_id FROM student WHERE first_name = 'Sawyer')),
('2023-11-04',(SELECT student_id FROM student WHERE first_name = 'Sawyer')),
('2023-04-13',(SELECT student_id FROM student WHERE first_name = 'Rhea')),
('2023-11-09',(SELECT student_id FROM student WHERE first_name = 'Branden')),
('2023-07-28',(SELECT student_id FROM student WHERE first_name = 'Tucker'));

INSERT INTO instrument (brand, type, real_instrument_id, cost,rental_id) 
VALUES 
('Fender', 'Guitar', '084-26-4796', 268,(SELECT rental_id FROM rental WHERE end_date = '2023-05-17')),
('Yamaha', 'Piano', '501-01-5627', 234,(SELECT rental_id FROM rental WHERE end_date = '2023-11-04')),
('Ibanez', 'Bass', '931-31-8248', 162,(SELECT rental_id FROM rental WHERE end_date = '2023-04-13')),
('Zildjan', 'Drums', '785-65-1122', 225,(SELECT rental_id FROM rental WHERE end_date = '2023-11-09')),
('Fender', 'Guitar', '007-28-8162', 102,(SELECT rental_id FROM rental WHERE end_date = '2023-07-28')),
('Fender', 'Guitar', '308-43-5788', 172,NULL),
('Fender', 'Guitar', '913-07-2998', 176,NULL),
('Yamaha', 'Piano', '022-77-0622', 285,NULL),
('Yamaha', 'Piano', '820-57-0208', 151,NULL),
('Zildjan', 'Drums', '565-11-9348', 216,NULL);