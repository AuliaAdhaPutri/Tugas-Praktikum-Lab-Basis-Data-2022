-- Active: 1663738801222@@127.0.0.1@3306@classicmodels
-- NAMA : MUHAMMAD SOFYAN DAUD PUJAS
-- NIM  : H071211045

show tables;

SELECT * FROM customers;
SELECT * FROM payments;
SELECT * FROM orderdetails;
SELECT * FROM employees;

-- NOMOR 1 : Menggunakan database classicmodels tampilkan nama pelanggan yang total belanjanya melebihi kredit limit, serta tampilkan selisih total belanja dengan kreditlimit, 
-- kemudian urutkan berdasarkan selisih tersebut secara menurun.
USE classicmodels;
SELECT 
c.customerName AS `Nama Pelanggan`, 
SUM(p.amount) AS `Total Belanja`, 
c.creditLimit AS `Batas Kredit`,
ABS(SUM(p.amount) - c.creditLimit) AS `Selisih`
FROM customers AS c
JOIN payments AS p USING (`customerNumber`)
GROUP BY `customerName`
ORDER BY `Selisih` DESC
LIMIT 5;

-- NOMOR 2 : Siapa customer yang total pembelian barangnya terbanyak (dihitung dari quantity bukan price)

SELECT 
CONCAT(c.customerName, ' : ', c.contactFirstName, c.contactLastName, '@', c.addressLine1) `Pelanggan`, 
SUM(od.quantityOrdered) `Jumlah Orderan`
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
GROUP BY c.customerNumber
ORDER BY `Jumlah Orderan` DESC
LIMIT 1;

-- NOMOR 3 : Tampilkan jumlah dan list pelanggan, serta jumlah pembayaran untuk pembayaran yang dilakukan pada bulan februari setiap tahunnya.

SELECT 
CONCAT(MONTHNAME(p.paymentDate), ' ', YEAR(p.paymentDate)) AS `Hari Pembayaran`, 
COUNT(*) AS `Jumlah Pelanggan`, 
GROUP_CONCAT(c.customerName ORDER BY c.customerName) AS `List Pelanggan`, 
SUM(p.amount) AS `Jumlah Pembayaran`
FROM customers AS c
JOIN payments AS p USING(customerNumber)
GROUP BY `Hari Pembayaran`
HAVING `Hari Pembayaran` LIKE 'February%'
ORDER BY `Jumlah Pembayaran` DESC;

-- NOMOR 4 : Tampilkan informasi jumlah orderan serta keuntungan untuk penjualan 2001 Ferrari
-- Enzo yang keuntungannya lebih besar dari 5000.
-- Berikut ketentuan outputnya:
-- a. Nama Produk dalam huruf kapital
-- b. Jumlah di Order
-- c. Waktu Orderan dipisah dengan Comma
-- d. Harga Beli
-- e. Harga Jual
-- f. Total Kuantitas Orderan
-- g. Serta Keuntungan bersih yang diperoleh

SELECT 
p.productName AS `Nama Produk`, 
COUNT(*) AS `Jumlah di Order`, 
GROUP_CONCAT(o.orderDate) AS `Waktu Orderan`, 
p.buyPrice AS `Harga Beli`,
od.priceEach AS `Harga Jual`,
SUM(od.quantityOrdered) AS `Total Jumlah Orderan`,
CONCAT(od.priceEach * SUM(od.quantityOrdered), ' - ', p.buyPrice * SUM(od.quantityOrdered), ' = ', (od.priceEach * SUM(od.quantityOrdered)) - (p.buyPrice * SUM(od.quantityOrdered))) AS `Pendapatan - Modal = Keuntungan`
FROM products p
LEFT JOIN orderdetails od USING(productCode)
JOIN orders o ON od.orderNumber = o.orderNumber
WHERE p.productName = '2001 Ferrari Enzo'
GROUP BY od.priceEach
HAVING ((od.priceEach * SUM(od.quantityOrdered)) - (p.buyPrice * SUM(od.quantityOrdered))) > 5000
ORDER BY (od.priceEach * SUM(od.quantityOrd	ered)) - (p.buyPrice * SUM(od.quantityOrdered)) DESC ;

-- NOMOR 5 : Tampilkan alamat pertama dari tiap kantor, no telp yang 5 angka terakhirnya
-- disamarkan, jumlah karyawan, jumlah pelanggan yang pernah dilayani, serta
-- rata-rata penghasilan.
SELECT 
offices.addressLine1 AS `Alamat`, 
REPLACE(offices.phone, RIGHT(offices.phone, 6), '* ****') AS `Nomor Telp`, 
COUNT(DISTINCT employeeNumber) AS `Jumlah Karyawan`,
COUNT(DISTINCT customers.customerNumber) AS `Jumlah Pelanggan`,
FORMAT(AVG(amount), 2) AS `Rata-Rata Penghasilan`
FROM employees
RIGHT JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN offices USING (officeCode)
RIGHT JOIN payments ON customers.customerNumber = payments.customerNumber
WHERE employees.jobTitle = 'Sales Rep'
GROUP BY officeCode
ORDER BY `Nomor Telp`;