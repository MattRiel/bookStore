// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'services.dart';
import 'book.dart';

class HomeScreen extends StatefulWidget {
  final BookService bookService;

  HomeScreen({required this.bookService});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Book> _books = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter book title',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      try {
                        final books =
                            await widget.bookService.fetchBooks(query);
                        setState(() {
                          _books = books;
                        });
                      } catch (e) {
                        print('Error fetching books: $e');
                      }
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return ListTile(
                  leading: Image.network(book.imageUrl),
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () {
                    // Navigate to a new screen to show more details of the book
                    Navigator.pushNamed(context, '/details', arguments: book);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
