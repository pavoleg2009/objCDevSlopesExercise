const assert = require('assert');
const Tutorial = require('../models/tutorial');

describe('Create tutorial', () => {
  it('create new tutorial', (done) => {

    const tutorial1 = new Tutorial({
      title: 'Swift: Firebase 3 - How to Build a Login Page Using iOS9 Constraint Anchors (Ep 1)',
      description: "Much awaited, anticipated, and requested video series on how to use Firebase is now here. Today, we'll briefly go through what the application does in terms of chat functionality. We will then dive right into Xcode and create a new project, and build our login page using iOS 9 constraint anchors. Stay tuned for the next episode where we'll look at how to install the Firebase SDK and save our users into the real time database.",
      iframe: '<div class = "container"><iframe class="video"  src="https://www.youtube.com/embed/lWSc0wHFTXM" frameborder="0" allowfullscreen></iframe></div>',
      thumbnail: 'https://i.ytimg.com/vi/lWSc0wHFTXM/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=TGhwrmjPHei6vcOni_OM5EFzCag'
    });

    const tutorial2 = new Tutorial({
      title: '10 Reasons Why I Abandoned Storyboards and Interface Builder',
      description: "Quick break from all the coding today. In today's video I'll list out my top 10 reasons why I don't use storyboards. Let the flame begin...",
      iframe: '<div class = "container"><iframe class="video"  src="https://www.youtube.com/embed/g6yz5oX5iWc" frameborder="0" allowfullscreen></iframe></div>',
      thumbnail: 'https://i.ytimg.com/vi/g6yz5oX5iWc/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=F58wmOyAKC2CfMS05nHioHB8SxA'
    });

    const tutorial3 = new Tutorial({
      title: 'Lets Build That App Live Stream: Q&A Ask me anything!',
      description: "Ask me anything you want while I'm still here!",
      iframe: '<div class = "container"><iframe class="video"  src="https://www.youtube.com/embed/M1509QJWPJ8" frameborder="0" allowfullscreen></iframe></div>',
      thumbnail: 'https://i.ytimg.com/vi/M1509QJWPJ8/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=8QRSAcfApLqV4IJDEfj05NuEgpo'
    });

    const tutorial4 = new Tutorial({
      title: 'In App Purchases! (Swift 3 in Xcode : Swifty Store Kit)',
      description: "n today's tutorial, we dive into In-App Purchases and implement them into our very own app. Now with In-App Purchase implemented in your own app, you can start bringing in some money! Enjoy & Happy New Year!",
      iframe: '<div class = "container"><iframe class="video"  src="https://www.youtube.com/embed/dwPFtwDJ7tc" frameborder="0" allowfullscreen></iframe></div>',
      thumbnail: 'https://i.ytimg.com/vi/dwPFtwDJ7tc/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=mHIj6dSU613ZFjg891J1g0bsBPc'
    });

    Promise.all([
      tutorial1.save(),
      tutorial2.save(),
      tutorial3.save(),
      tutorial4.save()
    ])
      .then(() => Tutorial.find())
      .then((tutorials) => {
//        console.log(tutorials);
        assert(tutorials.length === 4);
        done();
      })
  })
});
