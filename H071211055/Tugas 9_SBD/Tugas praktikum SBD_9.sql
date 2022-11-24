# 1.“classicmodels”, tambahkan 3 data dlm orders&orderdetails, stelah itu commit:

select count(*) from orderdetails;
show variables like '%autocommit%';
set autocommit = on; -- ini untuk commit, commit menyimpan data secara permanen

begin;

select @data1:=MAX(orderNumber)+1 from orders;
select @data2:=@data1 +1 from orders limit 1;
select @data3:=@data2 +1 from orders limit 1;

insert into orders (orderNumber, orderDate, requiredDate, shippedDate, status , comments, customerNumber)
values (@data1, '2022-12-20', '2022-01-1', '', 'In Process', '', 103),
		(@data2, '2022-12-20', '2022-01-1', '', 'In Process', '', 103),
		(@data3, '2022-12-20', '2022-01-1', '', 'In Process', '', 103);

insert into orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
values (@data1 , 'S18_3259', 50, 1.22, 6),
		(@data2 , 'S18_3259', 50, '', 7),
		(@data3 , 'S18_3259', 50, '', 8);

commit;

select*from orders;
select*from orderdetails;

# 2. Hapus seluruh data dari tabel ordersdetails dan gunakan perintah ROLLBACK untuk mengembalikan data tersebut
begin;
delete from  orderdetails;
select count(*) from orderdetails; 
rollback;
delete from orderdetails;
select count(*) from orderdetails;

select count(*) from productlines;
select*from productlines

