//Inspo : https://auth0.com/blog/node-js-and-express-tutorial-building-and-securing-restful-apis/
//expresss library
const express = require('express');
//Add headers to api
const cors = require('cors')
//turns things in JS objects
const bodyParser = require('body-parser')

const {startDB, startDatabase} = require('./database/mongo')
const {insertTrip, getTrip} = require('./database/trips')  

const app = express();
//const router = app.router()
const PORT = 3000;

app.use(bodyParser.json())
app.use(cors())

  
app.listen(PORT, (error) =>{
    if(!error)
        console.log("Server is Successfully Running, and App is listening on port "+ PORT)
    else 
        console.log("Error occurred, server can't start", error);
    }
);

startDatabase().then(async ()=>{
    await insertTrip({"title":"This is a test trip!"})
})

app.get("/", async(req,res)=>{
    res.status(200)
    res.send(await getTrip())
})

app.post('/', async (req, res) => {
    const newTrip = req.body;
    console.log(newTrip)
    await insertTrip(newTrip);
    res.send({ message: 'New trip inserted.' });
  });