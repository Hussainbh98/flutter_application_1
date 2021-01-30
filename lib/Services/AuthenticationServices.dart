import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationServices {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  authStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future signInAnonymously() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      print("******");
      print(userCredential);
      print("******");
      return userCredential;
    } catch (e) {
      print(e);
    }
  }
}
