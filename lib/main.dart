import 'package:flutter/material.dart';
import 'package:igloo/screens/welcome_screen.dart';
import 'package:igloo/screens/login_screen.dart';
import 'package:igloo/screens/registration_screen.dart';
import 'package:igloo/screens/chat_screen.dart';
import 'package:igloo/navigation_widget.dart';

void main() => runApp(Igloo());

class Igloo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        NavigationWidget.id: (context) => NavigationWidget(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}