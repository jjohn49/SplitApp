const express = require('express');
const { Transaction } = require('mongoose/node_modules/mongodb');
const AppModels = require('./../models')
const app = express();
app.use(express.json());

//---------------------POST---------------------------------------
//This is the sign in page: function gets the username and password provided in req body
//finds the user by the id and gathers its information.  
//If the password in req body matches the password in  the DB then it returns their info
//If 
app.post("/signin", async (req, res)=>{
    let username = req.body["_id"];
    let reqPassword = req.body["password"];

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
    //console.log(user)
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
        //console.log(user)
        res.status(200).send("Transaction " + user + " has updated")
    }catch(error){
        res.status(400).send("Error: " + error)
        console.log(error)
    }
})

//works
app.post("/transactions-for-trips-with-user", async (req, res)=>{

    try {
        const userId = req.body["userId"];
    
    //Queries all trips with the userID
    const tripQuery = await AppModels.Trip.find({users: userId}).exec()

    //makes an array of just the trips Ids
    tripIds = tripQuery.map( (trip)=>{return trip._id})

    //finds all transactions in the trip
    const transactions = await AppModels.Transaction.find({tripId : {$in : tripIds}}).exec()

    res.send(transactions).status(200)
    } catch (error) {
        console.log(error)
        res.send(error).status(400)
    }
    
})

//Better version of getting tris for user
//more secure
app.post("/trips-for-user", async (req,res)=>{
    const reqUserId = req.body["userId"];
    const query = await AppModels.Trip.find({users: reqUserId}).exec()
    //console.log(query)
    res.send(query)
})

module.exports = app;