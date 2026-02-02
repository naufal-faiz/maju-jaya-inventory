DELIMITER $$

## *** INSERT documents *** ##
CREATE TRIGGER trg_documents_insert
AFTER INSERT ON documents
FOR EACH ROW
INSERT INTO audit_logs
(table_name, record_id, action, new_value, changed_by)
VALUES (
    'documents',
    NEW.id,
    'INSERT',
    JSON_OBJECT(
        'document_number', NEW.document_number, 
        'document_type', NEW.document_type, 
        'description', NEW.description),
    USER()
);

## *** UPDATE documents *** ##
CREATE TRIGGER trg_documents_update
AFTER UPDATE ON documents
FOR EACH ROW
BEGIN
    IF OLD.deleted_at IS NULL AND NEW.deleted_at IS NULL THEN
    INSERT INTO audit_logs (
        table_name,
        record_id,
        action,
        old_value,
        new_value,
        changed_by
    )
    VALUES (
        'documents',
        OLD.id,
        'UPDATE',
        JSON_OBJECT(
            'document_number', OLD.document_number,
            'document_type', OLD.document_type,
            'description', OLD.description
        ),
        JSON_OBJECT(
            'document_number', NEW.document_number,
            'document_type', NEW.document_type,
            'description', NEW.description
        ),
        USER()
    );
    ELSEIF OLD.deleted_at IS NULL AND NEW.deleted_at IS NOT NULL THEN
        INSERT INTO audit_logs (
            table_name,
            record_id,
            action,
            old_value,
            new_value,
            changed_by
        )
    VALUES (
            'documents',
            OLD.id,
            'DELETE',
            JSON_OBJECT('deleted_at', OLD.deleted_at),
            JSON_OBJECT('deleted_at', NEW.deleted_at),
            USER()
        );
    END IF;
    END$$

## *** LOCK DELETED DOCUMENT *** ##
CREATE TRIGGER trg_documents_lock_deleted
BEFORE UPDATE ON documents
FOR EACH ROW
BEGIN
    IF OLD.deleted_at IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Dokumen terhapus tidak bisa diubah';
    END IF;
END$$

## BELUM DIGUNAKAN ##
## BLOCK USING DELETED DOCUMENT TO TRANSACTION ##
CREATE TRIGGER trg_transactions_block_deleted_document
BEFORE INSERT ON transactions
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM documents
        WHERE id = NEW.document_id
        AND deleted_at IS NOT NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Dokumen sudah dihapus dan tidak boleh digunakan';
    END IF;
END$$

DELIMITER;

SHOW TRIGGERS LIKE 'documents';

# JIKA DIPERLUKAN SAJA!!
DROP TRIGGER IF EXISTS trg_documents_insert;

DROP TRIGGER IF EXISTS trg_documents_update;

DROP TRIGGER IF EXISTS trg_documents_lock_deleted;

DROP TRIGGER IF EXISTS trg_transactions_block_deleted_document;