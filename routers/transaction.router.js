const express = require('express');
const transactionController = require('../controllers/transaction.controller');

const transactionRouter = express.Router();

transactionRouter.post('/make-payment', transactionController.makePayment);

module.exports = transactionRouter;