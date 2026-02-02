# DROP USER
DROP USER IF EXISTS 'ardisusilo.supervisor'@'%';

# DROP ROLE
DROP ROLE IF EXISTS supervisor_role;

# CREATE ROLE
CREATE ROLE supervisor_role;
GRANT SELECT ON maju_jaya_inventory.* TO supervisor_role;
GRANT UPDATE ON maju_jaya_inventory.transactions TO supervisor_role;

# BUAT USER
CREATE USER 'ardisusilo.supervisor'@'%' IDENTIFIED BY 'ardi_pass';

# ASSIGN ROLE
GRANT supervisor_role TO 'ardisusilo.supervisor'@'%';

# ROLE DEFAULT
SET DEFAULT ROLE supervisor_role TO
'ardisusilo.supervisor'@'%';