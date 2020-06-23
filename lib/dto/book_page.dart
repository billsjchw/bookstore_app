import 'package:bookstore_app/dto/book.dart';
import 'package:flutter/material.dart';

class BookPage {
  final int number;
  final int size;
  final int totalElements;
  final int totalPages;
  final List<Book> content;

  BookPage({
    @required this.number,
    @required this.size,
    @required this.totalElements,
    @required this.totalPages,
    @required this.content,
  });

  factory BookPage.fromJson(Map<String, dynamic> json) {
    return BookPage(
      number: json['number'],
      size: json['size'],
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      content: json['content'].map<Book>((e) => Book.fromJson(e)).toList(),
    );
  }
}
