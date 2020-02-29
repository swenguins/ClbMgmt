///This is just a very basic and incomplete signUp page for users.
///This needs to be expanded to include different signUp forms for
///Members and Admins. I think matching the aesthetic of the login page would
///be the best move, especially since the login page is currently coded as a
///scrolling page, just change the title from sign in to sign up and modify the
///contents of the page. - JK 2/28

import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignUpPageState();
}

class _SignUpPageState extends State <SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Creation',
          style: TextStyle(
            color: Color(0xFFFFFBFA),
          ),
        ),
        bottom: PreferredSize(
            child: Container(
              color: Theme.of(context).accentColor,
              height: 2.0,
            ),
            preferredSize: Size.fromHeight(2.0)),
      ),
      //add for key for authing account create?
      body: Center(
        child: ListView(
            children: <Widget>[
              showEmailInput(),
              showPasswordInput(),
              showFirstNameInput(),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        backgroundColor: Theme.of(context).primaryColor,
        label: Text(
          'Create Account',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textSelectionColor,
          ),
        ),
        icon: Icon(Icons.add,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
  /*SHOW EMAIL INPUT METHOD
    * Displays the Email input text field.
  */
  Widget showEmailInput() {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width/50.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: MediaQuery.of(context).size.width/250.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: MediaQuery.of(context).size.width/250.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          prefixIcon: Icon(Icons.email, color: Colors.white),
          filled: true,
          fillColor: Theme.of(context).primaryColor,
          hintText: 'Email',
          hintStyle: TextStyle(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).textSelectionColor,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  /*SHOW PASSWORD INPUT METHOD
    * Displays the Password input text field.
  */
  Widget showPasswordInput() {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width/50.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        obscureText: true,
        autocorrect: false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: MediaQuery.of(context).size.width/250.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: MediaQuery.of(context).size.width/250.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          prefixIcon: Icon(
              Icons.lock,
              color: Colors.white),
          filled: true,
          fillColor: Theme.of(context).primaryColor,
          hintText: 'Password',
          hintStyle: TextStyle(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).textSelectionColor,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget showFirstNameInput() {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width/50.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autocorrect: false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: MediaQuery.of(context).size.width/250.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: MediaQuery.of(context).size.width/250.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          prefixIcon: Icon(
              Icons.person,
              color: Colors.white
          ),
          filled: true,
          fillColor: Theme.of(context).primaryColor,
          hintText: 'First Name',
          hintStyle: TextStyle(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).textSelectionColor,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

}