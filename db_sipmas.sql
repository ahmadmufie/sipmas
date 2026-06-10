-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Jun 2026 pada 18.05
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sipmas`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `aktivitas` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `dispatches`
--

CREATE TABLE `dispatches` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `pesan_instruksi` text DEFAULT NULL,
  `status_dispatch` enum('Menunggu Konfirmasi','Menuju Lokasi','Penanganan Selesai') DEFAULT 'Menunggu Konfirmasi',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `instansi_id` int(11) DEFAULT NULL,
  `pesan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `dispatches`
--

INSERT INTO `dispatches` (`id`, `report_id`, `contact_id`, `pesan_instruksi`, `status_dispatch`, `created_at`, `instansi_id`, `pesan`) VALUES
(2, 2, 2, NULL, 'Menunggu Konfirmasi', '2026-06-07 12:25:09', NULL, NULL),
(3, 3, 1, NULL, 'Menunggu Konfirmasi', '2026-06-07 12:31:49', NULL, NULL),
(4, 4, 2, NULL, 'Menunggu Konfirmasi', '2026-06-07 12:36:26', NULL, NULL),
(5, 5, 3, NULL, 'Menunggu Konfirmasi', '2026-06-07 12:40:58', NULL, NULL),
(6, 6, NULL, NULL, 'Menunggu Konfirmasi', '2026-06-07 12:45:39', NULL, NULL),
(7, 7, 3, 'saya membutuhkan 3 mobil damkar', 'Menunggu Konfirmasi', '2026-06-07 12:50:16', NULL, NULL),
(8, 8, 3, 'punten mawa udud marlong', 'Menunggu Konfirmasi', '2026-06-07 14:28:59', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `emergency_contacts`
--

CREATE TABLE `emergency_contacts` (
  `id` int(11) NOT NULL,
  `nama_instansi` varchar(100) NOT NULL,
  `nomor_telp` varchar(20) NOT NULL,
  `jenis` enum('Polisi','Rumah Sakit','Damkar','BPBD') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `emergency_contacts`
--

INSERT INTO `emergency_contacts` (`id`, `nama_instansi`, `nomor_telp`, `jenis`, `created_at`) VALUES
(1, 'Polisi', '110', 'Polisi', '2026-06-07 07:48:54'),
(2, 'Ambulans', '118', 'Rumah Sakit', '2026-06-07 07:48:54'),
(3, 'Pemadam Kebakaran', '113', 'Damkar', '2026-06-07 07:48:54'),
(4, 'BPBD', '117', 'BPBD', '2026-06-07 07:48:54');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `laporan_summary`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `laporan_summary` (
`status` enum('Menunggu','Diproses','Selesai','Ditolak')
,`total` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `laporan_user_summary`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `laporan_user_summary` (
`user_id` int(11)
,`total_laporan` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pesan` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `kategori` enum('Kriminalitas','Kecelakaan','Kebakaran','Darurat Medis','Lainnya') NOT NULL,
  `deskripsi` text NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `accuracy` float DEFAULT NULL,
  `status` enum('Menunggu','Diproses','Selesai','Ditolak') DEFAULT 'Menunggu',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `reports`
--

INSERT INTO `reports` (`id`, `user_id`, `kategori`, `deskripsi`, `foto`, `latitude`, `longitude`, `accuracy`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'Kriminalitas', 'Maling', '1780822832855-WhatsApp Image 2026-05-12 at 3.52.07 PM (1).jpeg', -6.91474400, 107.60981000, NULL, 'Selesai', '2026-06-07 09:00:32', '2026-06-07 12:25:34'),
(2, 2, 'Kecelakaan', 'AYA NU MAOT', '1780825584134-LCD-removebg-preview.png', -6.89823329, 107.63457528, NULL, 'Selesai', '2026-06-07 09:46:24', '2026-06-07 12:25:33'),
(3, 2, 'Kriminalitas', 'Ada kena jambret', '1780835354069-AUTOMATIC.png', -6.89823329, 107.63457528, NULL, 'Selesai', '2026-06-07 12:29:14', '2026-06-07 12:38:41'),
(4, 2, 'Kecelakaan', 'Ada tabrakan', '1780835739477-222.png', -6.89830043, 107.63459289, NULL, 'Diproses', '2026-06-07 12:35:39', '2026-06-07 12:38:47'),
(5, 2, 'Lainnya', 'Kejepit pager', '1780836026114-111.png', -6.89822598, 107.63457696, NULL, 'Selesai', '2026-06-07 12:40:26', '2026-06-07 12:41:07'),
(6, 2, 'Darurat Medis', 'Terdapat darurat passien', '1780836293315-222.png', -6.89823329, 107.63457528, NULL, 'Diproses', '2026-06-07 12:44:53', '2026-06-07 12:45:39'),
(7, 2, 'Kebakaran', 'butuh dafkar', '1780836574422-222.png', -6.89823329, 107.63457528, NULL, 'Selesai', '2026-06-07 12:49:34', '2026-06-07 12:50:20'),
(8, 2, 'Lainnya', 'ieu aya budak maot punten', NULL, -6.89823329, 107.63457528, NULL, 'Diproses', '2026-06-07 14:27:19', '2026-06-07 14:28:59');

-- --------------------------------------------------------

--
-- Struktur dari tabel `report_status`
--

CREATE TABLE `report_status` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `status` enum('Menunggu','Diproses','Selesai','Ditolak') NOT NULL,
  `catatan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `nik` varchar(50) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `nik`, `no_telp`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Administrator SIPMAS', '1234567890123456', '081111111111', '$2b$10$wO0Q3R.dZgqR5O.C3oB2.O8gX/y/L.4O0O1.oU/T4N1Q3Q3Q3Q3Q3', 'admin', '2026-06-07 07:48:54', '2026-06-07 09:06:45'),
(2, 'Rizal', '1212121212121212', '0811111111', '$2b$10$7DBsOefJZRBE1gieqE.yAu1YqIgo8UnZ3fjbN.eXtX82rjvdTLIl6', 'user', '2026-06-07 08:57:28', '2026-06-07 08:57:28'),
(5, 'Admin', 'admin', '085555555555', '$2b$10$ODwR5xycLBsJnInpoKoAju22SLPoqbB5gc6oJw/ES7U9I7ra0HGFi', 'admin', '2026-06-07 09:10:11', '2026-06-07 11:24:50');

-- --------------------------------------------------------

--
-- Struktur untuk view `laporan_summary`
--
DROP TABLE IF EXISTS `laporan_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `laporan_summary`  AS SELECT `reports`.`status` AS `status`, count(0) AS `total` FROM `reports` GROUP BY `reports`.`status` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `laporan_user_summary`
--
DROP TABLE IF EXISTS `laporan_user_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `laporan_user_summary`  AS SELECT `reports`.`user_id` AS `user_id`, count(0) AS `total_laporan` FROM `reports` GROUP BY `reports`.`user_id` ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_activity_user` (`user_id`);

--
-- Indeks untuk tabel `dispatches`
--
ALTER TABLE `dispatches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_dispatch_report` (`report_id`),
  ADD KEY `fk_dispatch_contact` (`contact_id`);

--
-- Indeks untuk tabel `emergency_contacts`
--
ALTER TABLE `emergency_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_notifications_user` (`user_id`);

--
-- Indeks untuk tabel `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_reports_user` (`user_id`),
  ADD KEY `idx_reports_status` (`status`),
  ADD KEY `idx_reports_kategori` (`kategori`),
  ADD KEY `idx_reports_created` (`created_at`);

--
-- Indeks untuk tabel `report_status`
--
ALTER TABLE `report_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_report_status` (`report_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nik` (`nik`),
  ADD UNIQUE KEY `no_telp` (`no_telp`),
  ADD UNIQUE KEY `username` (`nik`),
  ADD UNIQUE KEY `nik_2` (`nik`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `dispatches`
--
ALTER TABLE `dispatches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `emergency_contacts`
--
ALTER TABLE `emergency_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `report_status`
--
ALTER TABLE `report_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `fk_activity_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `dispatches`
--
ALTER TABLE `dispatches`
  ADD CONSTRAINT `fk_dispatch_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_reports_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `report_status`
--
ALTER TABLE `report_status`
  ADD CONSTRAINT `fk_report_status` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
