use appseminar;

-- no 1:
select sm.nama as 'Nama Mahasiswa dan Dosen', sm.nim as 'Nim dan Nip', sp.nama as 'Prodi'
from ss_mahasiswa as sm
inner join ss_prodi as sp
on sp.id_prodi = sm.id_prodi
where sp.nama like '%komputer%'
union 
select sd.nama , sd.nip, sp.nama from ss_dosen as sd
inner join ss_prodi as sp
on sd.id_prodi = sp.id_prodi
where sp.nama like '%komputer%';


select*from ss_mahasiswa;
select*from ss_prodi;
select*from ss_dosen;

-- no 2:
select * from ss_dosen;
select `Nama`, `Prodi`, group_concat(status) as 'Riwayat status' from 
  (select distinct ss_dosen.nama as `Nama`, ss_prodi.nama as `Prodi`,
  (select 'penguji 1' where ss_penguji.id_penguji_1 = ss_dosen.id_dosen) as status
  from ss_dosen
  inner join ss_prodi on ss_dosen.id_prodi = ss_prodi.id_prodi, ss_penguji
  where (select 'penguji 1' where ss_penguji.id_penguji_1 = ss_dosen.id_dosen) is not null
union 
   select distinct ss_dosen.nama as `Nama`, ss_prodi.nama  as `Prodi`,
   (select 'penguji 2' where ss_penguji.id_penguji_2 = ss_dosen.id_dosen) as status
   from ss_dosen inner join ss_prodi on ss_dosen.id_prodi = ss_prodi.id_prodi, ss_penguji
   where (select 'penguji 2' where ss_penguji.id_penguji_2 = ss_dosen.id_dosen) is not null
union 
   select distinct ss_dosen.nama as `Nama`, ss_prodi.nama  as `Prodi`,
   (select 'pembimbing utama' where ss_pembimbing.id_pembimbing_utama = ss_dosen.id_dosen) as status
   from ss_dosen inner join ss_prodi on ss_dosen.id_prodi = ss_prodi.id_prodi, ss_pembimbing
   where (select 'pmbimbing utama' where ss_pembimbing.id_pembimbing_utama = ss_dosen.id_dosen) is not null
union 
   select distinct ss_dosen.nama as `Nama`, ss_prodi.nama  as `Prodi`,
		(select 'pembimbing pertama' where ss_pembimbing.id_pembimbing_pertama = ss_dosen.id_dosen) as status
        from ss_dosen inner join ss_prodi on ss_dosen.id_prodi = ss_prodi.id_prodi, ss_pembimbing
		where (select 'pmbimbing pertama' where ss_pembimbing.id_pembimbing_pertama = ss_dosen.id_dosen) is not null
) riwayat
   group by `Nama`
   order by `Nama` desc;


-- no 3:

use classicmodels;

select city,count(*) from  -- count itu untuk menjumlahkan berapa yang ada didalam, kalau pake group by nanti berdasarkan itunya yang di hitung
(select c.customerName, c.city 
from customers as c
where customerName like 'L%'
union 
select concat(e.firstName, ' ', e.lastName), o.city
from employees as e
inner join offices as o
on e.officeCode = o.officeCode
where e.firstName like 'L%'
) as nama
group by city
order by count(customername) desc
limit 1;


select*from employees;
select*from customers;
select*from offices;
