const mongoose = require('mongoose');
mongoose.Promise = global.Promise;

before((done) => {
  mongoose.connect('mongodb://localhost/objc_devspoles_execise');
  mongoose.connection
    .once('open', () => {
      console.log('Connected to MongoDB');
      done()
    })
    .on('error', (error) => {
      console.warn('Error while trying to connect to DB.: '+ error);
    });
});

beforeEach((done) => {
  const {tutorials} = mongoose.connection.collections;
  tutorials.drop(() => {
    done();
  })
})
