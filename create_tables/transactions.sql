CREATE TABLE transactions (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transaction_date DATE NOT NULL,
    entry_date DATETIME NOT NULL,
    transaction_type ENUM("IN", "OUT") NOT NULL,
    supplier_id INT NULL,
    document_id INT NOT NULL,
    notes TEXT,
    status ENUM('POSTED', 'PENDING_REVIEW', 'REJECTED') DEFAULT 'POSTED',
    FOREIGN KEY (supplier_id) REFERENCES suppliers (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (document_id) REFERENCES documents (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

DESC transactions;

SHOW CREATE TABLE transactions;

# JANGAN DIPAKE KALO GA PERLU!
DROP TABLE transactions;