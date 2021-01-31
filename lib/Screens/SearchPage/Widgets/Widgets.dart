import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/BookDetail/BookDetailPage.dart';

bookPush(context, book) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => BookDetail(book)));
}
