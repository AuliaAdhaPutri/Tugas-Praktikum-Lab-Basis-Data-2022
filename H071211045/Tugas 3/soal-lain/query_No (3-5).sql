-- Active: 1663738801222@@127.0.0.1@3306@db_praktikum

-- Lihat semua tabel
USE db_praktikum;
SHOW TABLES;

-- Untuk tabel mahasiswa, tambahkan atribut baru sebagai berikut:
ALTER TABLE mahasiswa
ADD No_telp varchar(20) NOT NULL,
ADD Alamat varchar(100),
ADD Email varchar(50) NOT NULL,
ADD Keterangan varchar(20);

-- [NO.3] Tambahkan data pada tabel mahasiswa dengan datanya adalah semua nama praktikan pada GB Asistensi Anda.
INSERT INTO mahasiswa (NIM, Nama, No_telp, Alamat, Email, Keterangan)
VALUES
('H071211045', 'Muhammad Sofyan Daud Pujas', '085215702573', 'Jl. Sahabat', 'gaero38@gmail.com', 'SEMESTER 3'),
('H071211006', 'Nur Hikmah', '083131422710', 'Aluppang, Kab. Pinrang', 'nurhikmah01@gmail.com', 'SEMESTER 3'),
('H071211020', 'Muhammad Khaibar Akbar', '082193121763', 'Kab. Takalar', 'khaibar02@gmail.com', 'SEMESTER 3'),
('H071211028', 'Muhammad Kahfi MS', '085212191271', 'BTP Jl. Kerukunan Timur', 'kahfims03@gmail.com', 'SEMESTER 3'),
('H071211039', 'Isty Hamdayani', '082159539087', 'Jl. Muh. Tamrin', 'istyhamdayani04@gmail.com', 'SEMESTER 3'),
('H071211048', 'Wirya Olivia D. Susetiyo', '081258851575', 'Jl. Haji Kalla No.35', 'wiryaolivia05@gmail.com', 'SEMESTER 3'),
('H071211053', 'Aditya Erlangga Bagaskara', '08114447121', 'Jl. Abdur Kadir', 'aditya.erlangga06@gmail.com', 'SEMESTER 3'),
('H071211055', 'Aulia Adha Putri', '085387663152', 'Jl. Poros Makassar', 'auliaadha07@gmail.com', 'SEMESTER 3'),
('H071211056', 'Muhammad Fikri', '082292432995', 'Bone Pute Kab. Luwu Timur', 'muhfikri08@gmail.com', 'SEMESTER 3'),
('H071211058', 'Eka Hanny Oktavia', '089695453002', 'Jln. Makkio Baji IV', 'ekahanny09@gmail.com', 'SEMESTER 3'),
('H071211069', 'Muhammad Faiz F. Syarifuddin', '085342291413', 'Jl. Nuri No. 121 Kota Palopo', 'faizfatwa10@gmail.com', 'SEMESTER 3');

-- [NO.4] Tambahkan 5 data pada tabel buku dan tabel pinjam dengan perintah insert tanpa disertai nama kolomnya.
INSERT INTO buku
VALUES  ('Kitab Hacker', 2019, 'Dedik Kurniawan', NULL),
        ('The Pragmatic Programmer', 1999, 'Andrew Hunt, David Thomas', NULL),
        ('The Clean Coder', 2011, 'Robert C. Martin', NULL),
        ('Clean Code', 2008, 'Robert C. Martin', NULL),
        ('Refactoring', 1999, 'Martin Fowler, Kent Beck, John Brant, William Opdyke, Don Roberts', NULL);

INSERT INTO pinjam
VALUES ('2022-05-10', 1, 1, 1, NULL),
       ('2022-05-10', 1, 2, 0, NULL),
       ('2022-05-10', 6, 5, 1, NULL),
       ('2022-05-10', 7, 3, 0, NULL),
       ('2022-05-10', 6, 4, 0, NULL);


-- [NO.5] Tambahkan 2 data baru pada tabel mahasiswa dengan data pertama terdapat blak pada salah satu kolom dan data kedua terdapat nilai null pada salah satu kolomnya.
INSERT INTO  mahasiswa (NIM, Nama, No_telp, Alamat, Email, Keterangan)
VALUES  ('H071211090', 'Vladimir Al Putin', '3952682116', 'Moscow', '', 'SEMESTER 20'),
        ('H071211091', 'Xi Jinping', '13052892612', NULL, 'china.xi@tencent.qq', 'SEMESTER 20');

SELECT * FROM mahasiswa;
SELECT * FROM buku;
SELECT * FROM pinjam;

DESC mahasiswa;