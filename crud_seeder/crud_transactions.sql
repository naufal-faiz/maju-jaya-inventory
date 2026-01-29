INSERT INTO transactions
(transaction_date, entry_date, transaction_type, supplier_id, document_id, notes)
VALUES
('2025-01-02', NOW(), 'IN', 1, 1, 'Pembelian awal Januari'),
('2025-01-10', NOW(), 'OUT', NULL, 2, 'Pemakaian produksi');

SELECT * FROM transactions;

# SEKALI LAGI JANGAN PAKE
TRUNCATE transactions;