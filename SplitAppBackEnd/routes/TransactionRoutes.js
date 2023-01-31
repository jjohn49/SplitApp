const express = require('express');
const AppModels = require('./../models')
const app = express();
app.use(express.json());


//----------------POST---------------------------
//Adds new transaction to database
app.post("/new-transaction", async (req, res) =>{
    //console.log("New transaction tried to be posted")
    //add code to check what all the body was posted

    //deletes the id because mongo will create one
    delete req.body["_id"]
    const transaction = new AppModels.Transaction(req.body);
    //console.log(req.body)

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
    console.log("Someone tried updating the transactoion " + req.body)
    const transactionId = req.query.transaction;
    try{
        const transaction = await AppModels.Transaction.findById(transactionId);
        transaction.userId= req.body["userId"]
        transaction.trip= req.body["tripId"]
        transaction.cost= req.body["cost"]
        transaction.where= req.body["where"]
        transaction.description= req.body["description"]
        transaction.votesToDelete= req.body["votesToDelete"]
        transaction.save();
        console.log(transaction)
        res.status(200).send("Transaction " + transactionId + " has updated")
    }catch(error){
        res.status(400).send("Error: " + error)
        console.log(error)
    }
})




module.exports = app;