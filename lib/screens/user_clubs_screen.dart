import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class UserClubsScreen extends StatefulWidget {
  //static const String id = 'profile_screen';
  @override
  _UserClubsScreenState createState() => _UserClubsScreenState();
}

class _UserClubsScreenState extends State<UserClubsScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("My Clubs", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
         ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new ExpansionTile(
              title: const Text("Rowan IEEE Club",style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.computer),
              trailing: Icon(Icons.keyboard_arrow_down),
              children: <Widget>[ 
                //On release, these should be buttons for either the club page, event check-in, etc
                  Column(children: <Widget>[
                    Text("No upcoming events")
                  ]
                )
               
              ],
              
              backgroundColor: Colors.grey,

              ),

              new ExpansionTile(
              title: const Text("Penguins",style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.people),
              trailing: Icon(Icons.keyboard_arrow_down),
              children: <Widget>[ 
                //On release, these should be buttons for either the club page, event check-in, etc
                  Column(children: <Widget>[
                    Text("No upcoming events")
                  ]
                )
               
              ],
              
              backgroundColor: Colors.grey,

              ),
              
              new ExpansionTile(
              title: const Text("Corona Club",style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.error),
              trailing: Icon(Icons.keyboard_arrow_down),
              children: <Widget>[ 
                //On release, these should be buttons for either the club page, event check-in, etc
                  Column(children: <Widget>[
                    Text("No upcoming events")
                  ]
                )
               
              ],
              
              backgroundColor: Colors.grey,

              ),

              
              new ExpansionTile(
              title: const Text("RU Faculty",style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.school),
              trailing: Icon(Icons.keyboard_arrow_down),
              children: <Widget>[ 
                //On release, these should be buttons for either the club page, event check-in, etc
                  Column(children: <Widget>[
                    Text("No upcoming events")
                  ]
                )
               
              ],
              
              backgroundColor: Colors.grey,

              ),

              new ExpansionTile(
              title: const Text("Kevin's Gym",style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.fitness_center),
              trailing: Icon(Icons.keyboard_arrow_down),
              children: <Widget>[ 
                //On release, these should be buttons for either the club page, event check-in, etc
                  Column(children: <Widget>[
                    Text("No upcoming events")
                  ]
                )
               
              ],
              
              backgroundColor: Colors.grey,

              ),


            /*===Debug Init Text===
            Text(
              "You are at the user clubs screen.\n\n" +
              "The purpose of this screen is to display a list of user's clubs.\n\n" +
              "For non-admins, a reccomendtions tab, based on common interests and location.\n" +
              "Could be a useful feature to add as development progresses.\n\n" +
              "A User can navigate to each club's page when tap on a club's card in the list.",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
            ),*/
           ],
        ),
      )
      );
  }
}