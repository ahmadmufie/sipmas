require('dotenv').config();
const express = require('express');
const session = require('express-session');
const path = require('path');

// Import Controllers
const reportController = require('./controllers/reportController');
const settingsController = require('./controllers/settingsController');
const authController = require('./controllers/authController'); // Pastikan ini ada

const app = express();

// ==========================================
// 1. SETUP MIDDLEWARE
// ==========================================
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// ==========================================
// 2. SETUP SESSION
// ==========================================
app.use(session({
    secret: process.env.SESSION_SECRET || 'sipmas_secret_key_default',
    resave: false,
    saveUninitialized: false,
    cookie: { secure: false, maxAge: 1000 * 60 * 60 * 24 }
}));

// ==========================================
// 3. SETUP VIEW ENGINE & LOCALS
// ==========================================
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.use((req, res, next) => {
    res.locals.user = req.session.user || null;
    next();
});

// ==========================================
// 4. AUTH MIDDLEWARE
// ==========================================
const { isAuth, isUser, isAdmin } = require('./middleware/authMiddleware');

// ==========================================
// 5. ROUTING
// ==========================================

// Auth Routes
app.use('/auth', require('./routes/auth'));

// Root Redirection
app.get('/', (req, res) => {
    if (req.session.user) {
        return res.redirect(req.session.user.role === 'admin' ? '/admin/dashboard' : '/user/dashboard');
    }
    res.redirect('/auth/login');
});

// User Routes
app.get('/user/dashboard', isUser, reportController.getUserDashboard);
app.get('/user/lapor', isUser, reportController.getReportForm);
app.use('/reports', require('./routes/reports'));

// Admin Dashboard & Management
app.get('/admin/dashboard', isAdmin, (req, res) => res.render('admin/dashboard'));
app.get('/admin/reports', isAdmin, reportController.getAdminReportsPage);
app.post('/admin/reports/update-status', isAdmin, reportController.updateReportStatus);

// Admin Dispatch
app.get('/admin/dispatch', isAdmin, reportController.getDispatchPage);
app.post('/admin/dispatch', isAdmin, reportController.processDispatch);

// Admin Settings
app.get('/admin/settings', isAdmin, settingsController.getSettingsPage);
app.post('/admin/settings/add-contact', isAdmin, settingsController.addContact);
app.get('/admin/settings/delete-contact/:id', isAdmin, settingsController.deleteContact);

// AI Features (Opsional)
app.use('/ai', require('./routes/ai'));

// Pastikan folder uploads bisa diakses publik
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
// ==========================================
// 6. ERROR HANDLING
// ==========================================
app.use((req, res) => {
    res.status(404).send('<h1>404 - Halaman Tidak Ditemukan</h1><a href="/">Kembali ke Beranda</a>');
});

// ==========================================
// 7. START SERVER
// ==========================================
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`==========================================`);
    console.log(`🚀 Server SIPMAS berjalan di Port: ${PORT}`);
    console.log(`🔗 Akses lokal: http://localhost:${PORT}`);
    console.log(`==========================================`);
});