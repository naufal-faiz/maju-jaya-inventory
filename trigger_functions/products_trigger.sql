DELIMITER $$

## *** INSERT PRODUCTS *** ##
CREATE TRIGGER trg_products_insert
AFTER INSERT ON products
FOR EACH ROW
INSERT INTO audit_logs
(table_name, record_id, action, new_value, changed_by)
VALUES (
    'products',
    NEW.id,
    'INSERT',
    JSON_OBJECT(
        'name', NEW.name, 
        'current_price', NEW.current_price,  
        'min_stock', NEW.min_stock),
    CURRENT_USER()
);

## *** UPDATE PRODUCTS *** ##
CREATE TRIGGER trg_products_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs (
        table_name,
        record_id,
        action,
        old_value,
        new_value,
        changed_by
    )
    VALUES (
        'products',
        OLD.id,
        'UPDATE',
        JSON_OBJECT(
            'name', OLD.name,
            'current_price', OLD.current_price,
            'min_stock', OLD.min_stock
        ),
        JSON_OBJECT(
            'name', NEW.name,
            'current_price', NEW.current_price,
            'min_stock', NEW.min_stock
        ),
        CURRENT_USER()
    );
    END$$

## *** DELETE PRODUCTS *** ##
CREATE TRIGGER trg_products_audit_soft_delete
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    IF OLD.deleted_at IS NULL AND NEW.deleted_at IS NOT NULL THEN
        INSERT INTO audit_logs (
            table_name,
            record_id,
            action,
            old_value,
            new_value,
            changed_by
        )
        VALUES (
            'products',
            OLD.id,
            'DELETE',
            JSON_OBJECT('deleted_at', OLD.deleted_at),
            JSON_OBJECT('deleted_at', NEW.deleted_at),
            CURRENT_USER()
        );
    END IF;
END$$

## *** LOCK DELETED PRODUCTS *** ##
CREATE TRIGGER trg_products_lock_deleted
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF OLD.deleted_at IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Produk terhapus tidak bisa diubah';
    END IF;
END$$

DELIMITER ;

SHOW TRIGGERS LIKE 'products';

# JIKA DIPERLUKAN SAJA!!
DROP TRIGGER IF EXISTS trg_products_insert;
DROP TRIGGER IF EXISTS trg_products_update;
DROP TRIGGER IF EXISTS trg_products_delete;
DROP TRIGGER IF EXISTS trg_products_audit_soft_delete;
DROP TRIGGER IF EXISTS trg_products_lock_deleted;