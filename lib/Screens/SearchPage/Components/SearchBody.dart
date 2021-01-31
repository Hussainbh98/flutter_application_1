import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/book.dart';
import 'package:flutter_application_1/Screens/SearchPage/Widgets/Widgets.dart';
import 'package:flutter_application_1/Services/getData.dart';

import '../Search.dart';

class SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookResponse>(
      future: getSearchData(newURL),
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
                    trailing:
                        Text(snapshot.data.items[index].volumeInfo.printType),
                    onTap: () => bookPush(context, snapshot.data.items[index]),
                    title: Text(snapshot.data.items[index].volumeInfo.title),
                    subtitle: snapshot.data.items[index].volumeInfo.subtitle ==
                            null
                        ? null
                        : Text(snapshot.data.items[index].volumeInfo.subtitle),
                    leading: snapshot.data.items[index].volumeInfo.imageLinks
                                .thumbnail ==
                            null
                        ? null
                        : Hero(
                            tag: snapshot.data.items[index],
                            child: snapshot.data.items[index].volumeInfo
                                        .imageLinks.thumbnail !=
                                    null
                                ? Image.network(
                                    snapshot.data.items[index].volumeInfo
                                        .imageLinks.thumbnail,
                                  )
                                : Image.network(
                                    'https://www.kindpng.com/picc/m/21-214921_page-borders-for-microsoft-word-7-free-download.png')),
                  ));
                }),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
