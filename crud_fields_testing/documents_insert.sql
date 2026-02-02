INSERT INTO
    documents (
        document_number,
        document_type,
        document_date,
        description
    )
VALUES (
        'SO-001',
        'Surat Order',
        '2026-01-20',
        'Pembelian Stok Awal TV LED'
    );

SELECT * FROM documents; 

INSERT INTO
    documents (
        document_number,
        document_type,
        document_date,
        description
    )
VALUES (
        'SJ-001',
        'Surat Jalan',
        '2026-02-10',
        'Penjualan 11 Unit Laptop Acer dan 5 Unit kulkas LG'
    );

SELECT * FROM documents WHERE document_type = "Surat Jalan"; 

### COBA COBA
INSERT INTO documents (document_number, document_type, document_date, description)
VALUES (
    'SO-002',
    'Surat Order',
    '2026-01-31',
    'Pengisian Slot Gudang Kosong'
);