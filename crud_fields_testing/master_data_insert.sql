INSERT INTO
    categories (name, description)
VALUES (
        'Gadget',
        'Smartphone, Laptop, dan lain-lain'
    ),
    (
        'Alat Cuci',
        'Mesin cuci, wastafel, dan lain-lain'
    ),
    (
        'Elektronik',
        'Televisi, AC, kulkas, dan lain-lain'
    );

INSERT INTO
    products (
        product_code,
        name,
        category_id,
        unit_of_measure,
        current_price,
        min_stock
    )
VALUES (
        'TV-001',
        'TV LED 42"',
        3,
        'unit',
        2500000.00,
        5
    ),
    (
        'LAP-002',
        'Laptop Acer',
        1,
        'unit',
        5000000.00,
        10
    ),
    (
        'PHO-003',
        'Smartphone Samsung',
        1,
        'unit',
        2000000.00,
        8
    ),
    (
        'REF-004',
        'Kulkas LG',
        3,
        'unit',
        3500000.00,
        3
    ),
    (
        'MES-005',
        'Mesin Cuci Sharp',
        2,
        'unit',
        2200000.00,
        6
    );

INSERT INTO
    suppliers (name, contact_info)
VALUES (
        'PT. Sharp Manufacture',
        'Phone: 08123456789, email: sharp@manufacture.com'
    ),
    (
        'CV. LG Electronics',
        'Phone: 08123456789, email: lg@electronics.com'
    ),
    (
        'PT. Acer Indonesia',
        'Phone: 08123456789, email: acer@indonesia.com'
    ),
    (
        'PT. Satyamita Kemas Lestari',
        'Phone: 08123456789, email: satyamita@kemas.com'
    );