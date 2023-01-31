const express = require('express');
const AppModels = require('./../models')
const app = express();
app.use(express.json());




//----------------POST---------------------------
//adds a new trip
app.post("/new-trip", async (req,res)=>{
    console.log("Someone tried to post a new trip called" + req.body["name"])
    delete req.body["_id"]
    //console.log(req.body)
    const trip = new AppModels.Trip(req.body);

    try{
        await trip.save();
        res.send(trip);
    }catch (error){
        console.log(error)
        res.status(500).send(error)
    }
});

//--------------------POST----------------------------
//gets trips for certain transaction
app.post("/transactions-for-trip", async (req,res)=>{
    const reqTripId = req.query.trip;
    const query = await AppModels.Transaction.find({tripId: reqTripId}).exec()
    //console.log(query)
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

//deletes the trip and all transactions in the trip
app.delete("/delete-trip", async (req, res)=>{
    const tripID = req.query.trip;
    try{
        const trip = await AppModels.Trip.findById(tripID);
        console.log(trip)
        trip.delete();

        //used to delete all transactions for the trip that are now useless
        const transactions = await AppModels.Transaction.find({ tripId : tripID})
        console.log("-----------------DELETING FOLLOWING TRANSACTIONS--------------------")
        console.log(transactions)
        console.log("-----------------DELETED PREVIOUS TRANSACTIONS--------------------")
        transactions.delete();

        res.status(200).send("Trip " + tripID + " deleted")
    }catch(error){
        res.status(400).send("Error: " + error)
    }
})

app.put('/update-trip-vtd', async (req, res)=>{
    const tripID = req.query.trip;
    console.log("updating ")
    try{
        const trip = await AppModels.Trip.findById(tripID);
        trip["votesToEndTrip"] = req.body["votesToEndTrip"]
        trip.save();
        res.status(200).send("Trip " + tripID + "'s votes to delete were successfully updated")
    }catch(error){
        res.status(400).send(error)
    }
})





module.exports = app;