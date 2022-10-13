const express = require('express');
const tripModel = require('./models')
const app = express();



app.post("/new-trip", async (req,res)=>{
    console.log("Someone tried to post ")
    const trip = new tripModel(req.body);

    try{
        await trip.save();
        res.send(trip);
    }catch (error){
        res.status(500).send(error)
    }
});

app.get("/get-trips", async (req,res)=>{
    const trips = await tripModel.find({});

    try{
        res.send(trips);
    }catch (error) {
        res.status(500).send(error)
    }
})

module.exports = app;