// models/comment.js
// 2017-01-07
// by Oleg Pavlichenkov

const mongoose = require('mongoose');

const CommentSchema = mongoose.Schema({
  content: String,
  author: String
  // author: {
  //   type: Schema.Types.ObjectId,
  //   ref: 'user'
  // }
});

const Comment = mongoose.model('comment', CommentSchema);
module.exports = Comment;
