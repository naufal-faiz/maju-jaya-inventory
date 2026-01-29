INSERT INTO
    transactions (
        transaction_date,
        entry_date,
        transaction_type,
        supplier_id,
        document_id,
        notes
    )
VALUES (
        '2025-01-01',
        NOW(),
        'IN',
        2,
        1,
        'Pembelian Stok Awal TV LED'
    )

INSERT INTO
    transaction_details (
        transaction_id,
        product_id,
        quantity,
        unit_price
    )
SELECT 1, id, 10, current_price
FROM products
WHERE
    id = 1;

INSERT INTO
    transactions (
        transaction_date,
        entry_date,
        transaction_type,
        supplier_id,
        document_id,
        notes
    )
VALUES (
        '2025-01-01',
        NOW(),
        'OUT',
        NULL,
        2,
        'Penjualan 2 Unit TV LED'
    );

INSERT INTO
    transaction_details (
        transaction_id,
        product_id,
        quantity,
        unit_price
    )
SELECT 4, id, 2, current_price
FROM products
WHERE
    id = 1;