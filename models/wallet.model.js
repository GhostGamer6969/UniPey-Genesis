const mongoose = require('mongoose');

const walletSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    walletAddress: { type: String, required: true, unique: true }
});

const Wallet = mongoose.model('Wallet', walletSchema);

module.exports = Wallet;

