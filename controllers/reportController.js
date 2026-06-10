const db = require('../config/database');

exports.createReport = async (req, res) => {
    const { kategori, deskripsi, latitude, longitude } = req.body;
    const userId = req.session.user.id;
    
    // UBAH KE CLOUD-NATIVE: 
    // Menggunakan req.file.location untuk mengambil URL dari AWS S3.
    const foto = req.file ? req.file.location : null;

    try {
        await db.query(
            'INSERT INTO reports (user_id, kategori, deskripsi, foto, latitude, longitude, status) VALUES (?, ?, ?, ?, ?, ?, "Menunggu")',
            [userId, kategori, deskripsi, foto, latitude, longitude]
        );
        res.redirect('/user/dashboard');
    } catch (err) {
        console.error(err);
        res.status(500).send('<script>alert("Gagal membuat laporan!"); window.history.back();</script>');
    }
};

exports.getGisData = async (req, res) => {
    try {
        // Query ini akan selalu mengambil status paling update dari tabel reports
        const [reports] = await db.query(`
            SELECT r.id, r.latitude, r.longitude, r.kategori, r.status, r.created_at, u.username 
            FROM reports r 
            JOIN users u ON r.user_id = u.id
        `);
        res.json(reports);
    } catch (err) {
        console.error(err);
        res.status(500).json([]);
    }
};

// Menampilkan Halaman Semua Laporan (Admin)
exports.getAdminReportsPage = async (req, res) => {
    try {
        // Query ini otomatis mengambil kolom 'foto' (yang sekarang berisi URL S3) karena menggunakan r.*
        const [reports] = await db.query(`
            SELECT r.*, u.username 
            FROM reports r 
            JOIN users u ON r.user_id = u.id
            ORDER BY r.created_at DESC
        `);
        res.render('admin/reports', { reports });
    } catch (err) {
        console.error(err);
        res.status(500).send('Terjadi kesalahan pada database');
    }
};

// Menampilkan Halaman Dispatch Instansi
exports.getDispatchPage = async (req, res) => {
    try {
        const [reports] = await db.query(`
            SELECT r.*, u.username, u.no_telp 
            FROM reports r 
            JOIN users u ON r.user_id = u.id 
            WHERE r.status = 'Menunggu' 
            ORDER BY r.created_at ASC
        `);
        const [contacts] = await db.query(`SELECT * FROM emergency_contacts`);
        res.render('admin/dispatch', { reports, contacts });
    } catch (err) {
        console.error(err);
        res.status(500).send('Terjadi kesalahan pada database');
    }
};

// Memproses Tindakan Dispatch
exports.processDispatch = async (req, res) => {
    const { report_id, contact_id, pesan_instruksi } = req.body;
    
    try {
        await db.query(
            'INSERT INTO dispatches (report_id, contact_id, pesan_instruksi) VALUES (?, ?, ?)', 
            [report_id, contact_id, pesan_instruksi]
        );
        
        await db.query('UPDATE reports SET status = ? WHERE id = ?', ['Diproses', report_id]);
        
        res.redirect('/admin/dispatch');
    } catch (err) { 
        console.error("Error Detail:", err); 
        res.status(500).send('Error pada server: ' + err.message); 
    }
};

// Menampilkan Dashboard User beserta Riwayat Laporannya
exports.getUserDashboard = async (req, res) => {
    try {
        const userId = req.session.user.id;
        const [reports] = await db.query(
            'SELECT * FROM reports WHERE user_id = ? ORDER BY created_at DESC',
            [userId]
        );
        res.render('user/dashboard', { reports });
    } catch (err) {
        console.error(err);
        res.status(500).send('Terjadi kesalahan saat memuat dashboard');
    }
};

// Menampilkan Halaman Form Lapor
exports.getReportForm = (req, res) => {
    res.render('user/lapor');
};

// Memperbarui Status Laporan (Diproses/Selesai)
exports.updateReportStatus = async (req, res) => {
    const { report_id, status } = req.body;
    try {
        await db.query('UPDATE reports SET status = ? WHERE id = ?', [status, report_id]);
        res.redirect('/admin/reports');
    } catch (err) { 
        console.error(err); 
        res.status(500).send('Error Update'); 
    }
};