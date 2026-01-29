CREATE ROLE it_staff_role;
GRANT ALL PRIVILEGES ON maju_jaya_inventory.* TO it_staff_role;

# BUAT USER
CREATE USER 'nopaleon.it_staff'@'%' IDENTIFIED BY 'nopal_pass';

# ASSIGN ROLE
GRANT it_staff_role TO 'nopaleon.it_staff'@'%';

# ROLE DEFAULT
SET DEFAULT ROLE it_staff_role TO
'nopaleon.it_staff'@'%';