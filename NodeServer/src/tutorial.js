// models/tutorial.js
// 2017-01-07
// by Oleg Pavlichenkov

const mongoose = require('mongoose');


const TutorialSchema = mongoose.Schema({
  title: String,
  description: String,
  iframe: String,
  thumbnail: String,
  comments: {
    type: Schema.Types.ObjectId,
    ref: 'comment'
  }
});

const Tutorial = mongoose.model('tutorial', TutorialSchema);
module.exports = Tutorial;
