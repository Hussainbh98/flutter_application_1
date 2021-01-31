import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/getData.dart';

import '../Search.dart';

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
                color: Theme.of(context).brightness == Brightness.light
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
