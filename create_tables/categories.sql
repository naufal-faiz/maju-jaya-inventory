CREATE TABLE categories (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    deleted_at TIMESTAMP DEFAULT NULL
);

DESC categories;

SHOW CREATE TABLE categories;

# JANGAN DIPAKE KALO GA PERLU!
DROP TABLE categories;