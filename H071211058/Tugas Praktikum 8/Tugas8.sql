USE appseminar;

-- Nomor 1
SELECT d.nama 'Nama', d.nip AS 'NIM/NIP', p.nama AS 'Program Studi', 'Dosen' AS 'Keterangan'
FROM ss_dosen AS d
INNER JOIN ss_prodi AS p
UNION
SELECT m.nama AS 'Nama', m.nim AS 'NIM/NIP', p.nama AS 'Program Studi', 'Mahasiswa' AS 'Keterangan'
FROM ss_mahasiswa AS m
INNER JOIN ss_prodi AS p
ON m.id_prodi = p.id_prodi;

-- Nomor 2
SELECT `Nama Dosen`, `Nama Prodi`, GROUP_CONCAT( " ", stat) AS `Riwayat Status`
FROM (
		SELECT DISTINCT ss_dosen.nama AS `Nama Dosen`, ss_prodi.nama AS `Nama Prodi`, (
			SELECT 'Penguji 1' WHERE ss_penguji.id_penguji_1 = ss_dosen.id_dosen) AS stat
		FROM ss_dosen LEFT JOIN ss_prodi USING(id_prodi), ss_penguji 
		UNION 
		SELECT DISTINCT ss_dosen.nama AS `Nama Dosen`, ss_prodi.nama AS `Nama Prodi`, (
			SELECT 'Penguji 2' WHERE ss_penguji.id_penguji_2 = ss_dosen.id_dosen) AS stat
		FROM ss_dosen LEFT JOIN ss_prodi USING(id_prodi), ss_penguji
		UNION 
		SELECT DISTINCT ss_dosen.nama AS `Nama Dosen`, ss_prodi.nama AS `Nama Prodi`, (
			SELECT 'Penguji 3' WHERE ss_penguji.id_penguji_3 = ss_dosen.id_dosen) AS stat
		FROM ss_dosen LEFT JOIN ss_prodi USING(id_prodi), ss_penguji
		UNION 
		SELECT DISTINCT ss_dosen.nama AS `Nama Dosen`, ss_prodi.nama AS `Nama Prodi`, (
			SELECT 'Pembimbing Utama' WHERE ss_pembimbing.id_pembimbing_utama = ss_dosen.id_dosen) AS stat
		FROM ss_dosen LEFT JOIN ss_prodi USING(id_prodi), ss_pembimbing
		UNION 
		SELECT DISTINCT ss_dosen.nama AS `Nama Dosen`, ss_prodi.nama AS `Nama Prodi`, (
			SELECT 'Pembimbing Pertama' WHERE ss_pembimbing.id_pembimbing_pertama = ss_dosen.id_dosen) AS stat
		FROM ss_dosen LEFT JOIN ss_prodi USING(id_prodi), ss_pembimbing
		UNION 
		SELECT DISTINCT ss_dosen.nama AS `Nama Dosen`, ss_prodi.nama AS `Nama Prodi`, (
			SELECT 'Pembimbing Kedua' WHERE ss_pembimbing.id_pembimbing_kedua = ss_dosen.id_dosen) AS stat
		FROM ss_dosen LEFT JOIN ss_prodi USING(id_prodi), ss_pembimbing
	) AS riwayat
GROUP BY `Nama Dosen`
HAVING `Riwayat Status` IS NOT NULL 
ORDER BY `Nama Dosen` DESC;

USE classicmodels;

-- Nomor 3
SELECT city, SUM(Jumlah) AS sum_jumlah
FROM (
	 SELECT employees.firstName, COUNT(offices.city) AS 'Jumlah', offices.city
     FROM employees
     INNER JOIN offices
     ON employees.officeCode = offices.officeCode
     WHERE employees.firstName LIKE 'L%'
     GROUP BY offices.city
     UNION
     SELECT customerName, count(city) AS 'Jumlah', city
     FROM customers
     WHERE customerName LIKE 'L%'
     GROUP BY city
	) AS count_city
GROUP BY city
ORDER BY sum_jumlah DESC
LIMIT 1;