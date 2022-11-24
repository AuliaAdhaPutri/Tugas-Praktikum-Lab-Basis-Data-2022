-- Nomor 1
SELECT customers.customerName AS 'Nama Pelanggan', 
	SUM(payments.amount) AS 'Total Belanja', 
	customers.creditLimit AS 'Batas Kredit', 
	SUM(payments.amount) - creditLimit AS 'Selisih'
FROM customers
JOIN payments
ON customers.customerNumber = payments.customerNumber
GROUP BY customerName
HAVING SUM(payments.amount) > creditLimit
ORDER BY 'Selisih' DESC; 


-- Nomor 2
SELECT CONCAT(Customers.customerName, " : ", customers.contactFirstName," ", customers.contactLastName,"@", customers.addressLine1) AS 'Pelanggan',
	SUM(quantityOrdered) AS 'Jumlah Orderan' 
FROM customers
JOIN orders
ON  customers.customerNumber = orders.customerNumber
JOIN orderdetails
ON  orders.orderNumber = orderdetails.orderNumber
GROUP BY customers.customerName
ORDER BY `Jumlah Orderan` DESC LIMIT 1;


-- Nomor 3
SELECT CONCAT(MONTHNAME(paymentDate),' ',YEAR(paymentDate)) AS 'Hari Pembayaran', 
	COUNT(customers.customerNumber) AS 'Jumlah Pelanggan',
	GROUP_CONCAT(DISTINCT customers.customerName SEPARATOR ", ") AS 'List Pelanggan', 
	SUM(payments.amount) AS 'Jumlah Pembayaran' 
FROM customers
JOIN payments
ON  customers.customerNumber = payments.customerNumber
GROUP BY  `Hari Pembayaran`
HAVING `Hari Pembayaran` LIKE "%February%" ORDER BY `Jumlah Pembayaran` DESC;


-- Nomor 4
SELECT products.productName AS 'Nama Produk',
	COUNT(orderdetails.orderNumber) AS 'Jumlah di Order', 
	GROUP_CONCAT(orders.orderDate SEPARATOR ", ") AS 'Waktu Orderan', 
	products.buyPrice AS 'Harga Beli', 
	orderdetails.priceEach AS 'Harga Jual', 
	SUM(orderdetails.quantityOrdered) AS 'Total Kuantitas Orderan',
	CONCAT((orderdetails.priceEach * SUM(orderdetails.quantityOrdered))," - ",(products.buyPrice * SUM(orderdetails.quantityOrdered))," = ",(orderdetails.priceEach * SUM(orderdetails.quantityOrdered))-(products.buyPrice * SUM(orderdetails.quantityOrdered))) AS 'Pendapatan - Modal = Keuntungan'
FROM products
JOIN orderdetails
ON  products.productCode = orderdetails.productCode
JOIN orders
ON orderdetails.orderNumber = orders.orderNumber
GROUP BY orderdetails.priceEach
HAVING `Nama Produk` = "2001 Ferrari Enzo" AND (orderdetails.priceEach * SUM(orderdetails.quantityOrdered))-(products.buyPrice * SUM(orderdetails.quantityOrdered)) > 5000 
ORDER BY `Jumlah di Order` DESC;

-- Nomor 5
SELECT offices.addressLine1 AS 'Alamat', 
	CONCAT(LEFT(offices.phone, CHAR_LENGTH(offices.phone) - 6),"* ****") AS 'Nomor Telp', 
	COUNT(DISTINCT employees.employeeNumber) AS 'Jumlah Karyawan', 
	COUNT(DISTINCT customers.customerName) AS 'Jumlah Pelanggan', 
	ROUND(AVG(payments.amount),2) AS 'Rata-rata penghasilan'
FROM offices
JOIN employees
ON offices.officeCode =  employees.officeCode 
LEFT JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
LEFT JOIN payments
ON customers.customerNumber = payments.customerNumber
where employees.jobTitle != "president"
GROUP BY offices.officeCode;