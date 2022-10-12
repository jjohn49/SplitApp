const {MongoMemoryServer} = require('mongodb-memory-server');
const {MongoClient} = require('mongodb');

let database = null;

//initializes a temp db every time the code is run
async function startDatabase() {
  const mongo = await MongoMemoryServer.create();
  const mongoDBURL = mongo.getUri();
  const connection = await MongoClient.connect(mongoDBURL, {useNewUrlParser: true});
  database = connection.db();
}

async function getDatabase() {
  if (!database) await startDatabase();
  return database;
}

//exports these methods
module.exports = {
  getDatabase,
  startDatabase,
};