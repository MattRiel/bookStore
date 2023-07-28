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
                        final books = await widget.bookService.fetchBooks(query);
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book),
                      ),
                    );
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

class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
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
          ],
        ),
      ),
    );
  }
}
