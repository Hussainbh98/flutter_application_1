import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/book.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:share/share.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

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

            //bookThumbnail
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
                          child: checkThumbnail(book))),
                ),
              ),
            ]),

            //bookTitle & publishedDate
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

            // authors
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: checkBookAuthors(context, book.volumeInfo.authors),
            ),

            //categories
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20),
              child: checkBookCategories(context, book.volumeInfo.categories),
            ),

            //avg Rattings
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

            //about
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
            //Comments
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

            //Similer Books
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

  checkBookCategories(context, categories) {
    if (categories == null) {
      Row(
        children: [
          FilterChip(
              label: Text("none 😢"),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              onSelected: (bool value) {
                print("selected");
              }),
        ],
      );
    } else if (categories.length == 0) {
      Row(
        children: [
          FilterChip(
              label: Text("none 😢"),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              onSelected: (bool value) {
                print("selected");
              }),
        ],
      );
    } else if (categories.length != null) {
      if (categories.length == 1) {
        return Row(
          children: [
            FilterChip(
                label: Text(categories[0]),
                backgroundColor: Colors.transparent,
                shape: StadiumBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                onSelected: (bool value) {
                  print("selected");
                }),
          ],
        );
      } else if (categories.length == 2) {
        return Row(
          children: [
            FilterChip(
                label: Text(categories[0]),
                backgroundColor: Colors.transparent,
                shape: StadiumBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                onSelected: (bool value) {
                  print("selected");
                }),
            FilterChip(
                label: Text(categories[1]),
                backgroundColor: Colors.transparent,
                shape: StadiumBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                onSelected: (bool value) {
                  print("selected");
                }),
          ],
        );
      }
      // more than 2
      else {
        return Row(
          children: [
            FilterChip(
                label: Text(categories[0]),
                backgroundColor: Colors.transparent,
                shape: StadiumBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                onSelected: (bool value) {
                  print("selected");
                }),
            FilterChip(
                label: Text(categories[1]),
                backgroundColor: Colors.transparent,
                shape: StadiumBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                onSelected: (bool value) {
                  print("selected");
                }),
          ],
        );
      }
    }
  }

  checkBookDescription(bookDescription) {
    if (bookDescription == null) {
      return Text("No description for this book. 😢");
    } else if (bookDescription != null) {
      if (book.volumeInfo.description.length < 180)
        return Text(book.volumeInfo.description);
      else if (book.volumeInfo.description.length >= 180) {
        return Text(book.volumeInfo.description.substring(0, 180) + "..");
      }
    }
  }

  checkThumbnail(bookThumbnail) {
    if (bookThumbnail == null) {
      return Container(color: Colors.white);
    } else if (bookThumbnail != null) {
      return Image.network(
        book.volumeInfo.imageLinks.thumbnail,
        height: 200,
        fit: BoxFit.cover,
      );
    }
  }

  checkBookTitle(bookTitle) {
    if (bookTitle == null) {
      return Text("No tile for this book");
    } else if (bookTitle != null) {
      if (bookTitle.length >= 30) {
        return Text(
          book.volumeInfo.title.substring(0, 20) + "..",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      }
      return Text(
        book.volumeInfo.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }
  }

  checkBookAuthors(context, bookAuthorsArr) {
    String authors;

    if (bookAuthorsArr == null) {
      authors = "No authors";
    } else if (bookAuthorsArr.length == 0) {
      authors = "No authors";
    } else if (bookAuthorsArr.length == 1) {
      authors = book.volumeInfo.authors[0];
    } else if (bookAuthorsArr.length >= 1) {
      authors = getAllAuthors(book.volumeInfo.authors);
    }

    if (authors.length >= 25) {
      return Text(authors.substring(0, 25) + "..",
          style: TextStyle(
              fontSize: 17,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor));
    } else if (authors.length < 25) {
      return Text(authors,
          style: TextStyle(
              fontSize: 17,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor));
    }
  }

  getAllAuthors(authors) {
    List<String> authorsList = [];

    for (var i = 0; i < authors.length; i++) {
      authorsList.add(book.volumeInfo.authors[i]);
    }

    return authorsList.toString();
  }

  getBookcategories(context, bookCategoriesArr) {
    String categories;

    if (bookCategoriesArr == null) {
      categories = "No categories";
      return Row(
        children: [
          FilterChip(
            label: Text(
              categories,
            ),
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(
                side: BorderSide(color: Theme.of(context).primaryColor)),
          )
        ],
      );
    } else if (bookCategoriesArr.length == 0) {
      categories = "No categories";
      return Row(
        children: [
          FilterChip(
              label: Text(
                categories,
              ),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              onSelected: (bool value) {
                print("selected");
              })
        ],
      );
    } else if (book.volumeInfo.categories.length == 1) {
      categories = book.volumeInfo.categories[0];
    } else if (bookCategoriesArr.length >= 1) {
      //categories = getAllcategories(book.volumeInfo.categories);
    }

    return Row(
      children: [
        for (int i = 0; i <= categories.length; i++)
          FilterChip(
              label: Text(
                book.volumeInfo.categories[i],
              ),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              onSelected: (bool value) {
                print("selected");
              })
      ],
    );
  }

  getAllcategories(categoriesArr) {
    List<String> categoriesList = [];

    for (var i = 0; i < categoriesArr.length; i++) {
      categoriesList.add(book.volumeInfo.categories[i]);
    }
    print(categoriesList);
    return categoriesList;
  }

  aboutThisBook(context, book) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AboutBookIteam(book)));
  }
}

class AboutBookIteam extends StatelessWidget {
  AboutBookIteam(this.book);

  final book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About this book'),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            item(context, 'Book Title', book.volumeInfo.title),
            item(context, 'Book Authors', getAuthor()),
            item(context, 'Book ID', book.id),
            item(context, 'Book ISBN',
                book.volumeInfo.industryIdentifiers[0].identifier),
            item(context, 'Type', book.volumeInfo.printType),
            item(context, 'Book Publisher', book.volumeInfo.publisher),
            item(context, 'Published On', book.volumeInfo.publishedDate),
            item(context, 'Book Pages', book.volumeInfo.pageCount),

            // item(context, "Book Category", book.volumeInfo.categories),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Book Category",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: FilterChip(
                        label: bookCategoryChips(book.volumeInfo.categories),
                        backgroundColor: Colors.transparent,
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        onSelected: (bool value) {
                          print("selected");
                        }),
                  ),
                  SizedBox(height: 15)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Book Description",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        book.volumeInfo.description != null
                            ? book.volumeInfo.description
                            : "This book has no description",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bookCategoryChips(category) {
    if (category == null) {
      return Text("No categories");
    } else if (category == 0) {
      return Text("No categories");
    } else if (category.length == 1) {
      return Text(category[0]);
    } else if (category.length >= 1) return Text(category);
  }

  Widget item(context, name, item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$name",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: checkItemType(item),
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }

  checkItemType(item) {
    if (item.runtimeType == String) {
      return Text(item);
    } else {
      return Text((item).toString());
    }
  }

  getISBN(book) {
    String iSBNValue;

    if (book.volumeInfo.industryIdentifiers.length == 1) {
      iSBNValue = book.volumeInfo.industryIdentifiers[0].identifier;
    } else if (book.volumeInfo.authors.length == 1) {
      iSBNValue = book.volumeInfo.authors[0];
    }
    //(book.volumeInfo.authors.length != 1)
    else {
      iSBNValue = getAllAuthors(book.volumeInfo.authors.length);
    }
    return book;
  }

  getAuthor() {
    String authorValue;
    if (book.volumeInfo.authors.length == 0) {
      authorValue = "Empty";
    } else if (book.volumeInfo.authors.length == 1) {
      authorValue = book.volumeInfo.authors[0];
    }
    //(book.volumeInfo.authors.length != 1)
    else {
      authorValue = getAllAuthors(book.volumeInfo.authors.length);
    }
    return authorValue;
  }

  getAllAuthors(int numberOfAuthors) {
    String authors;

    authors = book.volumeInfo.authors[0] + ' , ' + book.volumeInfo.authors[1];

    return authors;
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
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor:
                        Theme.of(context).primaryColor.withOpacity(.3),
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
        backgroundColor: Theme.of(context).primaryColor,
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
