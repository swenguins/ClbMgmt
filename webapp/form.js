//Script Written by Noah Doyle
// Your web app's Firebase configuration
var user_profile_pic = null;

window.addEventListener("load", function () {
    addClickListeners();
    addInputListeners();
    populate_current_event_table();
    populate_owned_clubs_table()
    addCheckInListeners();
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
const user = auth.current_user;
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
    window.location.href = 'signIn.html';
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
    }).then(window.location.href = 'clubinfo.html');

}

function getClubByName(name) {
    let returnString = "here";
    let test = "";
    clubsCollection.where("club_name", "==", name).get().then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            test = doc.id;
            return test;
        });
        returnString = test;
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
                    localStorage['current_club'] = clubs[i].parentElement.parentElement.firstElementChild.innerHTML;
                    window.location.href = "clubinfo.html";
                })
            }
            else{
                clubs[i].addEventListener("click", function(){
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

function addJoinListeners(){
    joinButtons = document.getElementsByClassName("joinButton");
    if (joinButtons.length > 0){
        for (let i = 0 ; i < joinButtons.length ; i++){
            joinButtons[i].addEventListener("click", function(){
                let name = joinButtons[i].parentElement.parentElement.firstElementChild.innerHTML;
                let desc = joinButtons[i].parentElement.previousElementSibling.innerHTML;
                displayMyClub(name,desc);
                getClubByName(name);
                console.log(localStorage['club_id'])
                const usersCollection = database.collection('clubs').doc(localStorage['club_id']).collection("users");
                let user = firebase.auth().currentUser;
                usersCollection.add({
                    id : user.uid
                })
                joinButtons[i].parentElement.parentElement.innerHTML = "";
            })
        }
    }
}

function addInputListeners(){
    console.log("here to add listener")
    let new_club_search = document.getElementById("club-search-name");
    if(new_club_search){
        new_club_search.addEventListener('input', function () {
            let club_table= document.getElementById("tableBody")
            club_table.innerHTML = "";
            if (new_club_search.value != ""){
                searchClub(new_club_search.value);

            }
        })
    }
  var  new_event_search = document.getElementById("event-search-name");
    if(new_event_search){
        new_event_search.addEventListener('input', function () {
            clearEventTable().then(r => {
                if (new_event_search.value != "") {
                    searchEvent(new_event_search.value);
                }
            });
        })
    }
}

function searchClub(data){
    console.log(data)
    clubsCollection.get().then(function(querySnapshot) {
        querySnapshot.forEach(function (doc) {
            var name = doc.data().club_name;
            name = name.toLowerCase();
            if (name.includes(data)) {
                displayClubSearch(doc.data().club_name,doc.data().description);
            }
        });
    })
}

function searchEvent(data){
    console.log(data)
    clubsCollection.get().then(function(querySnapshot) {
        querySnapshot.forEach(function (doc) {
            const eventsCollection = database.collection('clubs').doc(doc.id).collection("Events");
            eventsCollection.get().then(function(querySnapshot) {
                querySnapshot.forEach(function (doc) {
                    var name = doc.data().event_name;
                    name = name.toLowerCase();
                    if (name.includes(data)) {
                        console.log("adding row")
                        displayEvent(doc.data().event_name, doc.data().description,doc.data().start_time,doc.data().date);
                    }
                });
            })
        });
    })

}

function populate_current_event_table(){
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();
    today = yyyy + '-' + mm + '-' + dd;
    current_table = document.getElementById("current-event-table");
    if (current_table){
        upcoming_table = document.getElementById("upcoming-event-body");
        clubsCollection.get().then(function(querySnapshot) {
            querySnapshot.forEach(function (doc) {
                let current_club_name = doc.data().club_name;
                const eventsCollection = doc.ref.collection("Events");
                eventsCollection.get().then(function(querySnapshot) {
                    querySnapshot.forEach(function (doc) {
                        var name = doc.data().event_name;
                        console.log(name)
                        var desc = doc.data().description;
                        console.log(desc)
                        var time = doc.data().start_time;
                        var date = doc.data().date;
                        console.log(date)
                        console.log(today)
                        //Year, Month, Date
                        if(today == date){
                            var rowc = current_table.insertRow(0);
                            var cell0 = rowc.insertCell(0);
                            var cell1 = rowc.insertCell(1);
                            var cell2 = rowc.insertCell(2);
                            var cell3 = rowc.insertCell(3);
                            var cell4 = rowc.insertCell(4);
                            var cell5 = rowc.insertCell(5);
                            cell0.innerHTML = current_club_name;
                            cell1.innerHTML = name;
                            cell2.innerHTML = desc;
                            cell3.innerHTML = date;
                            cell4.innerHTML = time;
                            cell5.innerHTML =  "<a href='#'  class='checkInButton'>Check In</a>";
                            addCheckInListeners();
                        }
                        else{
                            var rowu = upcoming_table.insertRow(0);
                            var cell5 = rowu.insertCell(0)
                            var cell6 = rowu.insertCell(1);
                            var cell7 = rowu.insertCell(2);
                            var cell8 = rowu.insertCell(3);
                            var cell9 = rowu.insertCell(4);
                            cell5.innerHTML = current_club_name;
                            cell6.innerHTML = name;
                            cell7.innerHTML = desc;
                            cell8.innerHTML = date;
                            cell9.innerHTML = time;
                        }
                    });
                })
            });
        })
    }

    function displayEvent(name, desc, start, date){
        event_table = document.getElementById("event-search-table");
        var row = event_table.insertRow(0);
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);

        cell1.innerHTML = name;
        cell2.innerHTML = desc;
        cell3.innerHTML = date;
        cell4.innerHTML = start;
    }

}

async function clearEventTable() {
    event_table = document.getElementById("event-search-table");
    event_table.innerHTML = "";
    console.log("cleared")
    return "resolved";
}
//Displays the club in profile
function displayClubSearch(name, descrip)
{
    var table = document.getElementById("tableBody");
    var row = table.insertRow(0);
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    cell1.innerHTML = name;
    cell2.innerHTML = descrip;
    cell3.innerHTML = "<a href='#'  class='joinButton'>Join</a>";
    addJoinListeners();
}

function displayMyClub(name, descrip)
{
    var table = document.getElementById("my-club-table");
    var row = table.insertRow(0);
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    cell1.innerHTML = name;
    cell2.innerHTML = descrip;
}

function checkIntoEventByName(club_name, event_name,user) {
    let returnString = "here";
    let test = "";
    clubsCollection.where("club_name","==",club_name).get().then(function(querySnapshot) {
        querySnapshot.forEach(function (doc) {
            const eventsCollection = doc.ref.collection("Events");
            eventsCollection.where("event_name", "==", event_name).get().then(function(querySnapshot) {
                querySnapshot.forEach(function (doc) {
                    doc.ref.collection('checkedIn').add({
                        user_email : user
                    })
                });
            })
        });
    })

}

function addCheckInListeners(){
    checkInButtons = document.getElementsByClassName("checkInButton");
    if (checkInButtons.length > 0){
        for (let i = 0 ; i < checkInButtons.length ; i++){
            checkInButtons[i].addEventListener("click", function(){
                let user = firebase.auth().currentUser;
                let club_name = checkInButtons[i].parentElement.parentElement.firstElementChild.innerHTML;
                let event_name = checkInButtons[i].parentElement.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.innerHTML;
                checkIntoEventByName(club_name,event_name, user.email);
                checkInButtons[i].setAttribute('style', 'background-color: black;');
            })
        }
    }
}

function getUserClubs(){
    clubsCollection.get().then(function(querySnapshot) {
        querySnapshot.forEach(function (doc) {
            const eventsCollection = database.collection('clubs').doc(doc.id).collection("Events");
            eventsCollection.get().then(function(querySnapshot) {
                querySnapshot.forEach(function (doc) {
                    var name = doc.data().event_name;
                    name = name.toLowerCase();
                    if (name.includes(data)) {
                        console.log("adding row")
                        displayEvent(doc.data().event_name, doc.data().description,doc.data().start_time,doc.data().date);
                    }
                });
            })
        });
    })
}

function populate_owned_clubs_table() { //and your joined clubs

    my_clubs = document.getElementById("my-club-table");
    if (my_clubs) {

        clubsCollection.get().then(function (querySnapshot) {
            querySnapshot.forEach(function (doc) {
                var name = doc.data().club_name;
                var desc = doc.data().description;

                var rowm = my_clubs.insertRow(0);
                var cell1 = rowm.insertCell(0);
                var cell2 = rowm.insertCell(1);
                var cell3 = rowm.insertCell(2);


                cell1.innerHTML = name;
                cell2.innerHTML = desc;
                cell3.innerHTML =  "<a href='#'  class='manageButton'>Manage</a>";
                addClickListeners();
            });


        })
    }
}