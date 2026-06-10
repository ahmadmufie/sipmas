# 🤖 Dokumentasi Integrasi AI Service

Sistem SIPMAS akan dilengkapi dengan **AI Engine** berbasis Gemini untuk membantu admin memverifikasi laporan masyarakat dan memberikan konsultasi P3K secara lebih cepat dan cerdas.

## 📌 Rencana Implementasi AI
Sistem AI akan diterapkan pada alur pembuatan laporan dengan fokus pada:

1. **AI Image Validation (Vision AI)**
   * **Tujuan:** Memeriksa foto yang diunggah pelapor untuk memastikan keaslian dan relevansi (misal: mendeteksi apakah foto benar-benar menunjukkan kecelakaan/kebakaran, bukan foto *selfie* atau gambar acak).
   * **Rencana Layanan:** Gemini Vision API.

2. **Automated Categorization & P3K Consultation (NLP)**
   * **Tujuan:** Menganalisis teks `deskripsi` yang diketik pengguna untuk menilai tingkat urgensi (Darurat/Biasa) dan memberikan panduan P3K awal sebelum admin menindaklanjuti.
   * **Rencana Layanan:** Gemini Text API.

## 🔄 Alur Kerja AI (Arsitektur Jaringan)
1. User mengirim *request* POST berisi teks dan foto.
2. Backend (Node.js) meneruskan *payload* tersebut ke **AI Service VPC** (via REST API).
3. AI Service mengembalikan skor validitas dan tingkat urgensi.
4. Laporan disimpan ke *Database* beserta *metadata* hasil analisis AI.