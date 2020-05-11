// club search screen

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igloo/components/rounded_button.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class SearchScreen extends StatefulWidget {
  //static const String id = 'profile_screen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _auth = FirebaseAuth.instance;
  String search;

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
        title: const Text("Search", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
      ),

      body: new Center(
        child: new Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),

              onChanged: (value) {
                //This will be the value to search the database with
                //This is currently just 'text', so a ClubID, name, or anything else you'd like
                //is a completely valid search query
                search = value.trim();
              }
              
              ),
          
            Container(padding: EdgeInsets.only(
              top: 30.0),
              child: RoundedButton(
                title: "Search for Clubs",
              
                color: Colors.lightBlueAccent,
                onPressed: null, //do nothing, at the moment
                //set Flexible Opacity to 0.0?
              ), 
            ),
            

            Flexible(
              child: Opacity(
                opacity: 0.3,
                child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 300.0,
                      padding: EdgeInsets.only(top: 75.0),
                      child: Image.asset('images/igloo_logo.png')
                    ),
                  ),
                 ),
            )
            
          ],
        )
      ,)
    );
  }
}