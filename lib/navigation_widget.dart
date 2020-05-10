import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This navigator widget will navigate to these screens.
import 'package:igloo/screens/profile_screen.dart';
import 'package:igloo/screens/user_clubs_screen.dart';
import 'package:igloo/screens/user_events_screen.dart';
import 'package:igloo/screens/search_screen.dart';
import 'package:igloo/screens/settings_screen.dart';


final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class NavigationWidget extends StatefulWidget {
  static const String id = 'navigation_widget';
  @override
  _NavigationWidget createState() => _NavigationWidget();
}

class _NavigationWidget extends State<NavigationWidget> {
  
  final _auth = FirebaseAuth.instance;
  int _currentIndex = 0;
  
  List<Widget> _pages = [
    ProfileScreen(),
    UserClubsScreen(),
    UserEventsScreen(),
    SearchScreen(),
    SettingsScreen(),
  ];

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
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black54,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
              color: Colors.black54,
            ),
            title: Text(
              'Clubs',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_note,
              color: Colors.black54,
            ),
            title: Text(
              'Events',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black54,
            ),
            title: Text(
              'Find Clubs',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.black54,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}