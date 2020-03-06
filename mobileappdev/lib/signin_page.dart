import 'package:flutter/material.dart';
import 'colors.dart';
import 'size_config.dart';
import 'profile_page.dart';
import 'auth.dart';
//import 'sign_up_page.dart';

///This is the primary login page for the Application.
///Todo: Change Login button text to white, adjust size & positioning
///Todo: Position in left or right third of screen under password input.
///Todo: Add a checkbox next to this button for a 'remember me later' feature
///Todo: Make text color, size positioning changes to the signUp button as well
///Todo: Position near bottom left corner of the screen w/ a '+' or other icon
///Todo: Make label for signUp button that says 'Don't have an account?'
///Todo: Find a way to attach a 'forgot password?' text to password form field
///Todo: Move buttons into their own functions to keep code modular.
///Todo: Make screen scroll back down after keyboard is retracted. (focus password field to see what I mean)
///Todo: firebase implementation (of course)
///Other than the two flatbuttons, which were added quickly, this code is how I
///will structure, size and comment going foward, not only for my own sanity, but
///for the sanity of the group (some comments are notes to myself if it's confusing just ask)
/// - JK 2/28

///Instantiate the LoginPage as a Stateful Widget.
class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignInPageState();
}

///Color values used for curved header and footer gradients.
const List<Color> blueGradients = [
  primaryLight, primaryBase, primaryDark,
];

///Linear Gradient used for the title 'Sign In' text gradient.
final Shader linearTextGradient = LinearGradient(
  colors: <Color>[primaryLight, primaryBase],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

///Navigates to the Profile Page once a user is logged in.
//Future navigateToProfilePage(context) async {
  //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
//}

///Navigates to the SignUp Page.
//Future navigateToSignUpPage(context) async {
  //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
//}

///Builds the LoginPage.
class _SignInPageState extends State <SignInPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); ///Initialize screen size configurations.
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              WavyHeader(), ///Display the Wavy Header.
              LoginPageTitle(), ///Display the LoginPage's Title.
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: () => null,
                  color: primaryBase,
                  textColor: surfaceWhite,
                  child: Text('Login with Google'),
                ),
                MaterialButton(
                  onPressed: () => null,
                  color: primaryBase,
                  textColor: errorRed,
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              WavyFooter(), ///Displays the Wavy Footer.
            ],
          ),
        ],
      ),
    );
  }
}

///Builds the ClipPath that displays the Wavy Header.
class WavyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: blueGradients,
            begin: Alignment.topLeft,
            end: Alignment.center,
          ),
        ),
        height: SizeConfig.screenHeight / 2.5,
      ),
    );
  }
}

///Defines and Draws the Clipper Path/Values for the Wavy Header Clipper.
class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    var firstControlPoint = new Offset(size.width / 7, size.height - 30);
    var firstEndPoint = new Offset(size.width / 6, size.height / 1.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width / 5, size.height / 4);
    var secondEndPoint = Offset(size.width / 1.5, size.height / 5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset(size.width - (size.width / 9), size.height / 6);
    var thirdEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///Moves from bottom right to top.
    path.lineTo(size.width, 0.0);

    ///Closes the path by reaching start point from top right corner.
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

///Builds the Title Widget for the Login/SignUp Page.
class LoginPageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: SizeConfig.blockSizeVertical * 16,
      right: SizeConfig.blockSizeHorizontal * 4,
      child: Text(
        'Sign In.',
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 20,
          foreground: Paint()..shader = linearTextGradient,
        ),
      ),
    );
  }
}

///Todo: Add error text in Input decoration as well. Incomplete! comment too.
class EmailFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.screenWidth / 60),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: surfaceWhite,
          fontStyle: FontStyle.italic,
          //fontFamily: "OpenSans",
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: primaryBase,
          prefixIcon: Icon(
            Icons.email,
            color: surfaceWhite,
          ),
          hintText: 'E-Mail',
          hintStyle: TextStyle(
            color: surfaceWhite,
            fontStyle: FontStyle.italic,
            //fontFamily: 'OpenSans',
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: primaryBase,
              width: SizeConfig.screenWidth / 250,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: accent,
              width: SizeConfig.screenWidth / 250,
            ),
          ),
        ),
      ),
    );
  }
}

///Todo: Add error text in Input decoration as well. Incomplete! comment too.
class PasswordFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.screenWidth / 60),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        obscureText: true,
        style: TextStyle(
          color: surfaceWhite,
          //fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: primaryBase,
          prefixIcon: Icon(
            Icons.lock,
            color: surfaceWhite,
          ),
          hintText: 'Password',
          hintStyle: TextStyle(
            color: surfaceWhite,
            fontStyle: FontStyle.italic,
            //fontFamily: 'OpenSans',
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: primaryBase,
              width: SizeConfig.screenWidth / 250,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: primaryLight,
              width: SizeConfig.screenWidth / 250,
            ),
          ),
        ),
      ),
    );
  }
}

///Builds the ClipPath that displays the Wavy Footer.
class WavyFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: FooterWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: blueGradients,
            begin: Alignment.center,
            end: Alignment.bottomRight,
          ),
        ),
        height: SizeConfig.screenHeight / 2,
      ),
    );
  }
}

///Defines and Draws the Clipper Path/Values for the Wavy Footer Clipper.
class FooterWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height - 60);

    var secondControlPoint = Offset(size.width - (size.width / 6), size.height - (size.height / 6));
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}