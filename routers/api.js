const express = require('express');
// const loginRouter = require('./login.router');
const signupRouter = require('./signup.router');
// const transactionRouter = require('./transaction.router');
const api = express();

// api.use('/login', loginRouter);
api.use('/signup', signupRouter);
// api.use('/transaction', transactionRouter);

module.exports = api;
