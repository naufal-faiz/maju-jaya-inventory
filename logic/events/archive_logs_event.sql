SET GLOBAL event_scheduler = ON;

## *** EVENT SCHEDULER FOT RETENSI AUDIT LOGS *** ##
CREATE EVENT ev_retensi_audit_logs
ON SCHEDULE EVERY 1 MONTH -- Dijalankan sebulan sekali
STARTS CURRENT_TIMESTAMP
DO
  BEGIN
    INSERT INTO audit_logs_archive
    SELECT * FROM audit_logs
    WHERE changed_at < NOW() - INTERVAL 6 MONTH;

    DELETE FROM audit_logs
    WHERE changed_at < NOW() - INTERVAL 6 MONTH;
  END;
