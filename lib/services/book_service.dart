import 'package:bookstore_app/dto/message.dart';
import 'package:bookstore_app/services/service.dart' as service;

Future<Message> findAllBooks(int page, int size) {
  final params = <String, String>{
    'page': page.toString(),
    'size': size.toString(),
  };
  return service.get('/book/find-all-books', params);
}

Future<Message> bookFuzzySearch(String keyword, int page, int size) {
  final params = <String, String>{
    'keyword': keyword,
    'page': page.toString(),
    'size': size.toString(),
  };
  return service.get('/book/book-fuzzy-search', params);
}
