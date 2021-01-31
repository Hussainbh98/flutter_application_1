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
