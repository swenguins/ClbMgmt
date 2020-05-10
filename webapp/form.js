//Script Written by Noah Doyle
// Your web app's Firebase configuration
let user_profile_pic = null;

window.addEventListener("load", function () {
    addClickListeners();
    addInputListeners();
    populate_current_event_table();
    populate_owned_clubs_table()
    addCheckInListeners();
    club_event_table();
    console.log(localStorage['current_club'])
    if (window.location.href.includes("CreateEvent.html") || window.location.href.includes("ManageClub.html")){
        console.log(localStorage['current_club']);
        getClubByName(localStorage['current_club']);
        console.log(localStorage['club_id'])
    }
    else {
        //localStorage['current_club'] = null;
    }
})


const firebaseConfig = {
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

    let email = document.getElementById("email");
    let password = document.getElementById("password");

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
    let image = document.getElementById("profile_img_preview");
    image.src = URL.createObjectURL(e.target.files[0]);
    console.log(user_profile_pic);
}

//Signs into your account.
function signIn(){

    let email = document.getElementById("email");
    let password = document.getElementById("password");

    const promise = auth.signInWithEmailAndPassword(email.value, password.value); //Firebase given function to sign in with email.
    promise.catch(e => alert(e.message));
    let user = firebase.auth().currentUser;
    if(user != null)
    {
        window.location.href = 'EventCheckIn.html';
    }

}


//Signs out of the users Firebase granted account
function signOut(){
    auth.signOut();
    alert("Signed Out");
}


function createClub(){
    let user = firebase.auth().currentUser;
    let clubName = document.getElementById("New-Club-Name");
    let description = document.getElementById("New-Club-Description");
    let ID = clubsCollection.add({
        club_name: clubName.value,
        description: description.value
    }).then(user => {
        window.location.href = 'ClubPage.html';
    });
}

//This checks to see if the users login state has changed, or if there is a user at all NONSTOP IT LOOPS, this is from firebase
auth.onAuthStateChanged(function(user){

    user = firebase.auth().currentUser;//This saves the users information so you can switch html files and still have that info.
    let email = user.email;




    if(user){

//User Is signed in
        let user = firebase.auth().currentUser;
        email = user.email; //creates a variable to store the users email. This can be done similarly with any of the users info, in this loop.
        //document.getElementById("welcome").innerHTML = "Welcome User : " + email;

    }else{
        //no user is signed in
        alert("No Active User");

    }

});

function createEvent() {
    const eventsCollection = database.collection('clubs').doc(localStorage['club_id']).collection("Events");
    console.log(eventsCollection)
    let eventName = document.getElementById("New-Event-Name");
    let description = document.getElementById("New-Event-Description");
    let date = document.getElementById("meeting-time");
    let dates = date.value.split("T");
    let time = dates[1];
    let day = dates[0];
    eventsCollection.add({
        event_name: eventName.value,
        description: description.value,
        date: day,
        start_time: time
    }).then(user => {
        window.location.href = 'ManageClub.html';
    });

}

function getClubByName(name) {
    clubsCollection.where("club_name", "==", name).get().then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            localStorage['club_id'] = doc.id;
        });
    })
}

function addClickListeners(){
    let clubs = document.getElementsByClassName("manageButton");
    if (clubs.length > 0){
        for (let i = 0 ; i < clubs.length ; i++){
            if (clubs[i].innerHTML == 'Manage'){
                clubs[i].addEventListener("click", function(){
                    localStorage['current_club'] = clubs[i].parentElement.parentElement.firstElementChild.innerHTML;
                    window.location.href = "ManageClub.html";
                })
            }
            else{
                clubs[i].addEventListener("click", function(){
                    localStorage['current_club'] = clubs[i].parentElement.parentElement.firstElementChild.innerHTML;
                    window.location.href = "ClubRegistration.html";
                })
            }
        }
    }

    let new_club_button = document.getElementById("addBtn");
    if (new_club_button){
        new_club_button.addEventListener('click', function () {
            createClub();
        })
    }
    let new_event_button = document.getElementById("event-btn");
    if (new_event_button){
        new_event_button.addEventListener('click', function () {
            createEvent();
        })
    }
}

function addJoinListeners(){
    let joinButtons = document.getElementsByClassName("joinButton");
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
  let  new_event_search = document.getElementById("event-search-name");
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
            let name = doc.data().club_name;
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
    let today = new Date();
    let dd = String(today.getDate()).padStart(2, '0');
    let mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    let yyyy = today.getFullYear();
    today = yyyy + '-' + mm + '-' + dd;
    let current_table = document.getElementById("current-event-table");
    if (current_table){
        let upcoming_table = document.getElementById("upcoming-event-body");
        clubsCollection.get().then(function(querySnapshot) {
            querySnapshot.forEach(function (doc) {
                let current_club_name = doc.data().club_name;
                const eventsCollection = doc.ref.collection("Events");
                eventsCollection.get().then(function(querySnapshot) {
                    querySnapshot.forEach(function (doc) {
                        let name = doc.data().event_name;
                        console.log(name)
                        let desc = doc.data().description;
                        console.log(desc)
                        let time = doc.data().start_time;
                        let date = doc.data().date;
                        console.log(date)
                        console.log(today)
                        //Year, Month, Date
                        if(today == date){
                            let rowc = current_table.insertRow(0);
                            let cell0 = rowc.insertCell(0);
                            let cell1 = rowc.insertCell(1);
                            let cell2 = rowc.insertCell(2);
                            let cell3 = rowc.insertCell(3);
                            let cell4 = rowc.insertCell(4);
                            let cell5 = rowc.insertCell(5);
                            cell0.innerHTML = current_club_name;
                            cell1.innerHTML = name;
                            cell2.innerHTML = desc;
                            cell3.innerHTML = date;
                            cell4.innerHTML = time;
                            cell5.innerHTML =  "<a href='#'  class='checkInButton'>Check In</a>";
                            addCheckInListeners();
                        }
                        else{
                            let rowu = upcoming_table.insertRow(0);
                            let cell5 = rowu.insertCell(0)
                            let cell6 = rowu.insertCell(1);
                            let cell7 = rowu.insertCell(2);
                            let cell8 = rowu.insertCell(3);
                            let cell9 = rowu.insertCell(4);
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
}

function displayEvent(name, desc, start, date){
    let event_table = document.getElementById("event-search-table");
    let row = event_table.insertRow(0);
    let cell1 = row.insertCell(0);
    let cell2 = row.insertCell(1);
    let cell3 = row.insertCell(2);
    let cell4 = row.insertCell(3);

    cell1.innerHTML = name;
    cell2.innerHTML = desc;
    cell3.innerHTML = date;
    cell4.innerHTML = start;
}

async function clearEventTable() {
    let event_table = document.getElementById("event-search-table");
    event_table.innerHTML = "";
    console.log("cleared")
    return "resolved";
}
//Displays the club in profile
function displayClubSearch(name, descrip)
{
    let table = document.getElementById("tableBody");
    let row = table.insertRow(0);
    let cell1 = row.insertCell(0);
    let cell2 = row.insertCell(1);
    let cell3 = row.insertCell(2);
    cell1.innerHTML = name;
    cell2.innerHTML = descrip;
    cell3.innerHTML = "<a href='#'  class='joinButton'>Join</a>";
    addJoinListeners();
}

function displayMyClub(name, descrip)
{
    let table = document.getElementById("my-club-table");
    let row = table.insertRow(0);
    let cell1 = row.insertCell(0);
    let cell2 = row.insertCell(1);
    cell1.innerHTML = name;
    cell2.innerHTML = descrip;
}

function checkIntoEventByName(club_name, event_name,user) {
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
    let checkInButtons = document.getElementsByClassName("checkInButton");
    if (checkInButtons.length > 0){
        for (let i = 0 ; i < checkInButtons.length ; i++){
            checkInButtons[i].addEventListener("click", function(){
                let user = firebase.auth().currentUser;
                let club_name = checkInButtons[i].parentElement.parentElement.firstElementChild.innerHTML;
                let event_name = checkInButtons[i].parentElement.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.innerHTML;
                checkIntoEventByName(club_name,event_name, user.email);
                checkInButtons[i].setAttribute('style', 'background-color: navy;');
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
                    let name = doc.data().event_name;
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

    let my_clubs = document.getElementById("my-club-table");
    if (my_clubs) {

        clubsCollection.get().then(function (querySnapshot) {
            querySnapshot.forEach(function (doc) {
                let name = doc.data().club_name;
                let desc = doc.data().description;

                let rowm = my_clubs.insertRow(0);
                let cell1 = rowm.insertCell(0);
                let cell2 = rowm.insertCell(1);
                let cell3 = rowm.insertCell(2);


                cell1.innerHTML = name;
                cell2.innerHTML = desc;
                cell3.innerHTML =  "<a href='#'  class='manageButton'>Manage</a>";
                addClickListeners();
            });


        })
    }
}

function club_event_table(){
    let today = new Date();
    let dd = String(today.getDate()).padStart(2, '0');
    let mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    let yyyy = today.getFullYear();
    let td_day = today.getDate();
    let td_month = today.getMonth() + 1;
    let td_year  = parseInt(today.getFullYear());
    today = yyyy + '-' + mm + '-' + dd;
    let future_table = document.getElementById("future-event-body");
    if (future_table){
        clubsCollection.where("club_name","==",localStorage['current_club']).get().then(function(querySnapshot) {
            querySnapshot.forEach(function (doc) {
                let current_club_name = doc.data().club_name;
                const eventsCollection = doc.ref.collection("Events");
                eventsCollection.get().then(function(querySnapshot) {
                    querySnapshot.forEach(function (doc) {
                        let name = doc.data().event_name;
                        let desc = doc.data().description;
                        let time = doc.data().start_time;
                        let date = doc.data().date;
                        let ev_date = date.split("-");
                        let ev_day = ev_date[2];
                        let ev_month = ev_date[1];
                        let ev_year = ev_date[0];
                        if (ev_year)
                        console.log(today)
                        //Year, Month, Date
                        if(ev_year < td_year){
                            addEventRowPast(name,desc,date,time);
                        }
                        else if (ev_month < td_month){
                            addEventRowPast(name,desc,date,time);
                        }
                        else if (ev_day < td_day){
                            addEventRowPast(name,desc,date,time);
                        }
                        else {
                            addEventRowFuture(name,desc,date,time);
                        }

                    });
                })
            });
        })
    }
}

function addEventRowPast(name,desc,date,time){
    let past_table = document.getElementById("past-event-body");
    let rowc = past_table.insertRow(0);
    let cell0 = rowc.insertCell(0);
    let cell1 = rowc.insertCell(1);
    let cell2 = rowc.insertCell(2);
    let cell3 = rowc.insertCell(3);
    cell0.innerHTML = name;
    cell1.innerHTML = desc;
    cell2.innerHTML = date;
    cell3.innerHTML = time;
}

function addEventRowFuture(name,desc,date,time) {
    let future_table = document.getElementById("future-event-body");
    let rowc = future_table.insertRow(0);
    let cell0 = rowc.insertCell(0);
    let cell1 = rowc.insertCell(1);
    let cell2 = rowc.insertCell(2);
    let cell3 = rowc.insertCell(3);
    cell0.innerHTML = name;
    cell1.innerHTML = desc;
    cell2.innerHTML = date;
    cell3.innerHTML = time;
}