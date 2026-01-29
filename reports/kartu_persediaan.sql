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
        PARTITION BY
            td.product_id
        ORDER BY t.transaction_date, t.id
    ) AS running_balance
FROM
    transaction_details td
    JOIN transactions t ON td.transaction_id = t.id
    JOIN documents d ON t.document_id = d.id
WHERE
    td.product_id = 1 -- INPUT ID PRODUCT
ORDER BY t.transaction_date, t.id;