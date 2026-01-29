DELIMITER $$

## *** CHECK STOCK BEFORE OUT *** ##
CREATE TRIGGER trg_check_stock_before_out
BEFORE INSERT ON transaction_details
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;

    -- Hitung stok saat ini
    SELECT 
        IFNULL(SUM(
            CASE 
                WHEN t.transaction_type = 'IN' THEN td.quantity
                WHEN t.transaction_type = 'OUT' THEN -td.quantity
            END
        ), 0)
    INTO current_stock
    FROM transaction_details td
    JOIN transactions t ON td.transaction_id = t.id
    WHERE td.product_id = NEW.product_id;

    -- Jika transaksi OUT dan stok tidak cukup
    IF (
        (SELECT transaction_type 
         FROM transactions 
         WHERE id = NEW.transaction_id) = 'OUT'
        AND current_stock < NEW.quantity
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stok tidak mencukupi untuk transaksi OUT';
    END IF;
END$$

## *** INSERT TRANSACTION DETAILS *** ##
CREATE TRIGGER trg_transaction_details_insert
AFTER INSERT ON transaction_details
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
        'transaction_details',
        NEW.id,
        'INSERT',
        JSON_OBJECT(
            'transaction_id', NEW.transaction_id,
            'product_id', NEW.product_id,
            'quantity', NEW.quantity,
            'unit_price', NEW.unit_price,
            'total_price', NEW.total_price
        ),
        CURRENT_USER()
    );
END$$

DELIMITER ;

SHOW TRIGGERS LIKE 'transaction_details';

# JIKA DIPERLUKAN SAJA!!
DROP TRIGGER IF EXISTS trg_check_stock_before_out;
DROP TRIGGER IF EXISTS trg_transaction_details_insert;