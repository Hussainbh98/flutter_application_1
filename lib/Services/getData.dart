import 'package:flutter_application_1/Models/book.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

var url;

Future<BookResponse> getSearchData(newURL) async {
  if (newURL == null) {
    newURL = 'https://www.googleapis.com/books/v1/volumes?q=egg';
  }

  var response = await http.get(newURL);
  var responseBody = jsonDecode(response.body);

  return BookResponse.fromJson(responseBody);
}

Future<BookResponse> getData() async {
  url = 'https://www.googleapis.com/books/v1/volumes?q=egg';
  var response = await http.get(url);
  var responseBody = jsonDecode(response.body);

  return BookResponse.fromJson(responseBody);
}

Future<BookResponse> getActionBooksData() async {
  url = 'https://www.googleapis.com/books/v1/volumes?q=action';
  var response = await http.get(url);
  var responseBody = jsonDecode(response.body);

  return BookResponse.fromJson(responseBody);
}
