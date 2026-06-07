const mysql = require('mysql2/promise');
require('dotenv').config();

// Membuat connection pool
const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10, // Maksimal koneksi paralel yang diizinkan
    queueLimit: 0        // 0 berarti tidak ada batas antrean
});

// Test koneksi saat aplikasi pertama kali dijalankan
pool.getConnection()
    .then(connection => {
        console.log('✅ Database MySQL berhasil terkoneksi!');
        connection.release(); // Kembalikan koneksi ke pool setelah test
    })
    .catch(err => {
        console.error('❌ Gagal terkoneksi ke Database MySQL:');
        console.error(err.message);
    });

module.exports = pool;