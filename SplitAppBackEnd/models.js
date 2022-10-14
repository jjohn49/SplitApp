const mongoose = require('mongoose');

//Schema for the trips
const TripSchema = new mongoose.Schema({
    name: {
        type:String,
        required:true
    },
    users: {
        type:[mongoose.Schema.Types.ObjectId],
        ref:"User",
        required:true
    },
    startDate:{
        type:Date,
        required:false
    },
    endDate:{
        type:Date,
        required:false
    }
});

const Trip = mongoose.model("Trip",TripSchema);

const TransactionSchema = new mongoose.Schema({
    //somehow need to make a foreign key right here
    userId:{
        type: mongoose.Schema.Types.ObjectId,
        ref:"User",
        req:true
    },
    trip:{
        type:mongoose.Schema.Types.ObjectId,
        ref:"Trip",
        required:true
    },
    cost:{
        type:Number,
        required:true
    },
    where:{
        type:String,
        required:false
    },
    description:{
        type:String,
        required:false
    }
});

const Transaction = mongoose.model("Transaction", TransactionSchema);
//new user schema 
const UserSchema = new mongoose.Schema({
    _id: {type:String},
    password:{
        type:String,
        required:true,
    },
    fName:{
        type:String,
        required:true
    },
    lName:{
        type:String,
        required:true
    },
    email:{
        type:String,
        required:true
    }
})

const User = mongoose.model("User", UserSchema);

module.exports = {
    Trip,
    User,
    Transaction
}