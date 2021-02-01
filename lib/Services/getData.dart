import 'package:flutter_application_1/Models/book.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

var url;

Future<BookResponse> getSearchData(aURL) async {
  if (aURL == null) {
    aURL =
        'https://www.googleapis.com/books/v1/volumes?q=egg:keyes&key=AIzaSyBbtwyjgK6D9Yd7edQ_6kVPoPs8kLUBkzA';
  }

  var response = await http.get(aURL);
  var responseBody = jsonDecode(response.body);

  return BookResponse.fromJson(responseBody);
}

Future<BookResponse> getData() async {
  url =
      'https://www.googleapis.com/books/v1/volumes?q=egg:keyes&key=AIzaSyBbtwyjgK6D9Yd7edQ_6kVPoPs8kLUBkzA';
  var response = await http.get(url);
  var responseBody = jsonDecode(response.body);

  return BookResponse.fromJson(responseBody);
}

Future<BookResponse> getActionBooksData() async {
  url =
      'https://www.googleapis.com/books/v1/volumes?q=action:keyes&key=AIzaSyBbtwyjgK6D9Yd7edQ_6kVPoPs8kLUBkzA';
  var response = await http.get(url);
  var responseBody = jsonDecode(response.body);

  return BookResponse.fromJson(responseBody);
}
