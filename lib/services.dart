import 'dart:convert';
import 'package:http/http.dart' as http;
import 'book.dart';

class BookService {
  final String apiKey;

  BookService(this.apiKey);

  Future<List<Book>> fetchBooks(String query) async {
    final url =
        'https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=10&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData.containsKey('items')) {
        final List<Book> books = [];
        for (var item in jsonData['items']) {
          final volumeInfo = item['volumeInfo'];

          final title = volumeInfo['title'];
          final author = volumeInfo['authors']?.join(', ') ?? 'Unknown Author';
          final description = volumeInfo['description'] ?? 'No description';
          final imageUrl = volumeInfo['imageLinks']?['thumbnail'] ?? 'No Image';
          final publisher = volumeInfo['publisher'] ?? 'No Publisher';
          final publicationDate = volumeInfo['publishedDate'] ?? 'No Date';
          final numberOfPages = volumeInfo['pageCount'] ?? 0;
          final editor = volumeInfo['editor'] ?? 'No Editor';

          books.add(Book(
            title: title,
            author: author,
            description: description,
            imageUrl: imageUrl,
            publisher: publisher,
            publicationDate: publicationDate,
            numberOfPages: numberOfPages,
            editor: editor,
          ));
        }
        return books;
      } else {
        throw Exception('No books found');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
