import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/book.dart';
import 'package:flutter_application_1/Services/getData.dart';

import '../../BookDetail/BookDetailPage.dart';

class MyHomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 8, bottom: 2),
              child: Text(
                "Eggs",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 20),
              child: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
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
                  child: Column(
                    children: [
                      Container(
                        height: 260,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                builder: (context) =>
                                                    BookDetail(snapshot
                                                        .data.items[i])));
                                      },
                                      child: Hero(
                                        tag: snapshot.data.items[i].volumeInfo
                                            .imageLinks.thumbnail,
                                        child: Container(
                                          height: 200,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    snapshot
                                                        .data
                                                        .items[i]
                                                        .volumeInfo
                                                        .imageLinks
                                                        .thumbnail,
                                                  ),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: -8,
                                      child: Text(snapshot.data.items[i]
                                                  .volumeInfo.title.length <=
                                              20
                                          ? snapshot
                                              .data.items[i].volumeInfo.title
                                          : snapshot.data.items[i].volumeInfo
                                                  .title
                                                  .substring(0, 20) +
                                              '..')),
                                  Positioned(
                                      bottom: -25,
                                      child: Text(snapshot.data.items[i]
                                                  .volumeInfo.authors[0] !=
                                              null
                                          ? snapshot.data.items[i].volumeInfo
                                              .volumeInfo.authors[0]
                                          : '-')),
                                ],
                              ),
                          ],
                        ),
                      ),
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
