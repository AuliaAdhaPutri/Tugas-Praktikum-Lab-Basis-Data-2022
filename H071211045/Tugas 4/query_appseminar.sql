-- Active: 1663738801222@@127.0.0.1@3306@appseminar
USE appseminar;

-- [NO.3] Tampilkan pembimbing utama dan Pembimbing pertama dari Mahasiswa bernama Sulaeman
SELECT d.nama as `Pembimbing Utama`, u.nama as `Pembimbing Pertama`, m.nama as `Mahasiswa`
FROM ss_mahasiswa as m
INNER JOIN ss_pembimbing as p ON m.id_mahasiswa = p.id_mahasiswa
INNER JOIN ss_dosen as d ON p.id_pembimbing_utama = d.id_dosen
INNER JOIN ss_dosen as u ON p.id_pembimbing_pertama = u.id_dosen
WHERE m.nama = 'Sulaeman';

SELECT * FROM ss_pembimbing;
DESC ss_pembimbing;
SHOW Tables;

