DROP PROCEDURE IF EXISTS sp_monthly_report;
DROP PROCEDURE IF EXISTS sp_running_stock;
DROP PROCEDURE IF EXISTS sp_stock_card;

DELIMITER $$

## *** MONTHLY REPORT PROCEDURE *** ##
CREATE PROCEDURE sp_monthly_report(IN p_month INT, IN p_year INT)
BEGIN
    SELECT
        p.product_code, 
        p.name AS product_name,
        SUM(CASE WHEN t.transaction_type = 'IN' THEN td.quantity ELSE 0 END) AS total_in,
        SUM(CASE WHEN t.transaction_type = 'OUT' THEN td.quantity ELSE 0 END) AS total_out,
        fn_get_stock(p.id) AS final_stock
    FROM products p
    LEFT JOIN transaction_details td ON p.id = td.product_id
    LEFT JOIN transactions t ON td.transaction_id = t.id
    WHERE MONTH(t.transaction_date) = p_month AND YEAR(t.transaction_date) = p_year
    GROUP BY p.id;
END$$

## *** STOCK MUTATION PROCEDURE *** ##
CREATE PROCEDURE sp_running_stock(IN p_start DATE, IN p_end DATE)
BEGIN
    SELECT 
        t.transaction_date,
        p.name AS product_name,
        t.transaction_type,
        td.quantity,
        t.status
    FROM transactions t
    JOIN transaction_details td ON t.id = td.transaction_id
    JOIN products p ON td.product_id = p.id
    WHERE t.transaction_date BETWEEN p_start AND p_end
    ORDER BY t.transaction_date ASC;
END$$

## *** STOCK CARD PROCEDURE *** ##
CREATE PROCEDURE sp_stock_card(IN p_product_id INT)
BEGIN
    SELECT
        t.transaction_date,
        t.entry_date,
        d.document_number,
        d.description,
        t.transaction_type,
        td.quantity AS qty_in_out,
        td.unit_price,
        SUM(
            CASE
                WHEN t.transaction_type = 'IN' THEN td.quantity
                ELSE - td.quantity
            END
        ) OVER (
            PARTITION BY td.product_id
            ORDER BY t.transaction_date, t.id
        ) AS running_balance
    FROM
        transaction_details td
        JOIN transactions t ON td.transaction_id = t.id
        JOIN documents d ON t.document_id = d.id
    WHERE
        td.product_id = p_product_id
    ORDER BY t.transaction_date, t.id;
END$$

DELIMITER ;