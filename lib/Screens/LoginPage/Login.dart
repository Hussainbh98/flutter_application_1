import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showLoginButton = false;

  final emailController = TextEditingController();
  final passController = TextEditingController();

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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / .5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        "https://cdn.dribbble.com/users/1450874/screenshots/14439208/media/1b40d21438a84ab306ef21a5b00705df.jpg?compress=1&resize=1000x750",
                      ),
                      fit: BoxFit.contain)),
            ),
            Text(
              'Book App',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.0, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.0, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 170),
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Forgot Password ?',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlineButton(
                    onPressed: () {
                      //https://cdn.dribbble.com/users/2424774/screenshots/6536759/06_protect_your_account.png?compress=1&resize=800x600

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text("SignIn"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "or",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(.5)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlineButton(
                    onPressed: () {},
                    child: Text("LogIn"),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(),
            ),
            Container(
              width: 230,
              child: Card(
                  child: ListTile(
                      leading: Container(
                        width: 40,
                        child: Image.network(
                          'https://img-authors.flaticon.com/google.jpg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      onTap: () {},
                      title: Text("Sigin with Google"))),
            ),
          ],
        ),
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
