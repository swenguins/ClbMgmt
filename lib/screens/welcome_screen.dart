import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:igloo/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation animation;
  
  @override
  void initState() {
    super.initState();
    
    controller = AnimationController(duration: Duration(seconds: 1), vsync: this,);
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //dispose();
      }
    });
    controller.addListener(() {
      setState(() {});
      });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/igloo_logo.png'),
                    height: animation.value * 150.0,
                  ),
                ),
                SizedBox(
                    width: 155.0,
                    child: TextLiquidFill(
                      text: 'Igloo.',
                      waveColor: Colors.lightBlueAccent,
                      boxBackgroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.w900,
                    ),
                    boxHeight: 300.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In', 
              color: Colors.lightBlueAccent, 
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
                },
            ),
            RoundedButton(
              title: 'Register', 
              color: Colors.blueAccent, 
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
                },
            ),
          ],
        ),
      ),
    );
  }
}