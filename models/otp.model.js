const mongoose = require('mongoose');

const otpSchema = new mongoose.Schema({
    phoneNumber: { type: String, required: true, unique: true },
    otp: { type: String, required: true },
    createdAt: { type: Date, default: Date.now, index: { expires: '3m' } } // OTP expires in 3 minutes
});

const OTP = mongoose.model('OTP', otpSchema);

module.exports = OTP;
//otp Schema.index({ createdAt: 1 }, { expireAfterSeconds: 300 }); 