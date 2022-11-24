use appseminar;

-- no1
select nim as 'NIM/NIP', ss_mahasiswa.nama, ss_prodi.nama as 'nama program studi', 'mahasiswa' as 'status'
from ss_mahasiswa
join ss_prodi on ss_mahasiswa.id_prodi= ss_prodi.id_prodi
where ss_prodi.nama like '%ilmu%'
union select nip, ss_dosen.nama, ss_prodi.nama as 'nama program studi', 'dosen' as 'status'
from ss_dosen
join ss_prodi on ss_dosen.id_prodi= ss_prodi.id_prodi
where ss_prodi.nama like '%ilmu%';

-- no2
select nama, prodi, group_concat(riwayat) as riwayat from (
	select distinct d.nama, pr.nama as prodi, "pembimbing utama" as riwayat from ss_dosen as d
	join ss_prodi as pr
	using (id_prodi)
	join ss_pembimbing  as pb on pb.id_pembimbing_utama = d.id_dosen
	union
		select distinct d.nama, pr.nama as prodi, "pembimbing pertama" as riwayat from ss_dosen as d
		join ss_prodi as pr
		using (id_prodi)
		join ss_pembimbing as pb on pb.id_pembimbing_pertama = d.id_dosen
		union
			select distinct d.nama, pr.nama as prodi, "penguji 1" as riwayat from ss_dosen as d
			join ss_prodi as pr
			using (id_prodi)
			join ss_penguji as pg on pg.id_penguji_1 = d.id_dosen
			union
				select distinct d.nama, pr.nama as prodi, "penguji 2" as riwayat from ss_dosen as d
				join ss_prodi as pr
				using (id_prodi)
				join ss_penguji as pg on pg.id_penguji_2 = d.id_dosen) as z
group by nama;


use classicmodels;

-- no3
select city from (
	select customerName, city from customers
	where customerName like 'L%'
	union 
	select concat(employees.firstname, " ", employees.lastName), offices.city
	from employees
	join offices
	using (officeCode)
	where employees.firstName like 'L%') as `employee`
group by city 
order by count(customerName) desc limit 1;