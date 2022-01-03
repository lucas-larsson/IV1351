CREATE TABLE bookings (
 booking_id INT NOT NULL,
 place VARCHAR(100) NOT NULL,
 time TIMESTAMP(6) NOT NULL,
 lesson_type VARCHAR(100) NOT NULL
);

ALTER TABLE bookings ADD CONSTRAINT PK_bookings PRIMARY KEY (booking_id);


CREATE TABLE person (
 personal_number VARCHAR(12) NOT NULL,
 name VARCHAR(568) NOT NULL,
 age INT NOT NULL,
 id INT NOT NULL,
 zip_code VARCHAR(5),
 street VARCHAR(100),
 city VARCHAR(50),
 skill_level VARCHAR(15),
 phone_number VARCHAR(15)
);


CREATE TABLE staff (
 id INT NOT NULL,
 staff_id VARCHAR(100) NOT NULL
);

ALTER TABLE staff ADD CONSTRAINT PK_staff PRIMARY KEY (id);


CREATE TABLE student (
 school_id CHAR(10) NOT NULL,
 parent_phone_number VARCHAR(15),
 parent_name VARCHAR(568),
 has_sibling VARCHAR(3)
)INHERITS (person);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (school_id);


CREATE TABLE student_bookings (
 booking_id INT NOT NULL,
 school_id CHAR(10) NOT NULL
);

ALTER TABLE student_bookings ADD CONSTRAINT PK_student_bookings PRIMARY KEY (booking_id,school_id);


CREATE TABLE applicant (
 applicant_id INT NOT NULL,
 has_sibling VARCHAR(3)
)INHERITS (person);

ALTER TABLE applicant ADD CONSTRAINT PK_applicant PRIMARY KEY (applicant_id);


CREATE TABLE instructure (
 school_id VARCHAR(10) NOT NULL
)INHERITS (person);

ALTER TABLE instructure ADD CONSTRAINT PK_instructure PRIMARY KEY (school_id);


CREATE TABLE instructure_salary (
 school_id VARCHAR(10) NOT NULL,
 salary FLOAT(10)
);

ALTER TABLE instructure_salary ADD CONSTRAINT PK_instructure_salary PRIMARY KEY (school_id);


CREATE TABLE instrument_rental (
 instrument_id INT NOT NULL,
 rented_instrument VARCHAR(100),
 school_id CHAR(10) NOT NULL
);

ALTER TABLE instrument_rental ADD CONSTRAINT PK_instrument_rental PRIMARY KEY (instrument_id);


CREATE TABLE schedule (
 id INT NOT NULL,
 staff_id INT NOT NULL,
 place VARCHAR(100) NOT NULL,
 time TIMESTAMP(6) NOT NULL,
 instructure VARCHAR(100) NOT NULL,
 lesson_type VARCHAR(50)
);

ALTER TABLE schedule ADD CONSTRAINT PK_schedule PRIMARY KEY (id,staff_id);


CREATE TABLE instructuer_bookings (
 booking_id INT NOT NULL,
 school_id VARCHAR(10) NOT NULL
);

ALTER TABLE instructuer_bookings ADD CONSTRAINT PK_instructuer_bookings PRIMARY KEY (booking_id,school_id);


CREATE TABLE lessons (
 instructure VARCHAR(50),
 instrument VARCHAR(50),
 min_places INT,
 max_places INT,
 lesson_id INT NOT NULL,
 lesson_typ VARCHAR(50),
 id INT,
 staff_id INT,
 time TIMESTAMP(10)
);


CREATE TABLE ensembles_lesson (
 lesson_id INT NOT NULL,
 genre VARCHAR(100),
 Attribute1 CHAR(10)
)INHERITS (lessons);

ALTER TABLE ensembles_lesson ADD CONSTRAINT PK_ensembles_lesson PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL
)INHERITS (lessons);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE indivdual_lesson (
 lesson_id INT NOT NULL,
 appoitment TIMESTAMP(6)
)INHERITS (lessons);

ALTER TABLE indivdual_lesson ADD CONSTRAINT PK_indivdual_lesson PRIMARY KEY (lesson_id);


ALTER TABLE student_bookings ADD CONSTRAINT FK_student_bookings_0 FOREIGN KEY (booking_id) REFERENCES bookings (booking_id);
ALTER TABLE student_bookings ADD CONSTRAINT FK_student_bookings_1 FOREIGN KEY (school_id) REFERENCES student (school_id);


ALTER TABLE applicant ADD CONSTRAINT FK_applicant_0 FOREIGN KEY (applicant_id) REFERENCES staff (id);


ALTER TABLE instructure_salary ADD CONSTRAINT FK_instructure_salary_0 FOREIGN KEY (school_id) REFERENCES instructure (school_id);


ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_0 FOREIGN KEY (school_id) REFERENCES student (school_id);


ALTER TABLE schedule ADD CONSTRAINT FK_schedule_0 FOREIGN KEY (staff_id) REFERENCES staff (id);


ALTER TABLE instructuer_bookings ADD CONSTRAINT FK_instructuer_bookings_0 FOREIGN KEY (booking_id) REFERENCES bookings (booking_id);
ALTER TABLE instructuer_bookings ADD CONSTRAINT FK_instructuer_bookings_1 FOREIGN KEY (school_id) REFERENCES instructure_salary (school_id);


ALTER TABLE lessons ADD CONSTRAINT FK_lessons_0 FOREIGN KEY (id,staff_id) REFERENCES schedule (id,staff_id);


COMMENT ON TABLE bookings IS 'bookings';
COMMENT ON COLUMN bookings.booking_id IS 'booking_id';
COMMENT ON COLUMN bookings.place IS 'place';
COMMENT ON COLUMN bookings.time IS 'time';
COMMENT ON COLUMN bookings.lesson_type IS 'lesson_type';
COMMENT ON TABLE person IS 'person';
COMMENT ON COLUMN person.personal_number IS 'personal_number';
COMMENT ON COLUMN person.name IS 'name';
COMMENT ON COLUMN person.age IS 'age';
COMMENT ON COLUMN person.id IS 'id';
COMMENT ON COLUMN person.zip_code IS 'zip_code';
COMMENT ON COLUMN person.street IS 'street';
COMMENT ON COLUMN person.city IS 'city';
COMMENT ON COLUMN person.skill_level IS 'skill_level';
COMMENT ON COLUMN person.phone_number IS 'phone_number';
COMMENT ON TABLE staff IS 'staff';
COMMENT ON COLUMN staff.id IS 'id';
COMMENT ON COLUMN staff.staff_id IS 'staff_id';
COMMENT ON TABLE student IS 'student';
COMMENT ON COLUMN student.school_id IS 'school_id';
COMMENT ON COLUMN student.parent_phone_number IS 'parent_phone_number';
COMMENT ON COLUMN student.parent_name IS 'parent_name';
COMMENT ON COLUMN student.has_sibling IS 'has_sibling';
COMMENT ON TABLE student_bookings IS 'student_bookings';
COMMENT ON COLUMN student_bookings.booking_id IS 'booking_id';
COMMENT ON COLUMN student_bookings.school_id IS 'school_id';
COMMENT ON TABLE applicant IS 'applicant';
COMMENT ON COLUMN applicant.applicant_id IS 'applicant_id';
COMMENT ON COLUMN applicant.has_sibling IS 'has_sibling';
COMMENT ON TABLE instructure IS 'instructure';
COMMENT ON COLUMN instructure.school_id IS 'school_id';
COMMENT ON TABLE instructure_salary IS 'instructure_salary';
COMMENT ON COLUMN instructure_salary.school_id IS 'school_id';
COMMENT ON COLUMN instructure_salary.salary IS 'salary';
COMMENT ON TABLE instrument_rental IS 'instrument_rental';
COMMENT ON COLUMN instrument_rental.instrument_id IS 'instrument_id';
COMMENT ON COLUMN instrument_rental.rented_instrument IS 'rented_instrument';
COMMENT ON COLUMN instrument_rental.school_id IS 'school_id';
COMMENT ON TABLE schedule IS 'schedule';
COMMENT ON COLUMN schedule.id IS 'id';
COMMENT ON COLUMN schedule.staff_id IS 'staff_id';
COMMENT ON COLUMN schedule.place IS 'place';
COMMENT ON COLUMN schedule.time IS 'time';
COMMENT ON COLUMN schedule.instructure IS 'instructure';
COMMENT ON COLUMN schedule.lesson_type IS 'lesson_type';
COMMENT ON TABLE instructuer_bookings IS 'instructuer_bookings';
COMMENT ON COLUMN instructuer_bookings.booking_id IS 'booking_id';
COMMENT ON COLUMN instructuer_bookings.school_id IS 'school_id';
COMMENT ON TABLE lessons IS 'lessons';
COMMENT ON COLUMN lessons.instructure IS 'instructure';
COMMENT ON COLUMN lessons.instrument IS 'instrument';
COMMENT ON COLUMN lessons.min_places IS 'min_places';
COMMENT ON COLUMN lessons.max_places IS 'max_places';
COMMENT ON COLUMN lessons.lesson_id IS 'lesson_id';
COMMENT ON COLUMN lessons.lesson_typ IS 'lesson_typ';
COMMENT ON COLUMN lessons.id IS 'id';
COMMENT ON COLUMN lessons.staff_id IS 'staff_id';
COMMENT ON COLUMN lessons.time IS 'time';
COMMENT ON TABLE ensembles_lesson IS 'ensembles_lesson';
COMMENT ON COLUMN ensembles_lesson.lesson_id IS 'lesson_id';
COMMENT ON COLUMN ensembles_lesson.genre IS 'genre';
COMMENT ON COLUMN ensembles_lesson.Attribute1 IS 'Attribute1';
COMMENT ON TABLE group_lesson IS 'group_lesson';
COMMENT ON COLUMN group_lesson.lesson_id IS 'lesson_id';
COMMENT ON TABLE indivdual_lesson IS 'indivdual_lesson';
COMMENT ON COLUMN indivdual_lesson.lesson_id IS 'lesson_id';
COMMENT ON COLUMN indivdual_lesson.appoitment IS 'appoitment';
