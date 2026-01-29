CREATE TABLE documents (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    document_number VARCHAR(50) UNIQUE NOT NULL,
    document_type VARCHAR(50) NOT NULL,
    document_date DATE NOT NULL,
    description TEXT,
    deleted_at TIMESTAMP DEFAULT NULL
);

DESC documents;

SHOW CREATE TABLE documents;

# JANGAN DIPAKE KALO GA PERLU!
DROP TABLE documents;