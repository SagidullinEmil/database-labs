CREATE TABLE IF NOT EXISTS students (
  student_id SERIAL PRIMARY KEY,
  full_name  VARCHAR(100) NOT NULL,
  email      VARCHAR(150) UNIQUE,
  gpa        NUMERIC(3,2) DEFAULT 0.00,
  enrolled_on DATE DEFAULT CURRENT_DATE
);

INSERT INTO students (full_name, email, gpa)
VALUES ('Alice Johnson', 'alice@example.com', 3.70);

INSERT INTO students (full_name, email, gpa) VALUES
('Bob Smith',   'bob@example.com',   3.10),
('Carol White', 'carol@example.com', 3.95),
('Dan Brown',   'dan@example.com',   2.80),
('Eva Green',   'eva@example.com',   3.40);

SELECT * FROM students;

SELECT student_id, full_name, gpa
FROM students
ORDER BY gpa DESC;

SELECT DISTINCT gpa
FROM students
ORDER BY gpa DESC;

SELECT full_name, email, gpa
FROM students
WHERE gpa >= 3.50
ORDER BY full_name ASC;

SELECT ROUND(gpa)::int AS gpa_bucket, COUNT(*) AS cnt
FROM students
GROUP BY gpa_bucket
HAVING COUNT(*) >= 2
ORDER BY gpa_bucket DESC;

SELECT student_id, full_name, gpa
FROM students
ORDER BY gpa DESC
LIMIT 3;

UPDATE students
SET gpa = gpa + 0.10
WHERE gpa < 3.00;

UPDATE students
SET email = 'bob.smith@example.com'
WHERE full_name = 'Bob Smith';

DELETE FROM students
WHERE gpa = 0.00;

WITH to_del AS (
  SELECT student_id
  FROM students
  ORDER BY gpa ASC
  LIMIT 2
)
DELETE FROM students
WHERE student_id IN (SELECT student_id FROM to_del);
