// routes/auth.js
const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// Route untuk menampilkan halaman (View)
router.get('/login', (req, res) => {
    // Jika sudah login, lempar kembali ke dashboard
    if(req.session.user) return res.redirect('/');
    res.render('auth/login');
});

router.get('/register', (req, res) => {
    if(req.session.user) return res.redirect('/');
    res.render('auth/register');
});

// Route untuk memproses form (Aksi)
router.post('/login', authController.login);
router.post('/register', authController.register);
router.get('/logout', authController.logout);

module.exports = router;