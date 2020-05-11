import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igloo/components/rounded_button.dart';
import 'package:igloo/screens/welcome_screen.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(   
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[ 
          
          Icon(Icons.account_circle,size: 250),

          SizedBox(
            width: 200.0,
            child: Text(
              'Welcome, demoUser!\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900,
                    ),
            ),
          ),
          RoundedButton(
            title: 'Log out',
            color: Colors.lightBlueAccent,
            onPressed: () {
              _auth.signOut();
              Navigator.popAndPushNamed(context, WelcomeScreen.id);
            },
          ),
        ],
      ),
    );
  }
}


/// This is older Profile page code that needs heavy refactoring to be implemented
/// in the current Club app with this page routing.

//  User testUser = new User('johnsample@test.com', '1234', 'John', 'Sample',
//  26, 'I\'m a test account for members and admins.');

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/sample_member_profile_bg.jpg'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         key: _scaffoldKey,
//         drawer: ClipRRect(
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(75.0),
//             bottomRight: Radius.circular(75.0),
//           ),
//           child: Drawer(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: <Widget>[
//                 Container(
//                   height: 125.0,
//                   child: DrawerHeader(
//                     decoration: BoxDecoration(
//                       color: Colors.blueAccent,
//                     ),
//                     child: Row( ///Add profile pic view to drawer.
//                       children: <Widget>[
//                         Column(
//                           children: <Widget>[
//                             Text( "John Sample",
//                               //testUser.getFirstName() + " "
//                                   //+ testUser.getLastName(),
//                               overflow: TextOverflow.fade,
//                               style: TextStyle(
//                                 //fontFamily: 'OpenSans',
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             Text(
//                               'test@test.com',
//                               //testUser.getEmail(),
//                               overflow: TextOverflow.fade,
//                               style: TextStyle(
//                                 //fontFamily: 'OpenSans',
//                                 fontSize: 10.0,
//                                 color: Colors.white,
//                               ),
//                             ),

//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0)
//                   ),
//                   elevation: 5.0,
//                   child: ListTile(
//                     title: Text('Search'),
//                     trailing: Icon(Icons.search),
//                   ),
//                 ),
//                 Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0)
//                   ),
//                   elevation: 5.0,
//                   child: ListTile(
//                     title: Text('Account Settings'),
//                     trailing: Icon(Icons.settings),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         body: ListView(
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   IconButton(
//                     icon: Icon(Icons.arrow_back_ios),
//                     color: Colors.white,
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.menu),
//                     color: Colors.white,
//                     onPressed: () {
//                       _scaffoldKey.currentState.openDrawer();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 40.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Text(
//                         "John",
//                         //testUser.getFirstName(),
//                         style: TextStyle(
//                           shadows: <Shadow>[
//                             Shadow(
//                               offset: Offset(3.0, 3.0),
//                               blurRadius: 7.0,
//                               color: Colors.black,
//                             ),
//                           ],
//                           //fontFamily: 'OpenSans',
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontSize: 35.0,
//                         ),
//                       ),
//                       SizedBox(width: 10.0,),
//                       Text(
//                         'Sample',
//                         //testUser.getLastName(),
//                         style: TextStyle(
//                           shadows: <Shadow>[
//                             Shadow(
//                               offset: Offset(3.0, 3.0),
//                               blurRadius: 7.0,
//                               color: Colors.black,
//                             ),
//                           ],
//                           //fontFamily: 'OpenSans',
//                           color: Colors.white,
//                           fontSize: 35.0,
//                         ),
//                       ),
//                       SizedBox(width: 25.0,),
//                       Container(
//                         height: 75.0,
//                         width: 75.0,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             image: DecorationImage(
//                               image: AssetImage('assets/sample_member_profile_pic.jpg'),
//                               fit: BoxFit.cover,
//                             ),
//                             borderRadius: BorderRadius.all(Radius.circular(75.0)),
//                             boxShadow: [BoxShadow(
//                                 offset: Offset(3.0, 3.0),
//                                 blurRadius: 7.0, color:
//                             Colors.black),]
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Text(
//                         'Test user for admins and members',
//                         //testUser.getShortProfileDescription(),
//                         overflow: TextOverflow.fade,
//                         style: TextStyle(
//                           shadows: <Shadow>[Shadow(
//                             offset: Offset(3.0, 3.0),
//                             blurRadius: 7.0,
//                             color: Colors.black,
//                           ),],
//                           //fontFamily: 'OpenSans',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.white,
//                           fontSize: 15.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Container(
//               height: MediaQuery.of(context).size.height - 185.0,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(80.0),
//                     topRight: Radius.circular(80.0),
//                   ),
//                   boxShadow: [BoxShadow(
//                     offset: Offset(3.0, 3.0),
//                     blurRadius: 7.0,
//                     color: Colors.black,
//                   ),]
//               ),
//               child: ListView(
//                 primary: false,
//                 padding: EdgeInsets.only(left: 25.0, right: 20.0),
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(top: 20.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: <Widget>[
//                         FlatButton.icon(
//                           onPressed: () {
//                           },
//                           color: Colors.blueAccent,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(40.0)),
//                           ),
//                           icon: Icon(
//                             Icons.group,
//                             color: Colors.white,
//                           ),
//                           label: Text(
//                             'My Memberships',
//                             style: TextStyle(
//                               //fontFamily: 'OpenSans',
//                               fontSize: 15.0,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         FlatButton.icon(
//                           onPressed: () {
//                             ///Switch between membership list and clubs I run list, hold state color on selectedbutton
//                           },
//                           color: Colors.blueAccent,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(40.0)),
//                           ),
//                           icon: Icon(
//                             Icons.verified_user,
//                             color: Colors.white,
//                           ),
//                           label: Text(
//                             'My Clubs',
//                             style: TextStyle(
//                               //fontFamily: 'OpenSans',
//                               fontSize: 15.0,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 15.0),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height - 300.0,
//                       child: ListView(
//                         children: [
//                           _buildClubItem('assets/penguins-1.jpg', 'Club Penguin', 'A fun club for penguins.', '1024'),
//                           _buildClubItem('assets/penguins-2.jpg', 'Penguin Yoga', 'Find your center, with your pet penguin.', '32'),
//                           _buildClubItem('assets/penguins-3.jpg', 'Penguins: A History', 'Explore the facinating history of penguins.', '349'),
//                           _buildClubItem('assets/penguins-1.jpg', 'Secret Penguin Group', 'Shh... it\'s a secret', '36'),
//                           _buildClubItem('assets/penguins-2.jpg', 'Another Penguin Club', 'A fun club for penguins.', '1024'),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildClubItem(String imageSource, String clubName,
//       String clubShortDescripton, String memberCount) {
//     return Padding(
//         padding: EdgeInsets.all(5.0),
//         child: Card(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30.0)
//           ),
//           elevation: 5.0,
//           child: ListTile(
//             onTap: (){
//               /// Go to club profile page!
//             },
//             leading: Container(
//               alignment: Alignment.centerLeft,
//               width: 56.0,
//               height: 56.0,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   fit: BoxFit.fill,
//                   image: AssetImage(imageSource),
//                 ),
//               ),
//             ),
//             title: Text(
//               clubName,
//               overflow: TextOverflow.fade,
//               style: TextStyle(
//                 //fontFamily: 'OpenSans',
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             subtitle: Text(
//               clubShortDescripton + '\n' + memberCount + ' members',
//               overflow: TextOverflow.fade,
//             ),
//             trailing: FlatButton.icon(
//               onPressed: () {
//                 /// Join club if invitations are open.
//                 /// if approval needed, send join request
//                 /// if invite-only display popup message.
//               },
//               color: Colors.blueAccent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(50.0)),
//               ),
//               icon: Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//               label: Text(
//                 'Join',
//                 style: TextStyle(
//                   //fontFamily: 'OpenSans',
//                   fontSize: 15.0,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         )


// class HomeScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => new _HomeScreenState();
// }
 
// class _HomeScreenState extends State<HomeScreen> {
  
//   String _userName = "...";
//   String _email = "...";
//   String _photoURL = "...";
  

//   _getUserAuth() {
//     FirebaseAuth.instance.currentUser().then((user){
//       setState((){this._userName = user.displayName; this._photoURL = user.photoUrl; this._email = user.email;});
//       });
//       //print(this._userName);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ListView(
//         children: <Widget>[
//           FlatButton(
//             color: Colors.blue,
//             child: Text(this._userName),
//             onPressed: _getUserAuth(),
//           ),
//           FlatButton(
//             color: Colors.blue,
//             child: Text(this._email),
//             onPressed: _getUserAuth(),
//           ),
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               image: DecorationImage(
//                 image: NetworkImage(this._photoURL),
//                 fit: BoxFit.cover,
//               ),
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }