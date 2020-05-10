const clubId = document.getElementById('clubId');
const clubName = document.getElementById('clubName');
const description = document.getElementById('description');
const num_users = document.getElementById('num_users');
const addBtn = document.getElementById('addBtn');
const updateBtn = document.getElementById('updateBtn');
const readBtn = document.getElementById('readBtn');
const removeBtn = document.getElementById('removeBtn');

const database = firebase.firestore();

const clubsCollection = database.collection('clubs');

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
      const ID = clubsCollection.add({
        club_name: clubName.value,
        description: description.value,
        num_users: Number(num_users.value)
  });
});

// basic supdate doc
updateBtn.addEventListener('click', e => {
  e.preventDefault();
  clubsCollection.doc(clubId.value).update({
    club_name: clubName.value,
    description: description.value,
    num_users: Number(num_users.value)
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
    clubsCollection.doc(clubId.value).get()
    .then(club => {
      if(club.exists)
        console.log(club.data());
      else
        console.log('Club does not exist !');
      })
    .catch(error => {
      console.error(error);
    });
  });