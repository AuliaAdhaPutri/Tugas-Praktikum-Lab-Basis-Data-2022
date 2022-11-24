-- Active: 1663738801222@@127.0.0.1@3306@classicmodels

-- NAMA: MUH. SOFYAN DAUD PUJAS
-- NIM: H071211045

-- Tugas Praktikum II
USE classicmodels;
SELECT * FROM customers; -- // Menampilkan semua data dari tabel customers

-- [NO.1] Tampilkan semua kolom dari tabel offices yang berasal dari San Francisco
SELECT * FROM offices WHERE city = 'San Francisco';

-- [NO.2] Tampilkan semua kolom dari tabel orderdetails, dimana quantityOrdered lebih besar dari 70, diurutkan secara menaik berdasarkan orderLineNumber
SELECT * FROM orderdetails WHERE quantityOrdered > 70 ORDER BY orderLineNumber;

-- [NO.3] Tampilkan productLine apa saja yang tersedia pada tabel products
SELECT DISTINCT productLine FROM products;

-- [NO.4] Tampilkan customerNumber dan customerName pada tabel customers dengan customerNumber di kisaran 100-150. Beri juga alias pada kolomnya.
SELECT customerNumber AS 'Customer Number', customerName AS 'Customer Name' FROM customers WHERE customerNumber BETWEEN 100 AND 150;
SELECT customerNumber AS 'Customer Number', customerName AS 'Customer Name' FROM customers ORDER BY customerNumber limit 0, 15;

-- [NO.5] Berikan Data customers yang bukan dari USA yang tidak bisa lagi menarik uang dari rekeningnya. Urutkan berdasarkan customerName secara menaik lalu berikan data dari index (inklusif) 10 sampai 19.
SELECT * FROM customers WHERE country <> 'USA' AND creditLimit = 0 ORDER BY customerName ASC LIMIT 9, 10;

-- Tugas Asistensi

-- [NO.6] Tampilkan contactFirstName, contactLastName, dan CreditLimit
SELECT contactFirstName, contactLastName, creditLimit FROM customers;

-- [NO.7] Tanmpilkan data yang contactFirstName diawali huruf A dan creditLimit nya  paling kecil tapi bukan 0
SELECT * FROM customers WHERE contactFirstName LIKE 'A%' AND creditLimit <> 0 ORDER BY creditLimit ASC LIMIT 1;