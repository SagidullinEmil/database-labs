BEGIN;

CREATE OR REPLACE FUNCTION fn_prevent_student_overlap()
RETURNS TRIGGER AS $$
DECLARE
  overlap_count INT;
  new_end DATE;
BEGIN
  new_end := COALESCE(NEW.check_out, DATE '9999-12-31');

  SELECT COUNT(*)
    INTO overlap_count
  FROM contracts c
  WHERE c.student_id = NEW.student_id
    AND c.contract_id <> COALESCE(NEW.contract_id, -1)
    AND c.status = 'active'
    AND (COALESCE(c.check_out, DATE '9999-12-31') >= NEW.check_in)
    AND (new_end >= c.check_in);

  IF overlap_count > 0 THEN
    RAISE EXCEPTION 'Student % already has an overlapping active contract', NEW.student_id;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_prevent_student_overlap ON contracts;
CREATE TRIGGER trg_prevent_student_overlap
BEFORE INSERT OR UPDATE OF student_id, check_in, check_out, status
ON contracts
FOR EACH ROW
WHEN (NEW.status = 'active')
EXECUTE FUNCTION fn_prevent_student_overlap();


CREATE OR REPLACE FUNCTION fn_prevent_room_overcapacity()
RETURNS TRIGGER AS $$
DECLARE
  active_count INT;
  cap INT;
BEGIN
  SELECT capacity INTO cap FROM rooms WHERE room_id = NEW.room_id;

  SELECT COUNT(*)
    INTO active_count
  FROM contracts c
  WHERE c.room_id = NEW.room_id
    AND c.contract_id <> COALESCE(NEW.contract_id, -1)
    AND c.status = 'active'
    AND (c.check_out IS NULL OR c.check_out >= CURRENT_DATE)
    AND c.check_in <= CURRENT_DATE;

  IF NEW.status = 'active' AND NEW.check_in <= CURRENT_DATE
     AND (NEW.check_out IS NULL OR NEW.check_out >= CURRENT_DATE) THEN
    active_count := active_count + 1;
  END IF;

  IF active_count > cap THEN
    RAISE EXCEPTION 'Room % would exceed capacity (% > %)', NEW.room_id, active_count, cap;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_prevent_room_overcapacity ON contracts;
CREATE TRIGGER trg_prevent_room_overcapacity
BEFORE INSERT OR UPDATE OF room_id, check_in, check_out, status
ON contracts
FOR EACH ROW
EXECUTE FUNCTION fn_prevent_room_overcapacity();


CREATE OR REPLACE FUNCTION fn_refresh_room_occupancy(p_room_id BIGINT)
RETURNS VOID AS $$
DECLARE
  cnt INT;
BEGIN
  SELECT COUNT(*)
    INTO cnt
  FROM contracts c
  WHERE c.room_id = p_room_id
    AND c.status = 'active'
    AND c.check_in <= CURRENT_DATE
    AND (c.check_out IS NULL OR c.check_out >= CURRENT_DATE);

  UPDATE rooms
  SET occupancy = cnt
  WHERE room_id = p_room_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_contract_after_change()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP IN ('INSERT','UPDATE') THEN
    PERFORM fn_refresh_room_occupancy(NEW.room_id);
  END IF;

  IF TG_OP = 'UPDATE' AND OLD.room_id <> NEW.room_id THEN
    PERFORM fn_refresh_room_occupancy(OLD.room_id);
  ELSIF TG_OP = 'DELETE' THEN
    PERFORM fn_refresh_room_occupancy(OLD.room_id);
  END IF;

  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_contract_after_change ON contracts;
CREATE TRIGGER trg_contract_after_change
AFTER INSERT OR UPDATE OR DELETE
ON contracts
FOR EACH ROW
EXECUTE FUNCTION fn_contract_after_change();

COMMIT;
