import 'package:bookstore/bookdetails.dart';
import 'package:flutter/material.dart';
import 'package:bookstore/services.dart';
import 'package:bookstore/homescreen.dart';
import 'package:bookstore/config.dart';

void main() {
  final BookService bookService = BookService(googleBooksApiKey);

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(bookService: bookService),
      '/details': (context) => BookDetailScreen(),
    },
  ));
}
