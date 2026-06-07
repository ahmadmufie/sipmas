// Pastikan path ini menunjuk ke file koneksi database Anda
const db = require('../config/database'); 

// 1. Menampilkan Halaman Pengaturan & Daftar Kontak
exports.getSettingsPage = async (req, res) => {
    try {
        const [contacts] = await db.query('SELECT * FROM emergency_contacts');
        res.render('admin/settings', { contacts });
    } catch (err) { 
        console.error("Error mengambil data kontak:", err);
        res.status(500).send('Terjadi kesalahan saat memuat halaman pengaturan'); 
    }
};

// 2. Menambah Instansi Baru
exports.addContact = async (req, res) => {
    const { nama_instansi, jenis, nomor_telp } = req.body;
    try {
        await db.query(
            'INSERT INTO emergency_contacts (nama_instansi, jenis, nomor_telp) VALUES (?, ?, ?)', 
            [nama_instansi, jenis, nomor_telp]
        );
        res.redirect('/admin/settings');
    } catch (err) { 
        console.error("Error menambah instansi:", err);
        res.status(500).send('Error menambah instansi'); 
    }
};

// 3. Menghapus Instansi
exports.deleteContact = async (req, res) => {
    const { id } = req.params;
    try {
        await db.query('DELETE FROM emergency_contacts WHERE id = ?', [id]);
        res.redirect('/admin/settings');
    } catch (err) { 
        console.error("Error menghapus instansi:", err);
        res.status(500).send('Error menghapus instansi'); 
    }
};