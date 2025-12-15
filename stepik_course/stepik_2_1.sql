CREATE TABLE IF NOT EXISTS students (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    enrollment_date DATE DEFAULT CURRENT_DATE
);

ALTER TABLE students
ADD COLUMN phone_number VARCHAR(20);

ALTER TABLE students
RENAME COLUMN full_name TO student_name;

ALTER TABLE students
ALTER COLUMN phone_number TYPE VARCHAR(30);

ALTER TABLE students
ALTER COLUMN student_name TYPE VARCHAR(120),
ALTER COLUMN email TYPE VARCHAR(200);

ALTER TABLE students
DROP COLUMN phone_number;

ALTER TABLE students
RENAME TO university_students;

DROP TABLE IF EXISTS university_students;