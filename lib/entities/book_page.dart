import 'package:bookstore_app/entities/book.dart';
import 'package:flutter/material.dart';

class BookPage {
  final int number;
  final int totalPages;
  final bool empty;
  final List<Book> content;

  BookPage({
    @required this.number,
    @required this.totalPages,
    @required this.empty,
    @required this.content,
  });

  factory BookPage.fromJson(Map<String, dynamic> json) {
    final content = <Book>[
      for (var item in json['content'])
        Book.fromJson(item),
    ];
    return BookPage(
      number: json['number'],
      totalPages: json['totalPages'],
      empty: json['empty'],
      content: content,
    );
  }
}
