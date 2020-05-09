//Script Written by Noah Doyle
// Your web app's Firebase configuration
var user_profile_pic = null;

window.addEventListener("load", function () {
    addClickListeners();
    console.log(localStorage['current_club'])
    if (window.location.href.includes("Manage.html") || window.location.href.includes("clubinfo.html")){
        console.log(localStorage['current_club']);
        getClubByName(localStorage['current_club']);
        console.log(localStorage['club_id'])
    }
    else {
        //localStorage['current_club'] = null;
    }
})


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
const database = firebase.firestore();
const clubsCollection = database.collection('clubs');
const auth = firebase.auth();

//Function for creating an account
function signUp(){

    var email = document.getElementById("email");
    var password = document.getElementById("password");

    if (user_profile_pic){
        firebase.storage().ref('user-profile-pics/' + user_profile_pic.name).put(user_profile_pic);
    }


    const promise = auth.createUserWithEmailAndPassword(email.value, password.value);
    promise.catch(e => alert(e.message));
    //alert("Signed Up");
}

function uploadImage(e) {
    e.preventDefault();
    user_profile_pic = e.target.files[0];
    var image = document.getElementById("profile_img_preview");
    image.src = URL.createObjectURL(e.target.files[0]);
    console.log(user_profile_pic);
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
        window.location.href = 'generic.html';
    }

}


//Signs out of the users Firebase granted account
function signOut(){
    auth.signOut();
    alert("Signed Out");
}


function createClub(){
    var user = firebase.auth().currentUser;
    var clubName = document.getElementById("New-Club-Name");
    var description = document.getElementById("New-Club-Description");
    var ID = clubsCollection.add({
        club_name: clubName.value,
        description: description.value
    });
    ID.then(window.location.href = 'profile.html');

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
        //document.getElementById("welcome").innerHTML = "Welcome User : " + email;

    }else{
        //no user is signed in
        alert("No Active User");

    }

});

//Display Profile Picture

function showUserDetails(){

    var user = firebase.auth().currentUser;
    var name, photoUrl;

    if (user != null) {
        name = user.displayName;
        photoUrl = user.photoURL;

        document.getElementById('dp').innerHTML=photoURL;
        document.getElementById('username').innerHTML=name;
    }}


function createEvent() {
    const eventsCollection = database.collection('clubs').doc(localStorage['club_id']).collection("Events");
    console.log(eventsCollection)
    var eventName = document.getElementById("New-Event-Name");
    var description = document.getElementById("New-Event-Description");
    var date = document.getElementById("meeting-time");
    var dates = date.value.split("T");
    var time = dates[1];
    var day = dates[0];
    const ID = eventsCollection.add({
        event_name: eventName.value,
        description: description.value,
        date: day,
        start_time: time
    });
    ID.then(window.location.href = 'clubinfo.html');
}

function getClubByName(name) {
    let returnString = "here";
    let test = "";
    clubsCollection.where("club_name", "==", name).get().then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            console.log(doc.id)
            test = doc.id;
            console.log(test)
            return test;
        });
        console.log(test)
        console.log(returnString)
        returnString = test;
        console.log(returnString)
        returnClubID(returnString);
    })

}

function returnClubID(data) {
    localStorage['club_id'] = data;
}

function addClickListeners(){
    clubs = document.getElementsByClassName("manageButton");
    if (clubs.length > 0){
        for (let i = 0 ; i < clubs.length ; i++){
            if (clubs[i].innerHTML == 'Manage'){
                clubs[i].addEventListener("click", function(){
                    console.log(clubs[i].parentElement.parentElement.firstElementChild.innerHTML);
                    localStorage['current_club'] = clubs[i].parentElement.parentElement.firstElementChild.innerHTML;
                    window.location.href = "clubinfo.html";
                })
            }
            else{
                clubs[i].addEventListener("click", function(){
                    console.log(clubs[i].parentElement.parentElement.firstElementChild.innerHTML);
                    localStorage['current_club'] = clubs[i].parentElement.parentElement.firstElementChild.innerHTML;
                    window.location.href = "user-club-metrics.html";
                })
            }
        }
    }

    new_club_button = document.getElementById("addBtn");
    if (new_club_button){
        new_club_button.addEventListener('click', function () {
            createClub();
        })
    }
    new_event_button = document.getElementById("event-btn");
    if (new_event_button){
        new_event_button.addEventListener('click', function () {
            createEvent();
        })
    }
}

function addChangeListeners(){

   var new_club_search = document.getElementById("club-search-name");
    if(new_club_search){
        new_event_button.addEventListener('change', function () {
            searchClub();
        })
    }
  var  new_event_search = document.getElementById("event-search-name");
    if(new_club_search){
        new_event_button.addEventListener('change', function () {
searchEvent();
        })
    }
}

function searchClub(){
var clubSearch = new_club_search.value()
}
var clubs = [];
    clubsCollection.get().then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            console.log(doc.id)
            test = doc.id;
            console.log(test)
            console.log(doc.description);
            console.log(doc.club_name);
            if(clubSearch == doc.club_name){
                clubs.add(doc.club_name, doc.club_description);
            }
            return test;

        });


}

function searchEvent(){
    const eventsCollection = database.collection('clubs').doc(localStorage['club_id']).collection("Events");

}