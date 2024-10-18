const app = require('./app');
const PORT = process.env.PORT || 3000;

async function start() {
    app.listen(PORT, () => {
        console.log(`Server is running on http://localhost:${PORT}`);
    });
}

start();
