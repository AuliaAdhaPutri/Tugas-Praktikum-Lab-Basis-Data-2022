USE appseminar;

-- No 1
SELECT ss_dosen.nama, ss_dosen.nip AS "NIM/NIP" , ss_prodi.nama 
FROM ss_dosen
JOIN ss_prodi
ON ss_dosen.id_prodi = ss_prodi.id_prodi
WHERE ss_prodi.id_prodi = 'H07'
UNION
SELECT ss_mahasiswa.nama, ss_mahasiswa.nim, ss_prodi.nama 
FROM ss_mahasiswa
JOIN ss_prodi
ON ss_mahasiswa.id_prodi = ss_prodi.id_prodi
WHERE ss_prodi.id_prodi = 'H07';

-- NO 2
select aa.nama, ss_prodi.nama as prodi, group_concat(riwayatStatus) as "riwayat status"
from 
(select ss_dosen.nama as nama, concat('Pembimbing Utama') as 'riwayatStatus'
from ss_dosen
inner join ss_pembimbing
on ss_dosen.id_dosen = ss_pembimbing.id_pembimbing_utama
union
select ss_dosen.nama as nama, concat('Pembimbing Pertama') as 'riwayatStatus'
from ss_dosen
inner join ss_pembimbing
on ss_dosen.id_dosen = ss_pembimbing.id_pembimbing_pertama
union
select ss_dosen.nama as nama, concat('Penguji 1') as 'riwayatStatus'
from ss_dosen
inner join ss_penguji
on ss_dosen.id_dosen = ss_penguji.id_penguji_1
union
select ss_dosen.nama as nama, concat('Penguji 2') as 'riwayatStatus'
from ss_dosen
inner join ss_penguji
on ss_dosen.id_dosen = ss_penguji.id_penguji_2) as aa
inner join ss_dosen
on ss_dosen.nama = aa.nama
inner join ss_prodi
on ss_dosen.id_prodi = ss_prodi.id_prodi
group by aa.nama
order by aa.nama;

-- NO 3
USE classicmodels;
SELECT COUNT(city), city FROM (
SELECT ofc.city, CONCAT(em.firstName, '', em.lastName) AS 'Nama'
FROM employees em
INNER JOIN offices ofc
ON ofc.officeCode = em.officeCode
HAVING Nama like 'L%'
UNION
SELECT c.city, c.customerName AS 'Nama' FROM customers c WHERE LEFT(c.customerName, 1) = 'L') as m
GROUP BY city
ORDER BY COUNT(city) DESC LIMIT 1;
    