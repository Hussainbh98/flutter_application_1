import 'package:flutter/material.dart';

Widget indent() {
  return SizedBox(height: 20);
}

Widget listTileItem(Icon anIcon, String theText) {
  return Card(
    child: ListTile(
      onTap: () {},
      leading: anIcon,
      title: Text(theText),
    ),
  );
}
