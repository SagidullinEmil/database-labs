BEGIN;

CREATE OR REPLACE VIEW v_active_contracts_today AS
SELECT
  c.contract_id,
  c.student_id,
  c.room_id,
  c.check_in,
  c.check_out,
  c.status
FROM contracts c
WHERE c.status = 'active'
  AND c.check_in <= CURRENT_DATE
  AND (c.check_out IS NULL OR c.check_out >= CURRENT_DATE);

CREATE OR REPLACE VIEW v_room_occupancy AS
SELECT
  d.dorm_id,
  d.name AS dorm_name,
  r.room_id,
  r.room_number,
  r.room_type,
  r.capacity,
  r.occupancy,
  (r.capacity - r.occupancy) AS free_beds
FROM rooms r
JOIN dormitories d ON d.dorm_id = r.dorm_id
WHERE r.is_active = TRUE;

CREATE OR REPLACE VIEW v_student_current_housing AS
SELECT
  s.student_id,
  s.first_name,
  s.last_name,
  s.faculty,
  s.email,
  c.contract_id,
  d.name AS dorm_name,
  r.room_number,
  c.check_in
FROM students s
LEFT JOIN v_active_contracts_today c ON c.student_id = s.student_id
LEFT JOIN rooms r ON r.room_id = c.room_id
LEFT JOIN dormitories d ON d.dorm_id = r.dorm_id;

CREATE OR REPLACE VIEW v_open_maintenance AS
SELECT
  mr.request_id,
  d.name AS dorm_name,
  r.room_number,
  mr.issue_type,
  mr.status,
  mr.reported_on,
  mr.description,
  st.full_name AS assigned_staff
FROM maintenance_requests mr
JOIN rooms r ON r.room_id = mr.room_id
JOIN dormitories d ON d.dorm_id = r.dorm_id
LEFT JOIN staff st ON st.staff_id = mr.assigned_staff_id
WHERE mr.status IN ('pending','in_progress');

COMMIT;
