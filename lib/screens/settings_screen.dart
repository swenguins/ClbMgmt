//make profile settings screen
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class SettingsScreen extends StatefulWidget {
  //static const String id = 'profile_screen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
 Widget build(BuildContext context) { //Content of the screen
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings",style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ //Placeholder ListTiles ==== NON-FUNCTIONAL, JUST FOR SHOW FOR DEMO
            new ListTile(
              leading: const Icon(Icons.people, size: 24),
              title: const Text('Account Settings',style: TextStyle(fontSize: 24.0)),
            ),
            new ListTile(
              leading: const Icon(Icons.notifications, size: 24),
              title: const Text('Notifications Settings',style: TextStyle(fontSize: 24.0)),
            ),
            new ListTile(
              leading: const Icon(Icons.lock, size: 24),
              title: const Text('Privacy Settings',style: TextStyle(fontSize: 24.0)),
            ),
            new ListTile(
              leading: const Icon(Icons.security, size: 24),
              title: const Text('Security Settings',style: TextStyle(fontSize: 24.0)),
            ),
            new ListTile(
              leading: const Icon(Icons.info, size: 24),
              title: const Text('About',style: TextStyle(fontSize: 24.0)),
            ),

            new Flexible(
              child: Opacity(
                opacity: 0.3,
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/igloo_logo.png'),
                    ),
                )
              ),
            )
          ],
          ),
      )
    );
  }
}