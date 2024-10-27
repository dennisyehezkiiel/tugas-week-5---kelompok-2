CREATE TABLE Customer (
    id_cust INT PRIMARY KEY,
    id_trans INT,
    email VARCHAR(255),
    name VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(50),
    nik VARCHAR(20),
    tanggal_lahir DATE
);

CREATE TABLE Account (
    id_acc INT PRIMARY KEY,
    id_cust INT,
    password VARCHAR(255),
    token VARCHAR(255),
    balance DECIMAL(15, 2),
    FOREIGN KEY (id_cust) REFERENCES Customer(id_cust)
);

CREATE TABLE Transaksi (
    trans_num INT PRIMARY KEY,
    trans_type VARCHAR(50),
    amount DECIMAL(15, 2),
    fee DECIMAL(15, 2),
    created_at DATETIME,
    description TEXT,
    id_trans INT,
    id_cust INT,
    FOREIGN KEY (id_cust) REFERENCES Customer(id_cust)
);

CREATE TABLE Invoice (
    id_invoice INT PRIMARY KEY,
    invoice_num VARCHAR(50),
    due_date DATE,
    id_merchant INT,
    id_trans INT,
    FOREIGN KEY (id_merchant) REFERENCES Merchant(id_merchant),
    FOREIGN KEY (id_trans) REFERENCES Transaksi(trans_num)
);

CREATE TABLE Merchant (
    id_merchant INT PRIMARY KEY,
    name VARCHAR(255),
    invoice_num VARCHAR(50),
    id_cust INT,
    FOREIGN KEY (id_cust) REFERENCES Customer(id_cust)
);

CREATE TABLE Activity_Log (
    id_log INT PRIMARY KEY,
    id_pengguna INT,
    tipe_aktivitas VARCHAR(100),
    tgl_aktivitas DATETIME,
    FOREIGN KEY (id_pengguna) REFERENCES Customer(id_cust)
);

-- Masukkan data ke tabel Customer
INSERT INTO Customer (id_cust, id_trans, email, name, address, phone, nik, tanggal_lahir)
VALUES 
(1, NULL, 'andimulyono@gmail.com', 'Andi Mulyono', 'Jl. Merdeka No. 10, Jakarta', '081234567890', '3172030405678901', '1990-01-01'),
(2, NULL, 'siti aminah@gmail.com', 'Siti Aminah', 'Jl. Kencana No. 5, Bandung', '081234567891', '3201020304056789', '1992-02-02');

-- Masukkan data ke tabel Account
INSERT INTO Account (id_acc, id_cust, password, token, balance)
VALUES 
(1, 1, 'sandi123', 'token123', 5000.00),
(2, 2, 'sandi456', 'token456', 3000.00);

-- Masukkan data ke tabel Transaksi
INSERT INTO Transaksi (trans_num, trans_type, amount, fee, created_at, description, id_trans, id_cust)
VALUES 
(1001, 'Deposit', 1000.00, 10.00, '2024-10-01 10:00:00', 'Deposit ke akun', NULL, 1),
(1002, 'Penarikan', 500.00, 5.00, '2024-10-02 12:00:00', 'Penarikan dari akun', NULL, 2);

-- Masukkan data ke tabel Merchant
INSERT INTO Merchant (id_merchant, name, invoice_num, id_cust)
VALUES 
(1, 'Pembayaran Listrik', 'INV001', 1),
(2, 'Pembayaran Internet', 'INV002', 2);

-- Masukkan data ke tabel Invoice
INSERT INTO Invoice (id_invoice, invoice_num, due_date, id_merchant, id_trans)
VALUES 
(1, 'INV1001', '2024-10-10', 1, 1001),
(2, 'INV1002', '2024-10-11', 2, 1002);

-- Masukkan data ke tabel Activity_Log
INSERT INTO Activity_Log (id_log, id_pengguna, tipe_aktivitas, tgl_aktivitas)
VALUES 
(1, 1, 'Login', '2024-10-01 09:00:00'),
(2, 1, 'Deposit', '2024-10-01 10:00:00'),
(3, 2, 'Login', '2024-10-02 11:00:00'),
(4, 2, 'Penarikan', '2024-10-02 12:00:00');