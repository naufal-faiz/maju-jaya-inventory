# DROP USER
DROP USER IF EXISTS 'indrakus.warehouse_staff'@'%';
DROP USER IF EXISTS'alifia.warehouse_staff' @'%';

# DROP ROLE
DROP ROLE IF EXISTS warehouse_staff_role;

# CREATE ROLE
CREATE ROLE warehouse_staff_role;

# GRANT PRIVILEGES
GRANT SELECT, INSERT, UPDATE ON maju_jaya_inventory.categories TO warehouse_staff_role;
GRANT SELECT, INSERT, UPDATE ON maju_jaya_inventory.suppliers TO warehouse_staff_role;
GRANT SELECT, UPDATE ON maju_jaya_inventory.products TO warehouse_staff_role;
GRANT SELECT, UPDATE ON maju_jaya_inventory.transactions TO warehouse_staff_role;
GRANT SELECT, UPDATE ON maju_jaya_inventory.transaction_details TO warehouse_staff_role;
GRANT SELECT ON maju_jaya_inventory.documents TO warehouse_staff_role;
GRANT SELECT ON maju_jaya_inventory.audit_logs TO warehouse_staff_role;
GRANT EXECUTE ON PROCEDURE maju_jaya_inventory.* TO warehouse_staff_role;

# BUAT USER
CREATE USER 'indrakus.warehouse_staff'@'%' IDENTIFIED BY 'indra_pass';
CREATE USER 'alifia.warehouse_staff' @'%' IDENTIFIED BY 'alifia_pass';

# ASSIGN ROLE
GRANT warehouse_staff_role TO 'indrakus.warehouse_staff'@'%';
GRANT warehouse_staff_role TO 'alifia.warehouse_staff' @'%';

# ROLE DEFAULT
SET DEFAULT ROLE warehouse_staff_role TO
'indrakus.warehouse_staff'@'%', 'alifia.warehouse_staff'@'%';