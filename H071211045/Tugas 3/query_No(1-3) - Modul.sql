-- Active: 1663738801222@@127.0.0.1@3306@classicmodels
USE classicmodels;

-- [NO.1] Tambahkanlah 3 orang employee baru pada tabel employees.
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES  (2573, 'Pujas', 'Sofyan', 'x3325', 'sofyan.pujas@gmail.com', 1, 1002, 'Owner'), 
        (2031, 'Sugiharto', 'Budi', 'x3333', 'budi_ss@yahoo.com', 1, 1002, 'Grand Secretary'),
        (2022, 'Santoso', 'Ahmad', 'x3012', 'ahmad32@gmail.com', 1, 1002, 'Grand Secretary');

-- [NO.2] Tambahkan data baru pada tabel office dan ubahlah nilai officeCode pada tabel employees dengan data office yang baru untuk data yang memiliki nilai officeCode = '4' dan jobTitle = 'Sales Rep'.
INSERT INTO offices (officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)
VALUES  ('8', 'Jakarta', '+62 21 719 229', 'Jl. Jendral Sudirman', 'Kav. 10-11', 'Jakarta', 'Indonesia', '10220', 'APAC');

UPDATE employees
SET officeCode = '8'
WHERE officeCode = '4' AND jobTitle = 'Sales Rep';

-- [NO.3] Hapuslah data pada tabel payments yang memiliki nilai amount yang lebih kecil dari 10.000.
DELETE FROM payments
WHERE amount < 10000;

SELECT * FROM payments where amount < 10000;
DESC offices;