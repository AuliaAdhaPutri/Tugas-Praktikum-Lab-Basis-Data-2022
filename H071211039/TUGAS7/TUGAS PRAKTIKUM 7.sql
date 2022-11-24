-- 1. Perhatikan database classic models. Buatlah query untuk menampilkan
-- data pembayaran (payment) terkecil dan terbesar untuk masing-masing
-- pengguna dengan menggunakan subquery.
select customers.customerName, customers.customerNumber, max(amo) as `pembayaran tertinggi`	, min(amo) as `pembayaran terendah` 
from 
(select customerNumber, amount as amo from payments) as lineamo 
left join customers
using(customerNumber)
group by customerNumber;

-- 2. Buatlah query untuk menampilkan seluruh employee yang bekerja di
-- office dengan employee terbanyak (misalnya office A memiliki paling
-- banyak employee, maka buatkan daftar employee pada office A)
SELECT  CONCAT (employees.firstName," ",employees.lastName) AS `Employee`, offices.officeCode
FROM offices
JOIN employees
USING (officeCode)
WHERE offices.officeCode =  
	(SELECT offices.officeCode
	FROM offices
	JOIN employees
	USING (officeCode)
	GROUP BY officeCode 
	order by count(employees.officeCode) DESC LIMIT 1);

-- 3. Buatlah query yang akan menampilkan seluruh product yang di namanya
-- mengandung kata ‘Ford’ beserta productScale dari product tersebut.
-- Gunakan subquery untuk menampilkannya.
SELECT productName, productScale
FROM products
WHERE productName IN
(SELECT productName
FROM products
WHERE productName LIKE '%Ford%') ;

-- 4. Siapa nama pelanggan, dan nama karyawan serta berapa nomor pesanan
-- dan biaya pesanan untuk pesanan yang paling mahal?
 select c.customerName, concat(e.firstName, ' ', e.lastName) as 'nama karyawan' , orderNumber, sum(quantityOrdered * priceEach) as `total pembelian`
 from customers as c
 inner join employees as e on c.salesRepEmployeeNumber = e.employeeNumber
 natural join orders as o
 natural join orderdetails
 group by orderNumber, customerName, `nama karyawan`, orderNumber
 having sum(quantityOrdered * priceEach) =
 (select sum(quantityOrdered * priceEach) as `total pembelian` from orderdetails group by orderNumber
 order by `total pembelian` desc limit 1) ;

-- 5. Tampilkan nama negara dan panjang karater negara, dimana
-- menampilkan dua negara yaitu negara dengan karakter terpanjang dan
-- negara dengan karakter terpendek 
 select distinct country, length(country) as `panjang karakter` from customers
 where length(country) =
 (select max(length(country)) from customers ) or
 length(country) =
 ( select  min(length(country)) from customers);
