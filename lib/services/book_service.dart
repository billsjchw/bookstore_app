import 'dart:convert' as convert;

import 'package:bookstore_app/entities/book_page.dart';
import 'package:bookstore_app/services/service.dart';

Future<BookPage> findAllBooks(int page, int size) async {
  final resp = await get(
    '/book/find-all-books',
    <String, String>{
      "page": page.toString(),
      "size": size.toString(),
    }
  );
  final json = convert.json.decode(resp.body);
  return BookPage.fromJson(json['data']);
}

Future<BookPage> bookFuzzySearch(String keyword, int page, int size) async {
  final resp = await get(
    '/book/book-fuzzy-search',
    <String, String>{
      "keyword": keyword,
      "page": page.toString(),
      "size": size.toString(),
    },
  );
  final json = convert.json.decode(resp.body);
  return BookPage.fromJson(json['data']);
}
