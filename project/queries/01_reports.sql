-- 1) Occupancy per dorm
SELECT d.name AS dorm,
       COUNT(r.room_id) AS rooms_total,
       SUM(r.occupancy) AS students_living_now,
       SUM(r.capacity) AS beds_total,
       ROUND(100.0 * SUM(r.occupancy)::numeric / NULLIF(SUM(r.capacity),0), 2) AS occupancy_percent
FROM dormitories d
JOIN rooms r ON r.dorm_id = d.dorm_id
GROUP BY d.name
ORDER BY occupancy_percent DESC;

-- 2) Free rooms / beds
SELECT dorm_name, room_number, room_type, capacity, occupancy, free_beds
FROM v_room_occupancy
WHERE free_beds > 0
ORDER BY dorm_name, free_beds DESC, room_number;

-- 3) Students with current housing
SELECT student_id,
       first_name || ' ' || last_name AS student,
       dorm_name,
       room_number,
       check_in
FROM v_student_current_housing
ORDER BY student;

-- 4) Students without housing (currently not assigned)
SELECT student_id,
       first_name || ' ' || last_name AS student,
       faculty,
       email
FROM v_student_current_housing
WHERE contract_id IS NULL
ORDER BY student;

-- 5) Room list with occupancy + free beds
SELECT dorm_name, room_number, room_type, capacity, occupancy, free_beds
FROM v_room_occupancy
ORDER BY dorm_name, room_number;

-- 6) List occupants of a given room (example: room_id = 1)
SELECT c.room_id, r.room_number,
       s.student_id, s.first_name, s.last_name,
       c.check_in, c.check_out
FROM v_active_contracts_today c
JOIN students s ON s.student_id = c.student_id
JOIN rooms r ON r.room_id = c.room_id
WHERE c.room_id = 1
ORDER BY s.last_name;

-- 7) Open maintenance requests (view)
SELECT * FROM v_open_maintenance
ORDER BY dorm_name, reported_on;

-- 8) Maintenance count by dorm and status
SELECT d.name AS dorm, mr.status, COUNT(*) AS requests
FROM maintenance_requests mr
JOIN rooms r ON r.room_id = mr.room_id
JOIN dormitories d ON d.dorm_id = r.dorm_id
GROUP BY d.name, mr.status
ORDER BY dorm, mr.status;

-- 9) Payments total per student
SELECT s.student_id,
       s.first_name || ' ' || s.last_name AS student,
       COALESCE(SUM(p.amount),0) AS total_paid
FROM students s
LEFT JOIN payments p ON p.student_id = s.student_id
GROUP BY s.student_id, student
ORDER BY total_paid DESC;

-- 10) Recent payments (last 30 days)
SELECT p.payment_id,
       s.first_name || ' ' || s.last_name AS student,
       p.amount,
       p.method,
       p.payment_date,
       p.note
FROM payments p
JOIN students s ON s.student_id = p.student_id
WHERE p.payment_date >= CURRENT_DATE - 30
ORDER BY p.payment_date DESC, p.payment_id DESC;
