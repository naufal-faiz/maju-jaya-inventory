CREATE TABLE audit_logs (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(100) NOT NULL,
    record_id INT NOT NULL,
    action ENUM('INSERT', 'UPDATE', 'DELETE', 'APPROVE') NOT NULL,
    old_value JSON NULL,
    new_value JSON NULL,
    changed_by VARCHAR(50),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DESC audit_logs;

SHOW CREATE TABLE audit_logs;

# JANGAN DIPAKE KALO GA PERLU!
DROP TABLE audit_logs;