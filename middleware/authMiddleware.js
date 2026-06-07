// middleware/authMiddleware.js

module.exports = {
    // Mengecek apakah user sudah login (secara umum)
    isAuth: (req, res, next) => {
        if (req.session.user) return next();
        res.redirect('/auth/login');
    },

    // Mengecek apakah yang login adalah masyarakat (user)
    isUser: (req, res, next) => {
        if (req.session.user && req.session.user.role === 'user') return next();
        res.redirect('/auth/login');
    },

    // Mengecek apakah yang login adalah polisi/admin
    isAdmin: (req, res, next) => {
        if (req.session.user && req.session.user.role === 'admin') return next();
        res.redirect('/auth/login');
    }
};