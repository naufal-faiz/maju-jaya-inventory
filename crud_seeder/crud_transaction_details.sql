INSERT INTO transaction_details
(transaction_id, product_id, quantity, unit_price)
VALUES
(1, 1, 100, (SELECT current_price FROM products WHERE id = 1)),
(1, 2, 100, (SELECT current_price FROM products WHERE id = 2)),
(2, 1, 20,  (SELECT current_price FROM products WHERE id = 1));

INSERT INTO
    transaction_details (
        transaction_id,
        product_id,
        quantity,
        unit_price
    )
SELECT 3, id, 15, current_price
FROM products
WHERE
    id = 3;

SELECT * FROM transaction_details;

# SEKALI LAGI JANGAN PAKE
TRUNCATE transaction_details;