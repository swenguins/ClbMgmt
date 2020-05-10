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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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
          ),
        ],
      ),
    );
  }
}