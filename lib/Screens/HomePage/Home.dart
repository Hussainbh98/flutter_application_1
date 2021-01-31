import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/Screens/ThemesPage/themeChanger.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../SearchPage/`Search.dart';
import 'Widget/Drawer.dart';
import 'Widget/HomePageBody.dart';

User user;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(ThemeData(
        brightness: Brightness.light,
      )),
      child: new MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      //initialRoute: "//",
      routes: routes,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Icon _searchIcon = Icon(Icons.search);
  final titleTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TheDrawer(),
      appBar: AppBar(
        title: Text("Book App"),
        actions: [
          IconButton(
              icon: _searchIcon,
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Search()));
                });
              }),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {})
        ],
      ),
      body: MyHomePageBody(),
    );
  }
}
