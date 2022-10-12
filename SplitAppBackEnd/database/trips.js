const {getDatabase} = require('./mongo');

const collectionName = 'trips';

async function insertTrip(trip) {
  const database = await getDatabase();
  const {insertedId} = await database.collection(collectionName).insertOne(trip);
  return insertedId;
}

async function getTrip() {
  const database = await getDatabase();
  return await database.collection(collectionName).find({}).toArray();
}

//exports these methods
module.exports = {
  insertTrip,
  getTrip,
};