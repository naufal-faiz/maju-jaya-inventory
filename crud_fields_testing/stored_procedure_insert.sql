### *** INSERT PRODUCT BY PROCEDURE *** ###
CALL sp_insert_product ("TV-0222", "TV Cocoa", 3, 'unit', 2000000, 10);
SELECT * FROM products WHERE product_code = "TV-024";

### *** INSERT TRANSACTION BY PROCEDURE *** ###
CALL sp_insert_transaction ("2026-02-12", NOW(), "OUT", NULL, 4, "Barang susulan");
CALL sp_insert_transaction ("2026-02-12", NOW(), "OUT", NULL, 4, "Barang susulan");
CALL sp_insert_transaction ("2026-02-12", NOW(), "IN", 4,  3, "Tambahan Stok");
SELECT * FROM transactions WHERE transaction_date = "2026-02-12";

### *** INSERT TRANSACTION DETAILS BY PROCEDURE *** ###
CALL sp_add_items (6, 4, 2);
CALL sp_add_items (7, 4, 9);
CALL sp_add_items (8, 1, 10);
SELECT * FROM transaction_details WHERE transaction_id BETWEEN 6 AND 8;

### *** INSERT PROCEDURE OF TRANSACTION WITH BLOCK TRANSACTION *** ###
START TRANSACTION;

CALL sp_insert_transaction ("2026-02-12", NOW(), "OUT", NULL,  4, "Barang Diborong");

SELECT * FROM transactions WHERE transaction_date = "2026-02-12" AND id BETWEEN 16 AND 20;

CALL sp_add_items (18, 4, 20);
SELECT * FROM transaction_details WHERE transaction_id BETWEEN 17 AND 20;

COMMIT;
# OR
ROLLBACK;