Berikut adalah daftar *endpoint* utama yang digunakan dalam sistem aplikasi SIPMAS. Seluruh *request* ke backend ditangani menggunakan Node.js (Express).

### 1. Autentikasi (`/auth`)
* **`POST /auth/register`**
  * **Deskripsi:** Mendaftarkan pengguna baru.
  * **Body:** `username`, `nik`, `no_telp`, `password`
* **`POST /auth/login`**
  * **Deskripsi:** Masuk ke dalam sistem (membuat session).
  * **Body:** `nik`, `password`
  * **Response:** Mengarahkan ke `/dashboard` (User) atau `/admin/dashboard` (Admin).

### 2. Pengaduan / Reports (`/reports`)
* **`POST /reports/create`**
  * **Deskripsi:** Membuat laporan pengaduan baru dengan unggahan foto.
  * **Format:** `multipart/form-data`
  * **Body:** `kategori`, `deskripsi`, `latitude`, `longitude`, `foto` (File upload otomatis ke AWS S3).
* **`GET /admin/reports`**
  * **Deskripsi:** Mengambil semua data laporan untuk ditampilkan di tabel admin.

### 3. Manajemen Status (`/admin/reports`)
* **`POST /admin/reports/update-status`**
  * **Deskripsi:** Mengubah status laporan (misal: Menunggu -> Diproses -> Selesai).
  * **Body:** `report_id`, `status`

### 4. Halaman Admin
* **`/admin/dashboard`** melihat informasi laporan dan GIS Map monitoring Center
* **`/admin/dispatch`** Penugasan Instansi untuk menangani laporan
* **`/admin/settings`** Kelola data instansi penanganan laporan darurat

### 4. Halaman User
* **`/user/dashboard`** Menampilkan Riwayat laporan, posisi maps anda saat ini, panggilan telpon instansi, dan Asisten AI P3K
* **`/user/lapor`** Mengisi Form Pelaporan Darurat untuk menjelaskan kejadian
