CREATE TABLE transaction_details (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transaction_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    unit_price DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    total_price DECIMAL(15, 2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    FOREIGN KEY (transaction_id) REFERENCES transactions (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

DESC transaction_details;

SHOW CREATE TABLE transaction_details;

# JANGAN DIPAKE KALO GA PERLU!
DROP TABLE transaction_details;