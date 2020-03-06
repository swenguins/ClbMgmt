import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  AuthService() {
    user = Observable(_auth.onAuthStateChanged);

    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db.collection('googleUsers').document(u.uid).snapshots().map((snap) => snap.data);
      } else {
        return Observable.just({ });
      }
    });
  }

  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.accessToken, 
      accessToken: googleAuth.idToken
      );
    
    
    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    updateUserData(user);
    print("signed in " + user.displayName);

    loading.add(false);

    return user;
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('googleUsers').document(user.email);

    return ref.setData({
      'displayName': user.displayName,
      'email': user.email,
      'lastSeen': DateTime.now(),
      'photoURL': user.photoUrl,
      'uid': user.uid
    }, merge: true);

  }

  void googleSignOut() {
    _auth.signOut();
  }

}

final AuthService authService = AuthService();