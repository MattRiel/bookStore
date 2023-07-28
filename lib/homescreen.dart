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
        title: Text('Google Book'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () {
              _searchController.clear();
              _searchBooks('');
            },
            icon: Icon(Icons.refresh),
          )
        ],
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
                  onPressed: () {
                    final query = _searchController.text.trim();
                    _searchBooks(query);
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
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      leading: Container(
                        child: Image.network(book.imageUrl),
                        width: 60,
                        height: 60,
                      ),
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      onTap: () {
                        // Navigate to a new screen to show more details of the book
                        Navigator.pushNamed(context, '/details',
                            arguments: book);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Define the _searchBooks() method to fetch books from the API based on the search query
  Future<void> _searchBooks([String? query]) async {
    if (query == null || query.trim().isEmpty) {
      // If the query is null or empty, clear the search results and return
      setState(() {
        _books.clear();
      });
      return;
    }

    try {
      final books = await widget.bookService.fetchBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      print('Error fetching books: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal memuat buku"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
