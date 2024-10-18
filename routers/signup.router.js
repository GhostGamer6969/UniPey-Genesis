const express = require('express');
const signupController = require('../controllers/signup.controller');

const signupRouter = express.Router();

signupRouter.post('/send-otp', signupController.sendOtp);
signupRouter.post('/verify-otp', signupController.verifyOtp);
signupRouter.post('/register', signupController.registerUser);

module.exports = signupRouter;