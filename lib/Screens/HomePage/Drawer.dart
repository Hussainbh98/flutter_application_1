import 'package:flutter/material.dart';

import '../ThemesPage/`Themes.dart';

class TheDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTileTheme(
        style: ListTileStyle.drawer,
        child: ListView(children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
              ),
              accountName: Text("Hussain"),
              accountEmail: Text("Hussainbh00@gmail.com")),
          listTileItem(Icon(Icons.person_rounded), "Profile"),
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
        ]),
      ),
    );
  }

  Widget indent() {
    return SizedBox(height: 20);
  }

  Widget listTileItem(Icon anIcon, String theText) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: anIcon,
        title: Text(theText),
      ),
    );
  }
}
