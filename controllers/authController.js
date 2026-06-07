const bcrypt = require('bcrypt');
const db = require('../config/database');

exports.login = async (req, res) => {
    const { username, password } = req.body;
    try {
        const [rows] = await db.query('SELECT * FROM users WHERE username = ?', [username]);
        
        if (rows.length === 0) {
            return res.status(401).send('<script>alert("Username tidak ditemukan!"); window.location="/auth/login";</script>');
        }

        const user = rows[0];
        const match = await bcrypt.compare(password, user.password);
        
        if (!match) {
            return res.status(401).send('<script>alert("Password salah!"); window.location="/auth/login";</script>');
        }

        // Karena nama_lengkap sudah jadi username, kita simpan username di session
        req.session.user = { 
            id: user.id, 
            nama: user.username, 
            role: user.role 
        };

        res.redirect(user.role === 'admin' ? '/admin/dashboard' : '/user/dashboard');
    } catch (err) {
        console.error(err);
        res.status(500).send('Terjadi kesalahan pada server');
    }
};

exports.register = async (req, res) => {
    // Menggunakan parameter username dan nik sesuai form baru
    const { username, nik, no_telp, password } = req.body;
    try {
        const hash = await bcrypt.hash(password, 10);
        
        await db.query(
            'INSERT INTO users (username, nik, no_telp, password, role) VALUES (?, ?, ?, ?, "user")', 
            [username, nik, no_telp, hash]
        );
        
        res.send('<script>alert("Registrasi berhasil! Silakan login."); window.location="/auth/login";</script>');
    } catch (err) {
        console.error(err);
        res.status(500).send('<script>alert("Error: Username atau NIK mungkin sudah terdaftar."); window.location="/auth/register";</script>');
    }
};

exports.logout = (req, res) => {
    req.session.destroy();
    res.redirect('/auth/login');
};