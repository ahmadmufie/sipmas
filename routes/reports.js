const express = require('express');
const router = express.Router();
const reportController = require('../controllers/reportController');
const { isUser, isAdmin } = require('../middleware/authMiddleware');

// Import library AWS S3 dan Multer
const multer = require('multer');
const multerS3 = require('multer-s3');
const { S3Client } = require('@aws-sdk/client-s3');

// 1. Inisialisasi Koneksi ke AWS S3
const s3 = new S3Client({
  region: process.env.AWS_REGION,
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  }
});

// 2. Setup Multer untuk upload foto laporan langsung ke AWS S3
const upload = multer({
  storage: multerS3({
    s3: s3,
    bucket: process.env.AWS_S3_BUCKET_NAME,
    // acl: 'public-read', // Aktifkan jika bucket S3 di-set public
    metadata: function (req, file, cb) {
      cb(null, { fieldName: file.fieldname });
    },
    key: function (req, file, cb) {
      // Menyimpan file di dalam folder "uploads" di AWS S3
      cb(null, `uploads/${Date.now().toString()}-${file.originalname}`);
    }
  })
});

// Rute untuk user membuat laporan
router.post('/create', isUser, upload.single('foto'), reportController.createReport);

// Rute untuk admin mengambil data peta
router.get('/gis-data', isAdmin, reportController.getGisData);

module.exports = router;