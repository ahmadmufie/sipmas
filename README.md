# 📢 SIPMAS (Sistem Pengaduan Masyarakat)

SIPMAS adalah aplikasi pelaporan keluhan masyarakat berbasis web yang dibangun dengan arsitektur **Cloud Native**. Aplikasi ini dirancang untuk dapat di-deploy secara otomatis menggunakan metode CI/CD dan mendistribusikan bebannya melintasi berbagai layanan cloud (Multi-Cloud).

## 🏗️ Arsitektur Cloud & Infrastruktur
Proyek ini memenuhi standar *Cloud Native* dengan pembagian komponen sebagai berikut:
* **Compute / Host (App & API):** Azure Web App Service (Docker Container)
* **Database:** Azure Database for MySQL
* **Object Storage:** Amazon Web Services (AWS) S3
* **Containerization:** Docker & Docker Compose
* **CI/CD Pipeline:** GitHub Actions

*Catatan: Infrastruktur ini mengimplementasikan prinsip **Multi-Cloud**, di mana layanan komputasi (Azure) dipisahkan secara fisik dan jaringan dari layanan penyimpanan file (AWS S3).*

## 🚀 Panduan Instalasi Lokal (Docker Compose)
Untuk menjalankan aplikasi ini secara lokal menggunakan Docker:

1. Clone repositori ini:
   ```bash
   git clone [https://github.com/ahmadmufie/sipmas.git](https://github.com/ahmadmufie/sipmas.git)
   cd sipmas