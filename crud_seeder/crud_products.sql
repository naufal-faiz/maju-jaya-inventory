INSERT INTO products
(product_code, name, category_id, unit_of_measure, current_price, min_stock)
VALUES
('PRD-001', 'Baut 10mm', 1, 'pcs', 1000.00, 50),
('PRD-002', 'Mur 10mm', 1, 'pcs', 800.00, 50),
('PRD-003', 'Plat Besi', 2, 'lembar', 50000.00, 10);

SELECT * FROM products;

# SEKALI LAGI JANGAN PAKE
TRUNCATE products;