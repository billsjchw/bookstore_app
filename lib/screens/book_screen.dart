import 'package:bookstore_app/components/add_to_cart_bar.dart';
import 'package:bookstore_app/components/book_view.dart';
import 'package:bookstore_app/dto/book.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  final Book book;

  BookScreen({@required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book')),
      bottomNavigationBar: AddToCartBar(book: book),
      body: BookView(book: book),
    );
  }
}
