const express = require('express');
const AppModels = require('./models');
const app = express();


const tripRoutes = require('./routes/TripRoutes');
const transactionRoutes = require('./routes/TransactionRoutes');
const userRoutes = require('./routes/UserRoutes');

app.use(transactionRoutes);
app.use(tripRoutes);
app.use(userRoutes);

app.use(express.json());

app.get("/", async (req, res)=>{
    res.send("<h1>Welcome to the SplittApp Backend Page</h1>")
})

module.exports = app;