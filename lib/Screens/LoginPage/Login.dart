import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showLoginButton = false;

  bool _emailValidatorIsEmpty = true;
  bool _passwordValidatorIsEmpty = true;

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  authStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future _signInAnonymously() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();

      return userCredential;
    } catch (e) {
      print(e);
    }
  }

  Future _signInWithEmailAndPassword(anEmail, aPassword) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: anEmail, password: aPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future _sendEmailVerification() async {
    User user = FirebaseAuth.instance.currentUser;

    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

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
            SizedBox(
              height: 30,
            ),

            // * NetworkImage
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / .5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/Illustrations/undraw_reading_list.png",
                      ),
                      fit: BoxFit.contain)),
            ),

            // * Book App
            Text(
              'Book App',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
              ),
            ),

            // * emailTextField
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      errorText: _emailValidatorIsEmpty
                          ? null
                          : 'Email Can\'t Be Empty',
                      labelText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.0, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )),
            ),

            // * passwordTextField
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(
                    controller: _passController,
                    onSubmitted:
                        submitEmailAndPass(_emailController, _passController),
                    decoration: InputDecoration(
                      errorText: _passwordValidatorIsEmpty
                          ? null
                          : 'Password Can\'t Be Empty',
                      labelText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.0, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )),
            ),

            // * Forgot Password ?
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 170),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                },
                child: Text(
                  'Forgot Password ?',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),

            // * SignIn or Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlineButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text("Sign In"),
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
                    onPressed: () {
                      setState(() {
                        if (_emailController.text.isEmpty) {
                          _emailValidatorIsEmpty = false;
                        } else {
                          _emailValidatorIsEmpty = true;
                        }
                        if (_passController.text.isEmpty) {
                          _passwordValidatorIsEmpty = false;
                        } else {
                          _emailValidatorIsEmpty = true;
                        }

                        if (_emailController.text.isNotEmpty &&
                            _passController.text.isNotEmpty) {
                          _signInWithEmailAndPassword(
                              _emailController.text.trim(),
                              _passController.text.trim());
                        }
                      });
                    },
                    child: Text("Log In"),
                  ),
                ),
              ],
            ),

            // * Divider
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(),
            ),

            // * Sigin with Google
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
                      onTap: () {
                        _signInWithGoogle();
                      },
                      title: Text("Sig In with Google"))),
            ),
          ],
        ),
      ),
    );
  }

  submitEmailAndPass(TextEditingController emailController,
      TextEditingController passController) {
    if (emailController != null && passController != null) {
    } else if (emailController == null) {
      _emailValidatorIsEmpty = true;
    } else if (passController == null) {
      _passwordValidatorIsEmpty = true;
    }
  }
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _emailValidatorIsEmpty = true;
  bool _passwordValidatorIsEmpty = true;
  bool _confirmPasswordValidatorIsEmpty = true;

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future _createUserWithEmailAndPassword(_email, _password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(e),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Scaffold(
            backgroundColor: Color(0xffffffff),
            body: Builder(
              builder: (context) => SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      // * pop(context)
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context),
                            ),
                          )
                        ],
                      ),

                      // * siginInAssetImage
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width / .5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/Illustrations/undraw_my_app_re.png",
                                ),
                                fit: BoxFit.contain)),
                      ),

                      // * Sign In
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 30,
                        ),
                      ),

                      // * emailTextField
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                errorText: _emailValidatorIsEmpty
                                    ? null
                                    : 'Email Can\'t Be Empty',
                                labelText: "Email",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.0,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            )),
                      ),

                      // * passwordTextField
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: TextField(
                              obscureText: true,
                              controller: _passController,
                              decoration: InputDecoration(
                                errorText: _passwordValidatorIsEmpty
                                    ? null
                                    : 'Password Can\'t Be Empty',
                                labelText: "Password",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.0,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            )),
                      ),

                      // * confirmPasswordTextField
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: TextField(
                              obscureText: true,
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                errorText: _confirmPasswordValidatorIsEmpty
                                    ? null
                                    : 'Password Can\'t Be Empty',
                                labelText: "Confirm Password",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.0,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            )),
                      ),

                      // * signInButton
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: OutlineButton(
                          onPressed: () {
                            setState(() {
                              if (_emailController.text.isEmpty) {
                                _emailValidatorIsEmpty = false;
                              } else {
                                _emailValidatorIsEmpty = true;
                              }

                              if (_passController.text.isEmpty) {
                                _passwordValidatorIsEmpty = false;
                              } else {
                                _passwordValidatorIsEmpty = true;
                                print(_passController.text);
                              }

                              if (_confirmPasswordController.text.isEmpty) {
                                _confirmPasswordValidatorIsEmpty = false;
                              } else {
                                _confirmPasswordValidatorIsEmpty = true;
                              }

                              if (_emailController.text.isNotEmpty &&
                                  _passController.text.isNotEmpty &&
                                  _confirmPasswordController.text.isNotEmpty) {
                                _createUserWithEmailAndPassword(
                                    _emailController.text,
                                    _passController.text,
                                    context);

                                // Scaffold.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text(
                                //         'User has been created, you can login now!'),
                                //   ),
                                // );
                              }
                            });
                          },
                          child: Text("Sign In"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _emailValidatorIsEmpty = false;

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Builder(
          builder: (context) => SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / .5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/Illustrations/undraw_forgot_password.png",
                            ),
                            fit: BoxFit.contain)),
                  ),

                  // * Forgot Password
                  Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                    ),
                  ),

                  // * emailTextField
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            errorText: _emailValidatorIsEmpty
                                ? 'Email Can\'t Be Empty'
                                : null,
                            labelText: "Email",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        )),
                  ),

                  // * send
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: OutlineButton(
                      onPressed: () {
                        setState(() {
                          if (_emailController.text.isEmpty) {
                            _emailValidatorIsEmpty = true;
                          } else {
                            _emailValidatorIsEmpty = false;
                          }

                          if (_emailController.text.isNotEmpty) {
                            final _auth = FirebaseAuth.instance;

                            _auth.sendPasswordResetEmail(
                                email: _emailController.text.trim());
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'An Email Has been sent. Check you\'r email.')),
                            );
                          }
                        });
                      },
                      child: Text("Send"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
