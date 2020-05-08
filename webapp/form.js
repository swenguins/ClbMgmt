//Script Written by Noah Doyle
// Your web app's Firebase configuration
var firebaseConfig = {
//firebase config stuff
    apiKey: "AIzaSyAE11kj_DIRt2w7UhJzLfd7FKJBgrXr1-8",
    authDomain: "penguin-club-management.firebaseapp.com",
    databaseURL: "https://penguin-club-management.firebaseio.com/",
    projectId: "penguin-club-management",
    storageBucket: "penguin-club-management.appspot.com",
    messagingSenderId: "943805784975",
    appId: "1:943805784975:web:856511aed7476ffd9b21fa",
    measurementId: "G-P739PW06R9"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);

const auth = firebase.auth();

//Function for creating an account
function signUp(){

    var email = document.getElementById("email");
    var password = document.getElementById("password");
    const promise = auth.createUserWithEmailAndPassword(email.value, password.value);
    promise.catch(e => alert(e.message));
    //alert("Signed Up");

}


//Signs into youre account.
function signIn(){

    var email = document.getElementById("email");
    var password = document.getElementById("password");

    const promise = auth.signInWithEmailAndPassword(email.value, password.value); //Firebase given function to sign in with email.
    promise.catch(e => alert(e.message));
    var user = firebase.auth().currentUser;
    if(user != null)
    {
        window.location.href = 'profile.html';
    }

}


//Signs out of the users Firebase granted account
function signOut(){
    auth.signOut();
    alert("Signed Out");
}


function createClub(){
    var user = firebase.auth().currentUser;
    document.getElementById("create").style.display = "block";
    //TODO: Create Club Function, this can either be done in the profile html or in a new html,

}

function manageClub(){
    var user = firebase.auth().currentUser;
    document.getElementById("manage").style.display = "block";
    //TODO: Create Management Function for Clubs, somewhere we will need to be able to get and set certain aspects of the club and create/manage events
}

function getClubAnalytics(){
    var user = firebase.auth().currentUser;
    document.getElementById("analytics").style.display = "block";
    //TODO: We must find a way to get the analytics for each club, This may need its own function or may get done another way
}



//This checks to see if the users login state has changed, or if there is a user at all NONSTOP IT LOOPS, this is from firebase
auth.onAuthStateChanged(function(user){

    var user = firebase.auth().currentUser;//This saves the users information so you can switch html files and still have that info.
    var email = user.email;




    if(user){

//User Is signed in
        var user = firebase.auth().currentUser;
        var email = user.email; //creates a variable to store the users email. This can be done similarly with any of the users info, in this loop.
        document.getElementById("welcome").innerHTML = "Welcome User : " + email;

        alert("Active User " + email); //sends an alert that the user is signed in, is a testing alert and should be removed upon rollout

    }else{
        //no user is signed in
        alert("No Active User");

    }

});
