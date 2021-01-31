import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/book.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:share/share.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'AboutThatBookPage/Methods/Methods.dart';
import 'RatingPage/RatingPage.dart';

class BookDetail extends StatelessWidget {
  BookDetail(this.book);

  final book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text("Book Detail"),
            floating: true,
            snap: true,
            actions: [
              IconButton(
                  tooltip: 'Share',
                  icon: Icon(Icons.share),
                  onPressed: () {
                    RenderBox box = context.findRenderObject();
                    Share.share(book.volumeInfo.previewLink,
                        subject: "Book Preview Link",
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  })
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 50,
            ),

            // * bookThumbnail
            Stack(alignment: AlignmentDirectional.center, children: [
              //thumbnail
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: checkThumbnail(book.volumeInfo.imageLinks.thumbnail)),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 20),
                child: Container(
                  child: Align(
                      child: Hero(
                          tag: book.volumeInfo.imageLinks.thumbnail,
                          child: checkThumbnail(
                              book.volumeInfo.imageLinks.thumbnail))),
                ),
              ),
            ]),

            // * bookTitle & publishedDate
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
              child: Row(
                children: [
                  checkBookTitle(book.volumeInfo.title),
                  Spacer(),
                  Text(
                    book.volumeInfo.publishedDate != null
                        ? book.volumeInfo.publishedDate
                        : " No date",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),

            // * authors
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: checkBookAuthors(context, book.volumeInfo.authors),
            ),

            // * categories
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20),
              child: checkBookCategories(context, book.volumeInfo.categories),
            ),

            // * avg Rattings
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
                  rating: book.volumeInfo.averageRating,
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

            // * about
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  aboutThisBook(context, book);
                },
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
                          child: checkBookDescription(
                              book.volumeInfo.description)),
                    ],
                  ),
                ),
              ),
            ),

            // * Comments
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, top: 8, bottom: 2),
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
                        style: TextStyle(color: Theme.of(context).primaryColor),
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
                        style: TextStyle(color: Theme.of(context).primaryColor),
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
                        style: TextStyle(color: Theme.of(context).primaryColor),
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
                        style: TextStyle(color: Theme.of(context).primaryColor),
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

            // * Similer Books
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, top: 8, bottom: 2),
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
          ]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
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
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text('Favorite Books'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.import_contacts,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text('To Be Read'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.library_books_rounded,
                            color: Theme.of(context).primaryColor,
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
                            color: Theme.of(context).primaryColor,
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

class BookDetailAuthorPage extends StatelessWidget {
  BookDetailAuthorPage(this.book);

  final book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(book.volumeInfo.authors[0] != null
              ? book.volumeInfo.authors[0]
              : "No Authors"),
        ),
        body: FutureBuilder<BookResponse>(
          future: getDataByAuthor(book.volumeInfo.authors[0] != null
              ? book.volumeInfo.authors[0]
              : "No Authors"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          trailing: Text(
                              snapshot.data.items[index].volumeInfo.printType),
                          onTap: () =>
                              _bookIteam(context, snapshot.data.items[index]),
                          title:
                              Text(snapshot.data.items[index].volumeInfo.title),
                          subtitle:
                              snapshot.data.items[index].volumeInfo.subtitle ==
                                      null
                                  ? null
                                  : Text(snapshot
                                      .data.items[index].volumeInfo.subtitle),
                          leading: snapshot.data.items[index].volumeInfo
                                      .imageLinks.thumbnail ==
                                  null
                              ? null
                              : Hero(
                                  tag: snapshot.data.items[index],
                                  child: Image.network(
                                    snapshot.data.items[index].volumeInfo
                                        .imageLinks.thumbnail,
                                  )),
                        ),
                      );
                    }),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Future<BookResponse> getDataByAuthor(authBook) async {
    var url =
        'https://www.googleapis.com/books/v1/volumes?q=$authBook+inauthor & max-results=100';

    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    //print(responseBody);

    return BookResponse.fromJson(responseBody);
  }

  _bookIteam(context, book) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BookDetail(book)));
  }
}
