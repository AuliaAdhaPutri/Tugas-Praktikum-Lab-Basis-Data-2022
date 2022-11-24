USE appseminar;

-- nomor 1
SELECT d.nama, p.nama AS 'program studi', d.nip AS 'nim / nip', 'dosen' AS 'status' 
FROM ss_dosen d
JOIN ss_prodi p
USING (id_prodi)
WHERE p.id_prodi = 'H07'
UNION 
SELECT m.nama, p.nama AS 'program studi', m.nim AS 'nim / nip', 'mahasiswa' AS 'status' 
FROM ss_mahasiswa m
JOIN ss_prodi p 
USING (id_prodi)
WHERE p.id_prodi = 'H07';

-- nomor 2
SELECT `nama dosen`, `nama prodi`, GROUP_CONCAT(" ", riwayat) AS `riwayat status` 
FROM
(SELECT DISTINCT ss_dosen.nama AS 'nama dosen', ss_prodi.nama AS 'nama prodi',
(SELECT 'penguji 1' WHERE ss_penguji.id_penguji_1 = ss_dosen.id_dosen) AS riwayat 
FROM ss_dosen LEFT JOIN ss_prodi USING (id_prodi), ss_penguji
UNION 
SELECT DISTINCT ss_dosen.nama AS 'nama dosen', ss_prodi.nama AS 'nama prodi',
(SELECT 'penguji 2' WHERE ss_penguji.id_penguji_2 = ss_dosen.id_dosen) AS riwayat 
FROM ss_dosen LEFT JOIN ss_prodi USING (id_prodi), ss_penguji
UNION 
SELECT DISTINCT ss_dosen.nama AS 'nama dosen', ss_prodi.nama AS 'nama prodi',
(SELECT 'pembimbing utama' WHERE ss_pembimbing.id_pembimbing_utama = ss_dosen.id_dosen) AS riwayat 
FROM ss_dosen LEFT JOIN ss_prodi USING (id_prodi), ss_pembimbing
UNION 
SELECT DISTINCT ss_dosen.nama AS 'nama dosen', ss_prodi.nama AS 'nama prodi',
(SELECT 'pembimbing pertama' WHERE ss_pembimbing.id_pembimbing_pertama = ss_dosen.id_dosen) AS riwayat 
FROM ss_dosen LEFT JOIN ss_prodi USING (id_prodi), ss_pembimbing) AS rstatus
GROUP BY `nama dosen`
HAVING `riwayat status` IS NOT NULL
ORDER BY `nama dosen` DESC;

-- nomor 3
USE classicmodels;

SELECT city, COUNT(*) AS 'jumlah' 
FROM 
(SELECT customerName, city FROM customers
WHERE customerName LIKE 'L%'
UNION 
SELECT e.firstname, o.city
FROM employees e
JOIN offices o
USING (officeCode)
WHERE e.firstName LIKE 'L%') AS `employee`
GROUP BY city 
ORDER BY COUNT(city) DESC
LIMIT 1;