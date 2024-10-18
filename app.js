const express = require('express');
const bodyParser = require('body-parser');
const api = require('./routers/api');

// Express app
const app = express();

// Middleware
app.use(bodyParser.json());
app.use(express.urlencoded({ extended: true }));

// CORS policy
app.use(cors({
    origin: 'http://localhost:3000'
}));

// API
app.use('/v1', api);

module.exports = app;