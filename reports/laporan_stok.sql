# *** ALL TIME PRODUCTS *** #
SELECT
    p.id,
    p.product_code,
    p.name AS product_name,
    p.unit_of_measure,
    COALESCE(
        SUM(
        CASE 
            WHEN t.transaction_type = 'IN' THEN  td.quantity
            WHEN t.transaction_type = 'OUT' THEN -td.quantity
        END
    ), 0
    ) AS stock_balance
FROM products p
LEFT JOIN transaction_details td ON p.id = td.product_id
LEFT JOIN transactions t ON td.transaction_id = t.id
WHERE p.deleted_at IS NULL
GROUP BY p.id, p.product_code, p.name, p.unit_of_measure
ORDER BY p.id ASC;

# *** MONTHLY STOCK *** #
SELECT
    p.product_code,
    p.name AS product_name,
    MONTH(t.transaction_date) AS month,
    YEAR(t.transaction_date) AS year,
    SUM(
        CASE 
            WHEN t.transaction_type = 'IN' THEN td.quantity  
            ELSE  -td.quantity
        END
    ) AS stock_movement
FROM transaction_details td
JOIN transactions t ON td.transaction_id = t.id
JOIN products p ON td.product_id = p.id
WHERE
    p.deleted_at IS NULL
    AND MONTH(t.transaction_date) = 2 -- VALUE INPUT
    AND YEAR(t.transaction_date) = 2026 -- VALUE INPUT
GROUP BY p.id, MONTH(t.transaction_date), year(t.transaction_date)
ORDER BY p.name;

# *** STOCK MUTATION *** #
SELECT
    p.product_code,
    p.name AS product_name,
    -- SALDO AWAL
    SUM(
        CASE
            WHEN t.transaction_date < '2026-01-30' -- INPUT TANGGAL AWAL
            THEN
                CASE
                    WHEN t.transaction_type = 'IN'  THEN td.quantity
                    ELSE -td.quantity
                END
            ELSE 0
        END
    ) AS opening_stock,
    -- MUTASI BULANAN ON GOING
    SUM(
        CASE
            WHEN t.transaction_date BETWEEN '2026-01-30' AND '2026-02-15' -- INPUT TANGGAL dan TANGGAL AKHIR
            THEN
                CASE
                    WHEN t.transaction_type = 'IN'  THEN td.quantity
                    ELSE -td.quantity
                END
            ELSE 0
        END
    ) AS stock_mutation,
    -- SALDO AKHIR
    SUM(
        CASE
            WHEN t.transaction_date <= '2025-02-15' -- INPUT TANGGAL AKHIR
            THEN
                CASE
                    WHEN t.transaction_type = 'IN'  THEN td.quantity
                    ELSE -td.quantity
                END
            ELSE 0
        END
    ) AS closing_stock
FROM products p
LEFT JOIN transaction_details td ON p.id = td.product_id
LEFT JOIN transactions t ON td.transaction_id = t.id
WHERE p.deleted_at IS NULL
GROUP BY p.id, p.product_code, p.name
ORDER BY p.name;