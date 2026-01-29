INSERT INTO documents
(document_number, document_type, document_date, description)
VALUES
('SJ-001', 'Surat Jalan', '2025-01-02', 'Barang masuk dari supplier'),
('SO-005', 'Surat Order', '2025-01-10', 'Barang keluar ke produksi');

SELECT * FROM documents;

# SEKALI LAGI JANGAN PAKE
TRUNCATE documents;