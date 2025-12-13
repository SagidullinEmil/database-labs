BEGIN;
INSERT INTO students (first_name, last_name, faculty, phone_number, email)
VALUES ('Test','Commit','Demo', '+996000000001', 'test.commit@demo.local');
COMMIT;

SELECT student_id, first_name, last_name, email
FROM students
WHERE email = 'test.commit@demo.local';

BEGIN;
INSERT INTO students (first_name, last_name, faculty, phone_number, email)
VALUES ('Test','Rollback','Demo', '+996000000002', 'test.rollback@demo.local');
ROLLBACK;

SELECT COUNT(*) AS should_be_zero
FROM students
WHERE email = 'test.rollback@demo.local';

BEGIN;
SAVEPOINT sp1;

INSERT INTO payments (student_id, amount, payment_date, method, note)
VALUES (1, 9999.99, CURRENT_DATE, 'cash', 'SAVEPOINT demo payment');

SAVEPOINT sp2;

INSERT INTO payments (student_id, amount, payment_date, method, note)
VALUES (1, -50, CURRENT_DATE, 'cash', 'This should fail');