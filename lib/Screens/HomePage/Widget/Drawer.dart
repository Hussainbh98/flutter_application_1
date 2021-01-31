import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../ThemesPage/`Themes.dart';
import 'DrawerWidgets.dart';

class TheDrawer extends StatelessWidget {
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTileTheme(
        style: ListTileStyle.drawer,
        child: ListView(children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.xovi.com/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png'),
              ),
              accountName: Text("No User !"),
              accountEmail: Text('No Email !')),
          listTileItem(Icon(Icons.person_rounded), "Profile"),
          Card(
            child: ListTile(
              onTap: () async {
                final GoogleSignInAccount googleUser =
                    await GoogleSignIn().signIn();

                // Obtain the auth details from the request
                final GoogleSignInAuthentication googleAuth =
                    await googleUser.authentication;

                // Create a new credential
                final GoogleAuthCredential credential =
                    GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken,
                );

                // Once signed in, return the UserCredential
                return await FirebaseAuth.instance
                    .signInWithCredential(credential);
              },
              leading: Icon(Icons.color_lens),
              title: Text("Login"),
            ),
          ),
          listTileItem(Icon(Icons.people_alt_rounded), "Community"),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ThemesPage()));
              },
              leading: Icon(Icons.color_lens),
              title: Text("Theme"),
            ),
          ),
          indent(),
          listTileItem(Icon(Icons.collections_bookmark), "My Books"),
          listTileItem(Icon(Icons.import_contacts), "To be read"),
          listTileItem(Icon(Icons.bookmark), "My Books"),
          indent(),
          Card(
              child: ListTile(
            title: Text(
              "Introduction Page",
            ),
            leading: Icon(Icons.phone_android),
            onTap: () {},
          )),
          indent(),
          listTileItem(Icon(Icons.person), "Contact us"),
          indent(),
          listTileItem(Icon(Icons.logout), "Sign out"),
          Card(
            child: ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              leading: Icon(Icons.color_lens),
              title: Text("signOut"),
            ),
          ),
        ]),
      ),
    );
  }
}
