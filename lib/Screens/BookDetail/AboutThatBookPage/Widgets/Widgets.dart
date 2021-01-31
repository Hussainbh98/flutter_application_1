import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/BookDetail/AboutThatBookPage/Methods/Methods.dart';

Widget AboutBookListTileItem(context, name, item) {
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
