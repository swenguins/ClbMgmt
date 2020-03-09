const clubId = document.getElementById('clubId');
const eventName = document.getElementById('eventName');
const description = document.getElementById('description');
const date = document.getElementById('date');
const time = document.getElementById('time');
const addBtn = document.getElementById('addBtn');
const updateBtn = document.getElementById('updateBtn');
const readBtn = document.getElementById('readBtn');
const removeBtn = document.getElementById('removeBtn');

const database = firebase.firestore();

const eventsCollection = database.collection('clubs').doc("szHiqxe60qojiYzS8j8W").collection("Events");

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
  
  
  const ID = eventsCollection.add({
    event_name: eventName.value,
    description: description.value,
    date: date.value,
    time: time.value
  });
});

// basic supdate doc
updateBtn.addEventListener('click', e => {
  e.preventDefault();
  eventsCollection.doc(eventId.value).update({
    event_name: eventName.value,
    description: description.value,
    date: Number(date.value),
    time: Number(time.value)
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
    eventsCollection.doc(eventId.value).get()
    .then(event => {
      if(event.exists)
        console.log(event.data());
      else
        console.log('Event does not exist !');
      })
    .catch(error => {
      console.error(error);
    });
  });