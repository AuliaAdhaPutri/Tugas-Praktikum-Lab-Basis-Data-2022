-- Active: 1663738801222@@127.0.0.1@3306@classicmodels
USE classicmodels;

SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM products;

-- [NO. 1] Tampilkan kolom tanggal pemesanan product dalam urutan menurun untuk pesanan Ford Pickup Truck 1940
SELECT o.orderDate, od.orderNumber, p.productName
FROM orders as o
INNER JOIN orderdetails as od
ON o.orderNumber = od.orderNumber
INNER JOIN products as p
ON od.productCode = p.productCode
WHERE p.productName = '1940 Ford Pickup Truck'
ORDER BY o.orderDate DESC;

-- [NO.2] Tampilkan daftar nama produk yang dijual dengan harga kurang dari 80% dari MSRP
SELECT DISTINCT p.productName, p.buyPrice, p.MSRP
FROM products as p
INNER JOIN orderdetails as od
ON p.productCode = od.productCode
INNER JOIN orders as o
ON od.orderNumber = o.orderNumber
WHERE od.priceEach < (p.MSRP * 0.8);

-- [NO.4]

-- Buatlah kolom baru dengan nama status yang bertipe data varchar pada tabel customers
ALTER TABLE customers
ADD `status` varchar(255);

-- Kemudian isi dengan `VIP` untuk pelanggan yang jumlah pembayarannya pernah diatas 100.000 atau yang pernah mengorder barang dengan kuantitas 50 keatas.
UPDATE customers as c
INNER JOIN orders as o
ON c.customerNumber = o.customerNumber
INNER JOIN payments as p
ON o.customerNumber = p.customerNumber
INNER JOIN orderdetails as od
ON o.orderNumber = od.orderNumber
SET c.status = 'VIP'
WHERE p.amount > 100000 OR od.quantityOrdered > 50;

-- Melihat Isi yang telah diubah (Dalam Kasus Ini : Sudah terhapus)
SELECT c.customerName, c.status, p.amount, od.quantityOrdered
FROM customers as c
INNER JOIN orders as o
ON c.customerNumber = o.customerNumber
INNER JOIN payments as p
ON o.customerNumber = p.customerNumber
INNER JOIN orderdetails as od
ON o.orderNumber = od.orderNumber
ORDER BY c.status DESC;

-- Sisanya di isi regular
UPDATE customers
SET status = 'Regular'
WHERE status IS NULL;

select * FROM customers;

-- [NO.5] 

-- Tampilkan semua data pelanggan yang pernah membatalkan pesanannya
SELECT c.customerName, o.status
FROM customers as c
INNER JOIN orders as o
ON c.customerNumber = o.customerNumber
WHERE o.status = 'Cancelled';

-- Menghapus data pelanggan
DELETE c
FROM customers as c
INNER JOIN orders as o
ON c.customerNumber = o.customerNumber
WHERE o.status = 'Cancelled';

-- Mengecek kembali data tersebut
SELECT * FROM customers;
SELECT * FROM orders;

-- Hapus & Menambah kembali Constraints nya
-- ALTER TABLE orders
-- DROP FOREIGN KEY `orders_ibfk_1`;

-- ALTER TABLE payments
-- DROP FOREIGN KEY `payments_ibfk_1`;

-- ALTER TABLE orders
-- ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerNumber`) 
-- REFERENCES `customers` (`customerNumber`) ON DELETE CASCADE;

-- ALTER TABLE customers
-- DROP FOREIGN KEY `customers_ibfk_1` FOREIGN KEY (`customerNumber`)
-- REFERENCES `orders` (`customerNumber`) ON DELETE CASCADE;