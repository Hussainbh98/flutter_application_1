import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
        SliverAppBar(
          title: Text("Cavalos Selvagens"),
          floating: true,
          snap: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(
                height: 50,
              ),
              Stack(alignment: AlignmentDirectional.center, children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Image.network(
                    "https://s3.amazonaws.com/virginia.webrand.com/virginia/344/KCVmVk4cdl7/202852714dec217e579db202a977be70.jpg?1590394862",
                    height: 210,
                    fit: BoxFit.cover,
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 20),
                  child: Container(
                    child: Align(
                      child: Image.network(
                        "https://s3.amazonaws.com/virginia.webrand.com/virginia/344/KCVmVk4cdl7/202852714dec217e579db202a977be70.jpg?1590394862",
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Cavalos Selvagens",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "22-5-2012",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  "Thais Marin, Mario de Lima",
                  style: TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).accentColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 20),
                child: Row(
                  children: [
                    FilterChip(
                        label: Text("Romance"),
                        backgroundColor: Colors.transparent,
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        onSelected: (bool value) {
                          print("selected");
                        }),
                    SizedBox(
                      width: 5,
                    ),
                    FilterChip(
                        label: Text("Love"),
                        backgroundColor: Colors.transparent,
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        onSelected: (bool value) {
                          print("selected");
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Row(children: [
                  Text(
                    "Avarage Ratings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RatingBarIndicator(
                    rating: 2.75,
                    itemCount: 5,
                    itemSize: 30.0,
                    direction: Axis.horizontal,
                    itemBuilder: (context, index) => Icon(
                      Icons.star_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 8, bottom: 2),
                              child: Text(
                                "About",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 0, left: 8, bottom: 5),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: 4,
                              width: 55,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10, bottom: 10),
                          child: Text(
                              'Das Supplement beruht auf zahlreichen Quellen, die in dem 2002 erschienenen Grundwerk noch nicht ausgewertet werden konnten. Neben weiteren Werken von Galen...'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, top: 8, bottom: 2),
                            child: Text(
                              "Comments",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0, left: 8, bottom: 5),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 4,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text("Hussain Mohammed"),
                        subtitle: Text("It Was A Great Book"),
                        trailing: Text(
                          '9:50 pm',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4RY_YogTNPSTqS3vZ3Urm0ywFnOoix-F6lw&usqp=CAU'),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text("Ali Ahmed"),
                        subtitle: Text("Best of all books"),
                        trailing: Text(
                          'Yesterday',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAF7dfWhWNTE_dILyhh2yn8qWbuATj7JXAkQ&usqp=CAU'),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text("Mohammed Abdulla"),
                        subtitle: Text("WOW !!!!!"),
                        trailing: Text(
                          'Yesterday',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTT4RiLhXBjmN2PX88mTAPZJfe9j0jl4VaNsw&usqp=CAU'),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text("Fatima Hussain"),
                        subtitle: Text("Amazing."),
                        trailing: Text(
                          '22-1-2021',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCU2vH_nKbaWqyXxYwb6igfLRG_pVuZvVGSw&usqp=CAU'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, top: 8, bottom: 2),
                            child: Text(
                              "Similer Books",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0, left: 8, bottom: 5),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 4,
                            width: 126,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      Container(
                        height: 170,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  "https://s3.amazonaws.com/virginia.webrand.com/virginia/344/KCVmVk4cdl7/202852714dec217e579db202a977be70.jpg?1590394862",
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/contemporary-fiction-night-time-book-cover-design-template-1be47835c3058eb42211574e0c4ed8bf_screen.jpg?ts=1594616847",
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6aMJMawHCCkCJ6QRuybxORQVQtKRvcyg4AQ&usqp=CAU",
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  "https://www.designforwriters.com/wp-content/uploads/2017/10/design-for-writers-book-cover-tf-2-a-million-to-one.jpg",
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  "https://cdn.pastemagazine.com/www/system/images/photo_albums/best-book-covers-fall-2019/large/bbcdune.jpg?1384968217",
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  "https://cdn.cp.adobe.io/content/2/rendition/7b31f130-b900-482f-b234-e418a2524fbf/artwork/627feec7-12d2-415c-a701-bfba9515047c/version/0/format/jpg/dimension/width/size/300",
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  "https://qph.fs.quoracdn.net/main-qimg-9b4267c07c73a0c6099650d9fd3e9933",
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  "https://edit.org/img/blog/xm68-book-cover-templates.jpg.pagespeed.ic.UkmaX_Yea1.jpg",
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(children: [
                        ListTile(
                            title: Text(
                          'Add To List :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )),
                        ListTile(
                          leading: Icon(
                            Icons.favorite,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text('Favorite Books'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.import_contacts,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text('To Be Read'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.library_books_rounded,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text('My Books'),
                          onTap: () {},
                        ),
                        ListTile(
                            title: Text(
                          'Add Ratings :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )),
                        ListTile(
                          leading: Icon(
                            Icons.insert_emoticon,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text('Your Rating'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RatingPage()),
                            );
                          },
                        ),
                      ]),
                    ));
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double ratingValue = 0;
  bool isEmojiTappped = false;
  List _emojis = [
    '🤮',
    '🤢',
    '😫',
    '😫',
    '😟',
    '😕',
    '🤨',
    '😃',
    '😁',
    '😍',
    '🥰',
  ];

  final textFormFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Rating"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Rate this Book !',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Center(
                  child: Container(
                    height: 50,
                    child: Text(
                      '${_emojis[ratingValue.toInt()]}',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Slider(
                    min: 0,
                    max: 10,
                    divisions: 10,
                    value: ratingValue,
                    onChanged: (newRating) {
                      print(newRating);
                      setState(() {
                        ratingValue = newRating;
                      });
                    }),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Row(children: [
                    Text('${_emojis[0.toInt()]}'),
                    Spacer(),
                    Text('${_emojis[9.toInt()]}')
                  ]),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1, //Normal textInputField will be displayed
                  maxLines: 5,
                  controller: textFormFieldController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5.0),
                      ),
                      labelText: 'Review'),
                  cursorColor: Theme.of(context).primaryColor,
                  // The validator receives the text that the user has entered.
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("🚨 Review found empty"),
              content: Text("Please add a review. 😃"),
              actions: [
                RaisedButton(
                  child: Text("i will add !"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).accentColor,
                ),
                RaisedButton(
                  child: Text("No Need !"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void popPage() {
    Navigator.pop(context);
  }
}
