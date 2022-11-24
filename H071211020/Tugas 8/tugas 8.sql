USE appseminar;

# No. 1
SELECT m.nama, p.nama prodi, m.nim AS `NIM/NIP`,"Mahasiswa" AS Keterangan
FROM ss_mahasiswa m
JOIN ss_prodi p
ON m.id_prodi = p.id_prodi
WHERE p.nama = 'Ilmu Komputer'
UNION
SELECT d.nama, p.nama, d.nip,"Dosen" AS keterangan
FROM ss_dosen d
JOIN ss_prodi p 
ON d.id_prodi = p.id_prodi
WHERE p.nama = 'Ilmu Komputer'

# No. 2
SELECT nama, prodi, group_concat(STATUS, ' ') riwayatStatus FROM 
(SELECT distinct d.nama, p.nama prodi, 'pembimbing utama' status
FROM ss_dosen d
JOIN ss_prodi p 
ON d.id_prodi = p.id_prodi
JOIN ss_pembimbing pb
ON pb.id_pembimbing_utama = d.id_dosen
UNION 
SELECT distinct d.nama, p.nama, 'pembimbing pertama' status
FROM ss_dosen d
JOIN ss_prodi p 
ON d.id_prodi = p.id_prodi
JOIN ss_pembimbing pb
ON pb.id_pembimbing_pertama = d.id_dosen
UNION
SELECT distinct d.nama, p.nama, 'penguji pertama' status
FROM ss_dosen d
JOIN ss_prodi p 
ON d.id_prodi = p.id_prodi
JOIN ss_penguji pj
ON pj.id_penguji_1 = d.id_dosen
UNION
SELECT distinct d.nama, p.nama, 'pnguji kedua' status
FROM ss_dosen d
JOIN ss_prodi p 
ON d.id_prodi = p.id_prodi
JOIN ss_penguji pj
ON pj.id_penguji_2 = d.id_dosen) a
GROUP BY nama
ORDER BY nama;

# No. 3
USE classicmodels;
SELECT city, COUNT(*) AS `Banyak` FROM
(SELECT o.city, e.firstName name
FROM offices o
JOIN employees e
USING (officecode)
WHERE e.firstName LIKE 'L%'
UNION 
SELECT city, customerName FROM customers
WHERE customerName LIKE 'L%') w
GROUP BY city
ORDER BY count(NAME) DESC LIMIT 1;

