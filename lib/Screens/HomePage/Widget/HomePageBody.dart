import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/book.dart';
import 'package:flutter_application_1/Services/getData.dart';

import '../../BookDetail/BookDetailPage.dart';

class MyHomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 2),
          child: Text(
            "Eggs",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2, left: 15, bottom: 5),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 4,
              width: 70,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
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
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 2),
          child: Text(
            "Action",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2, left: 15, bottom: 5),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 4,
              width: 88,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
        FutureBuilder<BookResponse>(
            future: getActionBooksData(),
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
