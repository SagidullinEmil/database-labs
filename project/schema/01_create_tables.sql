-- University Dormitory & Student Housing System
-- Core tables (PostgreSQL)

BEGIN;

CREATE TABLE dormitories (
  dorm_id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name           VARCHAR(120) NOT NULL UNIQUE,
  address        TEXT NOT NULL,
  total_capacity INTEGER NOT NULL CHECK (total_capacity > 0)
);

CREATE TABLE rooms (
  room_id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  dorm_id        BIGINT NOT NULL REFERENCES dormitories(dorm_id) ON DELETE CASCADE,
  room_number    VARCHAR(16) NOT NULL,
  room_type      VARCHAR(16) NOT NULL CHECK (room_type IN ('single','double','triple','quad')),
  capacity       INTEGER NOT NULL CHECK (capacity > 0 AND capacity <= 8),
  occupancy      INTEGER NOT NULL DEFAULT 0 CHECK (occupancy >= 0),
  is_active      BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT uq_room_per_dorm UNIQUE (dorm_id, room_number)
);

CREATE TABLE students (
  student_id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  first_name     VARCHAR(60) NOT NULL,
  last_name      VARCHAR(60) NOT NULL,
  faculty        VARCHAR(120),
  phone_number   VARCHAR(32),
  email          VARCHAR(120) UNIQUE,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE staff (
  staff_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  full_name      VARCHAR(120) NOT NULL,
  role           VARCHAR(60) NOT NULL CHECK (role IN ('administrator','maintenance','security','manager')),
  phone_number   VARCHAR(32),
  email          VARCHAR(120) UNIQUE,
  is_active      BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE contracts (
  contract_id    BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  student_id     BIGINT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  room_id        BIGINT NOT NULL REFERENCES rooms(room_id) ON DELETE RESTRICT,
  check_in       DATE NOT NULL,
  check_out      DATE,
  status         VARCHAR(16) NOT NULL DEFAULT 'active'
                 CHECK (status IN ('active','completed','cancelled')),
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT chk_contract_dates CHECK (check_out IS NULL OR check_out >= check_in)
);

CREATE TABLE payments (
  payment_id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  student_id     BIGINT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  amount         NUMERIC(10,2) NOT NULL CHECK (amount > 0),
  payment_date   DATE NOT NULL DEFAULT CURRENT_DATE,
  method         VARCHAR(16) NOT NULL DEFAULT 'cash'
                 CHECK (method IN ('cash','card','transfer')),
  note           TEXT
);

CREATE TABLE maintenance_requests (
  request_id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  room_id        BIGINT NOT NULL REFERENCES rooms(room_id) ON DELETE CASCADE,
  reported_by_student_id BIGINT REFERENCES students(student_id) ON DELETE SET NULL,
  assigned_staff_id      BIGINT REFERENCES staff(staff_id) ON DELETE SET NULL,
  reported_on    DATE NOT NULL DEFAULT CURRENT_DATE,
  issue_type     VARCHAR(24) NOT NULL
                 CHECK (issue_type IN ('plumbing','electricity','furniture','heating','cleaning','other')),
  description    TEXT NOT NULL,
  status         VARCHAR(16) NOT NULL DEFAULT 'pending'
                 CHECK (status IN ('pending','in_progress','resolved','cancelled')),
  resolved_on    DATE,
  CONSTRAINT chk_resolved_on CHECK (
    (status = 'resolved' AND resolved_on IS NOT NULL)
    OR (status <> 'resolved' AND resolved_on IS NULL)
  )
);

COMMIT;
