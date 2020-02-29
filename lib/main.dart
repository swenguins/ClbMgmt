import 'package:flutter/material.dart';
import 'theme.dart';
import 'login_page.dart';

///ReadMe: before you get started here's a good tutorial playlist to help set up
///android studio/flutter it was the one that got me set up.
///https://www.youtube.com/watch?v=1ukSR1GRtMU&list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ
///Here's a playlist we should watch on Flutter&Firebase
///https://www.youtube.com/watch?v=sfA3NWDBPZ4&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC
///Here's a playlist on just firebase auth.
///https://www.youtube.com/watch?v=aN1LnNq4z54&list=PL4cUxeGkcC9jUPIes_B8vRjn1_GaplOPQ
///


///This file acts as the root of the Application. Here you can set the theme
///and homepage, amongst other things that may need to be implemented in the
///future - JK 2/28

void main() => runApp(ClubManagementAppRoot());

class ClubManagementAppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: clubManagementAppTheme,
      home: LoginPage(),
    );
  }
}