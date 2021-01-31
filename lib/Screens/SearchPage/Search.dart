import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/getData.dart';

import 'Components/SearchBody.dart';
import 'Widgets/DropdownButton.dart';

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
              cursorColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Theme.of(context).accentColor,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Theme.of(context).accentColor),
              autofocus: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type Here',
                  hintStyle: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white.withOpacity(.4)
                          : null)),
              onChanged: (String value) {
                if (value.trim().isEmpty) {
                  value = "egg";
                  newURL = changeDropDownValue(dropdownValue, value);
                  getSearchData(newURL);
                }
                if (value != null) {
                  setState(() {
                    value = value.trimLeft();
                    value = value.trimRight();
                    value = value.replaceAll(' ', '+');

                    url = newURL;
                    newURL = changeDropDownValue(dropdownValue, value);
                    getSearchData(newURL);
                  });
                }
              },
              onSubmitted: (String value) {
                if (value != null) {
                  setState(() {
                    value = value.trimLeft();
                    value = value.trimRight();
                    value = value.replaceAll(' ', '+');

                    url = newURL;
                    newURL = changeDropDownValue(dropdownValue, value);
                    getSearchData(newURL);
                  });
                }
              }),
          actions: [
            MyDropdownButtonWidget(),
            //indent
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: SearchBody());
  }
}
