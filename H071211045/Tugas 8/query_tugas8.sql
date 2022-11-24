-- Active: 1663738801222@@127.0.0.1@3306@appseminar
USE appseminar;

show TABLES;

-- [NO.1] Tampilkan nama, nama program studi, dan nim/nip dari dosen dan mahasiswa Ilmu Komputer
select * from ss_mahasiswa;
select * from ss_dosen;
SELECT * FROM ss_prodi;
select m.nama, m.nim as `NIM/NIP`, p.nama as `Nama Prodi` from ss_mahasiswa as m
JOIN ss_prodi as p ON m.id_prodi = p.id_prodi
WHERE p.nama like '%Ilmu Komputer%'
UNION ALL
select d.nama, d.nip, p.nama from ss_dosen as d
JOIN ss_prodi as p ON d.id_prodi = p.id_prodi
WHERE p.nama like '%Ilmu Komputer%';

-- [NO. 2] Tampilkan nama, prodi, dan riwayat status yang
-- pernah dijalani (pembimbing utama, pertama, penguji 1, penguji 2) dari setiap
-- dosen, kemudian urutkan berdasarkan nama DESC
SELECT * FROM ss_dosen;
SELECT * FROM ss_penguji;
select * from ss_prodi;
select * from ss_pembimbing;

select t.nama, p.nama as `Prodi`, GROUP_CONCAT(`status` ORDER BY `status` desc) as `status` FROM (
    select d.nama, 'Pembimbing Utama' as `status` from ss_dosen as d
    JOIN ss_pembimbing as s ON d.id_dosen = s.id_pembimbing_utama
    UNION
    select d.nama, 'Pembimbing Pertama' as `status` from ss_dosen as d
    JOIN ss_pembimbing as s ON d.id_dosen = s.id_pembimbing_pertama
    UNION
    select d.nama, 'Penguji 1' as `status` from ss_dosen as d
    JOIN ss_penguji as s ON d.id_dosen = s.id_penguji_1
    UNION
    select d.nama, 'Penguji 2' as `status` from ss_dosen as d
    JOIN ss_penguji as s ON d.id_dosen = s.id_penguji_2
) as t
JOIN ss_dosen as d using (nama)
JOIN ss_prodi as p using (id_prodi)
GROUP BY t.nama
ORDER BY t.nama desc;

-- [NO. 3] buatlah query untuk menampilkan, kota apa yang paling
-- banyak karyawan atau pelanggan yang namanya diawali huruf L.
-- note (kota karyawan berdasarkan kota tempat dia bekerja)
use classicmodels;
select GROUP_CONCAT(t.name, ' | ') as `name`, city, count(*) from (
    select e.firstName as `name`, o.city as `city` from employees as e
    JOIN offices as o using (officeCode)
    UNION
    select customerName as `name`, city from customers
) as t
WHERE t.name like 'L%'
GROUP BY t.city
order by count(*) desc
limit 1;

