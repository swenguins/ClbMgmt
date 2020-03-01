// Designate reference to collection for input fields. This SHOULD allow a new document
// to be created for each new user entry with an auto-assigned ID in Firebase.
const colRef  = db.collection("users");

// Create a js reference to allow a function on Submit button selection.
const submitButton = document.querySelector("#submit");

// js references to input fields on the create page.
const fnameField = document.querySelector("#fname");
const lnameField = document.querySelector("#lname");
const emailField = document.querySelector("#email");
const pwField    = document.querySelector("#password");

// TODO: ADD VERIFICATION ALL FIELDS HAVE BEEN FILLED IN.
submitButton.addEventListener("click", function() {
    const fnameSave = fnameField.value;
    const lnameSave = lnameField.value;
    const emailSave = emailField.value;
    const pwSave    = pwField.value;
    console.log("Saving " + fnameSave + ", " + lnameSave + ", " + emailSave + ", " + pwSave + " to Firebase.");
    colRef.set({
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