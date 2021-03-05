import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/BookDetail/AboutThatBookPage/Widgets/Widgets.dart';
import 'package:share/share.dart';

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
              }),
          IconButton(
              tooltip: 'Share',
              icon: Icon(Icons.qr_code_rounded),
              onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            AboutBookListTileItem(context, 'Book Title', book.volumeInfo.title),
            AboutBookListTileItem(context, 'Book Authors', getAuthor()),
            AboutBookListTileItem(context, 'Book ID', book.id),
            AboutBookListTileItem(context, 'Book ISBN',
                book.volumeInfo.industryIdentifiers[0].identifier),
            AboutBookListTileItem(context, 'Type', book.volumeInfo.printType),
            AboutBookListTileItem(
                context, 'Book Publisher', book.volumeInfo.publisher),
            AboutBookListTileItem(
                context, 'Published On', book.volumeInfo.publishedDate),
            AboutBookListTileItem(
                context, 'Book Pages', book.volumeInfo.pageCount),

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
