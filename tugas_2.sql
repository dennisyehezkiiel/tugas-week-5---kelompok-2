CREATE TABLE Pengguna (
    id_pengguna INT PRIMARY KEY,
    email VARCHAR(255),
    kata_sandi VARCHAR(255),
    nama VARCHAR(255),
    alamat VARCHAR(255),
    telepon VARCHAR(50),
    tgl_lahir DATE
);

CREATE TABLE Akun (
    id_akun INT PRIMARY KEY,
    id_pengguna INT,
    token VARCHAR(255),
    saldo DECIMAL(15, 2),
    FOREIGN KEY (id_pengguna) REFERENCES Pengguna(id_pengguna)
);

CREATE TABLE Layanan (
    id_layanan INT PRIMARY KEY,
    nama VARCHAR(255),
    deskripsi TEXT,
    kategori VARCHAR(100)  -- contoh kategori: penerbangan, hotel, aktivitas wisata
);

CREATE TABLE Detail_Layanan (
    id_detail_layanan INT PRIMARY KEY,
    id_layanan INT,
    penyedia VARCHAR(255),
    lokasi VARCHAR(255),
    harga DECIMAL(15, 2),
    rincian TEXT,
    FOREIGN KEY (id_layanan) REFERENCES Layanan(id_layanan)
);

CREATE TABLE Pemesanan (
    id_pemesanan INT PRIMARY KEY,
    id_pengguna INT,
    id_detail_layanan INT,
    status VARCHAR(50),
    tgl_pemesanan DATETIME,
    tgl_kedatangan DATETIME,
    tgl_pulang DATETIME,
    FOREIGN KEY (id_pengguna) REFERENCES Pengguna(id_pengguna),
    FOREIGN KEY (id_detail_layanan) REFERENCES Detail_Layanan(id_detail_layanan)
);

CREATE TABLE Pembayaran (
    id_pembayaran INT PRIMARY KEY,
    id_pemesanan INT,
    jumlah DECIMAL(15, 2),
    metode VARCHAR(100),
    status VARCHAR(50),
    tgl_pembayaran DATETIME,
    FOREIGN KEY (id_pemesanan) REFERENCES Pemesanan(id_pemesanan)
);

CREATE TABLE Pengembalian_Dana (
    id_pengembalian_dana INT PRIMARY KEY,
    id_pembayaran INT,
    jumlah DECIMAL(15, 2),
    tgl_pengembalian DATETIME,
    FOREIGN KEY (id_pembayaran) REFERENCES Pembayaran(id_pembayaran)
);

CREATE TABLE Ulasan (
    id_ulasan INT PRIMARY KEY,
    id_layanan INT,
    id_pemesanan INT,
    penilaian INT,
    komentar TEXT,
    dibuat_pada DATETIME,
    FOREIGN KEY (id_layanan) REFERENCES Layanan(id_layanan),
    FOREIGN KEY (id_pemesanan) REFERENCES Pemesanan(id_pemesanan)
);

CREATE TABLE Notifikasi (
    id_notifikasi INT PRIMARY KEY,
    id_pengguna INT,
    tipe VARCHAR(100),
    pesan TEXT,
    status VARCHAR(50),
    dibuat_pada DATETIME,
    FOREIGN KEY (id_pengguna) REFERENCES Pengguna(id_pengguna)
);

CREATE TABLE Promosi (
    id_promosi INT PRIMARY KEY,
    id_layanan INT,
    diskon_persen DECIMAL(5, 2),
    berlaku_dari DATE,
    berlaku_hingga DATE,
    kode VARCHAR(50),
    FOREIGN KEY (id_layanan) REFERENCES Layanan(id_layanan)
);

CREATE TABLE Bahasa (
    id_bahasa INT PRIMARY KEY,
    nama_bahasa VARCHAR(100)
);

CREATE TABLE Konten_Terjemahan (
    id_konten_terjemahan INT PRIMARY KEY,
    id_layanan INT,
    id_bahasa INT,
    deskripsi TEXT,
    FOREIGN KEY (id_layanan) REFERENCES Layanan(id_layanan),
    FOREIGN KEY (id_bahasa) REFERENCES Bahasa(id_bahasa)
);

CREATE TABLE Poin_Loyalitas (
    id_poin INT PRIMARY KEY,
    id_pengguna INT,
    poin_didapat INT,
    poin_digunakan INT,
    saldo_poin INT,
    FOREIGN KEY (id_pengguna) REFERENCES Pengguna(id_pengguna)
);

CREATE TABLE Aktivitas_Log (
    id_aktivitas INT PRIMARY KEY,
    id_pengguna INT,
    tipe_aktivitas VARCHAR(100),
    tgl_aktivitas DATETIME,
    FOREIGN KEY (id_pengguna) REFERENCES Pengguna(id_pengguna)
);

CREATE TABLE Dukungan_Pelanggan (
    id_dukungan INT PRIMARY KEY,
    id_pengguna INT,
    deskripsi_masalah TEXT,
    status VARCHAR(50),
    dibuat_pada DATETIME,
    diselesaikan_pada DATETIME,
    FOREIGN KEY (id_pengguna) REFERENCES Pengguna(id_pengguna)
);

CREATE TABLE Tiket_Penerbangan (
    id_tiket INT PRIMARY KEY,
    id_detail_layanan INT,
    lokasi_keberangkatan VARCHAR(255),
    lokasi_kedatangan VARCHAR(255),
    waktu_keberangkatan DATETIME,
    waktu_kedatangan DATETIME,
    kelas VARCHAR(50),  -- contoh: ekonomi, bisnis
    FOREIGN KEY (id_detail_layanan) REFERENCES Detail_Layanan(id_detail_layanan)
);

CREATE TABLE Reservasi_Hotel (
    id_reservasi INT PRIMARY KEY,
    id_detail_layanan INT,
    lokasi VARCHAR(255),
    fasilitas TEXT,
    waktu_check_in DATETIME,
    waktu_check_out DATETIME,
    FOREIGN KEY (id_detail_layanan) REFERENCES Detail_Layanan(id_detail_layanan)
);

CREATE TABLE Lokasi (
    id_lokasi INT PRIMARY KEY,
    kota VARCHAR(100),
    negara VARCHAR(100)
);

CREATE TABLE Transportasi (
    id_transportasi INT PRIMARY KEY,
    id_detail_layanan INT,
    jenis_transportasi VARCHAR(50),  -- contoh: mobil, kereta, kapal
    penyedia VARCHAR(255),
    harga DECIMAL(15, 2),
    lokasi_awal VARCHAR(255),
    lokasi_tujuan VARCHAR(255),
    FOREIGN KEY (id_detail_layanan) REFERENCES Detail_Layanan(id_detail_layanan)
);

INSERT INTO Pengguna (id_pengguna, email, kata_sandi, nama, alamat, telepon, tgl_lahir)
VALUES 
(1, 'user1@example.com', 'password123', 'User Satu', 'Jl. Merdeka No.1', '081234567890', '1990-01-01'),
(2, 'user2@example.com', 'password456', 'User Dua', 'Jl. Raya No.2', '081234567891', '1992-02-02');

-- Masukkan data ke tabel Akun
INSERT INTO Akun (id_akun, id_pengguna, token, saldo)
VALUES 
(1, 1, 'token123', 5000.00),
(2, 2, 'token456', 3000.00);

-- Masukkan data ke tabel Layanan
INSERT INTO Layanan (id_layanan, nama, deskripsi, kategori)
VALUES 
(1, 'Penerbangan', 'Layanan penerbangan domestik dan internasional', 'Penerbangan'),
(2, 'Hotel', 'Layanan reservasi hotel di seluruh dunia', 'Hotel'),
(3, 'Transportasi', 'Layanan transportasi darat', 'Transportasi');

-- Masukkan data ke tabel Detail_Layanan
INSERT INTO Detail_Layanan (id_detail_layanan, id_layanan, penyedia, lokasi, harga, rincian)
VALUES 
(1, 1, 'Garuda Indonesia', 'Jakarta', 1500000.00, 'Penerbangan dari Jakarta ke Bali'),
(2, 2, 'Hotel Indonesia', 'Bali', 750000.00, 'Hotel bintang 5 di pusat kota Bali'),
(3, 3, 'Bluebird', 'Jakarta', 50000.00, 'Transportasi taksi dari Bandara Soekarno-Hatta ke pusat kota');

-- Masukkan data ke tabel Pemesanan
INSERT INTO Pemesanan (id_pemesanan, id_pengguna, id_detail_layanan, status, tgl_pemesanan, tgl_kedatangan, tgl_pulang)
VALUES 
(1, 1, 1, 'Dikonfirmasi', '2024-10-01 10:00:00', '2024-10-02 10:00:00', '2024-10-05 10:00:00'),
(2, 2, 2, 'Dibatalkan', '2024-10-02 12:00:00', '2024-10-03 12:00:00', '2024-10-06 12:00:00');

-- Masukkan data ke tabel Pembayaran
INSERT INTO Pembayaran (id_pembayaran, id_pemesanan, jumlah, metode, status, tgl_pembayaran)
VALUES 
(1, 1, 1500000.00, 'Kartu Kredit', 'Sukses', '2024-10-01 10:05:00'),
(2, 2, 750000.00, 'Transfer Bank', 'Gagal', '2024-10-02 12:05:00');

-- Masukkan data ke tabel Pengembalian_Dana
INSERT INTO Pengembalian_Dana (id_pengembalian_dana, id_pembayaran, jumlah, tgl_pengembalian)
VALUES 
(1, 2, 750000.00, '2024-10-03 12:30:00');

-- Masukkan data ke tabel Ulasan
INSERT INTO Ulasan (id_ulasan, id_layanan, id_pemesanan, penilaian, komentar, dibuat_pada)
VALUES 
(1, 1, 1, 5, 'Layanan sangat memuaskan!', '2024-10-05 14:00:00'),
(2, 2, 2, 3, 'Hotel cukup bagus, tetapi ada sedikit masalah di check-in.', '2024-10-07 18:00:00');

-- Masukkan data ke tabel Notifikasi
INSERT INTO Notifikasi (id_notifikasi, id_pengguna, tipe, pesan, status, dibuat_pada)
VALUES 
(1, 1, 'Pembayaran', 'Pembayaran Anda telah berhasil.', 'Terkirim', '2024-10-01 10:10:00'),
(2, 2, 'Pengembalian Dana', 'Dana Anda telah dikembalikan.', 'Terkirim', '2024-10-03 12:40:00');

-- Masukkan data ke tabel Promosi
INSERT INTO Promosi (id_promosi, id_layanan, diskon_persen, berlaku_dari, berlaku_hingga, kode)
VALUES 
(1, 1, 10.00, '2024-10-01', '2024-10-31', 'PROMO10'),
(2, 2, 15.00, '2024-11-01', '2024-11-30', 'HOTEL15');

-- Masukkan data ke tabel Bahasa
INSERT INTO Bahasa (id_bahasa, nama_bahasa)
VALUES 
(1, 'Indonesia'),
(2, 'English');

-- Masukkan data ke tabel Konten_Terjemahan
INSERT INTO Konten_Terjemahan (id_konten_terjemahan, id_layanan, id_bahasa, deskripsi)
VALUES 
(1, 1, 1, 'Layanan penerbangan domestik dan internasional'),
(2, 1, 2, 'Domestic and international flight services');

-- Masukkan data ke tabel Poin_Loyalitas
INSERT INTO Poin_Loyalitas (id_poin, id_pengguna, poin_didapat, poin_digunakan, saldo_poin)
VALUES 
(1, 1, 100, 20, 80),
(2, 2, 200, 50, 150);

-- Masukkan data ke tabel Aktivitas_Log
INSERT INTO Aktivitas_Log (id_aktivitas, id_pengguna, tipe_aktivitas, tgl_aktivitas)
VALUES 
(1, 1, 'Login', '2024-10-01 09:00:00'),
(2, 1, 'Pembayaran', '2024-10-01 10:05:00');

-- Masukkan data ke tabel Dukungan_Pelanggan
INSERT INTO Dukungan_Pelanggan (id_dukungan, id_pengguna, deskripsi_masalah, status, dibuat_pada, diselesaikan_pada)
VALUES 
(1, 1, 'Tidak bisa melakukan pembayaran', 'Selesai', '2024-10-01 10:20:00', '2024-10-01 11:00:00');

-- Masukkan data ke tabel Tiket_Penerbangan
INSERT INTO Tiket_Penerbangan (id_tiket, id_detail_layanan, lokasi_keberangkatan, lokasi_kedatangan, waktu_keberangkatan, waktu_kedatangan, kelas)
VALUES 
(1, 1, 'Jakarta', 'Bali', '2024-10-02 10:00:00', '2024-10-02 12:00:00', 'Ekonomi');

-- Masukkan data ke tabel Reservasi_Hotel
INSERT INTO Reservasi_Hotel (id_reservasi, id_detail_layanan, lokasi, fasilitas, waktu_check_in, waktu_check_out)
VALUES 
(1, 2, 'Bali', 'Kolam renang, Wi-Fi gratis', '2024-10-03 14:00:00', '2024-10-05 12:00:00');

-- Masukkan data ke tabel Lokasi
INSERT INTO Lokasi (id_lokasi, kota, negara)
VALUES 
(1, 'Jakarta', 'Indonesia'),
(2, 'Bali', 'Indonesia');

-- Masukkan data ke tabel Transportasi
INSERT INTO Transportasi (id_transportasi, id_detail_layanan, jenis_transportasi, penyedia, harga, lokasi_awal, lokasi_tujuan)
VALUES 
(1, 3, 'Mobil', 'Bluebird', 50000.00, 'Bandara Soekarno-Hatta', 'Jakarta');