SELECT * FROM audit_logs;

SELECT name, current_price, min_stock FROM products WHERE product_code = "PHO-071";

UPDATE products
SET
    name = "Smartphone Samsung S24 Ultra Pro Max",
    current_price = 18000000,
    min_stock = 5
WHERE
    id = 3;

UPDATE products SET deleted_at = NOW() WHERE id = 3;

UPDATE products SET name = "Smasnug" WHERE id = 3;

UPDATE transactions SET notes = "Pembelian Stok dari SHARP" WHERE id = 4;
SELECT * FROM transactions WHERE id =  4;

UPDATE transactions SET status = "POSTED" WHERE id = 4;
SELECT * FROM audit_logs WHERE table_name = "transactions" AND record_id = 4;

SELECT table_name, action, new_value, changed_by, changed_at FROM audit_logs;
SELECT table_name, action, old_value, new_value, changed_by, changed_at FROM audit_logs WHERE action = "UPDATE" LIMIT 100

SELECT DISTINCT unit_of_measure FROM products;

SELECT table_name, COUNT(*) as total_logs 
FROM audit_logs 
GROUP BY table_name 
ORDER BY total_logs DESC;

DELETE FROM transaction_details WHERE quantity = 10;

UPDATE documents SET document_number = "SO-002" WHERE id = 1;

INSERT INTO products (product_code, name, category_id, unit_of_measure, current_price, min_stock) VALUES
("PHO-002", "Iphone X HDC", 1, "unit", 10000000, -3);

INSERT INTO
    transaction_details (
        transaction_id,
        product_id,
        quantity,
        total_price,
        unit_price
    )
SELECT 1, id, 10, current_price, 10000
FROM products
WHERE
    id = 1;

INSERT INTO transactions (notes) VALUES ("Buat Order Fiktif");

INSERT INTO
    products (product_code, name, category_id, unit_of_measure)
VALUES ( 'PHO-071', 'Smartphone Tablet', 3, 'unit');

UPDATE transactions SET status = "POSTED" WHERE id = 4; 

SELECT * FROM audit_logs;

SELECT * FROM transaction_details WHERE transaction_id = 5;
