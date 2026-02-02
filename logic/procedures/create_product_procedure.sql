DROP PROCEDURE IF EXISTS sp_insert_product;

DELIMITER $$

## *** STORED PROCEDURE INSERT PRODUCT *** ##
CREATE PROCEDURE sp_insert_product(
    IN p_code VARCHAR(50),
    IN p_name VARCHAR(255),
    IN p_category_id INT,
    IN p_uom VARCHAR(100),
    IN p_price DECIMAL(15, 2),
    IN p_min_stock INT
) BEGIN 
    INSERT INTO products (product_code, name, category_id, unit_of_measure, current_price, min_stock) VALUES
    (p_code, p_name, p_category_id, p_uom, p_price, p_min_stock);
END $$

DELIMITER ;