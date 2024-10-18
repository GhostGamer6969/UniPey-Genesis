require('dotenv').config();
const twilio = require('twilio');
const User = require('../models/user.model');
const OTP = require('../models/otp.model');
const client = new twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);

async function sendLoginOtp(req, res) {
    const { phoneNumber } = req.body;
    const otp = Math.floor(100000 + Math.random() * 900000).toString();

    try {
        const user = await User.findOne({ phoneNumber });
        if (!user) {
            return res.status(404).send('User not found');
        }

        await OTP.findOneAndUpdate(
            { phoneNumber },
            { otp, createdAt: new Date() },
            { upsert: true, new: true }
        );

        await client.messages.create({
            body: `Your OTP is ${otp}`,
            from: process.env.TWILIO_PHONE_NUMBER,
            to: phoneNumber
        });
        res.status(200).send('OTP sent successfully');
    } catch (error) {
        res.status(500).send('Failed to send OTP');
    }
}

async function verifyLoginOtp(req, res) {
    const { phoneNumber, otp } = req.body;

    try {
        const otpRecord = await OTP.findOne({ phoneNumber, otp });

        if (otpRecord) {
            const currentTime = new Date();
            const otpCreationTime = new Date(otpRecord.createdAt);
            const timeDifference = (currentTime - otpCreationTime) / 1000; // in seconds

            if (timeDifference <= 300) { // 300 seconds = 5 minutes
                await OTP.deleteOne({ phoneNumber });
                res.status(200).send('OTP verified successfully');
            } else {
                res.status(400).send('OTP expired');
            }
        } else {
            res.status(400).send('Invalid OTP');
        }
    } catch (error) {
        res.status(500).send('Failed to verify OTP');
    }
}

module.exports = {
    sendLoginOtp,
    verifyLoginOtp
}