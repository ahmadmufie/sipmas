const express = require('express');
const router = express.Router();
const reportController = require('../controllers/reportController');
const { isUser, isAdmin } = require('../middleware/authMiddleware');
const multer = require('multer');

// Setup Multer untuk upload foto laporan
const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, 'uploads/'),
    filename: (req, file, cb) => cb(null, Date.now() + '-' + file.originalname)
});
const upload = multer({ storage });

// Rute untuk user membuat laporan
router.post('/create', isUser, upload.single('foto'), reportController.createReport);

// Rute untuk admin mengambil data peta
router.get('/gis-data', isAdmin, reportController.getGisData);

module.exports = router;