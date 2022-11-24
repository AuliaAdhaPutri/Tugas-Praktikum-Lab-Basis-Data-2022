-- Active: 1663738801222@@127.0.0.1@3306@classicmodels
USE classicmodels;

SELECT * FROM employees;

-- [NO.1] Tambahkanlah 3 orang employee baru pada tabel employees
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES  (2573, 'Pujas', 'Sofyan', 'x3325', 'sofyan.pujas@gmail.com', 1, '1002', 'Owner'), 
        (2031, 'Sugiharto', 'Budi', 'x3333', 'budi_ss@yahoo.com', 1, '1002', 'Grand Secretary'),
        (2022, 'Santoso', 'Ahmad', 'x3012', 'ahmad32@gmail.com', 1, '1002', 'Grand Secretary');

-- [NO.2] Pindahkanlah karyawan bejabatan 'Sales Rep' ke kantor yang lain.
UPDATE employees
SET officeCode = 5
WHERE jobTitle = 'Sales Rep';
       
