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