// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'book.dart';

class BookDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Book book = ModalRoute.of(context)!.settings.arguments as Book;
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book.imageUrl),
            SizedBox(height: 16.0),
            Text(
              'Title: ${book.title}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Author: ${book.author}'),
            SizedBox(height: 8.0),
            Text('Description: ${book.description}'),
            SizedBox(height: 8.0),
            Text('Publisher: ${book.publisher}'),
            SizedBox(height: 8.0),
            Text('Publication Date: ${book.publicationDate}'),
            SizedBox(height: 8.0),
            Text('Number of Pages: ${book.numberOfPages}'),
            SizedBox(height: 8.0),
            Text('Editor: ${book.editor}'),
          ],
        ),
      ),
    );
  }
}
