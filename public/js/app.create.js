console.log("app.create.js successful load.")

// Designate reference to collection for input fields. This SHOULD allow a new document
// to be created for each new user entry with an auto-assigned ID in Firebase.
var colRef  = db.collection("users");

// Create a js reference to allow a function on Submit button selection.
var submitButton = document.querySelector("#submit");

// js references to input fields on the create page.
var fnameField = document.querySelector("#fname");
var lnameField = document.querySelector("#lname");
var emailField = document.querySelector("#email");
var pwField    = document.querySelector("#password");

// TODO: ADD VERIFICATION ALL FIELDS HAVE BEEN FILLED IN.
submitButton.addEventListener("click", function() {
    var fnameSave = fnameField.value;
    var lnameSave = lnameField.value;
    var emailSave = emailField.value;
    var pwSave    = pwField.value;
    console.log("Saving " + fnameSave + ", " + lnameSave + ", " + emailSave + ", " + pwSave + " to Firebase.");
    colRef.add({
        fname : fnameSave,
        lname : lnameSave,
        email : emailSave,
        pw    : pwSave
    }).then(function() {
        console.log("Fields saved!");
    }).catch(function (error) {
        console.log("Got an error: " + error);
    });
});