const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const TutorialSchema = mongoose.Schema({
  title: String,
  description: String,
  iframe: String,
  thumbnail: String,
  comments: [{
    type: Schema.Types.ObjectId,
    ref: 'comment'
  }]
});

const Tutorial = mongoose.model('tutorial', TutorialSchema);
module.exports = Tutorial;
