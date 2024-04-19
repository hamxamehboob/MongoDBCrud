var MongoClient = require('mongodb').MongoClient;
var url = "mongodb+srv://HamzaMehboob:Allah786@hamzadb.pm9wo7i.mongodb.net/?retryWrites=true&w=majority&appName=HamzaDB";


MongoClient .connect(url, function(err, db) {
  if (err) throw err;
  var database = db.db("MAJU");

    database.collection("Students").deleteOne({name: "Ahmed"},( function(err, result) {
    if (err) throw err;
    console.log(" document deleted");
    db.close();
  }
));

  });