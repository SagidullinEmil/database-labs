BEGIN;

--Dorms
INSERT INTO dormitories (name, address, total_capacity) VALUES
('Ala-Too Residence', 'AUCA Campus, North Block', 240),
('Manas Hall',        'AUCA Campus, West Block', 180),
('Issyk-Kul House',   'AUCA Campus, East Block', 120);

--Rooms
INSERT INTO rooms (dorm_id, room_number, room_type, capacity) VALUES
(1,'A101','double',2),(1,'A102','single',1),(1,'A103','triple',3),(1,'A104','double',2),
(1,'A201','double',2),(1,'A202','double',2),(1,'A203','single',1),
(2,'B101','double',2),(2,'B102','double',2),(2,'B103','triple',3),(2,'B104','single',1),
(2,'B201','double',2),(2,'B202','double',2),
(3,'C101','single',1),(3,'C102','double',2),(3,'C103','double',2);

--Staff
INSERT INTO staff (full_name, role, phone_number, email) VALUES
('Aibek Sadykov', 'administrator', '+996700111111', 'a.sadykov@dorm.example'),
('Elena Kim',     'manager',       '+996700222222', 'e.kim@dorm.example'),
('Nurlan Usubaliev','maintenance',  '+996700333333', 'n.usubaliev@dorm.example'),
('Dina Turgunbaeva','maintenance',  '+996700444444', 'd.turgunbaeva@dorm.example'),
('Bakyt Osmonov', 'security',      '+996700555555', 'b.osmonov@dorm.example');

--Students
INSERT INTO students (first_name, last_name, faculty, phone_number, email) VALUES
('Emil','Sagidullin','Software Engineering', '+996700654321','emil.sagidullin@auca.kg'),
('Aigerim','Bekova','Computer Science', '+996700123456','aigerim.bekova@auca.kg'),
('Timur','Akhmetov','Economics', '+996555010101','timur.akhmetov@auca.kg'),
('Amina','Sultanova','Psychology', '+996555020202','amina.sultanova@auca.kg'),
('Daniyar','Isakov','International Relations', '+996555030303','daniyar.isakov@auca.kg'),
('Alina','Petrova','Business Administration', '+996555040404','alina.petrova@auca.kg'),
('Nurbolot','Kadyrov','Law', '+996555050505','nurbolot.kadyrov@auca.kg'),
('Mariya','Ivanova','Journalism', '+996555060606','mariya.ivanova@auca.kg');

--Contracts
INSERT INTO contracts (student_id, room_id, check_in, check_out, status) VALUES
(1,  1, CURRENT_DATE - 60, NULL, 'active'),
(2,  1, CURRENT_DATE - 55, NULL, 'active'),
(3,  3, CURRENT_DATE - 40, NULL, 'active'),
(4,  8, CURRENT_DATE - 30, NULL, 'active'),
(5,  9, CURRENT_DATE - 25, NULL, 'active'),
(6, 12, CURRENT_DATE - 20, NULL, 'active'),
(7, 14, CURRENT_DATE - 15, NULL, 'active');

--Payments (transaction records)
INSERT INTO payments (student_id, amount, payment_date, method, note) VALUES
(1, 12000, CURRENT_DATE - 35, 'transfer', 'Dorm fee - November'),
(1, 12000, CURRENT_DATE - 5,  'transfer', 'Dorm fee - December'),
(2, 12000, CURRENT_DATE - 8,  'card',     'Dorm fee - December'),
(3, 18000, CURRENT_DATE - 10, 'cash',     'Dorm fee - December'),
(4, 12000, CURRENT_DATE - 12, 'card',     'Dorm fee - December'),
(5, 12000, CURRENT_DATE - 20, 'transfer', 'Dorm fee - December'),
(6, 12000, CURRENT_DATE - 2,  'card',     'Dorm fee - December');

--Maintenance requests
INSERT INTO maintenance_requests
(room_id, reported_by_student_id, assigned_staff_id, reported_on, issue_type, description, status, resolved_on)
VALUES
(1,  2, 3, CURRENT_DATE - 14, 'furniture',  'Wardrobe door hinge is loose', 'in_progress', NULL),
(3,  3, 4, CURRENT_DATE - 7,  'heating',    'Radiator is not heating properly', 'pending', NULL),
(12, 6, 3, CURRENT_DATE - 20, 'plumbing',   'Bathroom sink is leaking', 'resolved', CURRENT_DATE - 15);

COMMIT;
