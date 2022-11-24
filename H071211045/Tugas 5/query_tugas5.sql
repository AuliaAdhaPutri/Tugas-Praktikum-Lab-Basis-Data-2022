-- Active: 1663738801222@@127.0.0.1@3306@classicmodels
-- NAMA : MUHAMMAD SOFYAN DAUD PUJAS
-- NIM  : H071211045
use classicmodels;

-- [NO.1] Siapa saja customers yang status pesanannya tertahan karena melebihi batas kredit
SELECT c.customerName, o.status, o.comments
FROM customers as c
JOIN orders as o ON c.customerNumber = o.customerNumber
WHERE o.status = 'on hold' AND o.comments like '%exceeded%';

-- [NO.2] Siapa saja customers yang berkomentar untuk menggunakan jasa pengantaran DHL? Tampilkan mereka.
SELECT c.customerName, o.status, o.comments
FROM customers as c
JOIN orders as o ON c.customerNumber = o.customerNumber
WHERE o.comments like '%DHL%';

-- [NO.3] Tampilkan semua order mobil bermerk Ferrari pada database classicmodels. 
-- Tampilkan pula nama customer, nama mobilnya, status order, serta tanggal pengiriman yang berurut dari terkini.

SELECT o.orderNumber, c.customerName, p.productName, o.status, o.shippedDate
FROM orders AS o
INNER JOIN orderdetails AS od USING (orderNumber)
INNER JOIN products AS p USING (productCode)
INNER JOIN customers AS c USING (customerNumber)
WHERE p.productName LIKE "%ferrari%"
ORDER BY o.shippedDate DESC;

-- [NO.4] Anton Designs, Ltd. memesan sebanyak 50 mobil "1934 Ford V8 Coupe". 
-- Masukkan data pemesanan ke database, dengan ketentuan disoal.

-- DELETE from orders WHERE orderNumber = 10426;
INSERT INTO orders 
VALUES (10426, NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), "2022-10-20", 'In Process', 'Started from order date, they requested a deadline by one year.', 465);

INSERT INTO orderdetails
VALUES (10426, "S18_2957", 50, 62.46, 2);

SELECT c.customerName, p.productName,  od.priceEach, od.quantityOrdered, o.status, o.orderDate, o.requiredDate
FROM customers as c
JOIN orders as o USING (customerNumber)
JOIN orderdetails as od USING (orderNumber)
JOIN products as p USING (productCode)
WHERE customerName like "%anton%";