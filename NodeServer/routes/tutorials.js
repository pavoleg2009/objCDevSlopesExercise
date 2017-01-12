// routes/tutorials.js
// 2017-01-07
// by Oleg Pavlichenkov

const express   = require('express');
const router    = express.Router();
const Tutorial  = require('../models/tutorial');

//================================
// Tutorial routes
//================================

// Index - show all tutorials

router.get('/', function(req, res){
//  console.log("GET from server !@!@!");
  Tutorial.find()
    .then((tutorials) => {
      res.send(tutorials);
    });
});

module.exports = router;
