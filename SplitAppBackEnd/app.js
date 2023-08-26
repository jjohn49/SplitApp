//Inspo : https://auth0.com/blog/node-js-and-express-tutorial-building-and-securing-restful-apis/
//expresss library
const express = require('express');
const mongoose = require('mongoose');
const router = require('./routes');
const app = express();
app.use(
    express.urlencoded({ extended: true })
);
app.use(express.json());
app.use(router)

const PORT = 8081;


mongoose.connect('mongodb+srv://jjohns49:Green2002@cluster0.7d65ffv.mongodb.net/?retryWrites=true&w=majority',
{
    useNewURLParser:true,
    useUnifiedTopology:true
});

const db = mongoose.connection;
db.on("error", console.error.bind(console, "connection error: "));
db.once("open", function(){
    console.log("Connection to Database was successful")
})
  
app.listen(PORT, (error) =>{
    if(!error)
        console.log("Server is Successfully Running, and App is listening on port "+ PORT)
    else 
        console.log("Error occurred, server can't start", error);
    }
);

