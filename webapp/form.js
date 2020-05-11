//Script Written by Noah Doyle + Kevin Bullock
// Your web app's Firebase configuration

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

//This checks to see if the users login state has changed, or if there is a user at all NONSTOP IT LOOPS, this is from firebase
auth.onAuthStateChanged(function(user){
    if(user){
        //creates a variable to store the users email. This can be done similarly with any of the users info, in this loop
    }else{
        //no user is signed in
    }
});


window.addEventListener("load", function () {
    addClickListeners();
    addInputListeners();
    addChangeListeners();
    populate_current_event_table();
    populate_events_attended_table();
    populate_owned_clubs_table();
    populate_membership_table();
    addCheckInListeners();
    club_event_table();
    getUserProfilePic();
    getClubInfo();
    getUsername();
    getClubProfilePic();
    getClubName();
})

//Function for creating an account
function signUp(){
    let email = document.getElementById("sign-up-email");
    let password = document.getElementById("sign-up-password");
    const promise = auth.createUserWithEmailAndPassword(email.value, password.value);
    promise.catch(e => alert(e.message));
    //alert("Signed Up");
    promise.then(user => {
        window.location.href = 'SignIn.html';
    });
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
    }).then(data => {
        console.log("here")
        clubsCollection.where("club_name", "==", clubName.value).get().then(function (querySnapshot) {
            querySnapshot.forEach(function (doc) {
                console.log("heree")
                console.log(doc.data())
                doc.ref.collection("users").doc(user.uid).set({
                    admin: true
                })
            })
        })
    }).then(data => {
        //window.location.href = 'ClubPage.html';
    });
}

function createEvent() {
    const eventsCollection = database.collection('clubs').doc(localStorage['club_id']).collection("Events");
    console.log(eventsCollection)
    let eventName = document.getElementById("New-Event-Name");
    let description = document.getElementById("New-Event-Description");
    let date = document.getElementById("meeting-date");
    let start_time = document.getElementById("meeting-start-time");
    let end_time = document.getElementById("meeting-end-time");
    let max_attendees = document.getElementById("max-attendance");
    let expected_attendees = document.getElementById("expected-attendance");
    let event_number = 0;
    clubsCollection.where("club_name", "==", localStorage['current_club']).get().then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            doc.ref.collection("Events").get().then(function (querySnapshot) {
                event_number = querySnapshot.size;
            }).then(function () {
                eventsCollection.add({
                    event_name: eventName.value,
                    description: description.value,
                    date: date.value,
                    start_time: start_time.value,
                    end_time: end_time.value,
                    max_attendees: max_attendees.value,
                    expected_attendees: expected_attendees.value,
                    event_number : event_number
                }).then(user => {
                    window.location.href = 'ManageClub.html';
                });
            })
        });
    })
}

async function getClubByName(name) {
    await clubsCollection.where("club_name", "==", name).get().then(async function(querySnapshot) {
        querySnapshot.forEach(await async function(doc) {
            localStorage['club_id'] = doc.id;
            console.log("changed club_id")
        });
    });
    return Promise.resolve();
}

function addClickListeners(){
    let clubs = document.getElementsByClassName("manageButton");
    if (clubs.length > 0){
        for (let i = 0 ; i < clubs.length ; i++){
            if (clubs[i].innerHTML == 'Manage'){
                clubs[i].addEventListener("click", async function(){
                    console.log(localStorage['club_id'])
                    localStorage['current_club'] = clubs[i].parentElement.parentElement.firstElementChild.innerHTML;
                    await getClubByName(clubs[i].parentElement.parentElement.firstElementChild.innerHTML);
                    window.location.href = "ManageClub.html";
                    console.log(localStorage['club_id'])
                })
            }
            else{
                clubs[i].addEventListener("click", async function(){
                    console.log(localStorage['club_id'])
                    console.log(localStorage['current_club'])
                    localStorage['current_club'] = clubs[i].parentElement.parentElement.firstElementChild.innerHTML;
                    await getClubByName(clubs[i].parentElement.parentElement.firstElementChild.innerHTML);
                    console.log(localStorage['club_id'])
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

    let sign_up_button = document.getElementById("sign-up-button");
    if (sign_up_button){
        sign_up_button.addEventListener('click', function () {
            signUp();
        })
    }

    let update_club_info_button = document.getElementById("edit-club-info-button");
    if (update_club_info_button){
        update_club_info_button.addEventListener('click',function () {
            updateClubInfo();
        })
    }
    let leave_club_button = document.getElementById("leave-club");
    if (leave_club_button){
        leave_club_button.addEventListener('click', function () {
            leaveClub();
        })
    }

}

function addJoinListeners(){
    let joinButtons = document.getElementsByClassName("joinButton");
    if (joinButtons.length > 0){
        for (let i = 0 ; i < joinButtons.length ; i++){
            joinButtons[i].addEventListener("click", async function(){
                let name = joinButtons[i].parentElement.parentElement.firstElementChild.innerHTML;
                let desc = joinButtons[i].parentElement.previousElementSibling.innerHTML;
                displayMyClub(name,desc);
                await getClubByName(name);
                const usersCollection = database.collection('clubs').doc(localStorage['club_id']).collection("users");
                let user = firebase.auth().currentUser;
                usersCollection.doc(user.uid).set({
                    admin: false
                })
                joinButtons[i].parentElement.parentElement.innerHTML = "";
            })
        }
    }
}

function addInputListeners(){
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
        new_event_search.addEventListener('input', async function () {
            await clearEventTable();
            if (new_event_search.value != "") {
                searchEvent(new_event_search.value);
            }
        })
    }
}

function addChangeListeners() {
    let upload_profile_pic_button = document.getElementById("profile_img");
    if (upload_profile_pic_button){
        upload_profile_pic_button.addEventListener("change", function(e){
            let preview = document.getElementById("account-pic");
            console.log()
            let file = e.target.files[0];
            preview.src = URL.createObjectURL(file);
            let storageRef = firebase.storage().ref('user-profile-image/'+firebase.auth().currentUser.uid);
            storageRef.delete().then(function () {
                storageRef.put(file);
            }).catch(function(error) {
                storageRef.put(file);
            });
        })
    }

    let upload_event_pic_button = document.getElementById("event_img");
    if (upload_event_pic_button){
        upload_event_pic_button.addEventListener("change", function(e){
            let preview = document.getElementById("event_img_preview");
            let event_number = 0;
            clubsCollection.where("club_name", "==", localStorage['current_club']).get().then(function(querySnapshot) {
                querySnapshot.forEach(function(doc) {
                    doc.ref.collection("Events").get().then(function (querySnapshot) {
                        event_number = querySnapshot.size;
                        console.log(event_number)
                    }).then(function () {
                        let file = e.target.files[0];
                        preview.src = URL.createObjectURL(file);
                        let storageRef = firebase.storage().ref('event-image/'+localStorage['club_id']+'/'+String(event_number));
                        storageRef.delete().then(function () {
                            storageRef.put(file);
                        }).catch(function(error) {
                            storageRef.put(file);
                        });
                })
                });
            })

        })
    }

    let upload_club_pic_button = document.getElementById("club_img");
    if (upload_club_pic_button){
        upload_club_pic_button.addEventListener("change", function(e){
            let preview = document.getElementById("club-pic");
            let file = e.target.files[0];
            preview.src = URL.createObjectURL(file);
            let storageRef = firebase.storage().ref('club-profile-image/'+localStorage['club_id']);
            storageRef.delete().then(function () {
                storageRef.put(file);
            }).catch(function(error) {
                storageRef.put(file);
            });
        })
    }
}

function searchClub(data){
    auth.onAuthStateChanged(function(user){
        if(user){
            let already_present = false;
            console.log(data)
            clubsCollection.get().then(function(querySnapshot) {
                querySnapshot.forEach(function (doc) {
                    let name = doc.data().club_name;
                    doc.ref.collection('users').doc(user.uid).get().then(function (doc) {
                        if (doc.exists){
                            already_present = true;
                        }
                    }).then(function (x) {
                        if (!already_present){
                            name = name.toLowerCase();
                            if (name.includes(data)) {
                                displayClubSearch(doc.data().club_name,doc.data().description);
                            }
                        }
                    })
                });
            })
        }else{
            //no user is signed in
            alert("No Active User");
        }
    });

}

function searchEvent(data){
    auth.onAuthStateChanged(function(user){
        if(user){
            let member = false;
            clubsCollection.get().then(function(querySnapshot) {
                querySnapshot.forEach(function (doc) {
                    doc.ref.collection("users").doc(user.uid).get().then(function (data) {
                        if (data.exists){
                            member = true;
                        }
                    }).then(function (data) {
                        if(!member){
                            let eventsCollection = database.collection('clubs').doc(doc.id).collection("Events");
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
                        }
                    })
                });
            })
        }else{
            //no user is signed in
            alert("No Active User");
        }
    });


}

function populate_current_event_table(){
    auth.onAuthStateChanged(function(user){
        if(user){
            let current_table = document.getElementById("current-event-table");
            if (current_table){
                let today = new Date();
                let dd = String(today.getDate()).padStart(2, '0');
                let mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
                let yyyy = today.getFullYear();
                let hrs = today.getHours();
                let minutes = today.getMinutes();
                clubsCollection.get().then(function(querySnapshot) {
                    querySnapshot.forEach(function (doc) {
                        let im_a_member = false;
                        doc.ref.collection("users").doc(user.uid).get().then(function (data) {
                            if (data.exists){
                                im_a_member = true;
                            }
                        }).then(function (data) {
                            let current_club_name = doc.data().club_name;
                            const eventsCollection = doc.ref.collection("Events");
                            eventsCollection.get().then(function(querySnapshot) {
                                querySnapshot.forEach(function (doc) {
                                    let checkedIn = false;
                                    doc.ref.collection("checkedIn").doc(user.uid).get().then(function (data) {
                                        if (data.exists){
                                            checkedIn = true;
                                        }
                                    }).then(function (data) {
                                        let name = doc.data().event_name;
                                        let desc = doc.data().description;
                                        let start_time = doc.data().start_time;
                                        let end_time = doc.data().end_time;
                                        let date = doc.data().date;
                                        let ev_date = date.split("-");
                                        let ev_day = ev_date[2];
                                        let ev_month = ev_date[1];
                                        let ev_year = ev_date[0];
                                        let ev_time = start_time.split(":");
                                        let ev_hour = ev_time[0];
                                        let ev_minute = ev_time[1];
                                        let ev_end_time = end_time.split(":");
                                        console.log(ev_end_time);
                                        console.log(hrs)
                                        console.log(minutes)
                                        let ev_end_hour = ev_end_time[0];
                                        let ev_end_min = ev_end_time[1];
                                        if (im_a_member) {
                                            if (ev_year > yyyy){
                                                addToUpcomingTable(current_club_name,name,desc,date,start_time);
                                            }
                                            else if (ev_year == yyyy && ev_month > mm){
                                                addToUpcomingTable(current_club_name,name,desc,date,start_time);
                                            }
                                            else if (ev_year == yyyy && ev_month == mm && ev_day > dd){
                                                addToUpcomingTable(current_club_name,name,desc,date,start_time);
                                            }
                                            else if (ev_year == yyyy && ev_month == mm && ev_day == dd && ev_hour > hrs){
                                                addToUpcomingTable(current_club_name,name,desc,date,start_time);
                                            }
                                            else if (ev_year == yyyy && ev_month == mm && ev_day == dd && ev_hour == hrs && ev_minute > minutes){
                                                addToUpcomingTable(current_club_name,name,desc,date,start_time);
                                            }
                                            else if (ev_year == yyyy && ev_month == mm && ev_day == dd && hrs < ev_end_hour){
                                                addToCurrentTable(current_club_name,name,desc,date,start_time, checkedIn);
                                            }
                                            else if (ev_year == yyyy && ev_month == mm && ev_day == dd && ev_end_hour == hrs && minutes < ev_end_min){
                                                addToCurrentTable(current_club_name,name,desc,date,start_time, checkedIn);
                                            }
                                        }
                                    })
                                });
                            })
                        })

                    });
                })
            }
        }else{
            //no user is signed in
            alert("No Active User");
        }
    });

}

function addToUpcomingTable(current_club_name,name,desc,date,time){
    let upcoming_table = document.getElementById("upcoming-event-body");
    let row = upcoming_table.insertRow(0);
    let cell5 = row.insertCell(0)
    let cell6 = row.insertCell(1);
    let cell7 = row.insertCell(2);
    let cell8 = row.insertCell(3);
    let cell9 = row.insertCell(4);
    cell5.innerHTML = current_club_name;
    cell6.innerHTML = name;
    cell7.innerHTML = desc;
    cell8.innerHTML = date;
    cell9.innerHTML = time;
}

function addToCurrentTable(current_club_name,name,desc,date,time,checkedIn) {
    let current_table = document.getElementById("current-event-table");
    let row = current_table.insertRow(0);
    let cell0 = row.insertCell(0);
    let cell1 = row.insertCell(1);
    let cell2 = row.insertCell(2);
    let cell3 = row.insertCell(3);
    let cell4 = row.insertCell(4);
    let cell5 = row.insertCell(5);
    cell0.innerHTML = current_club_name;
    cell1.innerHTML = name;
    cell2.innerHTML = desc;
    cell3.innerHTML = date;
    cell4.innerHTML = time;
    if (checkedIn){
        cell5.innerHTML =  "<a href='#' checkedin='true' class='checkInButton'>Checked In</a>";
    }
    else{
        cell5.innerHTML =  "<a href='#'  class='checkInButton'>Check In</a>";
    }

    addCheckInListeners();
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
    let cell3 = row.insertCell(2);
    cell1.innerHTML = name;
    cell2.innerHTML = descrip;
    cell3.innerHTML = "<a href='#'  class='manageButton'>Go To Club Page</a>";
    addClickListeners();
}

function checkIntoEventByName(club_name, event_name) {
    auth.onAuthStateChanged(function(user){
        if(user){
            clubsCollection.where("club_name","==",club_name).get().then(function(querySnapshot) {
                querySnapshot.forEach(function (doc) {
                    const eventsCollection = doc.ref.collection("Events");
                    eventsCollection.where("event_name", "==", event_name).get().then(function(querySnapshot) {
                        querySnapshot.forEach(function (doc) {
                            let today = new Date();
                            let date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
                            let time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                            let dateTime = date+' '+time;
                            doc.ref.collection('checkedIn').doc(user.uid).set({
                                time: dateTime
                            })
                        });
                    })
                });
            })
        }else{
            //no user is signed in
            alert("No Active User");
        }
    });
}

function addCheckInListeners(){
    let checkInButtons = document.getElementsByClassName("checkInButton");
    if (checkInButtons.length > 0){
        for (let i = 0 ; i < checkInButtons.length ; i++){
            checkInButtons[i].addEventListener("click", function(){
                let user = firebase.auth().currentUser;
                let club_name = checkInButtons[i].parentElement.parentElement.firstElementChild.innerHTML;
                let event_name = checkInButtons[i].parentElement.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.innerHTML;
                checkIntoEventByName(club_name,event_name);
                checkInButtons[i].setAttribute('checkedIn', "true");
                checkInButtons[i].innerHTML = "Checked In";
                checkInButtons[i].removeEventListener("click",this);
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
    auth.onAuthStateChanged(function(user){
        if(user){
            let record_exists = false;
            let isAdmin = false;
            let owned_clubs = document.getElementById("owned-club-table");
            if (owned_clubs) {

                clubsCollection.get().then(function (querySnapshot) {
                    querySnapshot.forEach(function (doc) {
                        doc.ref.collection("users").doc(user.uid).get().then(function (doc) {
                            if (doc.exists){
                                record_exists = true;
                                isAdmin = doc.data().admin;
                            }
                            console.log(isAdmin)
                        }).then(function(data){
                            console.log(isAdmin)
                            if (isAdmin && record_exists){
                                let name = doc.data().club_name;
                                let desc = doc.data().description;

                                let row = owned_clubs.insertRow(0);
                                let cell1 = row.insertCell(0);
                                let cell2 = row.insertCell(1);
                                let cell3 = row.insertCell(2);


                                cell1.innerHTML = name;
                                cell2.innerHTML = desc;
                                cell3.innerHTML =  "<a href='#'  class='manageButton'>Manage</a>";
                            }
                        }).then(function (data) {
                            addClickListeners();
                        });
                    })
                })

            }
        }else{
            //no user is signed in
            alert("No Active User");
        }
    });

}

function populate_membership_table() { //and your joined clubs
    auth.onAuthStateChanged(function(user){
        if(user){
            let record_exists = false;
            let my_clubs = document.getElementById("my-club-table");
            if (my_clubs) {
                let isAdmin = false;
                clubsCollection.get().then(function (querySnapshot) {
                    querySnapshot.forEach(function (doc) {
                        doc.ref.collection("users").doc(user.uid).get().then(function (data) {
                            if (data.exists){
                                record_exists = true;
                                isAdmin = data.data().admin;
                            }
                        }).then(function (data) {
                            if (!isAdmin && record_exists){
                                let name = doc.data().club_name;
                                let desc = doc.data().description;

                                let row = my_clubs.insertRow(0);
                                let cell1 = row.insertCell(0);
                                let cell2 = row.insertCell(1);
                                let cell3 = row.insertCell(2);


                                cell1.innerHTML = name;
                                cell2.innerHTML = desc;
                                cell3.innerHTML =  "<a href='#'  class='manageButton'>Go To Club Page</a>";
                            }
                        }).then(function (data) {
                            addClickListeners();
                        })
                    });


                })
            }
        }else{
            //no user is signed in
            alert("No Active User");
        }
    });
}

function club_event_table(){
    let today = new Date();
    let dd = String(today.getDate()).padStart(2, '0');
    let mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    let yyyy = today.getFullYear();
    let hrs = today.getHours();
    let minutes = today.getMinutes();
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
                        let expected_attendees = doc.data().expected_attendees;
                        let turnout = 0;
                        doc.ref.collection("checkedIn").get().then(function (data) {
                            turnout = data.size;
                        }).then(function (data) {
                            let ev_date = date.split("-");
                            let ev_day = ev_date[2];
                            let ev_month = ev_date[1];
                            let ev_year = ev_date[0];
                            let ev_time = time.split(":");
                            let ev_hour = ev_time[0];
                            let ev_minute = ev_time[1];
                            if (ev_year > yyyy) {
                                addEventRowFuture(name, desc, date, time);
                            } else if (ev_year == yyyy && ev_month > mm) {
                                addEventRowFuture(name, desc, date, time);
                            } else if (ev_year == yyyy && ev_month == mm && ev_day > dd) {
                                addEventRowFuture(name, desc, date, time);
                            } else if (ev_year == yyyy && ev_month == mm && ev_day == dd && ev_hour > hrs) {
                                addEventRowFuture(name, desc, date, time);
                            } else if (ev_year == yyyy && ev_month == mm && ev_day == dd && ev_hour == hrs && ev_minute > minutes) {
                                addEventRowFuture(name, desc, date, time);
                            } else if (ev_year == yyyy && ev_month == mm && ev_day == dd && hrs > ev_hour) {
                                addEventRowPast(name, desc, date, expected_attendees, turnout);
                            } else if (ev_year == yyyy && ev_month == mm && ev_day == dd && ev_hour == hrs && minutes > ev_minute) {
                                addEventRowPast(name, desc, date, expected_attendees, turnout);
                            }
                            else{
                                addEventRowPast(name, desc, date, expected_attendees, turnout);
                            }
                        });
                    })
                })
            });
        })
    }
}

function addEventRowPast(name,desc,date,expected, actual){
    let past_table = document.getElementById("past-event-body");
    let row = past_table.insertRow(0);
    let cell0 = row.insertCell(0);
    let cell1 = row.insertCell(1);
    let cell2 = row.insertCell(2);
    let cell3 = row.insertCell(3);
    let cell4 = row.insertCell(4);
    cell0.innerHTML = name;
    cell1.innerHTML = desc;
    cell2.innerHTML = date;
    cell3.innerHTML = expected;
    cell4.innerHTML = actual;
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

function populate_events_attended_table(){
    auth.onAuthStateChanged(function(user){
        if(user){
            let attended_table = document.getElementById("attended-events-table");
            if (attended_table){
                clubsCollection.get().then(function(querySnapshot) {
                    querySnapshot.forEach(function (doc) {
                        let current_club_name = doc.data().club_name;
                        const eventsCollection = doc.ref.collection("Events");
                        eventsCollection.get().then(function(querySnapshot) {
                            querySnapshot.forEach(function (doc) {
                                let attended = false;
                                let checkedInTime = "";
                                let name = doc.data().event_name;
                                let desc = doc.data().description;
                                doc.ref.collection("checkedIn").doc(user.uid).get().then(function (data) {
                                    if (data.exists){
                                        attended = true;
                                        checkedInTime = data.data().time;
                                    }
                                }).then(function (data) {
                                    if (attended){
                                        let row = attended_table.insertRow(0);
                                        let cell0 = row.insertCell(0);
                                        let cell1 = row.insertCell(1);
                                        let cell2 = row.insertCell(2);
                                        let cell3 = row.insertCell(3);
                                        cell0.innerHTML = current_club_name;
                                        cell1.innerHTML = name;
                                        cell2.innerHTML = desc;
                                        cell3.innerHTML = checkedInTime;
                                    }
                                });
                            })
                        })
                    });
                })
            }
        }else{
            //no user is signed in
            alert("No Active User");
        }
    });
}

function getUserProfilePic(){
    let pic  = document.getElementById("account-pic");
    if (pic){
        firebase.auth().onAuthStateChanged(function(user) {
            if (user) {
                let storageRef = firebase.storage().ref().child("user-profile-image/"+user.uid);

                storageRef.getDownloadURL().then(function(url) {
                    pic.src = url;
                }).catch(function(error) {

                });
            } else {
                // No user is signed in.
            }
        });

    }
}

function getClubInfo() {
    let club_name = document.getElementById("club-name-edit");
    if (club_name){
        club_name.setAttribute("value", localStorage['current_club']);
        let club_desc = document.getElementById("club-description-edit");
        clubsCollection.where("club_name", "==", localStorage['current_club']).get().then(function(querySnapshot) {
            querySnapshot.forEach(function(doc) {
                club_desc.setAttribute("value", doc.data().description);
            });
        })
    }

}

function updateClubInfo() {
    let club_name = document.getElementById("club-name-edit");
    let club_desc = document.getElementById("club-description-edit");
    clubsCollection.where("club_name", "==", localStorage['current_club']).get().then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            doc.ref.update({
                club_name: club_name.value,
                description:club_desc.value
            }).then(function() {
                console.log("Document successfully updated!");
            }).catch(function(error) {
                    // The document probably doesn't exist.
                    console.error("Error updating document: ", error);
                });
        });
    })
}

function getClubProfilePic(){
    let pic  = document.getElementById("club-pic");
    if (pic){
        firebase.auth().onAuthStateChanged(function(user) {
            if (user) {
                let storageRef = firebase.storage().ref().child("club-profile-image/"+localStorage['club_id']);

                storageRef.getDownloadURL().then(function(url) {
                    console.log("here1")
                    pic.src = url;
                    console.log(url)
                }).catch(function(error) {

                });
            } else {
                // No user is signed in.
            }
        });

    }
}

function getUsername(){
    let username = document.getElementById("user-name");
    if (username){
        firebase.auth().onAuthStateChanged(function(user) {
            if (user) {
                username.innerHTML = "Username";
                document.getElementById("user-email").innerHTML = user.email;
            } else {
                // No user is signed in.
            }
        });
    }
}

function getClubName(){
    let club_name = document.getElementById("club-name");
    if (club_name){
        club_name.innerHTML = localStorage['current_club'];
        let club_desc = document.getElementById("club-description");
        clubsCollection.where("club_name", "==", localStorage['current_club']).get().then(function(querySnapshot) {
            querySnapshot.forEach(function(doc) {
                club_desc.innerHTML = doc.data().description;
            });
        })
    }
}

function club_event_table(){
    let today = new Date();
    let dd = String(today.getDate()).padStart(2, '0');
    let mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    let yyyy = today.getFullYear();
    let hrs = today.getHours();
    let minutes = today.getMinutes();
    let up_coming = document.getElementById("upcoming-events");
    if (up_coming){
        clubsCollection.where("club_name","==",localStorage['current_club']).get().then(function(querySnapshot) {
            querySnapshot.forEach(function (doc) {
                const eventsCollection = doc.ref.collection("Events");
                eventsCollection.get().then(function(querySnapshot) {
                    querySnapshot.forEach(function (doc) {
                        let name = doc.data().event_name;
                        let desc = doc.data().description;
                        let start = doc.data().start_time;
                        let end = doc.data().end_time;
                        let date = doc.data().date;
                        let event_num = doc.data().event_number;
                        let ev_date = date.split("-");
                        let ev_day = ev_date[2];
                        let ev_month = ev_date[1];
                        let ev_year = ev_date[0];
                        let ev_time = start.split(":");
                        let ev_hour = ev_time[0];
                        let ev_minute = ev_time[1];
                        if (ev_year > yyyy) {
                            addEventPreview(name, desc, date, start, end, event_num);
                        } else if (ev_year == yyyy && ev_month > mm) {
                            addEventPreview(name, desc, date, start, end, event_num);
                        } else if (ev_year == yyyy && ev_month == mm && ev_day > dd) {
                            addEventPreview(name, desc, date, start, end, event_num);
                        } else if (ev_year == yyyy && ev_month == mm && ev_day == dd && ev_hour > hrs) {
                            addEventPreview(name, desc, date, start, end, event_num);
                        } else if (ev_year == yyyy && ev_month == mm && ev_day == dd && ev_hour == hrs && ev_minute > minutes) {
                            addEventPreview(name, desc, date, start, end, event_num);
                        }
                    });
                })
            });
        })
    }
}

function addEventPreview(name, desc, date, start, end, event_num){
    console.log(name);
    console.log(desc);
    console.log(date);
    console.log(start);
    console.log(end);
    console.log(event_num);
    let up_coming = document.getElementById("upcoming-events");
    console.log("event-image/"+localStorage['club_id']+"/"+String(event_num));
    let storageRef = firebase.storage().ref().child("event-image/"+localStorage['club_id']+"/"+String(event_num));
    storageRef.getDownloadURL().then(onResolve,onReject);
    function onResolve(url){
        let new_div = document.createElement("div");
        new_div.className = "eventPreviewWithImage";
        let new_img = document.createElement("img");
        new_img.className = "eventPreviewIMG";
        new_img.src = url;
        let second_div = document.createElement("div");
        second_div.className = "eventPreviewText";
        let third_div = document.createElement("div");
        third_div.className = "eventPreviewDate";
        let new_name = document.createElement("div");
        new_name.innerHTML = name;
        new_name.className = "previewTitle";
        let new_desc = document.createElement("div");
        new_desc.innerHTML = desc;
        second_div.append(new_name);
        second_div.append(new_desc);
        let new_date = document.createElement("div");
        new_date.innerHTML = date;
        let new_time = document.createElement("div");
        new_time.innerHTML = start+"-"+end;
        third_div.append(new_date);
        third_div.append(new_time);
        new_div.append(new_img);
        new_div.append(second_div);
        new_div.append(third_div);
        up_coming.append(new_div);
    }
    function onReject(){
        let new_div = document.createElement("div");
        new_div.className = "eventPreviewWithoutImage";
        let second_div = document.createElement("div");
        second_div.className = "eventPreviewText";
        let third_div = document.createElement("div");
        third_div.className = "eventPreviewDate";
        let new_name = document.createElement("div");
        new_name.className = "previewTitle";
        new_name.innerHTML = name;
        let new_desc = document.createElement("div");
        new_desc.innerHTML = desc;
        second_div.append(new_name);
        second_div.append(new_desc);
        let new_date = document.createElement("div");
        new_date.innerHTML = date;
        let new_time = document.createElement("div");
        new_time.innerHTML = start+"-"+end;
        third_div.append(new_date);
        third_div.append(new_time);
        new_div.append(second_div);
        new_div.append(third_div);
        up_coming.append(new_div);
    }
}

function leaveClub() {
    auth.onAuthStateChanged(function(user){
        if(user){
            clubsCollection.doc(localStorage['club_id']).get().then(function (doc) {
                doc.ref.collection("users").doc(user.uid).delete().then(function (data) {
                    window.location.href = "ClubPage.html";
                })
            })
        }else{
            //no user is signed in
        }
    });
}