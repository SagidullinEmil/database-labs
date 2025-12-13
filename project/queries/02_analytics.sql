-- 1) Beds utilization by room type
SELECT room_type,
       SUM(capacity) AS beds_total,
       SUM(occupancy) AS occupied_beds,
       ROUND(100.0 * SUM(occupancy)::numeric / NULLIF(SUM(capacity),0), 2) AS utilization_percent
FROM rooms
WHERE is_active = TRUE
GROUP BY room_type
ORDER BY utilization_percent DESC;

-- 2) Dorm with most open maintenance requests
SELECT dorm_name, COUNT(*) AS open_requests
FROM v_open_maintenance
GROUP BY dorm_name
ORDER BY open_requests DESC;

-- 3) Average resolution time (days) by issue type (resolved only)
SELECT issue_type,
       ROUND(AVG((resolved_on - reported_on))::numeric, 2) AS avg_days_to_resolve,
       COUNT(*) AS resolved_count
FROM maintenance_requests
WHERE status = 'resolved'
GROUP BY issue_type
ORDER BY avg_days_to_resolve;

-- 4) Payments by month (last 6 months)
SELECT to_char(date_trunc('month', payment_date), 'YYYY-MM') AS month,
       SUM(amount) AS total_amount,
       COUNT(*) AS payments_count
FROM payments
WHERE payment_date >= (CURRENT_DATE - INTERVAL '6 months')
GROUP BY 1
ORDER BY month;

-- 5) Payment methods distribution
SELECT method, COUNT(*) AS cnt, SUM(amount) AS total
FROM payments
GROUP BY method
ORDER BY cnt DESC;

-- 6) Students with highest total payments
SELECT s.student_id,
       s.first_name || ' ' || s.last_name AS student,
       SUM(p.amount) AS total_paid
FROM payments p
JOIN students s ON s.student_id = p.student_id
GROUP BY s.student_id, student
ORDER BY total_paid DESC
LIMIT 5;

-- 7) Rooms that are full
SELECT d.name AS dorm, r.room_number, r.capacity, r.occupancy
FROM rooms r
JOIN dormitories d ON d.dorm_id = r.dorm_id
WHERE r.is_active = TRUE AND r.occupancy = r.capacity
ORDER BY dorm, r.room_number;

-- 8) Dorm capacity vs. assigned students (sanity)
SELECT d.name AS dorm,
       d.total_capacity,
       SUM(r.capacity) AS beds_by_rooms,
       SUM(r.occupancy) AS occupied_beds
FROM dormitories d
JOIN rooms r ON r.dorm_id = d.dorm_id
GROUP BY d.name, d.total_capacity
ORDER BY dorm;

-- 9) Maintenance workload per staff (open only)
SELECT st.full_name,
       st.role,
       COUNT(mr.request_id) AS open_assigned
FROM staff st
LEFT JOIN maintenance_requests mr
  ON mr.assigned_staff_id = st.staff_id
 AND mr.status IN ('pending','in_progress')
WHERE st.is_active = TRUE
GROUP BY st.full_name, st.role
ORDER BY open_assigned DESC, st.full_name;

-- 10) Students per faculty (with and without housing)
SELECT s.faculty,
       COUNT(*) AS students_total,
       COUNT(v.contract_id) AS students_housed_now
FROM students s
LEFT JOIN v_student_current_housing v ON v.student_id = s.student_id AND v.contract_id IS NOT NULL
GROUP BY s.faculty
ORDER BY students_total DESC;
psql -U postgres -d dormitory_db
