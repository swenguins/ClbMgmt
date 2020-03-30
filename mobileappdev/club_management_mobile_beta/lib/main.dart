import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:provider/provider.dart';
import 'inits.dart' show CurrentUser;
import 'screens.dart';

void main() => runApp(ClubManagementApp());

// This widget is the root of the Club Managment application.
class ClubManagementApp extends StatelessWidget {
  
  // Build a widget with a StreamProvider/Consumer pair to monitor
  // the onAuthStateChanged, if the signed-in state changes,
  // the Consumer gets noified and rebuilds the widget.
  @override
  Widget build(BuildContext context) => StreamProvider.value(
    value: FirebaseAuth.instance.onAuthStateChanged.map((user) => CurrentUser.create(user)),
    initialData: CurrentUser.initial,
    child: Consumer<CurrentUser>(
      builder: (context, user, _) => MaterialApp(
        title: 'Club Management',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFF1976D2),
          primaryColorDark: const Color(0xFF004BA0),
          primaryColorLight: const Color(0xFF63A4FF),
          accentColor: const Color(0xFFFF9800),
          backgroundColor: const Color(0xFFFFFFFF),
          errorColor: const Color(0xFFC5032B),
        ),
        home: user.isInitialValue
          ? Scaffold(body: const SizedBox())
          : user.data != null ? LoginScreen() : LoginScreen(),
        //routes: {
          //'/settings': (_) => SettingsScreen(),
        //},
        //onGenerateRoute: _generateRoute,
      ),
    ),
  );

  // Handles named page route.
  // Route _generateRoute(RouteSettings settings) {
  //   try {
  //     return _doGenerateRoute(settings);
  //   } catch (e, s) {
  //     debugPrint("failed to generate route for $settings: $e $s");
  //     return null;
  //   }
  // }

  // Route _doGenerateRoute(RouteSettings settings) {
  //   if (settings.name?.isNotEmpty != true) return null;

  //   final uri = Uri.parse(settings.name);
  //   final path = uri.path ?? '';
    
  //   switch (path) {
  //     case '/club': {
  //       final club = (settings.arguements as Map ?? {})['note'];
  //       return _buildRoute(settings, (_) => ClubEditor(club: club));
  //     }
  //     default:
  //       return null;
  //   }
  // }

  // //Create a Route
  // Route _buildRoute(RouteSettings settings, Widget builder) =>
  //   MaterialPageRoute<void>(
  //     settings: settings,
  //     builder: builder,
  //   );

}