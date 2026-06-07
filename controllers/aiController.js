const { GoogleGenerativeAI } = require("@google/generative-ai");

// Inisialisasi API Key dari .env
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

exports.chat = async (req, res) => {
    try {
        // Menggunakan model 'gemini-1.5-flash'
        const model = genAI.getGenerativeModel({ model: "gemini-3.5-flash" });

        const prompt = req.body.message;

        // generateContent adalah fungsi utama sesuai dokumentasi
        const result = await model.generateContent(prompt);
        const response = await result.response;
        const text = response.text();

        res.json({ reply: text });
    } catch (error) {
        console.error("Error:", error);
        res.status(500).json({ reply: "Terjadi kendala pada server AI." });
    }
};