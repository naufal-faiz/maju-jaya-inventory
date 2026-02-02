START TRANSACTION;

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
        '2026-01-20',
        NOW(),
        'IN',
        2,
        1,
        'Pembelian Stok Awal TV LED'
    )

SELECT * FROM transactions;

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

SELECT * FROM transaction_details;

COMMIT;

START TRANSACTION;

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
        '2026-02-11',
        NOW(),
        'OUT',
        NULL,
        4,
        'Penjualan 11 Unit Laptop Acer dan 5 Unit kulkas LG'
    );

SELECT * FROM transactions WHERE transaction_type = 'OUT';


INSERT INTO
    transaction_details (
        transaction_id,
        product_id,
        quantity,
        unit_price
    )
VALUES (
        5,
        2,
        11,
        (
            SELECT current_price
            FROM products
            WHERE
                id = 2
        )
    ),
    (
        5,
        4,
        5,
        (
            SELECT current_price
            FROM products
            WHERE
                id = 4
        )
    );

SELECT * FROM transaction_details WHERE transaction_id = 5;
COMMIT;

START TRANSACTION;

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
        '2026-01-31',
        NOW(),
        'IN',
        2,
        3,
        'Pembelian Kulkas LG 25 Unit'
    ),
    (
        '2026-01-31',
        NOW(),
        'IN',
        4,
        3,
        'Pembelian Laptop Acer 21 Unit'
    ),
    (
        '2026-01-31',
        NOW(),
        'IN',
        1,
        3,
        'Pembelian Mesin Cuci Sharp 15 Unit'
    );

SELECT * FROM transactions WHERE id BETWEEN 2 AND 4;

INSERT INTO
    transaction_details (
        transaction_id,
        product_id,
        quantity,
        unit_price
    )
VALUES (
        2,
        4,
        25,
        (
            SELECT current_price
            FROM products
            WHERE
                id = 4
        )
    ),
    (
        3,
        2,
        21,
        (
            SELECT current_price
            FROM products
            WHERE
                id = 2
        )
    ),
    (
        4,
        5,
        15,
        (
            SELECT current_price
            FROM products
            WHERE
                id = 5
        )
    ),
    (
        4,
        1,
        10,
        (
            SELECT current_price
            FROM products
            WHERE
                id = 1
        )
    );

SELECT *
FROM transaction_details
WHERE
    transaction_id BETWEEN 2 AND 4;

COMMIT;