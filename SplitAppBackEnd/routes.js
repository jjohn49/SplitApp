const express = require('express');
const AppModels = require('./models')
const app = express();

//-------------------POST--------------------
//Adds a new user to the database 
app.post("/new-user", async (req,res)=>{
    console.log("New user tried to be posted")
    const user = new AppModels.User(req.body);

    try{
        await user.save();
        res.send(user);
    }catch (error){
        res.status(500).send(error)
    } 
})

//----------------POST---------------------------
//Adds new transaction to database
app.post("/new-transaction", async (req, res) =>{
    console.log("New transaction tried to be posted")
    const transaction = new AppModels.Transaction(req.body);

    try{
        await transaction.save();
        res.send(transaction);
    }catch (error){
        res.status(500).send(error)
    }
})

//----------------POST---------------------------
//adds a new trip
app.post("/new-trip", async (req,res)=>{
    console.log("Someone tried to post ")
    const trip = new AppModels.Trip(req.body);

    try{
        await trip.save();
        res.send(trip);
    }catch (error){
        res.status(500).send(error)
    }
});

//----------------GET---------------------------
//gets all the trips 
app.get("/get-trips", async (req,res)=>{
    const trips = await AppModels.Trip.find({});

    try{
        res.send(trips);
    }catch (error) {
        res.status(500).send(error)
    }
})

module.exports = app;