DROP FUNCTION IF EXISTS fn_get_stock;

DELIMITER $$

CREATE FUNCTION fn_get_stock(p_product_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_stock INT;
    SELECT IFNULL(SUM(CASE WHEN t.transaction_type = 'IN' THEN td.quantity ELSE -td.quantity END), 0)
    INTO total_stock
    FROM transaction_details td
    JOIN transactions t ON td.transaction_id = t.id
    WHERE td.product_id = p_product_id AND t.status = 'POSTED';
    
    RETURN total_stock;
END $$

DELIMITER ;