const express = require('express');
const { Query } = require('mongoose');
const AppModels = require('./models')
const app = express();

app.get("/", async (req, res)=>{
    res.send("<h1>Welcome to the SplittApp Backend Page</h1>")
})

app.post("/signin", async (req, res)=>{
    username = req.body["_id"];
    password = req.body["password"];

    try{
        const user = await AppModels.User.findById(username);
        
        if ((await user).password == password){
            res.status(200).send(user);
        }
    }catch(error){
        console.log(username)
        console.log(password)
        res.status(400).send("Username and password do not match");
    }
    
})

//-------------------POST--------------------
//Adds a new user to the database 
app.post("/register-user", async (req,res)=>{
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

//-----------------Delete------------------------
//Deletes a transaction
app.delete("/delete-transaction", async (req,res)=>{
    const transactionId = req.query.transaction;
    try{
        const transaction = await AppModels.Transaction.findById(transactionId);
        transaction.delete();
        res.status(200).send("Transaction " + transactionId + " deleted")
    }catch(error){
        res.status(400).send("Error: " + error)
    }
})

//-----------------PUT--------------------------
//updates the chosen transaction
app.put("/update-transaction", async (req,res)=>{
    const transactionId = req.query.transaction;
    try{
        const transaction = await AppModels.Transaction.findById(transactionId);
        transaction.userId= req.body["userId"]
        transaction.trip= req.body["tripId"]
        transaction.cost= req.body["cost"]
        transaction.where= req.body["where"]
        transaction.description= req.body["description"]
        transaction.save();
        console.log(transaction)
        res.status(200).send("Transaction " + transactionId + " has updated")
    }catch(error){
        res.status(400).send("Error: " + error)
        console.log(error)
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