CREATE ROLE auditor_role;
GRANT SELECT ON maju_jaya_inventory.* TO auditor_role;

# BUAT USER
CREATE USER 'fahmialfath.auditor'@'%' IDENTIFIED BY 'fahmi_pass';

# ASSIGN ROLE
GRANT auditor_role TO 'fahmialfath.auditor'@'%';

# ROLE DEFAULT
SET DEFAULT ROLE auditor_role TO
'fahmialfath.auditor'@'%';