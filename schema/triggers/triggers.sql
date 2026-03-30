DELIMITER //

CREATE TRIGGER complaint_status_change
AFTER UPDATE ON complaints
FOR EACH ROW
BEGIN

IF OLD.status_id <> NEW.status_id THEN

INSERT INTO complaint_history
(complaint_id, old_status, new_status)

VALUES
(NEW.complaint_id, OLD.status_id, NEW.status_id);

END IF;

END //

DELIMITER ;
