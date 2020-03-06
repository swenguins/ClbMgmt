import 'package:club_management_mobile_beta/auth.dart';
import 'package:club_management_mobile_beta/colors.dart';
import 'package:flutter/material.dart';

void main() => runApp(ClubManagementApp());

class ClubManagementApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: backgroundWhite,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBase,
          title: Text('SignIn'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: () => authService.googleSignIn(),
                color: primaryBase,
                textColor: surfaceWhite,
                child: Text('Login with Google'),
              ),
              MaterialButton(
                onPressed: () => authService.googleSignOut(),
                color: errorRed,
                textColor: surfaceWhite,
                child: Text('Signout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}