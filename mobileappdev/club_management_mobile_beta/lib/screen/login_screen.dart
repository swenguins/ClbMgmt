import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, AuthResult, GoogleAuthProvider;
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn;
import 'package:club_management_mobile_beta/inits.dart' show SizeConfig, AppColors;

// Instantiate the LoginScreen as a Stateful Widget.
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

//Color values used for curved Header and Footer gradients.
List<Color> blueGradients = [
 AppColors.primaryLight, AppColors.primaryBase, AppColors.primaryDark,
];

//Linear Gradient used for the title 'Sign In' text gradient.
Shader linearTextGradient = LinearGradient(
 colors: <Color>[AppColors.primaryLight, AppColors.primaryBase],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

// Builds the LoginPage.
class _LoginScreenState extends State<LoginScreen> {
  
  final _auth = FirebaseAuth.instance;  // Stores the Firebase Auth instance.
  final _googleSignIn = GoogleSignIn(); // Stores the Google SignIn instance.

  final _loginForm = GlobalKey<FormState>();  // Form key for the login screen.
  final _emailController = TextEditingController(); // Controller for the email field.
  final _passwordController = TextEditingController();  // Controller for the password field.
  bool _loggingIn = false;  // Boolean to track if the user is currently logging in.
  String _errorMessage; // String to hold an error message.
  bool _useEmailSignIn = false; // Boolean to track if the user wants to sign in via email.

  // Discards the email and password controller resources on a new instance.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Builds the main Login Widget.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Theme(
        data: ThemeData(primarySwatch: Colors.blue).copyWith(
          buttonTheme: ButtonTheme.of(context).copyWith(
            minWidth: 100,
            height: 50,
            buttonColor: Theme.of(context).primaryColorLight,
            textTheme: ButtonTextTheme.primary,
            ),
          ),
      child: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
            child: Form(
              key: _loginForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  WavyHeader(),
                  if (_useEmailSignIn) ..._buildEmailSignInFields(),
                  if (!_useEmailSignIn) ..._buildGoogleSignInFields(),
                  if (_errorMessage != null) _buildLoginMessage(),
                  WavyFooter(),
                ],
              ),
            ),
        ),
      ),
    ),
  );
  }

  List<Widget> _buildGoogleSignInFields() => [
    RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth / 200),
      onPressed: _signInWithGoogle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //add google logo image here.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40 / 1.618),
            child: const Text('Sign in with Google'),
          ),
        ],
      ),
    ),
    FlatButton(
      child: Text('Sign in with email'),
      onPressed: () => setState(() {
        _useEmailSignIn = true;
      }),
    ),
    if (_loggingIn) Container(
      width: 22,
      height: 22,
      margin: const EdgeInsets.only(top: 12),
      child: const CircularProgressIndicator(),
    ),
  ];

  List<Widget> _buildEmailSignInFields() => [
    TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: 'Email',
      ),
      validator: (value) => value.isEmpty ? 'Please input your email' : null,
    ),
    TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      validator: (value) => value.isEmpty ? 'Please input your password' : null,
      obscureText: true,
    ),
    const SizedBox(height: 16),
    _buildEmailSignInButton(),
    if(_loggingIn) const LinearProgressIndicator(),
    FlatButton(
      child: Text('Use Google Sign In'),
      onPressed: () => setState(() {
        _useEmailSignIn = false;
      }),
    ),
  ];

  Widget _buildEmailSignInButton() => RaisedButton(
    onPressed: _signInWithEmail,
    child: Container(
      height: 40,
      alignment: Alignment.center,
      child: const Text('Sign in / Sign up'),
    ),
  );

  Widget _buildLoginMessage() => Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 10),
    child: Text(_errorMessage,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
    ),
  );
  
  void _signInWithGoogle() async {
    _setLoggingIn();
    String errMsg;

    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await _auth.signInWithCredential(credential);
    } catch (e, s) {
      debugPrint('google signIn failed: $e. $s');
      errMsg = 'Login failed, please try again later.';
    } finally {
      _setLoggingIn(false, errMsg);
    }
  }

  void _signInWithEmail() async {
    if (_loginForm.currentState?.validate() != true) return;

    FocusScope.of(context).unfocus();
    String errMsg;
    try {
      _setLoggingIn();
      final result = await _doEmailSignIn(_emailController.text, _passwordController.text);
      debugPrint('Login result: $result');
    } on PlatformException catch (e) {
      errMsg = e.message;
    } catch (e, s) {
      debugPrint('Login failed: $e. $s');
      errMsg = 'Login failed, please try again later.';
    } finally {
      _setLoggingIn(false, errMsg);
    }
  }

  Future<AuthResult> _doEmailSignIn(String email, String password, {bool signUp = false}) => (signUp
    ? _auth.createUserWithEmailAndPassword(email: email, password: password)
    : _auth.signInWithEmailAndPassword(email: email, password: password)
  ).catchError((e) {
    if (e is PlatformException && e.code == 'ERROR_USER_NOT_FOUND') {
      return _doEmailSignIn(email, password, signUp: true);
    } else {
      throw e;
    }
  });

  void _setLoggingIn([bool logginIn = true, String errMsg]) {
    if (mounted) {
      setState(() {
        _loggingIn = logginIn;
        _errorMessage = errMsg;
      });
    }
  }
}

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

// ///Defines and Draws the Clipper Path/Values for the Wavy Header Clipper.
// class TopWaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0.0, size.height);

//     var firstControlPoint = new Offset(size.width / 7, size.height - 30);
//     var firstEndPoint = new Offset(size.width / 6, size.height / 1.5);
//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
//         firstEndPoint.dx, firstEndPoint.dy);

//     var secondControlPoint = Offset(size.width / 5, size.height / 4);
//     var secondEndPoint = Offset(size.width / 1.5, size.height / 5);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//         secondEndPoint.dx, secondEndPoint.dy);

//     var thirdControlPoint = Offset(size.width - (size.width / 9), size.height / 6);
//     var thirdEndPoint = Offset(size.width, 0.0);
//     path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
//         thirdEndPoint.dx, thirdEndPoint.dy);

//     ///Moves from bottom right to top.
//     path.lineTo(size.width, 0.0);

//     ///Closes the path by reaching start point from top right corner.
//     path.close();
//     return path;
//   }
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

// ///Builds the Title Widget for the Login/SignUp Page.
// class LoginPageTitle extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: SizeConfig.blockSizeVertical * 16,
//       right: SizeConfig.blockSizeHorizontal * 4,
//       child: Text(
//         'Sign In.',
//         style: TextStyle(
//           fontSize: SizeConfig.safeBlockHorizontal * 20,
//           foreground: Paint()..shader = linearTextGradient,
//         ),
//       ),
//     );
//   }
// }
//     SizeConfig().init(context); ///Initialize screen size configurations.
//     return Scaffold(
//       body: ListView(
//         padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         children: <Widget>[
//           Stack(
//             children: <Widget>[
//               WavyHeader(), ///Display the Wavy Header.
//               LoginPageTitle(), ///Display the LoginPage's Title.
//             ],
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 MaterialButton(
//                   onPressed: () => null,
//                   color: primaryBase,
//                   textColor: surfaceWhite,
//                   child: Text('Login with Google'),
//                 ),
//                 MaterialButton(
//                   onPressed: () => null,
//                   color: primaryBase,
//                   textColor: errorRed,
//                   child: Text('Logout'),
//                 ),
//               ],
//             ),
//           ),
//           Stack(
//             children: <Widget>[
//               WavyFooter(), ///Displays the Wavy Footer.
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// ///Todo: Add error text in Input decoration as well. Incomplete! comment too.
// class EmailFormField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(SizeConfig.screenWidth / 60),
//       child: TextFormField(
//         maxLines: 1,
//         keyboardType: TextInputType.emailAddress,
//         style: TextStyle(
//           color: surfaceWhite,
//           fontStyle: FontStyle.italic,
//           //fontFamily: "OpenSans",
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: primaryBase,
//           prefixIcon: Icon(
//             Icons.email,
//             color: surfaceWhite,
//           ),
//           hintText: 'E-Mail',
//           hintStyle: TextStyle(
//             color: surfaceWhite,
//             fontStyle: FontStyle.italic,
//             //fontFamily: 'OpenSans',
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(
//               color: primaryBase,
//               width: SizeConfig.screenWidth / 250,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(
//               color: accent,
//               width: SizeConfig.screenWidth / 250,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ///Todo: Add error text in Input decoration as well. Incomplete! comment too.
// class PasswordFormField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(SizeConfig.screenWidth / 60),
//       child: TextFormField(
//         maxLines: 1,
//         keyboardType: TextInputType.text,
//         obscureText: true,
//         style: TextStyle(
//           color: surfaceWhite,
//           //fontFamily: 'OpenSans',
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: primaryBase,
//           prefixIcon: Icon(
//             Icons.lock,
//             color: surfaceWhite,
//           ),
//           hintText: 'Password',
//           hintStyle: TextStyle(
//             color: surfaceWhite,
//             fontStyle: FontStyle.italic,
//             //fontFamily: 'OpenSans',
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(
//               color: primaryBase,
//               width: SizeConfig.screenWidth / 250,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(
//               color: primaryLight,
//               width: SizeConfig.screenWidth / 250,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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