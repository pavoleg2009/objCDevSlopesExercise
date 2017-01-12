// server.js
// 2017-01-07
// by Oleg Pavlichenkov

const express     = require('express');
const app         = express();
const bodyParser  = require('body-parser');
const mongoose    = require ('mongoose');

const tutorialRoutes = require("./routes/tutorials");
const commentRoutes = require("./routes/comments");

app.all('/*', function(req, res, next){
  res.header('Access-Control-Allow-Origin', "*");
  res.header("Access-Control-Allow-Headers", "X-Requested-With", "Content-Type, Accept");
  res.header("Access-Control-Allow-Methods", "POST, GET");
  next();
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

mongoose.Promise = global.Promise;
mongoose.connect('mongodb://localhost/objc_devspoles_execise');

app.use("/tutorials", tutorialRoutes);
//app.use("/comments", commentRoutes);
app.use("/tutorials/:id/comments",commentRoutes);


app.listen(6069, () => {
  console.log("server started!");
});
