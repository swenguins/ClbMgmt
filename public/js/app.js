console.log("app.js successful load.");

// Firebase configuration info.
var firebaseConfig = {
    apiKey: "AIzaSyCaIskrUlJ3Gd6FHxama8SoEZ1w7rWdVOM",
    authDomain: "club-mgmt-test.firebaseapp.com",
    databaseURL: "https://club-mgmt-test.firebaseio.com",
    projectId: "club-mgmt-test",
    storageBucket: "club-mgmt-test.appspot.com",
    messagingSenderId: "285793217980",
    appId: "1:285793217980:web:ada16b85b4fba83c928fb9",
    measurementId: "G-PMYFBBN8V0"
  };

// Initialize Firebase, set to variable "app"
var app = firebase.initializeApp(firebaseConfig);

// Initialize Firestore (db) and Analytics (analy)
var db    = firebase.firestore(app);
var analy = firebase.analytics(app);