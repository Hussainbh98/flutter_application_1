import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/book.dart';

import 'package:flutter_application_1/Screens/ThemesPage/themeChanger.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../SearchPage/`Search.dart';
import 'BookDetail.dart';
import 'Drawer.dart';
import '../../Services/getData.dart';

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
  bool isTapedSearch = false;

  Icon searchIcon = Icon(Icons.search);
  Icon removeIcon = Icon(Icons.clear);
  final titleTextFieldController = TextEditingController();

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TheDrawer(),
      appBar: AppBar(
        title: Text("Book App"),
        actions: [
          IconButton(
              icon: searchIcon,
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Search()));
                  //isTapedSearch = !isTapedSearch;
                });
              }),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {})
        ],
      ),
      body: MyHomePageBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

class MyHomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Eggs"),
        ),
        FutureBuilder<BookResponse>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < snapshot.data.items.length; i++)
                        Stack(
                          overflow: Overflow.visible,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookDetail(
                                              snapshot.data.items[i])));
                                },
                                child: Hero(
                                  tag: snapshot.data.items[i].volumeInfo
                                      .imageLinks.thumbnail,
                                  child: Container(
                                    height: 200,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              snapshot.data.items[i].volumeInfo
                                                  .imageLinks.thumbnail,
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                );
              } else
                return Center(child: CircularProgressIndicator());
            }),
      ],
    );
  }
}

// return FutureBuilder<BookResponse>(
//       future: getData(),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.hasError) print(snapshot.error);
//         if (snapshot.hasData) {
//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             physics: BouncingScrollPhysics(),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   bottom: 30, left: 15, right: 15, top: 15),
//               child: Row(
//                 children: [
//                   for (var i = 0; i < snapshot.data.items.length; i++)
//                     Stack(
//                       overflow: Overflow.visible,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           BookDetail(snapshot.data.items[i])));
//                             },
//                             child: Container(
//                               height: 200,
//                               width: 140,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   image: DecorationImage(
//                                       image: NetworkImage(
//                                         snapshot.data.items[i].volumeInfo
//                                             .imageLinks.thumbnail,
//                                       ),
//                                       fit: BoxFit.cover)),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                             bottom: -20,
//                             left: 10,
//                             child: Text(
//                               snapshot.data.items[i].volumeInfo.title + "....",
//                               style: TextStyle(fontSize: 20),
//                             ))
//                       ],
//                     )
//                 ],
//               ),
//             ),
//           );
//         } else
//           return Center(child: CircularProgressIndicator());
//       },
//     );
