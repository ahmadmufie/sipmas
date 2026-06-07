const express = require('express');
const router = express.Router();
const aiController = require('../controllers/aiController');
const { isAuth } = require('../middleware/authMiddleware');

// Rute untuk menerima pesan chat dari user ke AI
router.post('/chat', isAuth, aiController.chat);

module.exports = router;