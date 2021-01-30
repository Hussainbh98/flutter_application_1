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
        backgroundColor: Color(0xff000000),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Center(
                      child: Image.network(
                    "https://cdn.dribbble.com/users/3897976/screenshots/10602945/media/e2089366ec4db262df134b7f9efcc3c7.gif",
                    height: 300,
                    fit: BoxFit.cover,
                  )),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        showLoginButton = true;
                      });
                    },
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Theme.of(context).cursorColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusColor: Colors.amber,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                        labelText: 'Email Address',
                        hintText: "bird12@gmail.com"),
                  )),
              SizedBox(height: 20),
              Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextField(
                    controller: passController,
                    onChanged: (value) {
                      setState(() {
                        showLoginButton = true;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    cursorColor: Theme.of(context).cursorColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        focusColor: Colors.amber,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                        labelText: "Password",
                        hintText: "secretpass123"),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 100.0),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {},
                color: Theme.of(context).accentColor,
                child: Text("Sign up"),
              ),
              SignInButton(
                Buttons.Google,
                onPressed: signInWithGoogle,
              ),
              SignInButton(
                Buttons.Google,
                text: "Login Anonymously",
                onPressed: signInAnonymously,
              ),
              SignInButton(
                Buttons.Google,
                text: "signOut",
                onPressed: signOut,
              ),
            ],
          ),
        ),
        floatingActionButton: showLoginButton
            ? FloatingActionButton(
                tooltip: 'Login',
                onPressed: () {},
                child: Icon(Icons.login),
              )
            : null);
  }
}
