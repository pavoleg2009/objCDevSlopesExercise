// routes/comments.js
// 2017-01-07
// by Oleg Pavlichenkov

const express   = require('express');
const router    = express.Router({mergeParams:true});
const Comment   = require('../models/comment');
const Tutorial  = require('../models/tutorial');

var comments = [
  {
    username: "Jack123",
    comment: "This is temp comment"
  }

];

// router.put('/comments', function(req, res) {
//   var someObj = req.body;
//
//   var theId = someObj.uniqueId;
//
//   // talk to database, find the comment and replace it with new data
//
//   res.send("successfully updated");
// });

// CREATE New comment for tutorial/video

router.post('/', function(req, res) {
  //lookup Tutorial using Id
  Tutorial.findById(req.params.id, function(err, tutorial) {

    if (err) {
      console.log('Error at Tutorial.findById" ' + err);
      res.send('Can\'t find tutorial with given id to add comment! : '+ err);
    } else {
      var recivedComment = req.body;

      if (recivedComment) {
        if(recivedComment.author && recivedComment.content) {
          const newComment = new Comment({  content: recivedComment.content,
                                            author: recivedComment.author});
          newComment.save()
            .then(() => {
              tutorial.comments.push({_id: newComment.id});
              tutorial.save()
                .then(() => res.send("You successfully posted a comment"))
              });
        } else {
          res.send("You POST request has invalid data of Comment");
        }
      } else {
        res.send("Your POST request has no Commment data in body");
      }
    }
  });
});

router.get('/', function(req, res){
  console.log("GET COMMENT from server for ID: " + req.params.id);

  const query = Tutorial.findById(req.params.id)
    .populate('comments')
    .then((tutorial) => {
      console.log(tutorial);
      res.send(tutorial.comments);
    })

  // Tutorial.findById(req.params.id, function(err, tutorial) {
  //   res.send(tutorial.comments);
  // });



  // Tutorial.find()
  //   .then((tutorials) => {
  //     res.send(tutorials);
  //   });
});

module.exports = router;
