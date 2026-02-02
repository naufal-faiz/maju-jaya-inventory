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
    USER()
);

## *** UPDATE PRODUCTS *** ##
CREATE TRIGGER trg_products_update
AFTER UPDATE ON products
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
            'products',
            OLD.id,
            'DELETE',
            JSON_OBJECT('deleted_at', OLD.deleted_at),
            JSON_OBJECT('deleted_at', NEW.deleted_at),
            USER()
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

## BELUM DIGUNAKAN ##
## BLOCK USING DELETED DOCUMENT TO TRANSACTION ##
CREATE TRIGGER trg_transactions_block_deleted_product
BEFORE INSERT ON transactions
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM products
        WHERE id = NEW.product_id
        AND deleted_at IS NOT NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Produk sudah dihapus dan tidak boleh digunakan';
    END IF;
END$$

DELIMITER;

SHOW TRIGGERS LIKE 'products';

# JIKA DIPERLUKAN SAJA!!
DROP TRIGGER IF EXISTS trg_products_insert;

DROP TRIGGER IF EXISTS trg_products_update;

DROP TRIGGER IF EXISTS trg_products_lock_deleted;