const userId = document.getElementById('userId');
const firstName = document.getElementById('firstName');
const lastName = document.getElementById('lastName');
const age = document.getElementById('age');
const addBtn = document.getElementById('addBtn');
const updateBtn = document.getElementById('updateBtn');
const readBtn = document.getElementById('readBtn');
const removeBtn = document.getElementById('removeBtn');

const database = firebase.firestore();

const usersCollection = database.collection('users');

// hardcoded tag
/**
addBtn.addEventListener('click', e => {
  e.preventDefault();
  const ID = usersCollection.doc('user01').set({
    first_name: firstName.value,
    last_name: lastName.value,
    age: Number(age.value)
  })
  .then(()=>{
    console.log('Data has been saved successfully !')})
  .catch(error => {
    console.error(error)
  });
});
*/

//Creates fields which dont exist
/**
addBtn.addEventListener('click', e => {
  e.preventDefault();
  const ID = usersCollection.doc().set({
    first_name: firstName.value,
    last_name: lastName.value,
    age: Number(age.value)
  }, {merge: true});
});
*/
//
addBtn.addEventListener('click', e => {
  e.preventDefault();
  const ID = usersCollection.add({
    first_name: firstName.value,
    last_name: lastName.value,
    age: Number(age.value)
  });
});

// basic supdate doc
updateBtn.addEventListener('click', e => {
  e.preventDefault();
  usersCollection.doc(userId.value).update({
    first_name: firstName.value,
    last_name: lastName.value,
    age: Number(age.value)
  });
});
/**
// updating objects
updateBtn.addEventListener('click', e => {
  e.preventDefault();
  usersCollection.doc(userId.value).update({
    'favorite.food': 'Pizza'
  });
});
*/

// deleting a field is considered an update
/** 
updateBtn.addEventListener('click', e => {
  e.preventDefault();
  usersCollection.doc(userId.value).update({
    favorites: firebase.firestore.FieldValue.delete()
  });
});
*/
readBtn.addEventListener('click', e => {
    e.preventDefault();
    usersCollection.doc(userId.value).get()
    .then(user => {
      if(user.exists)
        console.log(user.data());
      else
        console.log('User does not exist !');
      })
    .catch(error => {
      console.error(error);
    });
  });