const mongoose = require('mongoose');
const { ObjectID } = require('mongoose/node_modules/mongodb');

//Schema for the trips
const TripSchema = new mongoose.Schema({
    name: {
        type:String,
        required:true
    },
    users: {
        type:[String],
        required:true
    },
    startDate:{
        type:Date,
        required:false
    },
    endDate:{
        type:Date,
        required:false
    },
    transactionCategories:{
        type:[String]
    },
    votesToEndTrip:{
        type:[String]
    }
    //maybe add something like is completed so we can seperate current trips from past trips
});

const Trip = mongoose.model("Trip",TripSchema);

const TransactionSchema = new mongoose.Schema({
    //somehow need to make a foreign key right here
    name: {type:String},
    userId:{
        type: String,
        req:true
    },
    tripId:{
        type:mongoose.Schema.Types.ObjectId,
        ref:"Trip",
        required:true
    },
    cost:{
        type:Number,
        required:true
    },
    date:{
        type:Date,
        required:true
    },
    where:{
        type:String,
        required:false
    },
    votesToDelete: [String],
    description:{
        type:String,
        required:false
    },
    category:{type:String}
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

const ActivitySchema = new mongoose.Schema({
    type: String,
    idOfActivity: mongoose.Schema.Types.Mixed,
    Date: Date
});

module.exports = {
    Trip,
    User,
    Transaction
}