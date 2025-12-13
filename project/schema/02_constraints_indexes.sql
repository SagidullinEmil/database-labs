BEGIN;

CREATE INDEX idx_rooms_dorm ON rooms(dorm_id);
CREATE INDEX idx_contracts_student ON contracts(student_id);
CREATE INDEX idx_contracts_room ON contracts(room_id);
CREATE INDEX idx_contracts_status ON contracts(status);
CREATE INDEX idx_payments_student ON payments(student_id);
CREATE INDEX idx_maint_room ON maintenance_requests(room_id);
CREATE INDEX idx_maint_status ON maintenance_requests(status);

COMMIT;