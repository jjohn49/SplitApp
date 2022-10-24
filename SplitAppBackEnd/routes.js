const express = require('express');
const AppModels = require('./models')
const app = express();

app.get("/", async (req, res)=>{
    res.send("<h1>Welcome to the SplittApp Backend Page</h1>")
})


//---------------------POST---------------------------------------
//This is the sign in page: function gets the username and password provided in req body
//finds the user by the id and gathers its information.  
//If the password in req body matches the password in  the DB then it returns their info
//If 
app.post("/signin", async (req, res)=>{
    username = req.body["_id"];
    reqPassword = req.body["password"];

    try{
        const user = await AppModels.User.findById(username);
        
        if ((await user).password == reqPassword){
            res.status(200).send(user);
        }else{
            res.send(false)
        }
    }catch(error){
        console.log(username)
        console.log(password)
        res.status(400).send("No such Username found");
    }
})

//-------------------POST--------------------
//Adds a new user to the database 
app.post("/register-user", async (req,res)=>{
    console.log("New user tried to be posted")
    const user = new AppModels.User(req.body);
    console.log(user)
    try{
        await user.save();
        res.send(user);
    }catch (error){
        res.status(500).send(error)
    } 
});

//--------------------PUT-------------------------------
//allows user to change only their first name, lastname, and email,
//Don't want to be messing with the password and the userId just yet
app.put("/update-userinfo", async (req,res)=>{
    const newUserInfo = req.body;
    const userId = req.query.userId;
    try{
        const user = await AppModels.User.findById(userId)
        user.fName = newUserInfo["fName"];
        user.lName = newUserInfo["lName"];
        user.email = newUserInfo["email"];
        user.save();
        console.log(user)
        res.status(200).send("Transaction " + user + " has updated")
    }catch(error){
        res.status(400).send("Error: " + error)
        console.log(error)
    }
})

//---------------------GET----------------------------
//gets all trips for certain user
app.get("/trips-for-user", async (req,res)=>{
    const reqUserId = req.query.user;
    const query = await AppModels.Trip.find({users: reqUserId}).exec()
    console.log(query)
    res.send(query)
})

//Better version of getting tris for user
//more secure
app.post("/trips-for-user", async (req,res)=>{
    const reqUserId = req.body["userId"];
    const query = await AppModels.Trip.find({users: reqUserId}).exec()
    console.log(query)
    res.send(query)
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
    //console.log("Someone tried to post ")
    const trip = new AppModels.Trip(req.body);

    try{
        await trip.save();
        res.send(trip);
    }catch (error){
        res.status(500).send(error)
    }
});

//--------------------GET----------------------------
//gets trips for certain transaction
app.get("/transactions-for-trip", async (req,res)=>{
    const reqTripId = req.query.trip;
    const query = await AppModels.Transaction.find({tripId: reqTripId}).exec()
    console.log(query)
    res.send(query)
})

//----------------GET---------------------------
//gets all the trips 
//should be used for admin only 
app.get("/get-trips", async (req,res)=>{
    const trips = await AppModels.Trip.find({});

    try{
        res.send(trips);
    }catch (error) {
        res.status(500).send(error)
    }
})


module.exports = app;