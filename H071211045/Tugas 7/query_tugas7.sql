-- Active: 1663738801222@@127.0.0.1@3306@classicmodels

-- NAMA : MUHAMMAD SOFYAN DAUD PUAJS
-- NIM  : H071211045

USE classicmodels;

-- [NO.1] Perhatikan database classic models. Buatlah query untuk menampilkan 
-- data pembayaran (payment) terkecil dan terbesar untuk masing-masing 
-- pengguna dengan menggunakan subquery.
SELECT
    customerName AS `Nama Pelanggan`,
    (SELECT MIN(amount) FROM payments WHERE customerNumber = c.customerNumber) AS `Pembayaran Terkecil`,
    (SELECT MAX(amount) FROM payments WHERE customerNumber = c.customerNumber) AS `Pembayaran Terbesar`
FROM
    customers c
INNER JOIN payments p ON c.customerNumber = p.customerNumber 
GROUP BY c.customerName;

-- [NO.2] Buatlah query untuk menampilkan seluruh employee yang bekerja di 
-- office dengan employee terbanyak (misalnya office A memiliki paling 
-- banyak employee, maka buatkan daftar employee pada office A)
SELECT officeCode, COUNT(e.employeeNumber) AS `Jumlah Karyawan`
FROM employees e 
GROUP BY `officeCode`
ORDER BY `Jumlah Karyawan` DESC
LIMIT 1;

SELECT 
    officeCode,
    CONCAT(e.firstName, ' ', e.lastName) AS `Nama Karyawan`, 
    e.jobTitle AS `Jabatan`, 
    e.email AS `Email`,
    e.extension AS `Extension`
FROM employees e
WHERE officeCode = (
    SELECT officeCode FROM employees e 
    GROUP BY `officeCode`
    ORDER BY COUNT(e.employeeNumber) DESC
    LIMIT 1
);

-- [NO.3] Buatlah query yang akan menampilkan seluruh product yang di namanya 
-- mengandung kata ‘Ford’ beserta productScale dari product tersebut. 
-- Gunakan subquery untuk menampilkannya. 
SELECT `productName`, `productScale`
FROM products
WHERE `productCode` IN 
    (SELECT `productCode` FROM products WHERE `productName` LIKE '%FORD%');

-- [NO.4] Siapa nama pelanggan, dan nama karyawan serta berapa nomor pesanan 
-- dan biaya pesanan untuk pesanan yang paling mahal? 
SELECT 
    c.customerName AS `Nama Pelanggan`,
    CONCAT(e.`firstName`, ' ', e.`lastName`) AS `Nama Karyawan`,
    o.orderNumber AS `Nomor Pesanan`,
    p.amount AS `Biaya Pesanan`
FROM customers c
INNER JOIN payments p using (`customerNumber`)
INNER JOIN orders o using (`customerNumber`)
INNER JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.amount = (SELECT MAX(amount) FROM payments) 
GROUP BY `Nama Pelanggan`, `Nama Karyawan`;

-- [NO.5] Tampilkan nama negara dan panjang karater negara, dimana 
-- menampilkan dua negara yaitu negara dengan karakter terpanjang dan 
-- negara dengan karakter terpendek
SELECT DISTINCT 
    country AS `Negara`, 
    LENGTH(`country`) AS `Panjang Karakter` 
FROM customers 
WHERE 
    LENGTH(country) = (SELECT MAX(LENGTH(country)) FROM customers) 
OR 
    LENGTH(country) = (SELECT MIN(LENGTH(country)) FROM customers); 



















