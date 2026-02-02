DELIMITER $$

## *** INSERT TRANSACTIONS *** ##
CREATE TRIGGER trg_transactions_insert
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs (
        table_name,
        record_id,
        action,
        new_value,
        changed_by
    )
    VALUES (
        'transactions',
        NEW.id,
        'INSERT',
        JSON_OBJECT(
            'transaction_date', NEW.transaction_date,
            'transaction_type', NEW.transaction_type,
            'supplier_id', NEW.supplier_id,
            'document_id', NEW.document_id,
            'notes', NEW.notes
        ),
        USER()
    );
END$$

## *** UPDATE TRANSACTIONS *** ##
CREATE TRIGGER trg_transactions_update
AFTER UPDATE ON transactions
FOR EACH ROW
BEGIN
    IF OLD.transaction_date <> NEW.transaction_date
        OR OLD.transaction_type <> NEW.transaction_type
        OR OLD.document_id <> NEW.document_id
        OR OLD.supplier_id <> NEW.supplier_id
        OR OLD.notes <> NEW.notes
    THEN
        INSERT INTO audit_logs (
            table_name,
            record_id,
            action,
            old_value,
            new_value,
            changed_by
        )
        VALUES (
            'transactions',
            OLD.id,
            'UPDATE',
            JSON_OBJECT(
                'transaction_date', OLD.transaction_date,
                'transaction_type', OLD.transaction_type,
                'supplier_id', OLD.supplier_id,
                'document_id', OLD.document_id,
                'notes', OLD.notes
            ),
            JSON_OBJECT(
                'transaction_date', NEW.transaction_date,
                'transaction_type', NEW.transaction_type,
                'supplier_id', NEW.supplier_id,
                'document_id', NEW.document_id,
                'notes', NEW.notes
            ),
            USER()
        );
    END IF;
END$$

## *** AUTO PENDING REVIEW BEFORE UPDATE *** ##
CREATE TRIGGER trg_transactions_auto_review
BEFORE UPDATE ON transactions
FOR EACH ROW
BEGIN
    IF OLD.status = 'POSTED'
        AND (
            OLD.transaction_date <> NEW.transaction_date OR
            OLD.transaction_type <> NEW.transaction_type OR
            OLD.supplier_id <> NEW.supplier_id OR
            OLD.document_id <> NEW.document_id OR
            OLD.notes <> NEW.notes
        ) THEN
    SET NEW.status = 'PENDING_REVIEW';
    END IF;
END$$

## *** ACCESS PERMISSION UPDATE TRANSACTION STATUS *** ##
CREATE TRIGGER trg_transactions_lock_posted
BEFORE UPDATE ON transactions
FOR EACH ROW
BEGIN
    IF NEW.status = 'POSTED'
       AND USER() NOT LIKE '%supervisor%'
       AND USER() NOT LIKE '%it_staff%'
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Status tidak boleh dipaksa POSTED. Perlu persetujuan Supervisor.';
    END IF;
END$$

## *** APPROVE TRANSACTION *** ##
CREATE TRIGGER trg_transactions_audit_update
AFTER UPDATE ON transactions
FOR EACH ROW
BEGIN
    IF OLD.status = 'PENDING_REVIEW'
       AND NEW.status = 'POSTED'
    THEN
        INSERT INTO audit_logs (
            table_name,
            record_id,
            action,
            old_value,
            new_value,
            changed_by
        )
        VALUES (
            'transactions',
            OLD.id,
            'APPROVE',
            JSON_OBJECT(
                'status', OLD.status
            ),
            JSON_OBJECT(
                'status', NEW.status
            ),
            USER()
        );
        END IF;
        END$$

DELIMITER;

SHOW TRIGGERS LIKE 'transactions';

# JIKA DIPERLUKAN SAJA!!
DROP TRIGGER IF EXISTS trg_transactions_insert;

DROP TRIGGER IF EXISTS trg_transactions_update;

DROP TRIGGER IF EXISTS trg_transactions_auto_review;

DROP TRIGGER IF EXISTS trg_transactions_lock_posted;

DROP TRIGGER IF EXISTS trg_transactions_audit_update;