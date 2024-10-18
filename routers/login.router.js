const express = require('express');
const loginController = require('../controllers/login.controller');

const loginRouter = express.Router();

loginRouter.post('/send-login-otp', loginController.sendLoginOtp);
loginRouter.post('/verify-login-otp', loginController.verifyLoginOtp);

module.exports = loginRouter;