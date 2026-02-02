DROP PROCEDURE IF EXISTS sp_insert_transaction;
DROP PROCEDURE IF EXISTS sp_add_items;

DELIMITER $$

## *** STORED PROCEDURE INSERT TRANSACTION *** ##
CREATE PROCEDURE sp_insert_transaction(
    IN p_transaction_date DATE,
    IN p_entry_date DATETIME,
    IN p_transaction_type ENUM("IN", "OUT"),
    IN p_supplier_id INT,
    IN p_document_id INT,
    IN p_notes TEXT
) BEGIN
    INSERT INTO transactions (transaction_date, entry_date, transaction_type, supplier_id, document_id, notes) VALUES
    (p_transaction_date, p_entry_date, p_transaction_type, p_supplier_id, p_document_id, p_notes);
END $$

## *** STORED PROCEDURE INSERT TRANSACTION DETAILS *** ##
CREATE PROCEDURE sp_add_items(
    IN p_transaction_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_price DECIMAL(15, 2);
    SELECT current_price INTO v_price FROM products WHERE id = p_product_id;
    INSERT INTO transaction_details (transaction_id, product_id, quantity, unit_price) VALUES
    (p_transaction_id, p_product_id, p_quantity, v_price);
END $$

DELIMITER ;