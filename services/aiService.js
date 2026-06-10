const { GoogleGenerativeAI } = require("@google/generative-ai");

// Inisialisasi Gemini menggunakan API Key dari .env
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

/**
 * Fungsi untuk menganalisis laporan dan memberikan saran P3K
 */
async function analyzeReportWithAI(kategori, deskripsi) {
    try {
        // Menggunakan model Gemini 1.5 Flash (cepat dan ringan)
        const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
        
        const prompt = `
        Kamu adalah asisten tanggap darurat (P3K) dan analis pelaporan masyarakat.
        Ada laporan masuk dengan data berikut:
        Kategori: ${kategori}
        Deskripsi Kejadian: "${deskripsi}"
        
        Tugasmu:
        1. Tentukan tingkat urgensi (Rendah / Sedang / Darurat).
        2. Jika urgensinya 'Sedang' atau 'Darurat' (terutama untuk medis/kecelakaan), berikan 1-2 kalimat instruksi P3K singkat kepada pelapor sambil menunggu bantuan datang. Jika urgensinya 'Rendah', berikan respon menenangkan.
        
        Balas dengan format singkat dan jelas.
        `;

        const result = await model.generateContent(prompt);
        return result.response.text();
        
    } catch (error) {
        console.error("Error dari Gemini API:", error);
        return "Sistem AI sedang sibuk. Harap tunggu bantuan petugas.";
    }
}

module.exports = { analyzeReportWithAI };