CREATE TABLE products (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    product_code VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    category_id INT NOT NULL,
    unit_of_measure VARCHAR(100) NOT NULL,
    current_price DECIMAL(15, 2) UNSIGNED NOT NULL DEFAULT 0.00,
    min_stock INT UNSIGNED NOT NULL DEFAULT 0,
    deleted_at TIMESTAMP DEFAULT NULL,
    INDEX name_idx (name),
    FOREIGN KEY (category_id) REFERENCES categories (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

DESC products;

SHOW CREATE TABLE products;

# JANGAN DIPAKE KALO GA PERLU!
DROP TABLE products;