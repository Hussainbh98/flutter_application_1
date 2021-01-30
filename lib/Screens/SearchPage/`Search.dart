import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/book.dart';
import 'package:flutter_application_1/Screens/HomePage/BookDetail.dart';
import 'package:flutter_application_1/Services/getData.dart';

String textFieldValue;
String newURL;
String dropdownValue = 'Title';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
            style: TextStyle(color: Theme.of(context).buttonColor),
            autofocus: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Egg !',
                hintStyle: TextStyle(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? Colors.white
                        : null)),
            onSubmitted: (String value) {
              setState(() {
                value = value.trimLeft();
                value = value.trimRight();
                value = value.replaceAll(' ', '+');

                url = newURL;
                newURL = changeDropDownValue(dropdownValue, value);
                getData();
              });
            }),
        actions: [
          MyDropdownButtonWidget(),
          //indent
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: TheBody(),
    );
  }
}

class TheBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookResponse>(
      future: getData(),
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
                    onTap: () =>
                        bookItemPush(context, snapshot.data.items[index]),
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

  bookItemPush(context, book) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BookDetail(book)));
  }
}

class MyDropdownButtonWidget extends StatefulWidget {
  MyDropdownButtonWidget({Key key}) : super(key: key);

  @override
  _MyDropdownButtonWidgetState createState() => _MyDropdownButtonWidgetState();
}

class _MyDropdownButtonWidgetState extends State<MyDropdownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      dropdownColor: Theme.of(context).primaryColor,
      icon: Icon(
        Icons.arrow_downward,
        color: Theme.of(context).primaryIconTheme.color,
      ),
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryIconTheme.color,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Title', 'Author', 'Publisher', 'ISBN', 'LCCN', 'OCLC']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
                color: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Colors.white
                    : null),
          ),
        );
      }).toList(),
    );
  }
}

changeDropDownValue(dropdownValue, textFieldValue) {
  String value = textFieldValue;
  if (dropdownValue == 'Title') {
    url = 'https://www.googleapis.com/books/v1/volumes?q=$value';
  } else if (dropdownValue == 'Author') {
    url = 'https://www.googleapis.com/books/v1/volumes?q=$value+inauthor';
  } else if (dropdownValue == 'Publisher') {
    url = 'https://www.googleapis.com/books/v1/volumes?q=$value+inpublisher';
  } else if (dropdownValue == 'ISBN') {
    url = 'https://www.googleapis.com/books/v1/volumes?q=$value+isbn';
  } else if (dropdownValue == 'LCCN') {
    url = 'https://www.googleapis.com/books/v1/volumes?q=$value+lccn';
  } else {
    //OCLC
    url = 'https://www.googleapis.com/books/v1/volumes?q=$value+oclc';
  }
  print(url);
  return url;
}
